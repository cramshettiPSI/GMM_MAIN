public without sharing class AwardHelper {
    
    public static void shareAwardswithStateCommission(list<Award__c> newawards){
        
            //Profile p = [Select Id,Name from Profile where Name = 'System Administrator'];
            //if(userInfo.getProfileId()!=p.Id){
                set<Id> primeAppIds = new set<Id>();
                for(Award__c a:newawards){
                    if(a.Prime_Application__c!=null){
                        primeAppIds.add(a.Prime_Application__c);
                    }
                }
                if(primeAppIds.size()>0){
                    Map<Id,Prime_Application__c> primeApps = new Map<Id,Prime_Application__c>([Select Id,createdById,Project_Name__r.Organization__c from Prime_Application__c where id in :primeAppids]);
                    list<Award__Share> awShares = new list<Award__Share>();
                    
                    if(primeApps.size()>0){
                        for(Award__c a:newawards){
                            if(a.Prime_Application__c!=null){
                                Award__Share aShare = new Award__Share();
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
            //}
            
    
        
    }
    
    public static void shareAwards(map<Id,Award__c> oldMap, map<Id,Award__c> newMap){
        
        
        //Profile p = [Select Id,Name from Profile where Name = 'System Administrator'];
        //if(userInfo.getProfileId()!=p.Id){
            set<Id> orgIds = new set<Id>();
            set<Id> conIds = new set<Id>();
            map<Id,Id> accIdtoAppId = new map<Id,Id>();
            map<Id,Id> conNametoAccId = new map<Id,Id>();
            list<Award__Share> awshares = new list<Award__Share>();
            for(Id i:newMap.keyset()){
                if(oldMap == null){
                    if(newMap.get(i).Org_Id__c != null){
                        orgIds.add(newMap.get(i).Org_Id__c);
                        accIdtoAppId.put(newMap.get(i).Org_Id__c,i); 
                    }
                }else{
                    if((oldMap.get(i).Grant_Status__c != 'Awarded' && newMap.get(i).Grant_Status__c=='Awarded')
                        ||(oldMap.get(i).Grant_Status__c != 'Awaiting Organization e-Signature' && newMap.get(i).Grant_Status__c=='Awaiting Organization e-Signature')){
                        if(newMap.get(i).Org_Id__c != null){
                            orgIds.add(newMap.get(i).Org_Id__c);
                            accIdtoAppId.put(newMap.get(i).Org_Id__c,i);                    
                        }
                    }
                }
            }
            if(orgIds.size()>0){
                list<Account> accs = new list<Account>([Select (Select Id, LastName, FirstName, Name,AccountId From Contacts) From Account a where Id in :orgIds]);
                if(accs.size()>0){
                    for(Account a: accs){
                        if(a.Contacts.size()>0){
                            for(Contact c: a.Contacts){
                                conIds.add(c.id);
                                conNametoAccId.put(c.Id,c.AccountId);
                            }
                        }
                    }
                }
                if(conIds.size()>0){
                    set<Id> roleIds = new set<Id>();
                    list<User> users = new list<User>([Select Id,FirstName,LastName,Name,userRoleId,ContactId from User where ContactId in :conIds]);
                    if(users.size()>0){
                        for(User u: users){                 
                           if(u.Id!=userInfo.getUserId() && accIdtoAppId.get(conNametoAccId.get(u.ContactId))!=null){               
                            Award__Share aShare = new Award__Share();
                            aShare.ParentId = accIdtoAppId.get(conNametoAccId.get(u.ContactId));
                            aShare.userorgroupId = u.Id;
                            aShare.AccessLevel = 'Edit';
                            awshares.add(aShare); 
                           }                            
                        }
                    }                   
                }
                if(awshares.size()>0){
                    insert awshares;
                }
                
                
            }
        //}
    
    }
    
    public static void awardSubAwardsCompetitive(map<Id,Award__c> oldrecs,map<Id,Award__c> newrecs){
        
        Id primeAwardRTId= Schema.SObjectType.Award__c.getRecordTypeInfosByName().get('Prime Award').getRecordTypeId();
        Id subAppAwardRTId= Schema.SObjectType.Award__c.getRecordTypeInfosByName().get('Sub App Award').getRecordTypeId();
        set<Id> primeAppIds = new set<Id>();        
        for(Id i: newRecs.keyset()){
            if(oldRecs.get(i).Grant_Status__c!=newRecs.get(i).Grant_Status__c&& newRecs.get(i).Grant_Status__c== 'Awarded'){
                primeAppIds.add(newRecs.get(i).Prime_Application__c);
            }
        }
        if(primeAppIds.size()>0){
            list<Prime_Application__c> compPrimes = new list<Prime_Application__c>([Select Id,CNCS_Status__c from Prime_Application__c where Id in :primeAppIds and Competitive_or_Formula__c = 'Competitive']);
            set<Id> primeAppIdsComp = new set<Id>();
            if(compPrimes.size()>0){
                for(Prime_Application__c p: compPrimes){
                     primeAppIdsComp.add(p.Id);   
                }
            }       
            if(primeAppIdsComp.size()>0){
                list<Award__c> subAppAwards = new list<Award__c>([Select Id,Name,Prime_Application__c from Award__c where Prime_Application__c = :primeAppIds and recordTypeId = :subAppAwardRTId]);
                if(subAppAwards.size()>0){
                    for(Award__c a: subAppAwards){
                        a.Grant_Status__c = 'Awarded';
                    }
                    update subAppAwards;
                }
            }
        }
    
        
    }
    
    public static void updateAppstoAwarded(map<Id,Award__c> oldrecs,map<Id,Award__c> newrecs){
        
        
        Id primeAwardRTId= Schema.SObjectType.Award__c.getRecordTypeInfosByName().get('Prime Award').getRecordTypeId();
        Id AppAwardRTId= Schema.SObjectType.Award__c.getRecordTypeInfosByName().get('App Award').getRecordTypeId();
        set<Id> primeAppIds = new set<Id>();       
        set<Id> appIds = new set<Id>(); 
        for(Id i: newRecs.keyset()){
            if(oldRecs.get(i).Grant_Status__c!=newRecs.get(i).Grant_Status__c&& newRecs.get(i).Grant_Status__c== 'Awarded' && (newRecs.get(i).RecordTypeId == primeAwardRTId || newRecs.get(i).RecordTypeId == AppAwardRTId)){
                primeAppIds.add(newRecs.get(i).Prime_Application__c);
                appIds.add(newRecs.get(i).Application_ID__c);
            }
        }
        if(primeAppIds.size()>0){
            list<Prime_Application__c> Primes = new list<Prime_Application__c>([Select Id,CNCS_Status__c from Prime_Application__c where Id in :primeAppIds]);      
            if(Primes.size()>0){
                for(Prime_Application__c p: Primes){
                     p.CNCS_Status__c = 'Awarded';
                }
            }    
            update primes;
        } 
        if(appIds.size()>0){
            list<Application3__c> apps = new list<Application3__c>([Select Id,Status__c,Grantee_Status__c from Application3__c where Id in :appIds]);      
            if(apps.size()>0){
                for(Application3__c p: apps){
                     p.Status__c = 'Awarded';                    
                }
            }    
            update apps;
        }   
     }          
        

}