trigger updateLegacyPerson on Contact (before update) {
    for (Contact obj: trigger.new){
        if (Trigger.isUpdate){
            MuleNotifier.notifyMule('per',String.valueOf(obj.Legal_Person_ID__c.intValue()));
        }
    } 
}