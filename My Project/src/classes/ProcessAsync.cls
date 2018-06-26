/*
 * Name: ProcessAsync
 * Description: provide support for Centralised Asynchronous Processing
 * Author: Stephen Moss
 * Date: 12/12/2016
 * Notes: from Chapter 7 of "Advanced Apex Programming (Third Edition)"
 */
public without sharing class ProcessAsync
	implements queueable, Database.AllowsCallouts {
	
		public void execute(QueueableContext context) {

			System.debug(LoggingLevel.DEBUG, 
        		'[ProcessAsync.execute] - Checking if app enabled...');

			if (!AppConfigSupport.appEnabled) return;	// on/off switch

			// request to be executed
			// filters by error to ensure errored records aren't re-executed
			// also filters on requests created in current context
			// this allows subsequent classes to use "with sharing" if required
			// FOR update locks record to reduce chance of concurrency errors
			List<AsyncRequest__c> requests;
			try {
				System.debug(LoggingLevel.DEBUG, 
        			'[ProcessAsync.execute] - Getting Job to execute...');
				requests = [SELECT ID, AsyncType__c, Params__c
							FROM AsyncRequest__c
							WHERE Error__c = false AND
							CreatedById = :UserInfo.getUserId()
							LIMIT 1 FOR update];
			} catch (Exception ex) { return; }

			if (requests.size()==0) { return; }

			AsyncRequest__c currentRequest = requests[0];

			// perform async process with appropriate function 
			// and delete if successful
			try {
				
				// NOTE: Async Request Types should be moved to a Constants class eventually
				
				if (currentRequest.AsyncType__c == 'Translate Solution') {
					System.debug(LoggingLevel.DEBUG, 
        				'[ProcessAsync.execute] - Translating Solution...');
					translate(currentRequest);
				}

				if (currentRequest.AsyncType__c == 'insertTask') {
					System.debug(LoggingLevel.DEBUG, 
        				'[ProcessAsync.execute] - Calling AWS Task Insert...');
					insertTask(currentRequest);
				}


				// Add more operations here...

				System.debug(LoggingLevel.DEBUG, 
        			'[ProcessAsync.execute] - Deleting AsyncRequest__c Job...');
				delete currentRequest;
				// Optional, clear from recycle bin
				database.emptyRecycleBin(new List<ID>{currentRequest.id});
			} catch (Exception ex) {
				// trap exception and update async request record
				System.debug(LoggingLevel.DEBUG, 
        		'[ProcessAsync.execute] - Processing Error occurred... Check Record for Details... ['
					+ currentRequest.Id + ']');
				currentRequest.Error__c = true;
				currentRequest.Error_Message__c = ex.getMessage();
				update currentRequest;
			}

			System.debug(LoggingLevel.DEBUG, 
        		'[ProcessAsync.execute] - Chaining Mechanism... Checking if User has another job...');

			// chaining mechanism
			// check if user has another pending request
			// and push it into Apex queue
			List<AsyncRequest__c> moreRequests = [SELECT ID, AsyncType__c, Params__c
									FROM AsyncRequest__c
									WHERE Error__c = false
									AND ID <> :currentRequest.id
									AND CreatedById = :UserInfo.getUserId()
									LIMIT 1];

			if (moreRequests.size() == 0) { 
				System.debug(LoggingLevel.DEBUG, 
        			'[ProcessAsync.execute] - No more open requests for user...');
				return; 
			}

			// if another async request is found, queue it for Processing
			try {
				System.debug(LoggingLevel.DEBUG, 
        			'[ProcessAsync.execute] - Queueing Next Job for User...');
				enqueueGoingAsync(context.getJobId());
			} catch (Exception ex) {
				// if queueing fails (e.g. chaining limit exception or 
				// callout performed in current context) call backup
				// future call function
				System.debug(LoggingLevel.DEBUG, 
        			'[ProcessAsync.execute] - Error Queuing Next Job... Calling tryToQueue()');
				tryToQueue();
			}

		} // end execute method


		// push async request into Apex queue
		// note we are purposely only pushing one job at a time
		// to reduce record contention and blocking
		public static void enqueueGoingAsync(ID currentJobId) {

			System.debug(LoggingLevel.DEBUG, 
        		'[ProcessAsync.enqueueGoingAsync] - Checking if a Job already queued for User...');
			
			// check if a job is already queued
			List<AsyncApexJob> jobs = [SELECT ID, Status, ExtendedStatus
				FROM AsyncApexJob
				WHERE JobType = 'Queueable' AND (status = 'Queued' Or status = 'Holding')
				AND CreatedById = :userinfo.getUserId()
				AND ApexClass.Name ='ProcessAsync'
				AND ID != :currentJobId LIMIT 1];

				if (jobs.size()==1) { 
					System.debug(LoggingLevel.DEBUG, 
        				'[ProcessAsync.enqueueGoingAsync] - A Job is already queued for User...');
					return; 
				} // Already have one queued and isn't this one

				// create queueable Apex job
				System.debug(LoggingLevel.DEBUG, 
        		'[ProcessAsync.enqueueGoingAsync] - Inserting Queueable Apex Job...');
				System.enqueueJob(new ProcessAsync());
		} // end enqueueGoingAsync method

		// future method to act as a backup mechanism to queue a request
		@future
		private static void tryToQueue() {
			System.debug(LoggingLevel.DEBUG, 
        		'[ProcessAsync.tryToQueue] - Checking if app enabled...');
			if (!AppConfigSupport.appEnabled) return; // On/Off switch
			try {
				if (Limits.getLimitQueueableJobs() - Limits.getQueueableJobs() > 0) {
					System.debug(LoggingLevel.DEBUG, 
        				'[ProcessAsync.tryToQueue] - Queueing Job...');
					enqueueGoingAsync(null);
				} 
			} catch (Exception ex) {
					// Wait for some else to make a request...
					System.debug(LoggingLevel.DEBUG, 
        				'[ProcessAsync.tryToQueue] - Re-queue Job Failed...');
			}
		} // end tryToQueue method

		// handle a 'Translate Solution' request
		// Note one single request can contain up to 100
		// solutions to be translated
		public void translate(AsyncRequest__c request) {

			System.debug(LoggingLevel.DEBUG, 
        		'[ProcessAsync.translate] - Checking Callout Limits...');
			
			// check we haven't reached Governor Callout Limits
			Integer allowedCallouts = Limits.getLimitCallouts() - Limits.getCallouts();
			if (allowedCallouts <= 0) return;

			// list of solutions to be processed
			List<ID> idsAfterSplit = request.Params__c.split(',');

			// check enough callouts are available for solutions to be processed
			if (allowedCallouts < idsAfterSplit.size()) {
				System.debug(LoggingLevel.DEBUG, 
        			'[ProcessAsync.translate] - Callout Limits Breached...');
				// throw Exception
				throw new AsyncUpdateException('Not Enough Callouts available to process Async Job');
			}

			// retrieve Solutions and process them
			System.debug(LoggingLevel.DEBUG, 
        		'[ProcessAsync.translate] - Processing Solutions...');
			List<Solution> solutionsToUpdate = 
				[SELECT ID, SolutionNote, SolutionSpanish__c
				 FROM Solution
				 WHERE ID in :idsAfterSplit
				 LIMIT :allowedCallouts];

			for (Solution sl : solutionsToUpdate) {
				sl.SolutionSpanish__c = SimulatedTranslator.translate(sl.SolutionNote);

			}
			update solutionsToUpdate;

			System.debug(LoggingLevel.DEBUG, 
        		'[ProcessAsync.translate] - Finished Processing Solutions...');

		} // end translate method

		// handle an 'insertTask' request
		// Note one single request can contain up to 100
		// solutions to be processed
		public void insertTask(AsyncRequest__c request) {
			System.debug(LoggingLevel.DEBUG, 
        		'[ProcessAsync.insertTask] - Checking Callout Limits...');
			
			// check we haven't reached Governor Callout Limits
			Integer allowedCallouts = Limits.getLimitCallouts() - Limits.getCallouts();
			if (allowedCallouts <= 0) return;

			// list of records to be processed
			List<ID> idsAfterSplit = request.Params__c.split(',');

			// check enough callouts are available for solutions to be processed
			if (allowedCallouts < idsAfterSplit.size()) {
				System.debug(LoggingLevel.DEBUG, 
        			'[ProcessAsync.insertTask] - Callout Limits Breached...');
				// throw Exception
				throw new AsyncUpdateException('Not Enough Callouts available to process Async Job');
			}

			// get the AWS Request Template Information
			AWS_Request_Template__c awsReqTemplate = [
				SELECT Request_Method__c, Request_Resource__c, Request_Payload__c
				FROM AWS_Request_Template__c
				WHERE Name = 'insertTask' LIMIT 1
			];

			// make callouts to AWS to insert tasks
			for (ID id : idsAfterSplit) {
				// Initialise the payload
				String awsPayload = awsReqTemplate.Request_Payload__c;
				awsPayload = awsPayload.replace('$recordId', id);
				awsPayload = awsPayload.replace('$taskSubject', 'Test Async Framework Task');
				awsPayload = awsPayload.replace('$taskText', 'This task was generated by the Apex Async Framework and AWS');

				AWS_API_GatewayInvoke aws = new AWS_API_GatewayInvoke(
     												awsReqTemplate.Request_Method__c, 
													null, 
													awsPayload, 
													awsReqTemplate.Request_Resource__c);

				// send the request to AWS
				// note any exceptions will be caught and processed by "execute" method
				aws.sendAWSRequest();

			}
		}

		public class AsyncUpdateException extends Exception {}

} // END ProcessAsync class