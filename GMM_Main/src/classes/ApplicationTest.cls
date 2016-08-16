@isTest
private class ApplicationTest {
    
    public static ApplicationEditpageExt ext;
    public static CustomSendEmailController customExt;
    public static CustomSendEmailController customExt2;
    public static CustomSendEmailController customExt3;
    public static CustomSendEmailController customExt4;
    public static NofaSelectionCont nofaselectExt;
    public static NOFAtoApplicationUIExt nofaToAppExt;
    
    static testMethod void ApplicationHelperTest() {
        
        Application3__c app = UtilityClass.createApplication();  
        insert app;   
        
        Application3__c app2 = new Application3__c(Name='Test App 2');
        app2.RecordTypeId = Schema.SObjectType.Application3__c.getRecordTypeInfosByName().get('Application').getRecordTypeId();
        app2.Project__c = app.Project__c;
        app2.Status__c = 'In Progress';
        app2.Grantee_Status__c = 'In Progress';
        app2.NOFA_RFP__c = app.NOFA_RFP__c;
        app2.Type_of_Application__c = 'New';
        app2.Application_Feedback_Summary__c = 'Test';
        app2.State_and_or_Territories__c = 'GA,HI,VA';
        app2.Counties__c = 'Fairfax,Leesburg';
        app2.EO_12372_Process__c = 'No';
        app2.Other__c = 'test';
        app2.Applicant_Delinquent_on_any_Federal_Debt__c = 'No';
        app2.Evaluation_Summary_or_Plan__c =  'test';
        app2.Cost_Effectiveness_and_Budget_Adequacy__c = 'Test';
        app2.Organization_Capability__c = 'test';
        app2.Executive_Summary__c = 'Test';
        app2.Education__c = 'Teacher Corps'; 
        app2.Characteristics_Priorities__c = 'test';
        insert app2;
        
    }
    
    static testMethod void ApplicationEditTest(){
        Application3__c app = UtilityClass.createApplication();  
        insert app; 
        
        Apexpages.currentPage().getParameters().put('id',app.Id);
        
        ApexPages.StandardController controller = new ApexPages.StandardController(new Application3__c());
        ext = new ApplicationEditpageExt(controller);
        
        ext.edit();
        ext.getThis();
        ext.isContinuingApp = false;
        //ext.save1();
        ext.Validate();
        ext.SaveAsDraft();
        ext.cancel();
        
    }
    
    static testMethod void customSendEmailContTest(){
        Application3__c app = UtilityClass.createApplication();
        insert app;
        
        /*EmailTemplate emT = UtilityClass.createEmailTemplate();
        emT.Body = '{!User.Name},{!Application3__c.Comments__c},{!NOFA__c.CreatedBy},{Current Date},{Authorized Representative Name},{Legal Applicant Name}'+
        '{Authorized Representative TITLE},{Legal Applicant Address},{Prefix} {LastName},{Application ID},{NOFA Name},{Date of Applicant’s correspondence}'+
        '{Fiscal year},{CNCS Program Director Name},{CNCS Program Director Title},{CNCS Program Name},{Application Due Date},{Application Submission Date}'+
        '{Intent Due Date from Notice},{Director of OGPO Name},{Director of OGPO TITLE},{Office Title of OGPO}';        
        insert emT;*/
         
        Apexpages.currentPage().getParameters().put('appId',app.Id);
        Apexpages.currentPage().getParameters().put('toAddresses','testEmail@test.com');
        Apexpages.currentPage().getParameters().put('status','Accepted');
        Apexpages.currentPage().getParameters().put('tmpName','Concept_Paper_Approved');    
        //ApexPages.StandardController controller = new ApexPages.StandardController(new Application3__c());
        customExt = new CustomSendEmailController();
        customExt.sendEmails();
        customExt.cancel();        
        
        Apexpages.currentPage().getParameters().put('status',null);
        customExt2 = new CustomSendEmailController();
        customExt2.sendEmails();
        customExt2.cancel(); 
        
        Apexpages.currentPage().getParameters().put('appId',app.Id);
        Apexpages.currentPage().getParameters().put('toAddresses','testEmail@test.com');
        Apexpages.currentPage().getParameters().put('status','Rejected');
        Apexpages.currentPage().getParameters().put('tmpName','Concept_Paper_Rejected_Email');      
        //customExt = new CustomSendEmailController();
        customExt.sendEmails();
        customExt.cancel(); 
        
        /*Apexpages.currentPage().getParameters().put('appId',app.Id);
        Apexpages.currentPage().getParameters().put('toAddresses','testEmail@test.com');
        Apexpages.currentPage().getParameters().put('status','Return to Rework');
        Apexpages.currentPage().getParameters().put('tmpName','Application_Retrun_to_Rework');      
        //customExt = new CustomSendEmailController();
        customExt.sendEmails();
        customExt.cancel();
        
        Apexpages.currentPage().getParameters().put('appId',app.Id);
        Apexpages.currentPage().getParameters().put('toAddresses','testEmail@test.com');
        Apexpages.currentPage().getParameters().put('status','Accepted');
        Apexpages.currentPage().getParameters().put('tmpName','Application_Accepted');      
        //customExt = new CustomSendEmailController();
        customExt.sendEmails();
        customExt.cancel();
        
        Apexpages.currentPage().getParameters().put('appId',app.Id);
        Apexpages.currentPage().getParameters().put('toAddresses','testEmail@test.com');
        Apexpages.currentPage().getParameters().put('status','Rejected');
        Apexpages.currentPage().getParameters().put('tmpName','Application_Rejected');      
        //customExt = new CustomSendEmailController();
        customExt.sendEmails();
        customExt.cancel();*/
        
        Apexpages.currentPage().getParameters().put('appId',app.Id);
        Apexpages.currentPage().getParameters().put('toAddresses','testEmail@test.com');
        Apexpages.currentPage().getParameters().put('status','Appeal Approved');
        Apexpages.currentPage().getParameters().put('tmpName','Appeal_Approved_Notification');      
        customExt3 = new CustomSendEmailController();
        customExt3.sendEmails();
        customExt3.cancel();  
        
        Apexpages.currentPage().getParameters().put('appId',app.Id);
        Apexpages.currentPage().getParameters().put('toAddresses','testEmail@test.com');
        Apexpages.currentPage().getParameters().put('status','Non Compliant');
        Apexpages.currentPage().getParameters().put('tmpName','Non_Compliant_Notification');        
        customExt4 = new CustomSendEmailController();
        customExt4.sendEmails();
        customExt4.cancel();                        
    
    }
    
    static testMethod void nofaSelectionTest(){
        Application3__c app = UtilityClass.createApplication();
        insert app;
        
        
        Application3__c app2 = new Application3__c(Name='Test App 2');
        app2.RecordTypeId = Schema.SObjectType.Application3__c.getRecordTypeInfosByName().get('Application').getRecordTypeId();
        app2.Project__c = app.Project__c;
        app2.Status__c = 'In Progress';
        app2.Grantee_Status__c = 'In Progress';
        app2.NOFA_RFP__c = app.NOFA_RFP__c;
        app2.Type_of_Application__c = 'New';
        app2.Application_Feedback_Summary__c = 'Test';
        app2.State_and_or_Territories__c = 'GA,HI,VA';
        app2.Counties__c = 'Fairfax,Leesburg';
        app2.EO_12372_Process__c = 'No';
        app2.Other__c = 'test';
        app2.Applicant_Delinquent_on_any_Federal_Debt__c = 'No';
        app2.Evaluation_Summary_or_Plan__c =  'test';
        app2.Cost_Effectiveness_and_Budget_Adequacy__c = 'Test';
        app2.Organization_Capability__c = 'test';
        app2.Executive_Summary__c = 'Test';
        app2.Education__c = 'Teacher Corps'; 
        app2.Characteristics_Priorities__c = 'test';
        insert app2;
        
        Apexpages.currentPage().getParameters().put('parentId',app.Id);
        Apexpages.currentPage().getParameters().put('id',app2.Id);
        Apexpages.currentPage().getParameters().put('isContinuingApp','fasle');
        
        ApexPages.StandardController controller = new ApexPages.StandardController(new Application3__c());
        nofaselectExt = new NofaSelectionCont(controller);
        
        nofaselectExt.continueApp();
        nofaselectExt.cancel();       
        
        Apexpages.currentPage().getParameters().put('isContinuingApp','true');
        nofaselectExt.continueApp();    
        
    }
    
    static testMethod void NofaToApplicationTest(){
        Application3__c app = UtilityClass.createApplication();
  
        NOFA__c nofa = [Select Id,Name from NOFA__c where Id = :app.NOFA_RFP__c];
        
        Apexpages.currentPage().getParameters().put('id',app.NOFA_RFP__c);
        Apexpages.currentPage().getParameters().put('projectid',app.Project__c);
        Apexpages.currentPage().getParameters().put('primeApplicationId',app.Prime_Application__c); 
        
        ApexPages.StandardController controller = new ApexPages.StandardController(nofa);
        nofaToAppExt = new NOFAtoApplicationUIExt(controller);
        
        nofaToAppExt.getThis();
        nofaToAppExt.Validate();
        nofaToAppExt.SaveAsDraft();
        nofaToAppExt.createProject();
        //nofaToAppExt.save1();
        //nofaToAppExt.Validate();         
        
    }
    
}