public with sharing class UtilityClass {
    public static void insertFieldIds(){
        list<Field_Ids__c> values = new list<Field_Ids__c>();
        Field_Ids__c value1 = new Field_Ids__c(Name='Attachment Application', Id__c='CF00Nr0000000OB8Q_lkid');
        values.add(value1);
        Field_Ids__c value2 = new Field_Ids__c(Name='Attachment Award', Id__c='CF00Nr0000000OHGB_lkid');
        values.add(value2);
        Field_Ids__c value3 = new Field_Ids__c(Name='Attachment Award Reporting', Id__c='CF00Nr0000000ORtX_lkid');
        values.add(value3);
        Field_Ids__c value4 = new Field_Ids__c(Name='Attachment Contact', Id__c='CF00Nr0000000OR9y_lkid');
        values.add(value4);
        Field_Ids__c value5 = new Field_Ids__c(Name='Attachment Monitoring Activity', Id__c='CF00Nr0000000Oh4V_lkid');
        values.add(value5);
        Field_Ids__c value6 = new Field_Ids__c(Name='Attachment Nofa', Id__c='CF00Nr0000000OB3z_lkid');
        values.add(value6);
        Field_Ids__c value7 = new Field_Ids__c(Name='Attachment Organization', Id__c='CF00Nr0000000OGTx_lkid');
        values.add(value7);
        Field_Ids__c value8 = new Field_Ids__c(Name='Attachment Stage', Id__c='CF00Nr0000000OD8D_lkid'); 
        values.add(value8);
        insert values;                    
    } 
    
    public static Application3__c createApplication(){
        
        NOFA__c nofa = createNofa();
        nofa.NOFA_Type__c='New';
        // nofa.CNCS_Corporate_Program__c = testCorpProgram.Id;
       // nofa.Timely_Submission__c=true;
       // nofa.Organization_Characteristics__c=true;
        insert nofa;
        
        Project__c proj = createProject();
        insert proj;
        
        Prime_Application__c pm = createPrimeApplication();
        insert pm;
      
        cb3__Budget__c cp =cloudbudget();
       // insert cp;
        
        
        Account acc=createOrganization();
        insert acc;
      
        Contact c= createContact();
        c.Phone='1234567890';
        insert c;
        
        Application3__c app = new Application3__c(Name='Test App');
        app.RecordTypeId = Schema.SObjectType.Application3__c.getRecordTypeInfosByName().get('Application').getRecordTypeId();
        app.Project__c = proj.Id;
        app.Status__c = 'In Progress';
        app.Grantee_Status__c = 'In Progress';
        app.NOFA_RFP__c = nofa.Id;
        app.Type_of_Application__c = 'New';
        app.Application_Feedback_Summary__c = 'Test';
        app.State_and_or_Territories__c = 'GA,HI,VA';
        app.Counties__c = 'Fairfax,Leesburg';
        app.EO_12372_Process__c = 'No';
        app.Other__c = 'test';
        app.Applicant_Delinquent_on_any_Federal_Debt__c = 'No';
        app.Evaluation_Summary_or_Plan__c =  'test';
        app.Cost_Effectiveness_and_Budget_Adequacy__c = 'Test';
        app.Organization_Capability__c = 'test';
        app.Executive_Summary__c = 'Test';
        app.Education__c = 'Teacher Corps';
        app.Legacy_App_ID__c = 'test931';
        app.Prime_Application__c = pm.id;
        app.Compliance_Flag__c='Flagged';
        app.Authorized_Representative__c=c.id;
        app.Response_Notification__c='Submitted';
        app.Submitted_Late__c=true;
        app.Compliance_Determination__c='test';
        //app.cb3__Application_Budget_Template__c=acc.id;
        app.Status__c = 'Accepted';
        app.Mitigating_Circumstances__c='Yes';
        app.FAPIIS_Review_Comments__c='Test';
        app.Date_FAPIIS_Review__c=Date.newInstance(1960, 2, 17);
        //app.Application_Due_Date__c=system.today();
        //insert app;
        return app;
    }
    
    public static Application3__c createConceptPaper(){
        
        NOFA__c nofa = createNofa();
        // nofa.CNCS_Corporate_Program__c = testCorpProgram.Id;
        insert nofa;
        
        Project__c proj = createProject();
        insert proj;
       
        
        Application3__c app = new Application3__c(Name='Test Concept Paper');
        app.RecordTypeId = Schema.SObjectType.Application3__c.getRecordTypeInfosByName().get('Concept Paper').getRecordTypeId();
        app.Project__c = proj.Id;
        app.Status__c = 'In Progress';
        app.Grantee_Status__c = 'In Progress';
        app.NOFA_RFP__c = nofa.Id;
        app.Type_of_Application__c = 'New';
        app.Application_Feedback_Summary__c = 'Test';
        app.State_and_or_Territories__c = 'GA,HI,VA';
        app.Counties__c = 'Fairfax,Leesburg';
        app.EO_12372_Process__c = 'No';
        app.Other__c = 'test';
        app.Applicant_Delinquent_on_any_Federal_Debt__c = 'No';
        app.Evaluation_Summary_or_Plan__c =  'test';
        app.Cost_Effectiveness_and_Budget_Adequacy__c = 'Test';
        app.Organization_Capability__c = 'test';
        app.Executive_Summary__c = 'Test';
        app.Education__c = 'Teacher Corps';
        app.Legacy_App_ID__c = 'test931';
       // Compliance_Determination__c
        //app.Prime_Application__c = pm.id;
        //insert app;
        return app;
        
    }
    
    public static Application3__c createNotification(){
        
        NOFA__c nofa = createNofa();
        // nofa.CNCS_Corporate_Program__c = testCorpProgram.Id;
        insert nofa;
        
        Project__c proj = createProject();
        insert proj;
       
        
        Application3__c app = new Application3__c(Name='Test Concept Paper');
        app.RecordTypeId = Schema.SObjectType.Application3__c.getRecordTypeInfosByName().get('Notification of Intent to Apply').getRecordTypeId();
        app.Project__c = proj.Id;
        app.Status__c = 'In Progress';
        app.Grantee_Status__c = 'In Progress';
        app.NOFA_RFP__c = nofa.Id;
        app.Type_of_Application__c = 'New';
        app.Application_Feedback_Summary__c = 'Test';
        app.State_and_or_Territories__c = 'GA,HI,VA';
        app.Counties__c = 'Fairfax,Leesburg';
        app.EO_12372_Process__c = 'No';
        app.Other__c = 'test';
        app.Applicant_Delinquent_on_any_Federal_Debt__c = 'No';
        app.Evaluation_Summary_or_Plan__c =  'test';
        app.Cost_Effectiveness_and_Budget_Adequacy__c = 'Test';
        app.Organization_Capability__c = 'test';
        app.Executive_Summary__c = 'Test';
        app.Education__c = 'Teacher Corps';
        app.Legacy_App_ID__c = 'test931';
       // Compliance_Determination__c
        //app.Prime_Application__c = pm.id;
        //insert app;
        return app;
        
    }
    
    public static Prime_Application__c createPrimeApplication(){
        //NOFA__c nofa = createNofa();
        Prime_Application__c pm=new Prime_Application__c();
        //pm.NOFO_RFP__c = nofa.Id;
        return pm;
    }
    
    public static Account createOrganization(){
        Account acc = new Account(Name='Test Acc');
        acc.Address_1__c = 'Test Address';
        acc.City__c = 'Test City';
        acc.Phone__c = '4636366172';
        //insert acc;
        return acc;
    }
    
    public static Project__c createProject(){
        Account org = createOrganization();
        insert org;
        
        Project__c proj = new Project__c();
        proj.Organization__c = org.Id;
        proj.State__c = 'VA';
        proj.Project_Start_Date__c = Date.today();
        proj.Project_End_Date__c = Date.today().addDays(30);
        proj.Status__c = 'Open';
        proj.Project_Title__c = 'test';
        proj.Street_Address_1__c = 'test st';
        proj.City__c = 'test city';
        proj.Zip__c = '34321';
        proj.Phone__c = '4445431111';
        
        return proj;
        
    }
    
    public static CNCS_Corporate_Program__c createProgram(){
        CNCS_Corporate_Program__c testProgram = new CNCS_Corporate_Program__c(name='TestPro');
        testProgram.RecordTypeId = Schema.SObjectType.CNCS_Corporate_Program__c.getRecordTypeInfosByName().get('Program').getRecordTypeId();
        return testProgram;
    }
    
    public static CNCS_Corporate_Program__c createCorpProgram(){
        CNCS_Corporate_Program__c testCorpProgram = new CNCS_Corporate_Program__c(Name='TestCorp');
        testCorpProgram.RecordTypeId = Schema.SObjectType.CNCS_Corporate_Program__c.getRecordTypeInfosByName().get('Corporate Program').getRecordTypeId();
        testCorpProgram.Code_Corporate__c = 'TESTCP';
        return testCorpProgram; 
    }
    
    public static NOFA__c  createNofa(){
        
        CNCS_Corporate_Program__c testProgram = createProgram();
        insert testProgram;
        
        
        //CNCS_Corporate_Program__c testPro = [Select id,name from CNCS_Corporate_Program__c where id=:testProgram.id];
        
        CNCS_Corporate_Program__c testCorpProgram = createCorpProgram();
        testCorpProgram.CNCS_Corporate_Program_Name__c = testProgram.Id;
        insert testCorpProgram;
        
        NOFA__c nofa = new NOFA__c(NOFA_name__c='Test Nofa');
        nofa.Use_bands_on_review_consensus__c = 'Yes';
        nofa.Comp_Sub_Applications_Should_be_Ranked__c = 'Yes';
        nofa.Use_consensus_scores__c = 'Yes';
        nofa.RecordTypeId = Schema.SObjectType.NOFA__c.getRecordTypeInfosByName().get('NOFO').getRecordTypeId();
        nofa.Peer_Review_Start_Date__c = date.today();
        nofa.Peer_Review_End_Date__c = date.today().addDays(5);
        nofa.Review_Cycle__c = 'Rolling';
        nofa.Review_Type__c = 'Staff';
        nofa.CNCS_Corporate_Program__c = testCorpProgram.Id;
        //nofa.CNCS_Corporate_Program__c = testProgram.Id;
        nofa.Max_of_Award_Years__c = 1;
        nofa.Concept_Paper_Input_Deadline__c = Date.today().addYears(1);
        nofa.Required__c = 'Doc Type 1;Doc Type 2';
        nofa.Organization_Docs__c = 'Doc Type 3;Doc Type 4';
        nofa.Optional__c = 'Doc Type 5;Doc Type 6';
        nofa.Focus_Area_and_Objectives_Location__c = true;
        nofa.Timely_Submission__c=true;
        nofa.Compliance_Review_Required__c=true;
        nofa.Notification_of_Intent_to_Apply_Required__c='Required';
        nofa.Intent_to_Apply_Due_Date__c=Date.newInstance(1960, 2, 17);
        nofa.Application_Input_Deadline__c = Date.today().addYears(1);
        
        //insert acc;
        return nofa;
    }
    
    public static Monitoring_Activity__c createMonitoringActivity(){
        Grant_Monitoring__c gm = new Grant_Monitoring__c();
        insert gm;
        Monitoring_Plan__c mp = new Monitoring_Plan__c(Grant_Monitoring__c=gm.id,Monitoring_Fiscal_Year__c='2015');
        insert mp;
        
        Monitoring_Activity__c ma = new Monitoring_Activity__c(Monitoring_Plan__c=mp.Id,Monitoring_Fiscal_Year__c='2015');
        //ma.Monitoring_Fiscal_Year__c = '2015';
        return ma;
    }
    
    public static NOFA_Group__c createNofaGroup(){
        NOFA_Group__c ng = new NOFA_Group__c();
        //ng.Name = 'Test grp';
        ng.Status__c = 'Completed';
        ng.Review_of__c = 'Application';
        ng.Review_Type__c = 'Staff';
        return ng;
    }
    public static Reviewer_Pool__c createReviewerPool(){
        Reviewer_Pool__c rp = new Reviewer_Pool__c();
        rp.Status__c = 'Available';
        rp.Roles__c = 'test';
        return rp;
    }
    public static Contact createContact(){
        Contact c = new Contact();
        c.RecordTypeId = Schema.SObjectType.Contact.getRecordTypeInfosByName().get('Expert Reviewer').getRecordTypeId();
        c.Salutation ='MR.';
        c.Primary_Phone__c = '3837373772';
        c.Is_this_a_Mobile_Number__c = 'No';
        c.Email = 'test@gmail.com';
        c.Re_Enter_Email__c = 'test@gmail.com';
        c.Mailing_Street_Address_1__c = 'test street';
        c.Mailing_State__c = 'test state';
        c.Mailing_City__c = 'test city';
        c.State_of_Residence__c = 'DC';
        c.How_did_you_hear_about_CNCS_Reviews__c = 'google';
        c.Highest__c = 'Test';      
        c.FirstName = 'Test';
        c.LastName = 'Contact';
        c.Area_of_Expertise__c = 'CNCS';
        c.State_of_Residence__c = 'VA';
        c.Highest__c = 'Less Than High School';
        return c;       
    }
    
    public static list<History__c> createEducationHistory(){
        IPEDS__c inst = new IPEDS__c(Name ='Virginia State Univ');      
        insert inst;
        
        list<History__c> histList = new list<History__c>();
        History__c eduHistory = new History__c();
        eduHistory.Organization_Type1__c = 'Higher Learning';
        eduHistory.From__c = Date.newInstance(1960, 2, 17);
        eduHistory.To__c = Date.newInstance(1965,2,18);
        eduHistory.CollegeUniversity__c = inst.Id;
        eduHistory.RecordTypeId = Schema.SObjectType.History__c.getRecordTypeInfosByName().get('Education').getRecordTypeId();
        eduHistory.Dummyfield__c = false;
        eduHistory.Areas_of_Study_Degree_Details__c = 'Test Area';
        histList.add(eduHistory);
        
        History__c eduHistory2 = new History__c();
        eduHistory2.Organization_Type1__c = 'College';
        eduHistory2.From__c = Date.newInstance(1970, 2, 17);
        eduHistory2.To__c = Date.newInstance(1980,2,18);
       eduHistory2.CollegeUniversity__c = inst.Id;
        eduHistory2.RecordTypeId = Schema.SObjectType.History__c.getRecordTypeInfosByName().get('Education').getRecordTypeId();
        eduHistory2.Areas_of_Study_Degree_Details__c = 'test area 2';
        eduHistory.Dummyfield__c = true;
        histList.add(eduHistory2);
        
        return histList; 
        
    }
    
    public static list<History__c> createEmploymenthistory(){
        list<History__c> histList = new list<History__c>();
        History__c empHistory = new History__c();
        empHistory.Employer__c = 'Test Employer';
        empHistory.Organization_Type1__c = 'City-Wide Org';
        empHistory.empFrom__c = Date.newInstance(1960, 2, 17);
        empHistory.empTo__c = Date.newInstance(1965,2,18);
        empHistory.Area_of_Expertise__c = 'CNCS';
        empHistory.Experience_Type__c = 'Professional';
        empHistory.Expertise__c = 'Test';
        empHistory.Years_of_Experience__c = 5;
        empHistory.Job_Description__c = 'test';
        empHistory.RecordTypeId = Schema.SObjectType.History__c.getRecordTypeInfosByName().get('Employment').getRecordTypeId();
        empHistory.Dummyfield__c = false;
        histList.add(empHistory);
        
        History__c empHistory2 = new History__c();
        empHistory2.Employer__c = 'Test Employer';
        empHistory2.Organization_Type1__c = 'City-Wide Org';
        empHistory2.empFrom__c = Date.newInstance(1965, 2, 17);
        empHistory2.empTo__c = Date.newInstance(1970,2,18);
        empHistory2.Area_of_Expertise__c = 'CNCS';
        empHistory2.Experience_Type__c = 'Professional';
        empHistory2.Expertise__c = 'Test';
        empHistory2.Years_of_Experience__c = 5;
        empHistory2.Job_Description__c = 'test';
        empHistory2.RecordTypeId = Schema.SObjectType.History__c.getRecordTypeInfosByName().get('Employment').getRecordTypeId();
        empHistory2.Dummyfield__c = true;
        histList.add(empHistory2);
        
        return histList; 
    }
    
    public static Paneling__c createPanel(){
        Paneling__c panel = new Paneling__c();
        panel.Start_Date__c = date.today();
        panel.End_Date__c = date.today().adddays(5);
        return panel;
    }
    
    public static Stages__c createStage(){
        Stages__c stage = new Stages__c();
        stage.Type__c = 'Test';
        stage.roles__c = 'Panel Coordinator';
        stage.Start_Date__c = date.today();
        stage.End_Date__c = date.today().adddays(5);
        return stage;
    }
    
    public static User createUser(String ProfileName){
        Profile p = [Select Id,Name from Profile where Name = :ProfileName];
        User u = new User();
        u.ProfileId = p.Id;
        u.FirstName = 'Test User';
        u.LastName = 'for Test Method';
        u.Email = 'testuser@test.com';
        u.Username = 'testuser@test.com.sb25';
        u.Alias = 'talias';
        u.TimeZoneSidKey = 'America/New_York';
        u.EmailEncodingKey = 'ISO-8859-1';
        u.LanguageLocaleKey = 'en_US';
        u.LocaleSidKey = 'en_US';
        return u;
    }
    
    public static Location__c createLocation(){
        Application3__c App = createApplication();
        insert App;
        
        Location__c Location = new Location__c();
        Location.Application__c = App.Id;
        Location.Name = 'Test Location';
        Location.Is_this_a_K_12_school__c = 'Yes';
        Location.NCES_IDs__c = 'a2Dr0000000048l';
        Location.Accessible_for_people_with_disablities__c = true;
        Location.Description_of_Accessibility__c = 'Test Desc';     
        Location.Supervisor_Name__c = 'Test Name';
        Location.Supervisor_Phone_Number__c = '1234567890';
        Location.Location_Type__c = '   Service Location';
        Location.Education__c = 'Teacher Corps';
        Location.Veterans_Military_Families__c = 'Access & Attract';
        Location.Disaster_Services__c = 'Disaster Assistance Provided';
        Location.Environmental_Stewardship__c = 'At-Risk Ecosystems';
        Location.Healthy_Futures__c = 'Access to Care';
        Location.Capacity_Building__c = 'Effectiveness & Efficiency';
        Location.Economic_Opportunities__c = 'Asset Building';
        
        Location.RecordTypeId = Schema.SObjectType.Location__c.getRecordTypeInfosByName().get('Locations').getRecordTypeId();
        return Location;
  }
  
  public static Award__c createAward(){
        Application3__c App = createApplication();
        insert App;
        
        Award__c Award = new Award__c();
        Award.Application_ID__c = App.Id;
        Award.NOFA_Name__c = app.NOFA_RFP__c;       
        Award.Name = 'Test Award';
        //Award.Master_Award__c = 
        //Award.Prime_Application__c = 
        Award.Organization__c = app.Organization__c;
        Award.Grant_Status__c = 'Awaiting PO Certification';
        Award.Grant__c = 'Test127262';
        //Award.Number_of_Child_Awards__c = 1;
        Award.Amendment__c=0;
        Award.RecordTypeId = Schema.SObjectType.Award__c.getRecordTypeInfosByName().get('App Award').getRecordTypeId();
        return Award;
  }
  
  public static EmailTemplate createEmailTemplate(){
    
        Folder f = [Select Id,Name from Folder where DeveloperName = 'Application_Concept_Paper_Templates'];
        
        EmailTemplate emT = new EmailTemplate();
        emt.Name = 'Test Email Template';
        emt.DeveloperName = 'Test_Email_Template';
        emt.Subject = 'Test Subject';
        emt.IsActive = true;
        emt.FolderId = f.Id;
        emt.TemplateType = 'text';
        return emt;
  }
  
  public static cb3__Budget__c cloudbudget(){
  Account acc =createOrganization();
  cb3__Budget__c objBudgetApp=new cb3__Budget__c();
  objBudgetApp.cb3__Application_Budget_Template__c=acc.id;
  objBudgetApp.cb3__Status__c='Completed';
  return objBudgetApp;
  }
}