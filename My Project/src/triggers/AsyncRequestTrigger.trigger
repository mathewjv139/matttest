/*
 * Name: AsyncRequestTrigger
 * Description: provide support for Centralised Asynchronous Processing of new Async Requests
 * Author: Stephen Moss
 * Date: 12/12/2016
 * Notes: from Chapter 7 of "Advanced Apex Programming (Third Edition)"
 */
trigger AsyncRequestTrigger on AsyncRequest__c (after insert) {

    System.debug(LoggingLevel.DEBUG, 
        '[AsyncRequestTrigger] - Executing Trigger...');

    // check if there is capacity in the Queueable Jobs
    if (Limits.getLimitQueueableJobs() - Limits.getQueueableJobs() > 0) {
        try {
            System.debug(LoggingLevel.DEBUG, 
        		'[AsyncRequestTrigger] - Queuing Async Jobs...');
            // queue the async Jobs
            ProcessAsync.enqueueGoingAsync(null);
        } catch (Exception ex) {
            // Ignore for now...
        }
    }

}