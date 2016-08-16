trigger ApplicationHistory on Application3__c(After Update) 
{   
    if(trigger.isAfter && trigger.isUpdate){ 
      cprh.TriggerHandler.LogRecordHistory(trigger.oldMap, trigger.newMap);
    }
}