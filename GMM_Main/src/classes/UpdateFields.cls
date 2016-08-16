public class UpdateFields {

    public Contact c{get;set;}
    public ApexPages.StandardController stdCntrlr {get; set;}
    private boolean buttonAcceptUser;
    private boolean buttonRejectUser;
    
    /*public boolean getButtonAcceptUser(){
        return buttonAcceptUser;
    }
    public boolean getButtonRejectUser(){
        return buttonRejectUser;
    }*/
    
    
    //Variable for user deatails.
    User u;
    
    public UpdateFields(ApexPages.StandardController controller){
        stdCntrlr = controller;
        
        c = new Contact();
        c = [select Id,Status__c,RecordTypeId, AccountId, FirstName,with_Budget__c,W_O_Budget__c, LastName, Email,CommunityAuto__c from Contact Where Id=: ApexPages.currentPage().getParameters().get('Id')];
        
        //To get User deatils for matching the Organization - Start
        u= new User();
        list<User> userList = [Select Id, ContactId, Contact.AccountId from User where Id = :UserInfo.getUserId()];
        if(userList != null && !userList.isEmpty()){
            u = userList[0];
        }
        //To get User deatils for matching the Organization - End
    }
    
    public PageReference accept(){
        PageReference pr;
        if(u != null && c != null && u.Contact.AccountId == c.AccountId && c.RecordTypeId == Schema.SObjectType.Contact.getRecordTypeInfosByName().get('Grantee').getRecordTypeId()){
            try{
                if(c.Status__c == 'Accepted' ||c.Status__c == 'Rejected'){
                    if(c.Status__c == 'Accepted'){
                    ApexPages.addMessage(new ApexPages.message(ApexPages.SEVERITY.ERROR,'You cannot accept an already accepted User'));
                    return null;
                }else if(c.Status__c == 'Rejected'){
                    ApexPages.addMessage(new ApexPages.message(ApexPages.SEVERITY.ERROR,'You cannot accept an already rejected User'));
                    return null;
                }
            }else{
                list<Profile> p = new list<Profile>([Select Id, Name from Profile where Name = 'Applicant']);
                c.Status__c = 'Accepted';
                update c;
                //this.contactRecord = (Contact)stdCntrlr.getRecord();
                //enableDisableCustomButtons();
                User u = new User();
                u.FirstName=c.FirstName;
                u.LastName=c.LastName;
                u.Alias = (c.FirstName+''+c.LastName).substring(0,1);
                u.profileId=p[0].Id;
                u.Email=c.Email;
                u.Username=c.Email+'.grantee';
                u.ContactId=c.Id;
                u.CommunityNickname = c.FirstName+''+c.LastName+''+c.CommunityAuto__c;
                u.EmailEncodingKey = 'ISO-8859-1';
                u.LanguageLocaleKey = 'en_US';
                u.LocaleSidKey = 'en_US';
                u.TimeZoneSidKey = 'America/New_York';
                list<User> userList = [Select Id, Username from User where Username = :u.Username];
                if(userList != null && !userList.isEmpty()){
                    ApexPages.addMessage(new ApexPages.message(ApexPages.SEVERITY.ERROR,'UserName already Exists, Please select new username or consider changing email'));
                }else{
                   insert u;
                  //  Assignpermissiontouser.Assignpermissionwithbudget(c.id,u.id);

        /*            if(c.with_Budget__c == true && c.W_O_Budget__c== false)
                    {
                    Assignpermissiontouser.Assignpermissionwithbudget(c.id,u.id);
                    }
                    if(c.W_O_Budget__c == true && c.with_Budget__c == false)
                    {
                    Assignpermissiontouser.Assignpermissionwithoutbudget(c.id,u.id);
                    }
                    if(c.W_O_Budget__c == true && c.with_Budget__c == true)
                    {
                    Assignpermissiontouser.Assignpermissionboth(c.id,u.id);
                    } */
                    
                    pr = new PageReference('/'+c.Id);
                }
          }
            }catch(exception e){
                ApexPages.addMessage(new ApexPages.message(ApexPages.SEVERITY.ERROR,e.getMessage()));
            }
            //PageReference thisPage = ApexPages.currentPage();
        }else{
            System.debug('****');
            ApexPages.addMessage(new ApexPages.message(ApexPages.SEVERITY.ERROR,'System Error: Either you are trying to accept User of other Organization OR User Account may not be of type Grantee. Please check the condition and try again.'));
        }
        
        return pr;
    }
    
    public PageReference reject(){
        PageReference pr;
        if(u != null && c != null && u.Contact.AccountId == c.AccountId && c.RecordTypeId == Schema.SObjectType.Contact.getRecordTypeInfosByName().get('Grantee').getRecordTypeId()){
            try{
                if(c.Status__c == 'Accepted' ||c.Status__c == 'Rejected'){
                    if(c.Status__c == 'Accepted'){
                    ApexPages.addMessage(new ApexPages.message(ApexPages.SEVERITY.ERROR,'You cannot reject an already accepted User'));
                    return null;
                }else if(c.Status__c == 'Rejected'){
                    ApexPages.addMessage(new ApexPages.message(ApexPages.SEVERITY.ERROR,'You cannot reject an already rejected User'));
                    return null;
                }
            }else{
                c.Status__c = 'Rejected';
                update c;
                pr = new PageReference('/'+c.Id);
          }
            }catch(exception e){
                ApexPages.addMessage(new ApexPages.message(ApexPages.SEVERITY.ERROR,e.getMessage()));
            }
        }else{
            ApexPages.addMessage(new ApexPages.message(ApexPages.SEVERITY.ERROR,'System Error: Either you are trying to reject User of other Organization OR User Account may not be of type Grantee. Please check the condition and try again.'));
        }
        return pr;
    }
    /*private void enableDisableCustomButtons(){
        // IF Stage = Prospecting THEN 
        // disable Prospecting button and enable Closed Won and Closed Lost buttons
        if(c.Status__c == 'Accepted'){
            buttonAcceptUser = false;
            buttonRejectUser = false;
            //buttonClosedLost = false;
        }
        // IF Stage = Closed Won or Closed Lost THEN 
        // enable Prospecting button and disable Closed Won and Closed Lost buttons
        else if(c.Status__c == 'Rejected'){
            buttonAcceptUser = false;
            buttonRejectUser = false;
            //buttonClosedLost = true;
        }
   }*/
}