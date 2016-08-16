/**
 * An apex page controller that exposes the site forgot password functionality
 */
public with sharing class ForgotPasswordController {
    public String username {get; set;}   
    public String SiteUrl;
       
    public ForgotPasswordController() {
  //  String retval = Apexpages.currentPage().getUrl();
    
  // String fullval =  Site.getName();
 
   // String baseURL = URL.getSalesforceBaseUrl().toExternalForm(); 
   // String PageURL = ApexPages.currentPage().getUrl();  
  //  String wholeURL = baseURL+PageURL;
  
    SiteUrl = Site.getBaseUrl();
    system.debug('#######'+SiteUrl);
 //   String testval2 = Site.getDomain();
 
  //  String testval3 = Site.getSiteId();
  
       }
        
        public PageReference forgotPassword()
         {
         	if(username == null || username == ''){
         		ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Info,'Validation Error: Please enter a value in the Username Field'));
         		return null;
         	}
         if(SiteUrl.contains('grantee'))
         {
         username = username +'.grantee';
         }
        else if(SiteUrl.contains('expert'))
         {
         username = username +'.expertreviewer';
         }
          boolean success = Site.forgotPassword(username);
         PageReference pr = Page.ForgotPasswordConfirm;
                pr.setRedirect(true);
                
                if (success) {                          
                        return pr;
                }
                return null;
         
             }
     public pagereference cancel(){    
        return new Pagereference('/apex/Login_Page');
    }   
        
}