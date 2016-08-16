@isTest
private class NofaSendEmailsContTest {
	
	public static NofaSendEmailsCont sendEmailExt;
	
    Static testMethod void NofaSendEmailsContTest(){
    	Contact userAccount = UtilityClass.createContact();
    	insert userAccount;
    	
    	Application3__c app = UtilityClass.createApplication();
    	app.Authorized_Representative__c = userAccount.Id;
    	app.Status__c='Accepted';
    	insert app;
    	
    	
        Application3__c app2 = new Application3__c(Name='Test App 2');
		app2.RecordTypeId = Schema.SObjectType.Application3__c.getRecordTypeInfosByName().get('Application').getRecordTypeId();
		app2.Project__c = app.Project__c;
		app2.Status__c = 'Rejected';
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
        app2.Status__c = 'Rejected';
        app2.Legacy_App_ID__c = 'Test Id';
        app2.Authorized_Representative__c = userAccount.Id;
        insert app2;
    	
    	NOFA__c nofa = [Select Id,Name from NOFA__c where id = :app.NOFA_RFP__c];
    	
    	/*EmailTemplate emT = []
    	/*UtilityClass.createEmailTemplate();
    	emT.Name = 'Application Accepted';
    	emT.DeveloperName = 'Application_Accepted';
    	emt.Subject = 'Application Accepted';
    	emt.Body = '{!Application3__c.Authorized_Representative__c},{!Application3__c.Application_Feedback_Summary__c}';
    	insert emt;*/
    	
    	/*EmailTemplate emT2 = UtilityClass.createEmailTemplate();
    	emT2.Name = 'Application Rejected';
    	emT2.DeveloperName = 'Application_Rejected';
    	emT2.Subject = 'Application Rejected';
    	emT2.Body = '{!Application3__c.Authorized_Representative__c},{!Application3__c.Application_Feedback_Summary__c}';
    	insert emt2;*/
    	
    	ApexPages.StandardController controller = new ApexPages.StandardController(nofa);
    	sendEmailExt = new NofaSendEmailsCont(controller);
        sendEmailExt.sendEmails();   	
    	
    }
}