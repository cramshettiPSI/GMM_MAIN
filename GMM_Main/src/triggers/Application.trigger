trigger Application on Application3__c (before insert, before update,after insert,after update) {
    if(trigger.isBefore){
        if(trigger.isInsert){
            ApplicationHelper.checkApplicationforSameYr(trigger.new);             
        }
        list<Application3__c> updateApps = new list<Application3__c>();
        if(trigger.isUpdate){
            for(Id i: trigger.newMap.keyset()){
                if(trigger.oldMap.get(i).project__c != trigger.newMap.get(i).project__c){
                    updateApps.add(trigger.newMap.get(i));
                }
            }
            if(updateApps.size()>0)
                ApplicationHelper.checkApplicationforSameYr(updateApps);
        }
    }
    /*if(trigger.isBefore){
        if(trigger.isInsert){
            ApplicationHelper.populateOrg(trigger.new);
        }
    }*/  
    set<Id> orgIds = new set<Id>();   
   
    if(trigger.isbefore){
        if(trigger.isInsert || trigger.isUpdate){
            for(Application3__c a: trigger.new){
                if(a.Organization__c!=null){
                    orgIds.add(a.Organization__c);
                }
            }
            if(orgIds!=null && orgIds.size()>0){
                map<Id,Account> accMap = new map<Id,Account>([Select Id,Red_Flag_Count__c from Account where id in :orgIds]);         
                for(Application3__c a: trigger.new){
                    if(a.Organization__c!=null && accMap.get(a.Organization__c)!=null){
                        a.Red_Flag_Count__c = accMap.get(a.Organization__c).Red_Flag_Count__c;
                    }
                }
            }
            
        }        
        
    }
    
    if(trigger.isAfter){
        if(trigger.isInsert || trigger.isUpdate){
            ApplicationHelper.shareApplicationsWithStateComission(trigger.new,trigger.oldMap); 
        }
        if(trigger.isInsert){
            ApplicationHelper.shareApplications(trigger.new);
        }
    }
    
}