trigger SyncField3 on Paneling__c(before insert,before update) {
    
        list<Id> PIds = new list<Id>();
        list<Id> contactIds = new list<Id>();
        for(Paneling__c r: Trigger.New) {
                //PIds.add(r.Id);
                if(r.Panel_Coordinator__c!=null){
                    contactIds.add(r.Panel_Coordinator__c);
                }
        }
            
        // List<Paneling__c> PList = new list<Paneling__c>([Select Id,Name,Owner.Id,Panel_Coordinator__c from Paneling__c where ID IN:PIds]);
        List<User> userList = new List<User>([Select Id,Name,ContactId from User where ContactId IN :contactIds]);
        //List<Paneling__c> PUpdate = new List<Paneling__c>();
        /*if(PList!=null && !PList.isEmpty()){
            for(Paneling__c er : PList){
                for(user u : UserList){
                    if(er.OwnerId != u.Id){
                //for(Reviewer__c r1 : er.Expert_Review_Panel__r){
                  er.OwnerId = u.Id;
                 PUpdate.add(er);
        }
                //if(r.Reviewer__c == null) {
                    //r.Reviewer__c = UserInfo.getUserId();  
                //}
                //r.OwnerId = r.Reviewer__c;   
                //}  
                }
            }
        }*/
           
        //update PUpdate;    
        Map<Id,Id> contactIdtoUserId = new Map<Id,Id>();
        if(userList!=null && !userList.isempty()){
            for(User u: userList){
                contactIdtoUserId.put(u.ContactId,u.Id);
            }
        }
        
        for(Paneling__c r: Trigger.New) {               
                if(r.Panel_Coordinator__c!=null && contactIdtoUserId.get(r.Panel_Coordinator__c)!=null){
                    r.OwnerId = contactIdtoUserId.get(r.Panel_Coordinator__c);
                }
        }
        
        
         

}