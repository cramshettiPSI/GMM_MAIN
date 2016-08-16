@istest

public class WithdrawapplicationTest{

    Private Static testmethod void TestWithdrawapplication(){    
    Application3__c objApp = new Application3__c();
        Pagereference pref = Page.CombinedDetailPage;
        test.setCurrentPage(pref);
        Application3__c testapp = UtilityClass.createApplication();
    Insert testapp;
        
        ApexPages.currentPage().getParameters().put('id',testapp.id);
        ApexPages.StandardController stdcon = new ApexPages.StandardController(testapp);
        Withdrawapplication obj_Withdrawapplication  = new Withdrawapplication(stdcon);
        obj_Withdrawapplication.reopen();
        obj_Withdrawapplication.OnHold();
        obj_Withdrawapplication.reopen1();
        obj_Withdrawapplication.reopen();
        obj_Withdrawapplication.reopenIntent();
        ///obj_Withdrawapplication.withdrawfunc();
      }
    Private Static testmethod void TestWithdrawapplication1(){    
        /*Application3__c testapp = UtilityClass.createApplication();  
        Insert testapp;*/
        
        Location__c testLoc = UtilityClass.createLocation();
        Insert testLoc; 
        
        Application3__c testapp = [Select Id,Name from Application3__c where Id = :testLoc.Application__c]; 
        
        ApexPages.currentPage().getParameters().put('id',testapp.id);
        ApexPages.StandardController stdcon = new ApexPages.StandardController(testapp);
        Withdrawapplication obj_Withdrawapplication  = new Withdrawapplication(stdcon);
        Pagereference pref = Page.CombinedDetailPage;
        test.setCurrentPage(pref);
        obj_Withdrawapplication.retrievebudgetStatusForApplication();
        obj_Withdrawapplication.Submitdetail();
        obj_Withdrawapplication.checkRequiredDocsAttached();
        //obj_Withdrawapplication.RecomForCNCS();
        obj_Withdrawapplication.AddLocations();
        obj_Withdrawapplication.Approve();
        obj_Withdrawapplication.HldforFormula();
        
        Pagereference pref1 = Page.ConceptpaperEdit;
        test.setCurrentPage(pref1);
        PageReference   objPageRef1 =  obj_Withdrawapplication.ConceptContinueBtnforStaff();
        obj_Withdrawapplication.ConceptContinueBtnforStaff();
        obj_Withdrawapplication.RecAwardsMethod();
    }
     Private Static testmethod void TestWithdrawapplication2(){   
       Account acc = UtilityClass.createOrganization();
       acc.o__c = 'Test Org char 1;Test Org char 2';
       acc.Organization_Type__c = 'Test Org Type 1;Test Org Type 2';
       insert acc;
         
       Application3__c testapp = UtilityClass.createApplication();
       testapp.Response_OC__c = 'Test org char 1';
       testapp.Response_TypeofOrg__c = 'Test org type 1';
       testapp.Response_Notification__c = 'Not Submitted';
       testapp.Organization__c = acc.Id;
       insert testapp;
       
       NOFA__c nofa = [Select Id,Name,Organization_Characteristics__c,Eligible_Org_Characteristics__c, Type_of_Organization__c, Eligible_Org_Types__c, 
       Notice_of_Intent_to_Apply_Submitted__c, Award_Amount__c, At_least_80_of_funds__c from NOFA__c where id = :testapp.NOFA_RFP__c];
       nofa.Organization_Characteristics__c = true;
       nofa.Eligible_Org_Characteristics__c = 'Test org char 1';
       nofa.Type_of_Organization__c  =  true;
       nofa.Eligible_Org_Types__c = 'Test org type 1';
       nofa.Notice_of_Intent_to_Apply_Submitted__c = true;
       nofa.Award_Amount__c = true;
       nofa.At_least_80_of_funds__c = true;
       update nofa;
       
       Pagereference pref = Page.CombinedDetailPage;
       test.setCurrentPage(pref);
       ApexPages.currentPage().getParameters().put('id',testapp.id);
       ApexPages.StandardController stdcon = new ApexPages.StandardController(testapp);
       Withdrawapplication obj_Withdrawapplication  = new Withdrawapplication(stdcon);
       obj_Withdrawapplication.confirmsign();
       obj_Withdrawapplication.cloneApp();
       obj_Withdrawapplication.completeComplianceReview();
       obj_Withdrawapplication.saveComplianceInfo();
     } 
     
     Private Static testmethod void TestWithdrawapplication3(){    
     Application3__c testapp = UtilityClass.createApplication();
     testapp.Prime_Application__c=null;
     Insert testapp;
     
        Pagereference pref = Page.CombinedDetailPage;
        test.setCurrentPage(pref);
        ApexPages.currentPage().getParameters().put('id',testapp.id);
        ApexPages.StandardController stdcon = new ApexPages.StandardController(testapp);
        Withdrawapplication obj_Withdrawapplication  = new Withdrawapplication(stdcon);  
        obj_Withdrawapplication.Approve();
        obj_Withdrawapplication.OnHold();
        obj_Withdrawapplication.Reject();
     }

     Private Static testmethod void TestWithdrawapplication4(){    
     Application3__c testapp = UtilityClass.createApplication();
     Insert testapp;
     
     String subject='Hello';
     List<String> addressesToSend = new List<String>{'ppandey@plan-sys.com'};
     String body= 'Welcome back';
        Pagereference pref = Page.CombinedDetailPage;
        test.setCurrentPage(pref);
        ApexPages.currentPage().getParameters().put('id',testapp.id);
        ApexPages.StandardController stdcon = new ApexPages.StandardController(testapp);
        Withdrawapplication obj_Withdrawapplication  = new Withdrawapplication(stdcon); 
        obj_Withdrawapplication.contApp();
        obj_Withdrawapplication.cloneApp();
        obj_Withdrawapplication.completeComplianceReview();
        obj_Withdrawapplication.saveComplianceInfo();
        obj_Withdrawapplication.Reject();
        obj_Withdrawapplication.Clone1();
       /// obj_Withdrawapplication.sendMail( subject, addressesToSend, body);
        obj_Withdrawapplication.Reject5();
       
        }
       Private Static testmethod void TestWithdrawapplication5(){    
    Application3__c objApp = new Application3__c();
        Pagereference pref = Page.CombinedDetailPage;
        test.setCurrentPage(pref);
        Application3__c testapp = UtilityClass.createApplication();
    Insert testapp;
        
        ApexPages.currentPage().getParameters().put('id',testapp.id);
        ApexPages.StandardController stdcon = new ApexPages.StandardController(testapp);
        Withdrawapplication obj_Withdrawapplication  = new Withdrawapplication(stdcon);  
        
        obj_Withdrawapplication.returntoRework();
        obj_Withdrawapplication.returntoReworkApp();
        obj_Withdrawapplication.ConceptContinueBtn(); 
        obj_Withdrawapplication.closePopup();
        obj_Withdrawapplication.showPopup();
        obj_Withdrawapplication.sendNCNotification();
        obj_Withdrawapplication.sendNCAfterReExam();
        obj_Withdrawapplication.sendAcceptedEmail();
        obj_Withdrawapplication.RecommendedtoCNCS();
        obj_Withdrawapplication.reload();
        obj_Withdrawapplication.confirmsign();
      }
      Private Static testmethod void TestWithdrawapplication6(){    
      Application3__c testapp = UtilityClass.createApplication();
      Insert testapp;
      System.Dmlexception ex;
        Pagereference pref = Page.CombinedDetailPage;
        test.setCurrentPage(pref);
       ApexPages.currentPage().getParameters().put('id',testapp.id);
       ApexPages.StandardController stdcon = new ApexPages.StandardController(testapp);
       Withdrawapplication obj_Withdrawapplication  = new Withdrawapplication(stdcon);  
      
      
        obj_Withdrawapplication.RecAwardsMethod(); 
        obj_Withdrawapplication.ApprovedforAward();
        obj_Withdrawapplication.contApp();
 }     
        public Static testmethod void TestWithdrawapplicationSubmit(){    
            Application3__c testapp = UtilityClass.createApplication();  
            testapp.Amendment_Justification__c = 'Test amend';
            testapp.Continuation_Changes__c = 'test  continuation';
            testapp.Clarification_Summary__c = 'test clarification';
            testapp.Cost_Effectiveness_and_Budget_Adequacy_C__c = 'test cost';
            testapp.Evaluation_Summary_or_Plan__c = 'test evaluation';
            testapp.Executive_Summary__c = 'test executive';
            testapp.Intermediary_Justification__c = 'test inter';
            testapp.Tools_and_Equipment__c = 'test tools';
            testapp.Need__c = 'test need';
            testapp.Organizational_Capability__c = 'test organization cap';
            testapp.Program_Design__c = 'test project';
            testapp.Project_Management__c = 'test project mana';
            testapp.Recruitment_and_Development__c = 'test recruitment';
            testapp.Strengthening_Communities__c = 'test stregnthen';
            testapp.Strengthen_Communities__c = 'test stregnthen';
            testapp.Other_Narrative__c = 'test';
            testapp.Safety_and_Security__c = 'test safety';
            testapp.Private_Match__c = 12;  
            testapp.Program_Management__c = 'test program management';      
            insert testapp;             
            
            NOFA__c Nofa = [Select Id,Name, n.Tools_and_Equipment_AP__c, n.Strengthening_Communities__c, 
            n.Safety_and_Security_AP__c, n.Recruitment_and_Development__c, n.Program_Management__c, n.Program_Design__c, n.Other__c, 
            n.Organizational_Capability__c, n.Need__c, n.Intermediary_Justification__c, n.Evaluation_Summary_of_Plan__c, n.Cost_Effectiveness_and_Budget_Adequacy__c, 
            n.Continuation_Changes__c, n.Clarification_Summary__c, n.Amendment_Justification__c From NOFA__c n where Id = :testapp.NOFA_RFP__c];
            Nofa.Tools_and_Equipment_AP__c = true;
            Nofa.Strengthening_Communities__c = true;
            Nofa.Safety_and_Security_AP__c = true;
            Nofa.Strengthening_Communities__c = true;
            Nofa.Recruitment_and_Development__c = true;     
            Nofa.Program_Management__c = true;
            Nofa.Program_Design__c = true;   
            Nofa.Other__c = true;
            Nofa.Organizational_Capability__c = true;
            Nofa.Need__c = true;
            Nofa.Intermediary_Justification__c = true;        
            Nofa.Evaluation_Summary_of_Plan__c = true;
            Nofa.Cost_Effectiveness_and_Budget_Adequacy__c = true;
            Nofa.Clarification_Summary__c = true;
            Nofa.Amendment_Justification__c = true;
            Nofa.Required__c = null;
            Nofa.Organization_Docs__c  = null;
            Nofa.Optional__c = null;
            update nofa;
            
            Location__c Location = new Location__c();
            Location.Application__c = testapp.Id;
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
            insert Location;
                                    
            ApexPages.currentPage().getParameters().put('id',testapp.id);
            ApexPages.StandardController stdcon = new ApexPages.StandardController(testapp);
            Withdrawapplication obj_Withdrawapplication  = new Withdrawapplication(stdcon);
            Pagereference pref = Page.CombinedDetailPage;
            test.setCurrentPage(pref);
            obj_Withdrawapplication.Submitdetail();
            
            nofa.Required__c = 'Doc Type 1;Doc Type 2';
            nofa.Organization_Docs__c = 'Doc Type 3;Doc Type 4';
            nofa.Optional__c = 'Doc Type 5;Doc Type 6';
            update nofa;
            
            ApexPages.currentPage().getParameters().put('id',testapp.id);
            ApexPages.StandardController stdcon2 = new ApexPages.StandardController(testapp);
            Withdrawapplication obj_Withdrawapplication2  = new Withdrawapplication(stdcon2);
            Pagereference pref2 = Page.CombinedDetailPage;
            test.setCurrentPage(pref);
            obj_Withdrawapplication2.Submitdetail();
            
            nofa.Review_Cycle__c = 'Post-Deadline';
            update nofa;
            
            ApexPages.currentPage().getParameters().put('id',testapp.id);
            ApexPages.StandardController stdcon3 = new ApexPages.StandardController(testapp);
            Withdrawapplication obj_Withdrawapplication3  = new Withdrawapplication(stdcon3);
            Pagereference pref3 = Page.CombinedDetailPage;
            test.setCurrentPage(pref);
            obj_Withdrawapplication3.Submitdetail();
            
            
        }
     

}