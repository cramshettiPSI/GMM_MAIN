/**
 * An apex page controller that exposes the change password functionality
 */
public with sharing class ChangePasswordController {
    public String oldPassword {get; set;}
    public String newPassword {get; set;}
    public String verifyNewPassword {get; set;}
    public String username {get; set;} 
    
    public PageReference changePassword() {
       Contact cont = [select Encryptpassword__c from contact where email =: username order by lastmodifieddate desc limit 1];
       if(cont.Encryptpassword__c == null || cont.Encryptpassword__c != verifyNewPassword){
           cont.Encryptpassword__c = verifyNewPassword;
           try {
               update cont;
           }
           catch(exception e){
               System.debug(e.getmessage());
           }
       }
        return Site.changePassword(newPassword, verifyNewPassword, oldpassword);    
    }     
    
    public pagereference intialchangepassword(){
        String startUrl = System.currentPageReference().getParameters().get('startURL');
        return Site.login(username, newpassword, startUrl);
    }
    public ChangePasswordController() {
    username = userinfo.getuseremail();
    }
}