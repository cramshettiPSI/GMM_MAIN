public with sharing class NofaSendEmailsCont {
  private ApexPages.StandardController controller;
  
    public NofaSendEmailsCont(ApexPages.StandardController controller) {
    this.controller = controller;
    }
    
    public PageReference sendEmails(){
       Id recordId = controller.getId();
       system.debug('nofa id = '+recordId);
       set<String> templates = new set<string>{'Application_Accepted','Application_Rejected'};
       Id appRTID = Schema.SObjectType.Application3__c.getRecordTypeInfosByName().get('Application').getRecordTypeId();
       map<String,EmailTemplate> templateMap = new map<String,EmailTemplate>();
       list<EmailTemplate> emailTemplates = new list<EmailTemplate>([Select e.DeveloperName,e.Subject, e.Name, e.Id, e.Description, e.Body From EmailTemplate e where DeveloperName in :templates ]); 
       for(EmailTemplate e: emailTemplates){
         templateMap.put(e.DeveloperName,e);
       }
       List<Application3__c> apps = new List<Application3__c>([Select Id,RecordTypeId,Name,Status__c,Application_Feedback_Summary__c,Authorized_Representative__c,Authorized_Representative__r.Email,Authorized_Representative__r.Name,Grantee_Status__c from Application3__c where Nofa_Rfp__c = :recordId]);
       list<Id> acceptedIds = new list<Id>();
       list<Id> rejectedIds = new list<Id>();
       system.debug('apps = '+apps.size());
       if(apps.size()>0){
       	try{
         for(Application3__c a: apps){
           if(a.RecordTypeId == appRTID){
             system.debug('status = '+a.status__c);
             if(a.Status__c=='Accepted'){
               //send accepted email
               if(a.Authorized_Representative__c!=null){
                 /*acceptedIds.add(a.Authorized_Representative__c);    */           
                 //try{
                    String subject = templateMap.get('Application_Accepted').subject;    
                    String body = templateMap.get('Application_Accepted').body;
                    if(body.contains('{!Application3__c.Authorized_Representative__c}'))
                        body = (null == a.Authorized_Representative__c) ? body : body.replace('{!Application3__c.Authorized_Representative__c}',a.Authorized_Representative__r.Name); 
                    if(body.contains('{!Application3__c.Application_Feedback_Summary__c}'))
                        body = (null == a.Application_Feedback_Summary__c) ? body.replace('{!Application3__c.Application_Feedback_Summary__c}',' ') : body.replace('{!Application3__c.Application_Feedback_Summary__c}',a.Application_Feedback_Summary__c); 
                    Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage(); 
                    list<String> addressesToSend = new list<String>();        
                    addressesToSend.add(a.Authorized_Representative__r.Email);                                       
                    email.setSubject( subject );
                    email.setToAddresses( addressesToSend );
                    email.setPlainTextBody( body );                                                                   
                    Messaging.SendEmailResult [] r = Messaging.sendEmail(new Messaging.SingleEmailMessage[] {email});  
                 	//ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Successfully sent Accepted Emails'));
                    //return null;
                 
                 /*}
                 catch(Exception e){
                   ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Could not send emails,please contact your administrator: '+e));
                   return null;
                 }*/
               }                                       
             }
             else if(a.Status__c=='Rejected'){
               //send rejected email
               if(a.Authorized_Representative__c!=null){
                 /*rejectedIds.add(a.Authorized_Representative__c); */
                 //try{
                   String subject = templateMap.get('Application_Rejected').subject;    
                   String body = templateMap.get('Application_Rejected').body;
                   if(body.contains('{!Application3__c.Authorized_Representative__c}'))
                      body = (null == a.Authorized_Representative__c) ? body : body.replace('{!Application3__c.Authorized_Representative__c}',a.Authorized_Representative__r.Name); 
                   if(body.contains('{!Application3__c.Application_Feedback_Summary__c}'))
                      body = (null == a.Application_Feedback_Summary__c) ? body.replace('{!Application3__c.Application_Feedback_Summary__c}',' ') : body.replace('{!Application3__c.Application_Feedback_Summary__c}',a.Application_Feedback_Summary__c); 
                   Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage(); 
                   list<String> addressesToSend = new list<String>();        
                   addressesToSend.add(a.Authorized_Representative__r.Email);                                       
                   email.setSubject( subject );
                   email.setToAddresses( addressesToSend );
                   email.setPlainTextBody( body );                                                                   
                   Messaging.SendEmailResult [] r = Messaging.sendEmail(new Messaging.SingleEmailMessage[] {email});
                   //ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Successfully sent Rejection Emails'));
                   //return null;
                 /*}
                 catch(exception e){
                   ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Could not send emails,please contact your administrator '+e));
                   return null;
                 }*/
               }
             }
           }
         }
         ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.INFO,'Sent successfully emails'));
         return null;
       	}
       	catch(Exception e){
       		 ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Could not send emails,please contact your administrator '+e));
             return null;
       	}
         /*if(acceptedIds.size()>0){
           try{
             Messaging.MassEmailMessage emails=new Messaging.MassEmailMessage(); 
              emails.setTargetObjectIds(acceptedIds);
              emails.setTemplateId(templateMap.get('Application_Accepted').Id);
              //emails.setsubject(templateMap.get('Application_Accepted').subject);
              Messaging.SendEmail(New Messaging.MassEmailMessage[]{emails});
           }
           catch(exception e){
             
           }
         }
         system.debug('rejectedIds = '+rejectedIds.size());         
         if(rejectedIds.size()>0){
           try{
          Messaging.MassEmailMessage emails=new Messaging.MassEmailMessage(); 
              emails.setTargetObjectIds(rejectedIds);
              emails.setTemplateId(templateMap.get('Application_Rejected').Id);
              //emails.setsubject(templateMap.get('Application_Rejected').subject);
              Messaging.SendEmail(New Messaging.MassEmailMessage[]{emails});
           }
           catch(exception e){
             
           }
         }*/
         
       }
         /*PageReference pageRef = new PageReference('/'+recordId);
         pageRef.setRedirect(true);
         return pageRef;*/
         return null;
      
    }

}