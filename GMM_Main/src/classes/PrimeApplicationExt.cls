/**
 *Apex class associated to PrimeApplicationDetailPage- Prime - Sub Model
 *=======================================================================
 *          Date           Purpose
 * Created : 12/29/2015    Initial version.
 * Created By:Prashant      -State Commison(Prime Applicant submit the ralated sub application to CNCS)
 *                          - Prime-Sub Amendment Flow
 *                          
 * Changes:  Request to everyone who ever change any thing plz add your changes and comment
 *          
 *          
 *          
 * ======================================================================
 **/

public class PrimeApplicationExt {

        public Prime_Application__c pc{get;set;}
        public Application3__c subapps{get;set;}
        public String id{get;set;}

                   
        public PrimeApplicationExt(ApexPages.StandardController controller) 
        {
             
           pc=(Prime_Application__c)controller.getRecord();
          
           id=ApexPages.currentPage().getParameters().get('id');
           pc=[select id,name,Competitive_or_Formula__c,State_Application_Identifier1__c,CNCS_Status__c,Prime_Application_Configured_BudgetForms__c,CNCS_Corporate_Program__c,Master_Award__c,NOFO_RFP__c,Type_of_Application__c,Program_Officer__c,Senior_Program_Officer__c,Program_Office_Director__c,Grants_Officer__c,Senior_Grants_Officer__c,Executive_Officer__c,Ex_Officer_Cost_Share__c,Recommended_Award_Amount__c,Total_Recommended_MSYs__c,Issue_Area__c,Subject_to_FAPIIS_Review__c,Date__c,Information_available__c,Satisfactory_Record_Executing_Programs__c,Demonstrates_Ethics_Integrity__c,Mitigating_Circumstances__c,FAPIIS_Review_Comments__c,
           NOFO_RFP__r.Cash_Grants_Awards__c            from Prime_Application__c where id=:pc.id];
           if(id!=null){
                String sUrlRewrite = System.URL.getSalesforceBaseUrl().getProtocol() 
                                       + '://' + System.URL.getSalesforceBaseUrl().getHost()
                                       + '/' + pc.Id;
                System.debug('11@@@'+sUrlRewrite);
           }
        }

       //Amendment logic to clone the prime application and sub application
        public PageReference Amend(){
            PageReference redirect;
            List<Application3__c> app_List = new List<Application3__c>();
            List<Application3__c> app_Clonedfrom_List = new List<Application3__c>();
            List<Application3__c> insertapp_List = new List<Application3__c>();
            Prime_Application__c primeappCloneFrom;
            Prime_Application__c newClonedprimeapp = new Prime_Application__c();
            if(id!=null){
                primeappCloneFrom=[select name,CNCS_Status__c,NOFO_RFP__c,Master_Award__c,Type_of_Application__c,Prime_Application_ID_Number__c from Prime_Application__c where id=:id];
                system.debug('pp@@'+primeappCloneFrom.Master_Award__c);
                newClonedprimeapp = primeappCloneFrom.clone(false,true);
                newClonedprimeapp.Prime_Application_ID_Number__c = primeappCloneFrom.Prime_Application_ID_Number__c + '-Cloned';
                newClonedprimeapp.Prime_Application__c=pc.id;
                newClonedprimeapp.NOFO_RFP__c=pc.NOFO_RFP__c;
                newClonedprimeapp.Type_of_Application__c='Amendment';
                newClonedprimeapp.CNCS_Status__c='In Progress';
                newClonedprimeapp.Master_Award__c=primeappCloneFrom.Master_Award__c;
                insert newClonedprimeapp;
                System.debug('New_Cloned_Record_ID'+newClonedprimeapp.id);
                //Sub Application clone      
                app_Clonedfrom_List = [SELECT Id, name FROM Application3__c WHERE Prime_Application__c = : id];
                for(Application3__c app : app_Clonedfrom_List){
                        Application3__c appCopy = app.clone(false,true);
                        appCopy.name = app.name + '-Cloned';
                        appCopy.Prime_Application__c = newClonedprimeapp.Id;
                        appCopy.NOFA_RFP__c=pc.NOFO_RFP__c;
                        appCopy.Amendable__c=true;
                        appCopy.Application__c=app.id;
                        app_List.add(appCopy);
             
                }
        
                if(!app_List.isEmpty())
                    insert app_List;
          
                if(!app_Clonedfrom_List.isEmpty())  
                    update app_Clonedfrom_List;         
                    redirect = new PageReference('/'+newClonedprimeapp.id);
                    return redirect;
         
                }
                return null;
        }
     
    
        public PageReference apply()
        {
            PageReference pr;
            pr=new PageReference( '/apex/projectlook?retURL='+pc.id+'&primeApplicationId='+pc.id +'&id='+pc.NOFO_RFP__c+'&opentoApps='+pc.CNCS_Status__c );
          
            return pr;    
        
        }
        
        public Boolean RecAwards {get;set;}
        public Boolean RecAwards1 {get;set;}
        
        public  PageReference RecAwardsMethod()
        { 
                
            List<Application3__c> subapps = new List<Application3__c>();
            Id ApplicationID=Schema.SObjectType.Application3__c.getRecordTypeInfosByName().get('Application').getRecordTypeId();
            subapps=[select id,name,status__c from Application3__c where Prime_Application__c=:pc.id and recordTypeId = :ApplicationID  and status__c != 'Rejected' and status__c != 'Held for Formula' and status__c != 'In Progress'];
            if(pc.Competitive_or_Formula__c == 'Competitive' || pc.Competitive_or_Formula__c == 'Formula'){
                for(Application3__c app:subapps){ 
                    if(app.status__c != 'Pending Prime Award Approval'){
                        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error, 'All Sub Applications should be in Pending Prime Award Approval Status in order to Recommend for Prime Award'));
                        return null;   
                    }
                }
            }
            pc.CNCS_Status__c = 'Recommended For Award'; 
            update pc;
            system.debug('upset in recommend for award method'+pc);   
            PageReference Redirect;
            Redirect = new PageReference('/apex/PrimeApplicationDetail?id='+pc.id);
            Redirect.setRedirect(false);
            RecAwards = true; 
            return Redirect;           
                   
        }
        
        public PageReference report()
        {
          PageReference Redirect;
         Redirect = new PageReference('/00Or0000000JzaI?pv0='+pc.id);
         Redirect.setRedirect(true);
           return Redirect;
        }
    
        public PageReference ApprovedforAward()
        {   
        	if((pc.Recommended_Award_Amount__c == null) && ((pc.NOFO_RFP__r.Cash_Grants_Awards__c=='Yes') || (pc.NOFO_RFP__r.Cash_Grants_Awards__c=='Optional' && pc.Program_Type__c=='Support Grant' ) || (pc.NOFO_RFP__r.Cash_Grants_Awards__c=='Optional' && pc.Program_Type__c=='Program Grant'))){
        	 ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.error,'Please enter Recommended Award Amount'));
                return null;
        	} 
           else{
           pc.CNCS_Status__c = 'Accepted'; 
           PageReference Redirect;
           // If(pc.id!=null && pc.id!='')
           // system.debug('Id = '+id);
           //Redirect = new PageReference('/'+id);
           update pc;
           Redirect = new PageReference('/apex/PrimeApplicationDetail?id='+pc.id);
           Redirect.setRedirect(true);
           return Redirect;
           }
    
        }
        
       public PageReference FormulaNOFAchange()
       {
           // pagereference pr = new pagereference('/apex/PrimeApplicationNOFAlookup?id='+pc.id); 
           // pr.setRedirect(true);
          // return pr;
                 
            try{
                Prime_Application__c newApp = new Prime_Application__c();                 
                newApp = pc.Clone(); 
                newApp.NOFO_RFP__c = null;      
                //newApp.Project__c = newProj.Id;
                insert newApp;
                PageReference pg = new PageReference('/apex/PrimeApplicationNOFAlookup?id='+newApp.Id);
               // pg.getParameters().put('isContinuingApp','true');
                pg.getParameters().put('parentId',pc.Id);
                pg.setRedirect(true);
                return pg;   
            }
            catch(Exception e){
                 ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error, 'Unable to create continuing Application due to '+e));                    
                 return null;
            }   
            return null;
    
     
        } 
   
       public PageReference submitsubApps(){ 
            Pagereference pg;
            /**List<Prime_Application__c> primesub =new List<Prime_Application__c>();
            primesub=[select id,name, (select id from Applications__r) from Prime_Application__c where id=:pc.id];
            system.debug('test@@'+primesub.size());**/
            List<Application3__c> subprime= new List<Application3__c>();
            subprime=[select id,name,status__c,Grantee_Status__c from Application3__c where Prime_Application__c=:pc.id AND Status__c = 'Recommended to CNCS' ];
            system.debug('test##'+subprime.size());
            if(subprime.size() > 0) {
                for(Application3__c apps:subprime){
                    apps.Status__c='Submitted to CNCS';
                    apps.Grantee_Status__c='Submitted to CNCS';
                }
                update subprime;
            }
            pc.CNCS_Status__c = 'Submitted to CNCS';
            update pc;
            pg = new pageReference('/apex/PrimeApplicationDetail?id='+pc.Id);
            pg.setRedirect(true);
            return pg;      
       }
   
      public PageReference ContPrimeApp(){
            try{
                Prime_Application__c newPrApp = new Prime_Application__c();                 
                newPrApp = pc.Clone(); 
                newPrApp.NOFO_RFP__c = null;  
                newPrApp.CNCS_Status__c = 'Draft';
              //  newPrApp.Project__c = newProj.Id;
                insert newPrApp;
                PageReference pg = new PageReference('/apex/PrimeNofaSelection?id='+newPrApp.Id);
                pg.getParameters().put('isContinuingApp','true');
                pg.getParameters().put('parentId',pc.Id);
                pg.setRedirect(true);
                return pg;   
            }
            catch(Exception e){
                 ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error, 'Unable to create continuing Application due to '+e));                    
                 return null;
            }   
            return null;
        }   
        
    
        public PageReference openSubApplications(){
           pc.CNCS_Status__c = 'Accepting Sub-Applications'; 
           PageReference Redirect;
           // If(pc.id!=null && pc.id!='')
           // system.debug('Id = '+id);
           //Redirect = new PageReference('/'+id);
           update pc;
           Redirect = new PageReference('/apex/PrimeApplicationDetail?id='+pc.id);
           Redirect.setRedirect(true);
           return Redirect;
        }
    
        public PageReference closeSubApplications(){
           pc.CNCS_Status__c = 'Closed to Sub-Applicants'; 
           PageReference Redirect;
           // If(pc.id!=null && pc.id!='')
           // system.debug('Id = '+id);
           //Redirect = new PageReference('/'+id);
           update pc;
           Redirect = new PageReference('/apex/PrimeApplicationDetail?id='+pc.id);
           Redirect.setRedirect(true);
           return Redirect;
        }
        
        public PageReference primeAppClone(){
            Prime_Application__c newPrApp = new Prime_Application__c();                 
            newPrApp = pc.Clone(); 
            newPrApp.CNCS_Status__c = 'In Progress';
            insert newPrApp;
            PageReference pg = new PageReference('/apex/PrimeApplicationDetail?id='+newPrApp.Id);
            
            pg.setRedirect(true);
            return pg;   
            //return null;
        }
        
        public PageReference CopyHeldFormulaApplications(){
             
            PageReference pg = new PageReference('/apex/CopyHeldFormulaApps?id='+pc.Id+'&nofaId='+pc.NOFO_RFP__c);            
            pg.setRedirect(true);
            return pg;              
            
        }
    
}