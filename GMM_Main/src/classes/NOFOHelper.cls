public without sharing class NOFOHelper {
    public static void shareNofos(map<Id,NOFA__c> oldMap,map<Id,NOFA__c> newmap){
        try{
            list<NOFA__c> primeSubnofasToShare = new list<NOFA__c>();
            list<NOFA__c> nofasToShare = new list<NOFA__c>();
            set<Id> nofaIdsToDeleteShare = new set<Id>();
            list<User> allCustomPortalUsers = new list<User>();
            list<User> allCustomPortalUserswoSC = new list<User>();
            list<NOFA__Share> nofaSharesforAllPortalUsers = new list<NOFA__Share>();
            list<NOFA__Share> nofaSharesforAllPortalUserswoSC = new list<NOFA__Share>();
            set<String> allPortalProfiles = new set<String>{'State Commission Profile','Applicant','Grantee Admin','Expert Reviewers'};
            set<String> allPortalProfileswoSC = new set<String>{'Applicant','Grantee Admin','Expert Reviewers'};
            if(oldMap==null){
                for(NOFA__c n: newMap.values()){
                    if(n.Allow_Prime_Applicants_and_Sub_Applicant__c == 'Yes' && n.NOFA_Active_Inactive__c){
                        //share with state commission and all portal users
                        primeSubnofasToShare.add(n);
                    }else{
                        if(n.NOFA_Active_Inactive__c){
                            // share only with grantee, applicant, and expert reviewers
                            nofasToShare.add(n);
                        }
                    }
                }
            }else{
                for(NOFA__c n: newMap.values()){
                    if(oldMap.get(n.Id).Allow_Prime_Applicants_and_Sub_Applicant__c != newMap.get(n.Id).Allow_Prime_Applicants_and_Sub_Applicant__c &&
                        newMap.get(n.Id).Allow_Prime_Applicants_and_Sub_Applicant__c == 'Yes'){
                        if(n.NOFA_Active_Inactive__c){
                            //share with state commission and all portal users
                            primeSubnofasToShare.add(n);
                        }
                    }else{
                        if(oldMap.get(n.Id).NOFA_Active_Inactive__c != newMap.get(n.Id).NOFA_Active_Inactive__c && newMap.get(n.Id).NOFA_Active_Inactive__c){
                            // share only with grantee, applicant, and expert reviewers
                            nofasToShare.add(n);
                        }else{
                            if(newMap.get(n.Id).NOFA_Active_Inactive__c == false){
                                nofaIdsToDeleteShare.add(n.Id);
                            }
                        }
                    }
                }
            }
            system.debug('nofasToShare = '+nofasToShare);
            system.debug('primeSubnofasToShare = '+primeSubnofasToShare);
            
            
            if(primeSubnofasToShare.size()>0){
                allCustomPortalUsers = [Select Id,Name,Profile.Name from user where Profile.Name in :allPortalProfiles and IsActive = true];
                for(NOFA__c n: primeSubnofasToShare){
                    for(User u:allCustomPortalUsers){
                         NOFA__Share aShare = new NOFA__Share();
                         aShare.ParentId = n.Id;
                         aShare.userorgroupId = u.Id;
                         aShare.AccessLevel = 'Read';
                         nofaSharesforAllPortalUsers.add(aShare);
                    }
                }
                
            }
            if(nofaSharesforAllPortalUsers.size()>0){
                insert nofaSharesforAllPortalUsers;
            }
            system.debug('allCustomPortalUserswoSC = '+allCustomPortalUserswoSC);
            if(nofasToShare.size()>0){
                allCustomPortalUserswoSC = [Select Id,Name,Profile.Name from user where Profile.Name in :allPortalProfileswoSC and IsActive = true];
                for(NOFA__c n: nofasToShare){
                    for(User u:allCustomPortalUserswoSC){
                         NOFA__Share aShare = new NOFA__Share();
                         aShare.ParentId = n.Id;
                         aShare.userorgroupId = u.Id;
                         aShare.AccessLevel = 'Read';
                         nofaSharesforAllPortalUserswoSC.add(aShare);
                    }
                }           
            }
            system.debug('nofaSharesforAllPortalUsers = '+nofaSharesforAllPortalUsers);
            if(nofaSharesforAllPortalUserswoSC.size()>0){
                insert nofaSharesforAllPortalUserswoSC;
            }
            if(nofaIdsToDeleteShare.size()>0){
                list<NOFA__Share> nofaShares = new list<NOFA__Share>([Select Id from NOFA__Share where parentId in :nofaIdsToDeleteShare]);
                if(nofashares.size()>0){
                    delete nofashares;
                }
            }
        }
        catch( DMLException dmlEx ){
            for( Integer i = 0; i < dmlEx.getNumDml(); i++ ){
                String errorMessage = 'Error creation of Nofa Share: ' + dmlEx.getDmlMessage( i );         
                throw new ApexException(errorMessage);
            }

        }
    }
    
    

}