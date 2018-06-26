/*
 * Name: SolutionTrigger
 * Description: provide support for asynchronous processing
 * Author: Stephen Moss
 * Date: 12/12/2016
 * Notes: from Chapter 7 of "Advanced Apex Programming (Third Edition)"
 */
trigger SolutionTrigger on Solution (after insert, after update) {

    System.debug(LoggingLevel.DEBUG, 
        '[SolutionTrigger] - Passing Control to GoingAsync.handleTrigger...');

    // pass to handler for asynchronous processing
    GoingAsync.handleSolutionTrigger(trigger.new, trigger.newMap,
        trigger.oldMap, trigger.isInsert);

}