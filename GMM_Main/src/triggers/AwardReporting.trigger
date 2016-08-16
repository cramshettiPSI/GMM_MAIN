trigger AwardReporting on Award_Reporting__c (after delete, after insert, after undelete, 
after update, before delete, before insert, before update)
{
    if(trigger.isBefore)
    {
        if(trigger.isUpdate){
            System.debug('New Map:'+Trigger.newMap);
            System.debug('Old Map:'+Trigger.oldMap);
           AwardReportingHelper.lockFFR(trigger.newMap,trigger.oldMap);            
        }
    }
    
    if(trigger.isBefore)
    {
        if(trigger.isUpdate){
          AwardReportingHelper.updateExpenditure(Trigger.new);
          AwardReportingHelper.updateObligation(Trigger.new);
          AwardReportingHelper.updateMatch(Trigger.new);
          AwardReportingHelper.updateModule(Trigger.new);          
        }
    if(trigger.isInsert){
             
            AwardReportingHelper.updateModule(Trigger.new);
        }
    }
    
    if(trigger.isAfter){
        if(trigger.isInsert){
            AwardReportingHelper.shareAwardReportingWithStateCommission(trigger.new);        
        }
        if(trigger.isInsert){
            AwardReportingHelper.shareAwardReports(trigger.new);  
          //  AwardReportingHelper.updateModule(Trigger.new);
        }
     /*   if(trigger.isUpdate)
        {
          if(checkRecursive.runOnce())
          {
             AwardReportingHelper.updateModule(Trigger.new);           
          }    
        } */
    }
}