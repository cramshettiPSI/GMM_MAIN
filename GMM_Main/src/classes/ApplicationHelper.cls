public without sharing class ApplicationHelper {
    public static void checkApplicationforSameYr(list<Application3__c> newApps){
        
        system.debug('checkApplicationforSameYr');
        set<Id> projectIds = new set<Id>();
        list<Application3__c> appToUpdate = new list<Application3__c>();
        set<Id> nofaIds = new set<Id>();
        list<Project__c> projects = new list<Project__c>();              
        Id appRecordTypeId = Schema.SObjectType.Application3__c.getRecordTypeInfosByName().get('Application').getRecordTypeId();
        Id cpRecordTypeId = Schema.SObjectType.Application3__c.getRecordTypeInfosByName().get('Concept Paper').getRecordTypeId();
        map<Id,Project__c> pMap = new map<Id,Project__c>();
        system.debug('newApps= '+newApps);        
        for(Application3__c a: newApps){                
          if(a.Project__c != null && appRecordTypeId == a.RecordTypeId  && a.Type_of_Application__c == 'New'){
             projectIds.add(a.Project__c);
          }
          if(a.Project__c != null && cpRecordTypeId == a.RecordTypeId){
             projectIds.add(a.Project__c);
          }
        } 
        if(projectIds!=null && projectIds.size()>0){       
            projects = [Select p.Name, p.Id,p.Organization__c,Project_Title__c, (Select Id, Name,NOFA_RFP__c,Project_Title__c,NOFA_RFP__r.Fiscal_Yr__c,NOFA_Fiscal_Yr__c,Project__c,RecordTypeId From Application__r) From Project__c p where Id in : projectIds];        
            
            for(Project__c p: projects){ 
                pMap.put(p.Id,p);                                  
                if(p.Application__r!=null && p.Application__r.size()>0){
                    for(Application3__c a: p.Application__r){
                      if(a.RecordTypeId == appRecordTypeId || a.RecordTypeId == cpRecordTypeId) {
                        nofaIds.add(a.NOFA_RFP__c);
                      }  
                    }
                    
                }
            }
            
            for(Application3__c newApp: newApps){
                newApp.Project_Title__c = pMap.get(newApp.Project__c).Project_Title__c;
                if(newApp.NOFA_RFP__c!=null){
                 nofaIds.add(newApp.NOFA_RFP__c);
                }
            }
            system.debug('nofaIds = '+nofaIds);
            if(nofaIds!=null && nofaIds.size()>0){
                Map<Id,Nofa__c> nofaFiscalYrs = new Map<Id,Nofa__c>([Select Id,Fiscal_Yr__c,Corporate_Program__r.Short_Code__c from NOFA__c where Id in :nofaIds]);   
          
              
           
                for(Project__c p: projects){                
                    for(Application3__c newApp: newApps){                                     
                        if(p.Application__r!=null && p.Application__r.size()>0){                            
                            for(Application3__c a: p.Application__r){                                   
                                if(a.RecordTypeId == appRecordTypeId || a.RecordTypeId == cpRecordTypeId){                                  
                                  if(a.RecordTypeId == newApp.RecordTypeId){                                                                  
                                    if(a.Project__c == newApp.Project__c && newApp.NOFA_RFP__c!=null && a.NOFA_RFP__c == newApp.NOFA_RFP__c && (a.NOFA_Fiscal_Yr__c != '' && a.Nofa_Fiscal_yr__c != null) && a.NOFA_Fiscal_Yr__c == nofaFiscalYrs.get(newApp.NOFA_RFP__c).Fiscal_Yr__c){                            
                                        newApp.adderror('A project can only be attached to a single application/concept paper in a fiscal year');                           
                                    }
                                  }
                                }
                             } 
                        
                        }
                             
                    
                    }
                }
            }
        }
        
        
    
        
        
    } 
      
    
    
    /*public static boolean isDupeAppWithaDiffProject(Id orgId,Id nofaId,String yr){
        set<Id> projectIds = new set<Id>();
        list<Project__c> projects = new list<Project__c>();
        
        Account a = [Select a.Name, a.Id, (Select Name From Projects__r) From Account a where Id = :orgId];
        if(a!=null && a.Projects__r != null){
            for(Project__c p: a.Projects__r){
                projectIds.add(p.Id);
            }   
        }
        system.debug('project Ids = '+projectIds);
        projects = [Select p.Name, p.Id,p.Organization__c, (Select Id, Name,NOFA_RFP__c,NOFA_RFP__r.Fiscal_Yr__c,NOFA_Fiscal_Yr__c,Project__c From Application__r) From Project__c p where Id in : projectIds];        
        
        for(Project__c p: projects){
            if(p.Application__r!=null){
                for(Application3__c app: p.Application__r){                 
                    if(app.Nofa_RFP__c == nofaId && app.NOFA_Fiscal_Yr__c == yr){
                        return true;
                    }
                    
                }
            }
        }
        return false;
        
    }*/
    
    /*public static void populateOrg(list<Application3__c> newapps){
        set<Id> usrIds = new set<Id>();
        map<Id,Id> usrIdtoOrgId = new map<Id,Id>();
        for(Application3__c a: newapps){
            if(a.Applicant_User__c !=null){
                usrIds.add(a.Applicant_User__c);
            } 
        }
        system.debug('usrIds = '+usrIds);
        list<User> users = new list<User>([Select u.Name, u.Id, u.AccountId From User u where Id in :usrIds]);
        for(User u:users){
            if(u.AccountId!=null)
                usrIdtoOrgId.put(u.Id,u.AccountId);
        }
        system.debug('user map = '+usrIdtoOrgId);
        for(Application3__c a:newApps){
            if(usrIdtoOrgId.get(a.Applicant_User__c)!=null){
                a.Organization__c = usrIdtoOrgId.get(a.Applicant_User__c);
            }
        }
        
    }*/
    
    public static void shareApplicationsWithStateComission(list<Application3__c> newApps,map<Id,Application3__c> oldmap){
        Profile p = [Select Id,Name from Profile where Name = 'System Administrator'];
        if(userInfo.getProfileId()!=p.Id){
            set<Id> primeAppIds = new set<Id>();
            for(Application3__c a:newApps){
                
                if(a.Prime_Application__c!=null && oldmap != null && oldmap.get(a.Id).Grantee_Status__c == 'In Progress' && a.Grantee_Status__c != 'In Progress' ){
                    primeAppIds.add(a.Prime_Application__c);
                }
                if(a.Prime_Application__c!=null && oldmap == null && a.Grantee_Status__c != 'In Progress' ){
                    primeAppIds.add(a.Prime_Application__c);
                }
            
            }
            if(primeAppIds.size()>0){
                Map<Id,Prime_Application__c> primeApps = new Map<Id,Prime_Application__c>([Select Id,createdById,Project_Name__r.Organization__c from Prime_Application__c where id in :primeAppids]);
                list<Application3__Share> appShares = new list<Application3__Share>();
                list<AccountShare> accShares = new list<AccountShare>();
                if(primeApps.size()>0){
                    for(Application3__c a:newApps){
                        if(a.Prime_Application__c!=null){
                            Application3__Share aShare = new Application3__Share();
                            aShare.ParentId = a.Id;
                            aShare.userorgroupId = primeApps.get(a.Prime_Application__c).createdById;
                            aShare.AccessLevel = 'Edit';
                            appShares.add(aShare);
                            
                            AccountShare accShare = new AccountShare();
                            accShare.AccountId = a.Organization__c;
                            accShare.userorgroupId = primeApps.get(a.Prime_Application__c).createdById;
                            accShare.AccountAccessLevel = 'Read';
                            accShare.OpportunityAccessLevel = 'Read';
                            accShares.add(accShare);
                        }
                    }
                }
                if(appShares.size()>0){
                    insert appShares;
                }
                if(accShares.size()>0){
                    insert accShares;
                }
            }
        }
    }
    
    public static void shareApplications(list<Application3__c> newApps){
        Profile p = [Select Id,Name from Profile where Name = 'System Administrator'];
        if(userInfo.getProfileId()!=p.Id){
            set<Id> orgIds = new set<Id>();         
            set<Id> conIds = new set<Id>();
            map<Id,Application3__c> accIdtoAppId = new map<Id,Application3__c>();
            map<Id,Id> conNametoAccId = new map<Id,Id>();
            list<Application3__Share> appShares = new list<Application3__Share>();
            for(Application3__c a: newApps){
                if(a.Organization__c != null){
                    orgIds.add(a.Organization__c);
                    accIdtoAppId.put(a.Organization__c,a);
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
                          if(u.Id!=userInfo.getUserId() && accIdtoAppId.get(conNametoAccId.get(u.ContactId))!= null && accIdtoAppId.get(conNametoAccId.get(u.ContactId)).OwnerId != u.Id){                               
                            Application3__Share aShare = new Application3__Share();
                            aShare.ParentId = accIdtoAppId.get(conNametoAccId.get(u.ContactId)).Id;
                            aShare.userorgroupId = u.Id;
                            aShare.AccessLevel = 'Edit';
                            appShares.add(aShare);
                          }                         
                        }
                    }                   
                }
                if(appshares.size()>0){
                    insert appshares;
                }
                
                
            }
        }
    }
}