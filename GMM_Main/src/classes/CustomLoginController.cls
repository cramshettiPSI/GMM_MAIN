global with sharing class CustomLoginController {

    global String username {get; set;}
    global String password {get; set;}
    global CustomLoginController () {}
    global PageReference login() {
        System.Debug('=========='+Site.login(username, password,'/CommunitiesLanding' ));
        system.debug('username = '+username);
        system.debug('password = '+password);
       Contact cont = [select Encryptpassword__c from contact where email =: username order by lastmodifieddate desc limit 1];
       System.debug('cont'+cont);
       if(cont.Encryptpassword__c == null){
           cont.Encryptpassword__c = password;
           try {
               update cont;
           }
           catch(exception e){
               System.debug(e.getmessage());
           }
       }
       return Site.login(username+'.grantee', password,'/CommunitiesLanding' ); 
      
    } 
   public pagereference joincommunity(){
        return new pagereference('/granteeportal/CommunitiesCustomSelfRegPage');
    } 
    
  public pagereference createOrg(){
      pagereference pgRef = new pagereference ('/apex/CommunitiesCustomSelfRegPage');
        pgRef.setRedirect(true);
        return pgRef;
    } 
    
   public pagereference forgotPwd(){
        pagereference pgRef = new pagereference ('/apex/ForgotPassword');
        pgRef.setRedirect(true);
        return pgRef;        
        
    }
   
    
}