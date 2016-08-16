trigger updateLegacyPSL on Project_Location__c (before update) {
    for (Project_Location__c obj: trigger.new){
        if (Trigger.isUpdate){
            MuleNotifier.notifyMule('loc',String.valueOf(obj.Legacy_PSL_ID__c.intValue()));
        }
    } 
}