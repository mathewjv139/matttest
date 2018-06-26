/*
 * Name: GoingAsync
 * Description: provide support for Centralised Asynchronous Processing
 * Author: Stephen Moss
 * Date: 12/12/2016
 * Notes: from Chapter 7 of "Advanced Apex Programming (Third Edition)"
 */
public class GoingAsync {

	// Protection from workflows and triggers
	private static Boolean alreadyProcessed = false;
	
	// Solution Trigger Handler
	// insert applicable records into async processing object
	public static void handleSolutionTrigger(List<Solution> solutionList,
		Map<ID, Solution> newMap, Map<ID, Solution> oldMap,
		Boolean isInsert) {

			System.debug(LoggingLevel.DEBUG, 
        		'[GoingAsync.handleTrigger] - Executing GoingAsync.handleTrigger...');

			// abort if we have already queued records
			if (alreadyProcessed) {
				System.debug(LoggingLevel.DEBUG, 
        			'[GoingAsync.handleTrigger] - GoingAsync.handleTrigger already executed...');
				return;
			} 

			alreadyProcessed = true;

			// list of async jobs to be queued
			List<AsyncRequest__c> newAsyncRequests = new List<AsyncRequest__c>();

			// list of Solutions to be processed
			List<String> textChangedIds = new List<ID>();

			// determine the list of Solutions to be processed
			System.debug(LoggingLevel.DEBUG, 
        		'[GoingAsync.handleTrigger] - Getting List of Solutions to process...');
			for (Solution sl : solutionList) {
				// if a new Solution or SolutionNote has been modified
				// add it to the list to be processed
				if (isInsert || sl.SolutionNote != oldMap.get(sl.id).SolutionNote)
					textChangedIds.add(sl.id);

				// if we have reached callout limit for Queuable Apex (currently 100)
				// add current processing list to async jobs list
				// Note one async job contains multiple Solutions
				if (textChangedIds.size() >= 100) {
					System.debug(LoggingLevel.DEBUG, 
        				'[GoingAsync.handleTrigger] - Callout Limit Reached... Queueing Solutions...');
					newAsyncRequests.add(
						new AsyncRequest__c(AsyncType__c = 'Translate Solution',
							Params__c = string.Join(textChangedIds,',')));
					newAsyncRequests.add(
						new AsyncRequest__c(AsyncType__c = 'insertTask',
							Params__c = string.Join(textChangedIds,',')));		
					textChangedIds.clear();
				}
			} // end solution FOR loop

			// if we have any remaining Solutions to be processed, queue them
			// Note one async job contains multiple Solutions
			if (textChangedIds.size() > 0) {
				System.debug(LoggingLevel.DEBUG, 
        			'[GoingAsync.handleTrigger] - Queueing Solutions...');
				newAsyncRequests.add(
						new AsyncRequest__c(AsyncType__c = 'Translate Solution',
							Params__c = string.Join(textChangedIds,',')));
				newAsyncRequests.add(
						new AsyncRequest__c(AsyncType__c = 'insertTask',
							Params__c = string.Join(textChangedIds,',')));		
			}

			System.debug(LoggingLevel.DEBUG, 
        		'[GoingAsync.handleTrigger] - Inserting ' + newAsyncRequests.size() +  
				' AsyncRequest__c records...');
			insert newAsyncRequests;

		} // end handleTrigger method

} // end GoingAsync class