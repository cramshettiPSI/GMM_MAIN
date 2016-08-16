trigger PrimeApplication on Prime_Application__c (after insert,after update) {
    if(trigger.isAfter){
         if(trigger.isInsert || trigger.isUpdate){
            PrimeApplicationHelper.shareRecords(trigger.new);
        }
    }
    if(trigger.isAfter){
        if(trigger.isUpdate){
            primeApplicationHelper.updateFormulaSubAppsToAwarded(trigger.oldMap,trigger.newMap);
            primeApplicationHelper.updateSubAppsToAccepted(trigger.oldMap,trigger.newMap); 
        }
    }

}