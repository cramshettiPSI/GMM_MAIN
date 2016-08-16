public  class ExpertReviewPanelHelper {
    
    public static void shareApplications(list<Expert_Review_Panel__c> newRecs){
        set<Id> panelIds = new set<Id>();       
        map<Id,Id> reviewerIdtoPanelId = new map<Id,Id>(); 
        map<Id,Id> stafffMemebertoPanelId = new map<Id,Id>(); 
        for(Expert_Review_Panel__c er: newRecs){
            panelIds.add(er.Panel__c);          
            if(er.Reviewer__c!=null)
                reviewerIdtoPanelId.put(er.Reviewer__c,er.Panel__c);
            if(er.Staff_Reviewer__c!=null)
                stafffMemebertoPanelId.put(er.Staff_Reviewer__c,er.Panel__c);
        }
        Map<Id,Paneling__c> panels = new Map<Id,Paneling__c>([Select Id,(Select Id, Paneling__c, Application__c From Panel_Applications__r) From Paneling__c p where Id in :panelIds]);
        
        if(reviewerIdtoPanelId.size()>0){
            list<Application3__Share> appShares = new list<Application3__Share>();
            list<User> users = new list<User>([Select Id,Name,ContactId from User where ContactId in :reviewerIdtoPanelId.keyset()]);
            for(User u: users){
                list<Panel_Application__c> panelApps = panels.get(reviewerIdtoPanelId.get(u.ContactId)).Panel_Applications__r;
                for(Panel_Application__c p: panelApps){                 
                    Application3__Share aShare = new Application3__Share();
                    aShare.ParentId = p.Application__c;
                    aShare.userorgroupId = u.Id;
                    aShare.AccessLevel = 'Read';
                    appShares.add(aShare);
                }
            }
            if(appShares.size()>0){
                insert appShares;
            }
        }
        if(stafffMemebertoPanelId.size()>0){
            list<Application3__Share> appShares2 = new list<Application3__Share>();
            list<User> users = new list<User>([Select Id,Name,ContactId from User where ContactId in :stafffMemebertoPanelId.keyset()]);
            for(User u: users){
                list<Panel_Application__c> panelApps = panels.get(stafffMemebertoPanelId.get(u.ContactId)).Panel_Applications__r;
                for(Panel_Application__c p: panelApps){                 
                    Application3__Share aShare = new Application3__Share();
                    aShare.ParentId = p.Application__c;
                    aShare.userorgroupId = u.Id;
                    aShare.AccessLevel = 'Read';
                    appShares2.add(aShare);
                }
            }
            if(appShares2.size()>0){
                insert appShares2;
            }
        }
    }
    
    /*public static void shareExternal(){
        list<Expert_Review_Panel__Share> erpShares = new list<Expert_Review_Panel__Share>();
           
        for(SampleShare__c e : [Select Name, parentid__c, userid__c From SampleShare__c] ){
            Expert_Review_Panel__Share aShare = new Expert_Review_Panel__Share ();
            aShare.ParentId = e.parentid__c;
        
            aShare.userorgroupId = e.userid__c ;
            aShare.AccessLevel = 'Edit';
            erpShares.add(aShare);
        }
        
        if(erpShares.size()>0){
          System.debug('*** erpShares***- erpShares.size()***'+erpShares);
          insert erpShares;
        }
        
    }*/
    
     public static void createERPSharingRecords(list<Expert_Review_Panel__c> erps){
        System.debug('***createERPSharingRecords***');
        set<Id> panelIds = new set<Id>();
        set<Id> panelCoordinators = new set<Id>();            
        list<User> users = new list<User>();
        list<User> reviewerUsers = new list<User>();
        list<Expert_Review_Panel__Share> erpShares = new list<Expert_Review_Panel__Share>();
        list<Expert_Review_Panel__Share> erpSharesForReviewers = new list<Expert_Review_Panel__Share>();
        map<Id,Expert_Review_Panel__c> erpMap = new map<Id,Expert_Review_Panel__c>();
        
        set<Id> expRevID=new set<Id>();
               
                       
        for(Expert_Review_Panel__c e: erps){
            panelIds.add(e.Panel__c);           
            if(e.Reviewer__c!=null){
            	erpMap.put(e.Reviewer__c,e);
            }            
        }
        
        list<Paneling__c> panels = [Select Id,Name,Panel_Coordinator__c,Staff_Liasion1__c from Paneling__c where Id in :panelIds]; 
        for(Paneling__c p: panels){
        	if(p.Panel_Coordinator__c!=null){
            	panelCoordinators.add(p.Panel_Coordinator__c);
        	}
            //staffUsers.add(p.Staff_Liasion1__c);
        }            
        
        system.debug('erpMap.keyset() = '+erpMap.keyset());
        Users = [Select Id,Name,contactId,IsActive  from User where contactId in :panelCoordinators];
        reviewerUsers = [Select Id,Name,ContactId,IsActive from User where contactId in :erpMap.keyset()];
        
        
        if(Users.size()>0){
            for(User u: Users){
            	if(u.IsActive){               
                    for(Expert_Review_Panel__c e: erps){
                        Expert_Review_Panel__Share aShare = new Expert_Review_Panel__Share ();
                        aShare.ParentId = e.Id;                    
                        aShare.userorgroupId = u.Id;
                        aShare.AccessLevel = 'Edit';
                        erpShares.add(aShare);
                    }  
            	}              
            } 
        }
        
       
        
        
        if(erpShares.size()>0){
          System.debug('*** erpShares***- erpShares.size()***'+erpShares);
          insert erpShares;
        } 
        system.debug('reviewerUsers = '+reviewerUsers);
        for(User u:reviewerUsers){
          if(u.IsActive){
            for(Expert_Review_Panel__c e: erps){
                if(e.Reviewer__c == u.ContactId){
                     Expert_Review_Panel__Share aShare = new Expert_Review_Panel__Share();
                     aShare.ParentId = e.Id;
                     aShare.userorgroupId = u.Id;
                     aShare.AccessLevel = 'Read';
                     erpSharesForReviewers.add(aShare);
                }
            }
          }
        } 
        
        if(erpSharesForReviewers.size()>0){
          System.debug('*** erpShares for reviewers***- erpShares.size()***'+erpShares);	
          insert erpSharesForReviewers;
        }
        
    }

}