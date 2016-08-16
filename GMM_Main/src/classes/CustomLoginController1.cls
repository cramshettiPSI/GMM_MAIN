global with sharing class CustomLoginController1 {

    

    global String username {get; set;}
    global String password {get; set;}
    global CustomLoginController1 () {}
    global PageReference forwardToCustomAuthPage() {
        return new PageReference('/CommunitiesCustomSelfRegPage1');
    }
    global PageReference login() {
        System.Debug('=========='+Site.login(username+'.', password,'/CommunitiesLanding' ));
       return Site.login(username+'.expertreviewer', password,'/CommunitiesLanding' ); 
      
    } 
    public pagereference createOrg(){
      pagereference pgRef = new pagereference ('/apex/CommunitiesCustomSelfRegPage1');
        pgRef.setRedirect(true);
        return pgRef;
    } 
    
   public pagereference forgotPwd(){
        pagereference pgRef = new pagereference ('/apex/ForgotPassword');
        pgRef.setRedirect(true);
        return pgRef;        
        
    }
    
}