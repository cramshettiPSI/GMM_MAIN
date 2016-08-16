trigger AwardHistory on Award__c (After Update) 
{
cprh.TriggerHandler.LogRecordHistory(trigger.oldMap, trigger.newMap);
}