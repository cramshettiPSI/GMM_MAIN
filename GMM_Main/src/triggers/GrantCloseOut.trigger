trigger GrantCloseOut on Grant_Close_Out__c (before insert) {
    if(trigger.isBefore){
        if(trigger.isInsert){
            set<Id> awardIds = new set<Id>();
            for(Grant_Close_Out__c gc: trigger.new){
                if(gc.Master_Award__c!=null){
                    awardIds.add(gc.Master_Award__c);
                }                
            }
            map<Id,String> pdemailMap = new map<Id,String>();
            map<Id,String> aremailMap = new map<Id,String>();
            map<Id,String> goEmailMap = new map<Id,String>();
            list<Master_Award__c> awards = new list<Master_Award__c>([Select Id,Name,PD_Email__c,AR_Email__c,Grants_Officer_Email__c
            from Master_Award__c where Id in :awardIds]);
            if(awards.size()>0){
                for(Master_Award__c a: awards){
                    pdemailMap.put(a.Id,a.PD_Email__c);
                    aremailMap.put(a.Id,a.AR_Email__c);
                    goEmailMap.put(a.Id,a.Grants_Officer_Email__c);
                }
            }
            for(Grant_Close_Out__c gc: trigger.new){
                if(pdemailMap.get(gc.Master_Award__c)!=null){
                    gc.PD_Email__c = pdemailMap.get(gc.Master_Award__c);
                }
                if(aremailMap.get(gc.Master_Award__c)!=null){
                    gc.AR_Email__c = aremailMap.get(gc.Master_Award__c);
                }    
                if(goEmailMap.get(gc.Master_Award__c)!=null){
                    gc.Grants_Officer_Email__c = goEmailMap.get(gc.Master_Award__c);
                }            
            }
         }
    }
}