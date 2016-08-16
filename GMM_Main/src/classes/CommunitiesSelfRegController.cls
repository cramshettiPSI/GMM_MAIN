/**
 * An apex page controller that supports self registration of users in communities that allow self registration
 */
public with sharing class CommunitiesSelfRegController {

    /*public Contact Con;
    String conEmail{get;set;}
    apexpages.standardController sController;*/
    
    public Contact contact {
    get {
            if (contact == null)
                contact = new Contact();
            return contact;
        }
        set;
    }
    
    public String firstName {get; set;}
    public String lastName {get; set;}
    public String email {get; set;}
    public String password {get; set {password = value == null ? value : value.trim(); } }
    public String confirmPassword {get; set { confirmPassword = value == null ? value : value.trim(); } }
    public String communityNickname {get; set { communityNickname = value == null ? value : value.trim(); } }
    
    public CommunitiesSelfRegController() {}
    
    /*public CommunitiesSelfRegController(ApexPages.StandardController stdController) {
        sController = stdController;
        this.Con = (Contact)stdController.getRecord();

    }*/
    
    
    private boolean isValidPassword() {
        return password == confirmPassword;
    }
    
    
    
    public pagereference Cancel(){
       pagereference pr  =new pagereference('/apex/Login_Page'); 
       return pr;
    
    }

    public PageReference registerUser() {
        system.debug('got here 1 ');
        try{
                String urlVal = Apexpages.currentPage().getUrl();
                system.debug('urlval = '+urlval);
                //If(urlVal.contains('CommunitiesCustomSelfRegPage')){
                if(contact.Email!=contact.Re_Enter_Email__c)
                {           
                    system.debug('got here 2 ');
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Info,'Email and Re-Enter Email address should be same.'));
                }
                //}
                /*else if(contact.New_Password__c!=contact.Re_Enter_Password__c)
                {           
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Info,'Password and Re-Enter Password should be same.'));
                }*/
                else
                {
                    system.Debug('========enter registeruser');
                    // it's okay if password is null - we'll send the user a random password in that case
                    if (!isValidPassword()) {
                    ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.ERROR, Label.site.passwords_dont_match);
                    ApexPages.addMessage(msg);
                    return null;
                }

                system.Debug('contact======='+contact);
                Profile prof = [Select Id, Name from Profile where Name = 'Customer Community Plus Login User'];
                String profileId = prof.Id; //'00et0000000QH5f';//'00et0000000QGiN';//'00et0000000QGiN'; //'00et0000000QGiN'; // To be filled in by customer.
                String roleEnum = 'External_Users';//'Externalusers'; // To be filled in by customer.
                Account accName = [Select Id, Name from Account where Name = 'PSI'];
                String accountId = accName.Id;//'001r0000004y5ai';//'001r00000058tim';//'001r0000004arr6'; // To be filled in by customer.
                system.Debug('contact======='+contact.id);
                contact.Accountid = accountId;
                if(firstName!=null&&firstName!='')
                    contact.firstname = firstname;
                system.debug('lastName = '+lastName);
                if(lastname!=null&&lastname!='')
                    contact.lastname = lastname;
                if(email!=null&&email!='')  
                    contact.email = email;
                //Contact.SSN__c = '12345';
                upsert contact;    
                String ContactId = contact.Id;
                System.debug('ContactId'+ContactId);
                //String userName = email;
                User u = new User(ProfileId = profileId);
                
                If(urlVal.contains('CommunitiesCustomSelfRegPage?')){
                    u.Username = contact.email+'.grantee';
                }
                else If(urlVal.contains('CommunitiesCustomSelfReg')){
                    u.Username = contact.email+'.statecommission';
                }
                else {
                    u.Username = contact.email;
                }
                u.Email = contact.Email;
                u.FirstName = contact.FirstName;
                u.LastName = contact.LastName;
                u.Contactid=contact.Id;
                u.CommunityNickname = contact.FirstName+''+contact.LastName;//communityNickname;
                system.debug(' CommunityNickname= '+ u.CommunityNickname);
                system.debug('user = '+accountId);
                system.debug('password= '+password);
                // system.Debug('============portaluser======'+Site.createPortalUser(u, accountId, password));
                
                //Commented by Sravan on 12/16/2015 - Start
                /*String userId = Site.createPortalUser(u, accountId, password);
                system.debug('userId = '+userId);
                if (userId != null) { 

                if (password != null && password.length() > 1) {
                return Site.login(u.userName, password, ApexPages.currentPage().getParameters().get('startURL'));
                // return Site.login(username, password, null);
                }
                else {*/
                //Commented by Sravan on 12/16/2015 - End
                
                //Added Code by Sravan on 12/23/2015 - Start
                list<User> userList = [Select Id, Username from User where Username = :u.Username];
                if(userList != null && !userList.isEmpty()){
                    //ApexPages.addMessage(new ApexPages.message(ApexPages.SEVERITY.ERROR,'UserName already Exists, Please select new username or consider changing email'));
                    ApexPages.addMessage(new ApexPages.message(ApexPages.SEVERITY.ERROR,'There is already an account associated with the email address entered. If you already have an account, please use the Forgot Password link to reset your password, or create an account using a unique email address.'));
                    return null;
                }else{
                    //Added IF Condition by Sravan on 12/16/2015
                    if(ContactId != null){
                        system.debug('In Else part ');              
                        PageReference page = new pagereference('/apex/SearchOrganization?uid='+ContactId+'&uname='+u.Username+'&password='+password);
                        page.setRedirect(true);
                        return page;
                    }
                }
                //Added Code by Sravan on 12/23/2015 - Start
                
                 //Commented by Sravan on 12/16/2015 - Start
                //}
                //}
                 //Commented by Sravan on 12/16/2015 - End
                }
            }
            catch(exception ex)
            {
                //ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Username Already exists'+ ex));
                //ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,ex.getMessage()));
            }
            return null;
            
    }
}