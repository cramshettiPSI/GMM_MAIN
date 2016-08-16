@isTest(seealldata=true)
public class AwardReportingHelperTest
{
    public static testmethod void method1()
    {
        Application3__c app = UtilityClass.createApplication();
        app.Proposed_Start_Date__c = Date.Today();
        insert app;
        
        Master_Award__c MasterAward = new Master_Award__c();
        MasterAward.Application__c = app.Id;
        MasterAward.Name = 'test34';
        MasterAward.Commitment__c = 10;
        MasterAward.Obligation__c= 1;
        insert MasterAward;
       
        Award__c Award = new Award__c();
        Award.Application_ID__c = app.Id;
        Award.Master_Award__c = MasterAward.Id;
        Award.NOFA_Name__c = app.NOFA_RFP__c;       
        Award.Name = 'Test Award';
        Award.Organization__c = app.Organization__c;
        Award.Grant_Status__c = 'Awaiting PO Certification';
        Award.Grant__c = 'Test127262';
        Award.Amendment__c=0;
        Award.RecordTypeId = Schema.SObjectType.Award__c.getRecordTypeInfosByName().get('App Award').getRecordTypeId();
        insert award;
        
    test.starttest();  
        
        Award_Reporting__c arep=new Award_Reporting__c();
        arep.Award__c=award.Id;
        arep.Expenditure_Comments__c='test';
        arep.Total_Fed_Funds_authorized_Cumulative__c=1000;
        arep.Recipient_share_of_exp_Cumulative__c=10;
        
        arep.Federal_Share_of_expenditures__c =5;
        arep.Fed_Share_of_expenditures_This_Period__c=5;
        
        arep.Total_Recipient_share_required__c =10;
        arep.Total_Federal_Funds_authorized__c =10;
        arep.Match_Comments__c='test';
        arep.Submitted_Date__c=Date.Today()+95;
        insert arep;
        arep.Submitted_Date__c=Date.Today()+100;
        update arep;
      
        arep.Total_Fed_Funds_authorized_Cumulative__c=2;
        arep.Recipient_share_of_exp_Cumulative__c=1;
        update arep;
        
        arep.Total_Fed_Funds_authorized_Cumulative__c=2;
        arep.Recipient_share_of_exp_Cumulative__c=10;
        update arep;
        
        arep.Submitted_Date__c=Date.Today()+190;
        update arep;
        arep.Total_Fed_Funds_authorized_Cumulative__c=100;
        arep.Recipient_share_of_exp_Cumulative__c=1;
        update arep;
        
        arep.Total_Fed_Funds_authorized_Cumulative__c=100;
        arep.Recipient_share_of_exp_Cumulative__c=79;
        update arep;
        
        arep.Total_Fed_Funds_authorized_Cumulative__c=100;
        arep.Recipient_share_of_exp_Cumulative__c=75;
        update arep;
        
        arep.Submitted_Date__c=Date.Today()+400;
        update arep;
        arep.Total_Fed_Funds_authorized_Cumulative__c=3;
        arep.Recipient_share_of_exp_Cumulative__c=1;
        update arep;
        arep.Total_Fed_Funds_authorized_Cumulative__c=10;
        arep.Recipient_share_of_exp_Cumulative__c=50;
        update arep;
       
        arep.Submitted_Date__c=Date.Today()+600;
        update arep;
        arep.Total_Fed_Funds_authorized_Cumulative__c=3;
        arep.Recipient_share_of_exp_Cumulative__c=1;
        update arep;
        arep.Total_Fed_Funds_authorized_Cumulative__c=10;
        arep.Recipient_share_of_exp_Cumulative__c=10;
        update arep;
        arep.Total_Fed_Funds_authorized_Cumulative__c=10;
        arep.Recipient_share_of_exp_Cumulative__c=9;
        update arep; 
        
        arep.Submitted_Date__c=Date.Today()+750;
        update arep;
        arep.Total_Fed_Funds_authorized_Cumulative__c=3;
        arep.Recipient_share_of_exp_Cumulative__c=1;
        update arep;
        arep.Total_Fed_Funds_authorized_Cumulative__c=10;
        arep.Recipient_share_of_exp_Cumulative__c=100;
        update arep;
        arep.Total_Fed_Funds_authorized_Cumulative__c=10;
        arep.Recipient_share_of_exp_Cumulative__c=10;
        update arep;         
       
        arep.Submitted_Date__c=Date.Today()+950;
        update arep;
        arep.Total_Fed_Funds_authorized_Cumulative__c=3;
        arep.Recipient_share_of_exp_Cumulative__c=1;
        update arep;
        arep.Total_Fed_Funds_authorized_Cumulative__c=10;
        arep.Recipient_share_of_exp_Cumulative__c=10;
        update arep;
        arep.Total_Fed_Funds_authorized_Cumulative__c=10;
        arep.Recipient_share_of_exp_Cumulative__c=9;
        update arep;       
        test.stoptest();
        
        
    }
     public static testmethod void method2()
    {
        Application3__c app = UtilityClass.createApplication();
        app.Proposed_Start_Date__c = Date.Today();
        insert app;
        
        Master_Award__c MasterAward = new Master_Award__c();
        MasterAward.Application__c = app.Id;
        MasterAward.Name = 'test34';
        MasterAward.Commitment__c = 10;
        MasterAward.Obligation__c= 1;
        insert MasterAward;
       
        Award__c Award = new Award__c();
        Award.Application_ID__c = app.Id;
        Award.Master_Award__c = MasterAward.Id;
        Award.NOFA_Name__c = app.NOFA_RFP__c;       
        Award.Name = 'Test Award';
        Award.Organization__c = app.Organization__c;
        Award.Grant_Status__c = 'Awaiting PO Certification';
        Award.Grant__c = 'Test127262';
        Award.Amendment__c=0;
        Award.RecordTypeId = Schema.SObjectType.Award__c.getRecordTypeInfosByName().get('App Award').getRecordTypeId();
        insert award;
       
     test.starttest();   
        
        Award_Reporting__c arep=new Award_Reporting__c();
        arep.Award__c=award.Id;
        arep.Expenditure_Comments__c='test';
        arep.Total_Fed_Funds_authorized_Cumulative__c=1000;
        arep.Recipient_share_of_exp_Cumulative__c=10;
        
        arep.Federal_Share_of_expenditures__c =5;
        arep.Fed_Share_of_expenditures_This_Period__c=5;
        
        arep.Total_Recipient_share_required__c =10;
        arep.Total_Federal_Funds_authorized__c =10;
        arep.Match_Comments__c='test';
        arep.Submitted_Date__c=Date.Today()+95;
        insert arep;
    
        arep.Submitted_Date__c=Date.Today()+1100;
        update arep;
        arep.Total_Fed_Funds_authorized_Cumulative__c=3;
        arep.Recipient_share_of_exp_Cumulative__c=1;
        update arep;
        arep.Total_Fed_Funds_authorized_Cumulative__c=10;
        arep.Recipient_share_of_exp_Cumulative__c=100;
        update arep;
        arep.Total_Fed_Funds_authorized_Cumulative__c=10;
        arep.Recipient_share_of_exp_Cumulative__c=10;
        update arep; 
                
        arep.Submitted_Date__c=Date.Today()+500;
        update arep;
        MasterAward.Commitment__c = 10;
        MasterAward.Obligation__c= 7;
        update MasterAward;
        update arep;
        MasterAward.Commitment__c = 1;
        MasterAward.Obligation__c= 10;
        update MasterAward;
        update arep;
        MasterAward.Commitment__c = 10;
        MasterAward.Obligation__c= 1;
        update MasterAward;
        update arep;
            
        arep.Submitted_Date__c=Date.Today()+800;
        update arep;
        MasterAward.Commitment__c = 10;
        MasterAward.Obligation__c= 7.5;
        update MasterAward;
        update arep;
        MasterAward.Commitment__c = 1;
        MasterAward.Obligation__c= 10;
        update MasterAward;
        update arep;
        MasterAward.Commitment__c = 10;
        MasterAward.Obligation__c= 1;
        update MasterAward;
        update arep;
        
        arep.Submitted_Date__c=Date.Today()+1100;
        update arep;
        MasterAward.Commitment__c = 10;
        MasterAward.Obligation__c= 8;
        update MasterAward;
        update arep;
        MasterAward.Commitment__c = 1;
        MasterAward.Obligation__c= 10;
        update MasterAward;
        update arep;
        MasterAward.Commitment__c = 10;
        MasterAward.Obligation__c= 1;
        update MasterAward;
        update arep;
        
        arep.Submitted_Date__c=Date.Today()+1600;
        update arep;
        MasterAward.Commitment__c = 10;
        MasterAward.Obligation__c= 8.5;
        update MasterAward;
        update arep;
        MasterAward.Commitment__c = 1;
        MasterAward.Obligation__c= 10;
        update MasterAward;
        update arep;
        MasterAward.Commitment__c = 10;
        MasterAward.Obligation__c= 1;
        update MasterAward;
        update arep;
       

      test.stoptest();    
    }
        
         public static testmethod void method3()
    {
      Profile p = [SELECT Id FROM Profile WHERE Name='Program Officer']; 
      User u = new User(Alias = 'standt', Email='standarduser@testorg.com', 
      EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
      LocaleSidKey='en_US', ProfileId = p.Id, 
      TimeZoneSidKey='America/Los_Angeles', UserName='standardusertesting@test.com');
        
        system.runas(u)
        {
            
      
        Application3__c app = UtilityClass.createApplication();
        app.Proposed_Start_Date__c = Date.Today();
        insert app;
        
        Master_Award__c MasterAward = new Master_Award__c();
        MasterAward.Application__c = app.Id;
        MasterAward.Name = 'test34';
        MasterAward.Commitment__c = 10;
        MasterAward.Obligation__c= 1;
        insert MasterAward;
 /*           
       Project__c proj = UtilityClass.createProject();
       insert proj; 
            
        Account acc= UtilityClass.createOrganization();
        insert acc;
  
        Contact c= UtilityClass.createContact();
        insert c;
      */     
        //Prime_Application__c pm=new Prime_Application__c(Name='Test Pm');
        //insert pm;
            
      test.starttest();       
        Award__c Award = new Award__c();
        Award.Application_ID__c = app.Id;
        Award.Master_Award__c = MasterAward.Id;
      //Award.Prime_Application__c = pm.Id;
        Award.NOFA_Name__c = app.NOFA_RFP__c;       
        Award.Name = 'Test Award';
        Award.Organization__c = app.Organization__c;
        Award.Grant_Status__c = 'Awaiting PO Certification';
        Award.Grant__c = 'Test127262';
        Award.Amendment__c=0;
        Award.RecordTypeId = Schema.SObjectType.Award__c.getRecordTypeInfosByName().get('App Award').getRecordTypeId();
        insert award;
        
        
        Award_Reporting__c arep=new Award_Reporting__c();
        arep.Award__c=award.Id;
        arep.Expenditure_Comments__c='test';
        arep.Total_Fed_Funds_authorized_Cumulative__c=1000;
        arep.Recipient_share_of_exp_Cumulative__c=10;
        
        arep.Federal_Share_of_expenditures__c =5;
        arep.Fed_Share_of_expenditures_This_Period__c=5;
        
        arep.Total_Recipient_share_required__c =10;
        arep.Total_Federal_Funds_authorized__c =10;
        arep.Match_Comments__c='test';
        arep.Submitted_Date__c=Date.Today()+95;
        insert arep;
            
        arep.Submitted_Date__c=Date.Today()+1900;
        update arep;
        MasterAward.Commitment__c = 10;
        MasterAward.Obligation__c= 9;
        update MasterAward;
        update arep;
        MasterAward.Commitment__c = 1;
        MasterAward.Obligation__c= 10;
        update MasterAward;
        update arep;
        MasterAward.Commitment__c = 10;
        MasterAward.Obligation__c= 1;
        update MasterAward;
        update arep;
     
      test.stoptest();    
    }
    }
}