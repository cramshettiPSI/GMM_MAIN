public without sharing class LocationHelper {
   
    public static void shareLocationWithStateCommission(list<Location__c> locs){
        
            Profile p = [Select Id,Name from Profile where Name = 'System Administrator'];
            if(userInfo.getProfileId()!=p.Id){
            
                set<Id> AppIds = new set<Id>();
                for(Location__c a:locs){
                    if(a.Application__c!=null){
                        AppIds.add(a.Application__c);
                    }
                }
                if(AppIds.size()>0){
                    set<Id> primeAppIds = new set<Id>();
                    map<Id,Application3__c> apps = new map<Id,Application3__c>([Select Id,Prime_Application__c,Organization__c from Application3__c where id in :appIds]);
                    for(Application3__c a:apps.values()){
                        primeAppIds.add(a.Prime_Application__c);
                    }
                    if(primeAppIds.size()>0){
                        Map<Id,Prime_Application__c> primeApps = new Map<Id,Prime_Application__c>([Select Id,createdById,Project_Name__r.Organization__c from Prime_Application__c where id in :primeAppids]);
                        list<Location__Share> locShares = new list<Location__Share>();
                        
                        if(primeApps.size()>0){
                            for(Location__c a:locs){
                                if(apps.get(a.Application__c).Prime_Application__c!=null){
                                    Location__Share aShare = new Location__Share();
                                    aShare.ParentId = a.Id;
                                    aShare.userorgroupId = primeApps.get(apps.get(a.Application__c).Prime_Application__c).createdById;
                                    aShare.AccessLevel = 'Edit';
                                    locShares.add(aShare);
                                
                                }
                            }
                        }
                        if(locShares.size()>0){
                            insert locShares;
                        }
                    }
                }
            }
            
    
        
    
    }
    
    public static void shareLocations(list<Location__c> newLocations){
        
        
        Profile p = [Select Id,Name from Profile where Name = 'System Administrator'];
        if(userInfo.getProfileId()!=p.Id){
            set<Id> orgIds = new set<Id>();
            set<Id> conIds = new set<Id>();
            map<Id,Id> accIdtoAppId = new map<Id,Id>();
            map<Id,Id> conNametoAccId = new map<Id,Id>();
            list<Location__Share> locShares = new list<Location__Share>();
            for(Location__c a: newLocations){
                if(a.Org_Id__c != null){
                    orgIds.add(a.Org_Id__c);
                    accIdtoAppId.put(a.Org_Id__c,a.Id); 
                }   
            }
            if(orgIds.size()>0){
                list<Account> accs = new list<Account>([Select (Select Id, LastName, FirstName, Name,AccountId From Contacts) From Account a where Id in :orgIds]);
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
                    list<User> users = new list<User>([Select Id,FirstName,LastName,Name,userRoleId,contactId from User where ContactId in :conIds]);
                    if(users.size()>0){
                        for(User u: users){                     
                          if(u.Id!=userInfo.getUserId() && accIdtoAppId.get(conNametoAccId.get(u.ContactId))!=null){        
                            Location__Share aShare = new Location__Share();
                            aShare.ParentId = accIdtoAppId.get(conNametoAccId.get(u.ContactId));
                            aShare.userorgroupId = u.Id;
                            aShare.AccessLevel = 'Edit';
                            locShares.add(aShare); 
                          }                         
                        }
                    }                   
                }
                if(locShares.size()>0){
                    insert locShares;
                }
                
                
            }
        }
    
    
    }
}