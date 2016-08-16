trigger Account on Account (after insert,after update) {
    /*if(trigger.isafter){
        if(trigger.isInsert || trigger.isUpdate){
            set<Id> orgIds = new set<Id>();
            for(Account a: trigger.new){
                orgIds.add(a.Id);
            }
            list<Application3__c> apps = new list<Application3__c>([Select Id, Red_Flag_Count__c,Organization__c from Application3__c where Organization__c in :orgIds]);
            if(apps.size()>0){
                for(Application3__c a: apps){
                    if(a.Organization__c!=null && trigger.newMap.get(a.Organization__c).Red_Flag_Count__c!=null){
                         a.Red_Flag_Count__c = trigger.newMap.get(a.Organization__c).Red_Flag_Count__c;
                    }
                }
                update apps;
            }
         }
            
    }*/        
        
}