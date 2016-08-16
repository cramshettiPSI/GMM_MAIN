trigger CNCSCorporateStructure on CNCS_Corporate_Program__c (After Update) 
{
cprh.TriggerHandler.LogRecordHistory(trigger.oldMap, trigger.newMap);
}