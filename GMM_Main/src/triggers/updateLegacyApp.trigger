trigger updateLegacyApp on Application3__c (before update) {
    for (Application3__c obj: trigger.new){
        if (Trigger.isUpdate && obj.RecordType.Name.equals('Application')){
            MuleNotifier.notifyMule('app',String.valueOf(obj.Legacy_App_ID__c));
        }
    } 
}