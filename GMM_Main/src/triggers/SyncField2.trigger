trigger SyncField2 on Expert_Review_Panel__c(after insert) {

        list<Id> ERPIds = new list<Id>();
        list<Id> contactIds = new list<Id>();
        List<Expert_Review_Panel__c> ERPUpdate = new List<Expert_Review_Panel__c>();
        for(Expert_Review_Panel__c r: Trigger.New) {
            ERPIds.add(r.Id);
            contactIds.add(r.Reviewer__c);
        }
        Map<Id,Expert_Review_Panel__c> ERPMap = new Map<Id,Expert_Review_Panel__c>([Select Id,Name,Owner.Id,Reviewer__c,Profile__c from Expert_Review_Panel__c where ID IN:ERPIds]);           
       list<User> users = new list<User>([Select Id,Name,ContactId from User where ContactId IN :contactIds]);
       Map<Id,Id> userMap = new Map<Id,Id>();
       if(users.size()>0){
           for(User u: users){
             userMap.put(u.ContactId,u.Id);
           }
       }
       
                    
        if(ERPMap!=null && !ERPMap.isEmpty()){
            if(userMap !=null && !userMap.isEmpty()){
                for(Expert_Review_Panel__c er : ERPMap.Values()){
                if(er.Profile__c == 'Expert Reviewer'){
                    if(userMap.get(er.Reviewer__c)!=null){
                       // er.OwnerId = userMap.get(er.Reviewer__c);   
                    }
                    }
                    /*for(User u : userMap.Values()){           
                        if(u.Id != er.OwnerId)
                        {               
                           er.OwnerId = u.Id;           
                        }
                    }*/               
                }
            }
        }
        //update ERPMap.Values();    
        
         if(trigger.isAfter){
         if(trigger.isInsert){
           expertReviewPanelHelper.shareApplications(trigger.new);
           system.debug('TRIGGER NEW:::'+trigger.new);
           expertReviewPanelHelper.createERPSharingRecords(trigger.new);
         }
        }  
}