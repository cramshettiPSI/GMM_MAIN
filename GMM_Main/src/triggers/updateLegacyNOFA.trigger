trigger updateLegacyNOFA on NOFA__c (before update) {
    for (NOFA__c obj: trigger.new){
        if (Trigger.isUpdate){
            MuleNotifier.notifyMule('nofa',String.valueOf(obj.Legacy_NOFA_ID__c.intValue()));
        }
    }
}