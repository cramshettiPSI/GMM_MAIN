public class NotifyGranteeAdmin {
    //Constructor
    public NotifyGranteeAdmin(){
        
    }
    
    //method for notifying Grantee Admin
    public void notifyEmailGranteeAdmin(list<Contact> newContactList, map<Id,Contact> oldConMap){
        
        if(newContactList != null && !newContactList.isEmpty()){
            
            //set for Organization Id's
            set<Id> orgIds = new set<Id>();
            
            for(Contact c : newContactList){
                if(c.RecordTypeId == Schema.SObjectType.Contact.getRecordTypeInfosByName().get('Grantee').getRecordTypeId()){
                    //check if recordtype id updated.
                    //if(oldConMap != null && oldConMap.get(c.Id).RecordTypeId != c.RecordTypeId){
                        if(c.AccountId != null && oldConMap != null && oldConMap.get(c.Id).AccountId != c.AccountId){
                            orgIds.add(c.AccountId);
                        }
                    //}                 
                }
            }//end of For
            
            //map for Organizations
            map<Id,Account> accountMap = new map<Id,Account>();
            
            if(orgIds != null && !orgIds.isEmpty()){
                //retrieve Organizations along with Grantee Admin User Accounts.
                accountMap = new map<Id,Account>([Select Id, Name, (Select Id, Email from Contacts where RecordTypeId = : Schema.SObjectType.Contact.getRecordTypeInfosByName().get('Grantee Admin').getRecordTypeId()) from Account where Id IN : orgIds]);
                
                //varibale for emails list.
                list<Messaging.singleEmailMessage> emails = new list<Messaging.singleEmailMessage>();
                
                //Variable for email.
                Messaging.singleEmailMessage email;
                
                //Iterating on Account Map and preparing emails.
                for(Contact con : newContactList){
                    if(con.RecordTypeId == Schema.SObjectType.Contact.getRecordTypeInfosByName().get('Grantee').getRecordTypeId()){
                        //check if recordtype id updated.
                        //if(oldConMap != null && oldConMap.get(con.Id).RecordTypeId != con.RecordTypeId){
                            
                            if(con.AccountId != null && oldConMap != null && oldConMap.get(con.Id).AccountId != con.AccountID){
                                if(accountMap != null){
                                    if(accountMap.get(con.AccountId) != null){
                                        if(accountMap.get(con.AccountId).contacts != null && !accountMap.get(con.AccountId).contacts.isEmpty()){
                                            //intializing single email.
                                            email = new Messaging.singleEmailMessage();
                                            
                                            //setting the Grantee Contact Id for Taget Object for Merge fields.
                                            //email.setTargetObjectId(con.Id);
                                            
                                            //list vaibale for toaddressEmails
                                            list<string> toAdd = new list<string>();
                                            
                                            //add Grantee Admin Emails to To Address of Email.
                                            toAdd.add(accountMap.get(con.AccountId).contacts[0].Email);
                                            
                                            //Set ToAddress of Email
                                            email.setToAddresses(toAdd);
                                            
                                            /*//Query Email Template
                                            list<EmailTemplate> emailTemplateList = [Select Id, Name, DeveloperName from EmailTemplate where DeveloperName = 'GranteeAdminEmail'];
                                            if(emailTemplateList != null && !emailTemplateList.isEmpty()){
                                                //set Email Template Id
                                                email.setTemplateId(emailTemplateList[0].Id);
                                            }//end of IF*/
                                            
                                            // use the html body to set the content of the body
                                            email.setSubject('New User Created for your Organization - '+con.Organization_Name__c);
                                            email.setHtmlBody('Dear Admin,<br></br>A new Grantee User has been created for your Organization. Please login to the Grantee Portal and review the user to either Accept or Reject them to the system. <br></br>User Account Link : <a href="'+System.Label.Grantee_Portal_Link+'/'+con.Id+'?nooverride=1'+'">click here.</a>');
                                            
                                            //Add Emails to list for sending Mass Emails.
                                            emails.add(email);
                                        }//end of Account Map Contacts null IF.
                                                                            
                                    }//end of AccountMap contact Account Id null IF.
                                }//end of AccountMap null IF.
                            }//end if Account Id null IF.
                            
                            
                        //}//end of IF.
                        
                    }//end of RecordType Grantee check IF               
                }//end of For.
                
                //Send Emails.
                if(emails != null && !emails.isEmpty()){
                    Messaging.sendEmail(emails);
                }
                
            }//end of If
            
        }//end of If
        
    }//end of method notifyEmailGranteeAdmin
}