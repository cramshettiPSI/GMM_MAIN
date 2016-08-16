trigger updateLegacyProj on Project__c (before update) {
    for (Project__c obj: trigger.new){
        if (Trigger.isUpdate){
            MuleNotifier.notifyMule('proj',String.valueOf(obj.Legacy_Project_ID__c.intValue()));
        }
    } 
}