trigger ReviewerRatingTrigger on Reviewer_Rating__c (after insert, after update, After delete) {
    if(Trigger.isAfter)
    {
        if(Trigger.isInsert)
        {
            if(!ReviewerRatingTriggerHandler.hasAlreadyRanAfterInsert)
            {
                ReviewerRatingTriggerHandler.handleAfterInsert(Trigger.newMap);
            }
        }
        else if( Trigger.isUpdate)
        {
            if(!ReviewerRatingTriggerHandler.hasAlreadyRanAfterUpdate)
            {
                ReviewerRatingTriggerHandler.handleAfterUpdate(Trigger.newMap, Trigger.oldMap);
            }
        }
        else if(Trigger.isDelete)
        {
            if(!ReviewerRatingTriggerHandler.hasAlreadyRanAfterDelete)
            {
                ReviewerRatingTriggerHandler.handleAfterDelete(Trigger.oldMap);
            }
        }
    }
}