public without sharing class MasterAwardHelper {
    
    /*public static void shareMasterAwardWithStateCommission(list<Master_Award__c> newRecs){
            Profile p = [Select Id,Name from Profile where Name = 'System Administrator'];
            if(userInfo.getProfileId()!=p.Id){
        
                set<Id> primeAppIds = new set<Id>();
                set<Id> appIds = new set<Id>();
                for(Master_Award__c a:newRecs){
                    if(a.Prime_Application__c!=null){
                        primeAppIds.add(a.Prime_Application__c);                    
                    }
                    if(a.Application__c!=null){
                        appIds.add(a.Application__c);
                    }
                }
                
                if(primeAppIds.size()>0){
                    Map<Id,Application3__c> apps = new Map<Id,Application3__c>([Select Id,Name,Organization__c from Application3__c where id in :appIds]);
                    Map<Id,Prime_Application__c> primeApps = new Map<Id,Prime_Application__c>([Select Id,createdById,Project_Name__r.Organization__c from Prime_Application__c where id in :primeAppids]);
                    list<Master_Award__Share> awShares = new list<Master_Award__Share>();
                    
                    if(primeApps.size()>0){
                        for(Master_Award__c a:newRecs){
                            if(apps.get(a.Application__c).Organization__c != null && apps.get(a.Application__c).Organization__c == primeApps.get(a.Prime_Application__c).Project_Name__r.Organization__c){
                                Master_Award__Share aShare = new Master_Award__Share();
                                aShare.ParentId = a.Id;
                                aShare.userorgroupId = primeApps.get(a.Prime_Application__c).createdById;
                                aShare.AccessLevel = 'Edit';
                                awShares.add(aShare);
                            
                            }
                        }
                    }
                    if(awShares.size()>0){
                        insert awShares;
                    }
                }
            }
        
    }*/
    
    public static void shareMasterAwards(list<Master_Award__c> newMasterAwards){
        
        
        Profile p = [Select Id,Name from Profile where Name = 'System Administrator'];
        if(userInfo.getProfileId()!=p.Id){
            set<Id> orgIds = new set<Id>();
            set<Id> conIds = new set<Id>();
            map<Id,Id> accIdtoAppId = new map<Id,Id>();
            map<Id,Id> conNametoAccId = new map<Id,Id>();
            list<Master_Award__Share> maShares = new list<Master_Award__Share>();
            for(Master_Award__c a: newMasterAwards){
                if(a.Org_Id__c != null){
                    orgIds.add(a.Org_Id__c);
                    accIdtoAppId.put(a.Org_Id__c,a.Id); 
                }   
            }
            if(orgIds.size()>0){
                list<Account> accs = new list<Account>([Select (Select Id, contact.accountid,LastName, FirstName, Name From Contacts) From Account a where Id in :orgIds]);
                if(accs.size()>0){
                    for(Account a: accs){
                        if(a.Contacts.size()>0){
                            for(Contact c: a.Contacts){
                                conIds.add(c.Id);
                                conNametoAccId.put(c.Id,c.AccountId);
                            }
                        }
                    }
                }
                if(conIds.size()>0){
                    set<Id> roleIds = new set<Id>();
                    list<User> users = new list<User>([Select Id,FirstName,LastName,Name,userRoleId,contactId from User where contactId in :conIds]);
                    if(users.size()>0){
                        for(User u: users){                     
                          if(u.Id!=userInfo.getUserId() && accIdtoAppId.get(conNametoAccId.get(u.contactid))!=null){        
                            Master_Award__Share aShare = new Master_Award__Share();
                            aShare.ParentId = accIdtoAppId.get(conNametoAccId.get(u.contactId));
                            aShare.userorgroupId = u.Id;
                            aShare.AccessLevel = 'Edit';
                            maShares.add(aShare); 
                          }                         
                        }
                    }                   
                }
                if(maShares.size()>0){
                    insert maShares;
                }
                
                
            }
        }
    
    
    }

}