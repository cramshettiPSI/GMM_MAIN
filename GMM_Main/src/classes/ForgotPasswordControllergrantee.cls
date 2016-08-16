/**
 * An apex page controller that exposes the site forgot password functionality
 */
public with sharing class ForgotPasswordControllergrantee {
    public String username {get; set;}   
       
    public ForgotPasswordControllergrantee() {}
        
        public PageReference forgotPassword()
         {
         username = username +'.grantee';
         boolean success = Site.forgotPassword(username);
         PageReference pr = Page.ForgotPasswordConfirm;
                pr.setRedirect(true);
                
                if (success) {                          
                        return pr;
                }
                return null;
        }
        
        
}