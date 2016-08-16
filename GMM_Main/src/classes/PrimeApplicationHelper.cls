public without sharing class PrimeApplicationHelper {

    public static void shareRecords(list<Prime_Application__c> primeApps){
        list<Profile> profiles = new list<Profile>([Select Id,Name from Profile where Name = 'System Administrator' or Name = 'Grantee Admin' or Name = 'Applicant']);
        map<String,Id> pMap = new map<String,Id>();
        for(Profile p: profiles){
            pMap.put(p.Name,p.Id);
        }
        if(userInfo.getProfileId()!=pMap.get('System Administrator')){
            //set<Id> roleIds = new set<Id>();
            list<User> users = new list<User>([Select Id,Name,userRoleId from User where isActive = true and (ProfileId = :pMap.get('Grantee Admin') or ProfileId = :pMap.get('Applicant'))]);
            
            if(users.size()>0){
                list<Prime_Application__Share> pshares = new list<Prime_Application__Share>();
                for(Prime_Application__c p: primeApps){
                    if(p.CNCS_Status__c == 'Accepting Sub-Applications'){
                        for(User u: users){
                            Prime_Application__Share pShare = new Prime_Application__Share();
                            pShare.ParentId = p.Id;
                            pShare.userorgroupId = u.Id;
                            pShare.AccessLevel = 'Read';
                            pShares.add(pShare);
                        }
                    }
                }
                if(pShares.size()>0){
                    insert pShares;
                }
            }
        }
    }
    
    public static void updateFormulaSubAppsToAwarded(map<Id,Prime_Application__c> oldRecs, map<Id,Prime_Application__c> newRecs){
        Id appRTId = Schema.SObjectType.Application3__c.getRecordTypeInfosByName().get('Application').getRecordTypeId();
        set<Id> primeAppIds = new set<Id>();        
        for(Id i: newRecs.keyset()){
            if(oldRecs.get(i).CNCS_Status__c!=newRecs.get(i).CNCS_Status__c && newRecs.get(i).CNCS_Status__c == 'Awarded' && newRecs.get(i).Competitive_or_Formula__c == 'Formula' ){
                primeAppIds.add(i);
            }
        }
        system.debug('primeAppIds = '+primeAppIds);
        if(primeAppIds.size()>0){
            list<Application3__c> formulasubApps = new list<Application3__c>([Select Id,Status__c, Grantee_Status__c from Application3__c where Prime_Application__c in :primeAppIds and RecordTypeId = :appRTId]);
            system.debug('formulaSubApps = '+FormulaSubApps);
            if(formulasubApps.size()>0){
                for(Application3__c a: formulasubApps){
                    //a.Grantee_Status__c = 'Awarded'
                    a.Status__c = 'Awarded';
                }
                update formulasubApps; 
            }       
        }
    }
    
    public static void updateSubAppsToAccepted(map<Id,Prime_Application__c> oldRecs, map<Id,Prime_Application__c> newRecs){
        Id appRTId = Schema.SObjectType.Application3__c.getRecordTypeInfosByName().get('Application').getRecordTypeId();
        set<Id> primeAppIds = new set<Id>();        
        for(Id i: newRecs.keyset()){
            if(oldRecs.get(i).CNCS_Status__c!=newRecs.get(i).CNCS_Status__c && newRecs.get(i).CNCS_Status__c == 'Accepted' ){
                primeAppIds.add(i);
            }
        }
        system.debug('primeAppIds = '+primeAppIds);
        if(primeAppIds.size()>0){
            list<Application3__c> subApps = new list<Application3__c>([Select Id,Status__c, Grantee_Status__c from Application3__c where Prime_Application__c in :primeAppIds and RecordTypeId = :appRTId and Status__c = 'Pending Prime Award Approval']);            
            if(subApps.size()>0){
                for(Application3__c a: subApps){
                    //a.Grantee_Status__c = 'Awarded'
                    a.Status__c = 'Accepted';
                }
                update subApps; 
            }       
        }
    }
}