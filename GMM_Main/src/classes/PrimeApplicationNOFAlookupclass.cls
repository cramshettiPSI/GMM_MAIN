public with sharing class PrimeApplicationNOFAlookupclass {

public Prime_Application__c previousprimeapp{get;set;}
public string primeappid{get;set;}
private final Prime_Application__c  primapp;

public list<Master_Award__c> master = new list<Master_Award__c>();
public list<Master_Award__c> mastertoinsert = new list<Master_Award__c>();


public list<Application3__c> Application = new list<Application3__c>();
public list<Application3__c> Applicationtoinsert = new list<Application3__c>();

public list<Slot__c> slot = new list<Slot__c>();
public list<Slot__c> slottoinsert = new list<Slot__c>();

//public list<cb3__Budget_Settings__c> Budgetforms = new list<cb3__Budget_Settings__c>();
//public list<cb3__Budget_Settings__c> Budgetformstoinsert = new list<cb3__Budget_Settings__c>();



ApexPages.StandardController con;

    public PrimeApplicationNOFAlookupclass(ApexPages.StandardController controller) 
    {
        This.con = controller;
        
        // NOFAid = con.NOFO_RFP__c;
         
          this.primapp= (Prime_Application__c )con.getRecord();


    
      primeappid = ApexPages.currentPage().getParameters().get('parentId');

 previousprimeapp=[select  name,Applicant_Delinquent_on_any_Federal_Debt__c,If_yes_please_explain__c,If_yes_please_explain_app_delinque__c,Demonstrates_Ethics_Integrity__c,EO_12372_Process__c,Assurances__c,Authorization__c,Certification__c,CNCS_Status__c,Date__c,NOFO_RFP__c,Program_Officer__c,
                   
                  Program_Office_Director__c,Grants_Officer__c,NOFA_RFP_ID__c,NOFO_Name__c,
                  Executive_Officer__c,Prime_Application_Configured_BudgetForms__c,Program_End_Date__c,Program_Start_Date__c,Project_Director__c,Project_Name__c,Project_Website_URL__c,Recommended_Award_Amount__c,Satisfactory_Record_Executing_Programs__c,Senior_Grants_Officer__c,Senior_Program_Officer__c,State_Application_Identifier__c,Sub_Application_Due_Date__c,Sub_Concept_Paper_Due_Date__c,Subject_to_FAPIIS_Review__c,Total_Recommended_MSYs__c,Type_of_Application__c,Ex_Officer_Cost_Share__c,
                   Issue_Area__c,Link__c,
                   Information_available__c, Mitigating_Circumstances__c, FAPIIS_Review_Comments__c from Prime_Application__c where id=:primeappid];
  
 slot = [select id,Award__c,Enrollment_End_Date__c,Enrollment_Start_Date__c,Prime_Application__c from Slot__c where Prime_Application__c =: primeappid ];    
 
 master = [select id,Max_of_Award_Years__c,AR_Email__c,Award_ID__c,Balance_Undrawn__c,Balance_Unexpended__c,Commitment__c,Deobligated_at_Closeout__c,Drawdowns__c,Expenditures__c,Final_Closed_Amount__c,GO_Phone__c,GO_Title__c,Grants_Officer__c,Application__c,Number__c,Number_of_Amended_Awards__c,Number_of_Child_Awards__c,Number_of_Open_Monitoring_Activities__c,Obligation__c,Org_Address__c,Legal_Applicant_Name__c,Org_Name__c,PD_Email__c,Program_Officer__c,Project__c,Project_Director_Name__c,Project_Director_Title__c,Project_Name__c,Status__c,Total_Obligated_Amount__c,Total_Unexpended_Amount__c,Unobligated__c,Waiver_Approved__c,Prime_Application__c from Master_Award__c where Prime_Application__c =: primeappid ];  
 
//Budgetforms = [select id,cb3__Business_Unit__c,cb3__AP1AllocationDifference__c,cb3__AP2AllocationDifference__c,cb3__AP3AllocationDifference__c,cb3__AP4AllocationDifference__c,cb3__CB_AP_Account_1__c,cb3__CB_AP_Account_2__c,cb3__CB_AP_Account_3__c,cb3__CB_AP_Account_4__c,cb3__CNCS_Column__c,cb3__Column_1_Name__c,cb3__Column_2_Name__c,cb3__Column_3_Name__c,cb3__Column_4_Name__c,cb3__CostMatch__c,cb3__Description__c,cb3__Grantee_Share_Column__c,cb3__Title__c  from cb3__Budget_Settings__c where Prime_Application__c =: primeappid ];    
 
  Application  = [select id,NOFA_RFP__r.Other_NCCC_CP__c,Withdraw_Justification__c,NOFA_RFP__r.Standard_CP__c,City__c,Legacy_App_ID__c,Project_Directorss__c,Subject_to_FAPIIS_Review__c ,Date_FAPIIS_Review__c,Mitigating_Circumstances__c,FAPIIS_Review_Comments__c,Information_available_FAPIIS_Review__c,Satisfactory_Record_Executing_Programs__c,Demonstrates_Ethics_Integrity__c,Corporate_Program__c,Application_Feedback_Summary__c,Energy_Efficiency_CP__c, Other_Energy_Efficiency_CP__c,If_Yes_Please_Explain_Applicant_Deliquen__c ,Opt_in_to_the_National_Service_Registry__c,If_Yes_Please_Explain_EO_12372__c ,Former_SPR_Code__c, Addendum_to__c, SPR_Code__c,Project_Priority__c, Disaster_Number_Funding_DOE__c, Partner_Project_Code__c, Team_Mobility__c, Campus__c,Primary_State_of_Service_Activities__c,Approved_Amount__c,Executive_Officer__c,Grants_Officer__c,Senior_Grants_Officer__c,Year_of_Grant__c,Program_Officer__c,Tools_and_Equipment__c,Safety_and_Security__c,Other_Area_Affected_by_Project__c,Cost_Effectiveness_and_Budget_Adequacy_C__c,If_other_please_specify_capacity__c,Other_Narrative__c,Name,
                  If_other_please_specify_disaster__c,Other_Application_Organization__c,Target_Populations1__c,NOFA_RFP_Summary__c,Focus_Area__c,If_other_please_specify_education__c,RecordTypeid,Education__c,
                  Characteristics_Priorities__c,Cost_Share__c,If_other_please_specify_Economic__c,Economic_Opportunities__c,If_other_please_specify_Health__c,Capacity_Building__c,Healthy_Futures__c,If_other_please_specify_Enivironment_Ste__c,
                  Environmental_Stewardship__c,Disaster_Services__c,If_other_please_specify_Veterns__c,Veterans_Military_Families__c,AmeriCorps_logo_will_display_on_website__c,Number_of_elevator_speeches_created__c,
                  Number_of_members_wearing_logo_every_day__c,Other_Revenue__c,Number_of_ongoing_volunteers__c,Number_of_episodic_volunteers_generated__c,Total_Match_Dollars__c,Private_Match__c,Local_State_Federal_Government_Match__c,
                  EO_12372_Process__c,Authorized_Representative__c,Point_of_Contact__c,Counties__c,State_and_or_Territories__c,Specify_if_you_want_to_be_in_more_rounds__c,Select_a_round__c,Disaster_Type__c,How_many_teams_are_being_requested__c,
                  Proposed_End_Date_is__c,Proposed_Start_Date_is__c,Project_website_urls__c,Applicant_User__c,Organization__c,Assignee__c,Grantee_Status__c,Have_funding_history_with_any_CNCS_org__c,How_many_teams_are_being_requested_CP__c,
                  Number_of_teams_to_complete_this_proj_CP__c,Specify_if_you_want_to_be_in_more_rou_CP__c,Disaster_Type_CP__c,Education_CP__c,Other_Education_CP__c ,
                  Veterans_and_Military_Families_CP__c,Disaster_Services_CP__c,Infrastructure_Improvement__c,If_other_please_specify_Enivronment__c,Healthy_Futures_CP__c,Environment_Stewardship_CP__c,Capacity_Building_CP__c,
                  Economic_Opportunities_CP__c,Target_Populations_CP__c,Need1__c,Program_Design__c ,Organizational_Capacity__c ,Strengthen_Communities__c,Evaluation_Summary_or_Plan__c ,Program_Management__c,
                  Intermediary_Justification__c,Need__c,Clarification_Summary__c,Continuation_Changes__c,VISTA_Assignment__c,Summary_of_Accomplishments__c,Leadership_and_Team__c,Cost_Effectiveness_and_Budget_Adequacy__c,
                  Organizational_Capability__c,Executive_Summary__c,Other__c,Amendment_Justification__c,Strengthening_Communities__c,Recruitment_and_Development__c,NOFA_RFP__c,Date_Received__c,Status__c,
                  Type_of_Submission__c,Type_of_Application__c,State_Application_Identifier__c,Option__c,Applicant_Delinquent_on_any_Federal_Debt__c,Additional_Information__c,If_Yes_provide_your_explination_here__c,
                  Review_by_State_Under_Executive_Order__c,Date_Received_by_State__c,Prefix__c,Organizational_Affiliation__c,First_Name__c,Title__c,Middle_Name__c,Telephone_Number__c,Last_Name__c,Email__c,Suffix__c,Project__c,
                  Areas_Affected_by_Project_Cities_Coutn__c,Proposed_Start_Date__c,Proposed_End_Date__c,Documents_RSVP_Only__c,of_Unduplicated_Volunteers__c,Documents_Foster_Grandparents_Only__c,
                  Other_Veterans_and_Military_Families_CP__c,If_other_please_specify_Infrastructure__c,Comments__c,
                  Program_Type__c,If_other_please_specify_Energy__c,Environmental_Stewardship_Conservation__c, Otherobjectives__c,Energy_Conservation__c,Natural_and_Other_Disasters__c,Other_Disaster_Services_CP__c,
                  Other_Healthy_Futures_CP__c,Other_Environment_Stewardship_CP__c,Other_Capacity_Building_CP__c,Other_Economic_Opportunities_CP__c,Natural_and_Other_Disasters_CP__c,Other_Natural_and_Other_Disasters_CP__c,
                  Other_Environmental_Steward_Conserv_CP__c,Environmental_Stewardship_Conservation_C__c,Energy_Conservation_CP__c,Other_Energy_Conservation_CP__c,Infrastructure_Improvement_CP__c,Urban_and_Rural_Development_CP__c,
                  NOFA_RFP__r.Focus_Areas_and_Objectives_NCCC_CP__c,Other_Infrastructure_Improvement_CP__c,Reject_Comments__c,
                  Other_Urban_and_Rural_Development_CP__c,Urban_and_Rural_Development__c,If_other_please_specify_Urban__c,NOFA_RFP__r.Required__c,NOFA_RFP__r.Organization_Docs__c,Submitted_By__c,NOFA_RFP__r.Review_Cycle__c,
                  Submitted_Late__c,Late_Submission_Justification__c,Senior_Program_Officer__c,Program_Office_Director__c,Ex_Officer_Cost_Share__c,Recommended_Award_Amount__c,Total_Recommended_MSYs__c,Issue_Area__c,Staff_Decision_Comments__c,
                  Red_Flag_Count__c,Red_Flags__c,CreatedById,NOFA_RFP__r.CNCS_Corporate_Program__r.Name,Organization__r.DUNS__C,Prime_Application__r.Project_director__c,Prime_Application__r.Project_Name__r.Email__c,
                  Compliance_Determination__c,Staff_Comments__c,Response_TS__c,Compliance_Flag__c,Staff_Verified_TS__c,Response_TypeofOrg__c,Compliance_Flag_TypeofOrg__c,Staff_Verified_TypeofOrg__c,
                  Response_CoA__c,Compliance_Flag_CoA__c,Staff_Verified_CoA__c,Response_Notification__c,Compliance_Flag_Notification__c,Staff_Verified_Notification__c,Response_OC__c,
                  Compliance_Flag_OC__c,Staff_Verified_OC__c,Response_AA__c,Compliance_Flag_AA__c,Staff_Verified_AA__c,Response_Atleast_80_funds__c,Compliance_Flag_Atleast_80_funds__c,
                  Staff_Verified_Atleast_80_funds__c,Response_Match_Met__c,Compliance_Flag_Match_Met__c,Staff_Verified_Match_Met__c,Nofa_Rfp__r.Compliance_Standard_Questions__c,
                  Nofa_Rfp__r.Notice_of_Intent_to_Apply_Submitted__c,Nofa_Rfp__r.Type_of_Organization__c,Nofa_Rfp__r.Award_Amount__c,Nofa_Rfp__r.At_least_80_of_funds__c,
                  Nofa_rfp__r.Compliance_Review_Required__c,Organization__r.O__c,Organization__r.Organization_Type__c,Nofa_Rfp__r.Notification_of_Intent_to_Apply_Required__c,
                  Nofa_Rfp__r.Eligible_Org_Types__c,Nofa_Rfp__r.Eligible_Org_Characteristics__c,Nofa_Rfp__r.Lower_Threshold__c,Nofa_Rfp__r.Upper_threshold__c,
                  Re_Examination__c, Non_Compliance_Re_Examination__c,Applicant_User__r.Email ,Prime_Application__c  from Application3__c where Prime_Application__c =: primeappid and Status__c =: 'Held for Formula'];  
    }
    public pagereference cancel()
{ 
 pagereference Redirect = new PageReference('/apex/PrimeApplicationDetail?id='+primeappid);
            return Redirect;
 }   
    public pagereference cloneapplication()
    {
    Prime_Application__c clonedapp = new Prime_Application__c();
    
    clonedapp = previousprimeapp;
    // clonedapp.Name  = previousprimeapp.Name;
    clonedapp.id = null;
    clonedapp.Project_Name__c  = previousprimeapp.Project_Name__c;
    clonedapp.Applicant_Delinquent_on_any_Federal_Debt__c  = previousprimeapp.Applicant_Delinquent_on_any_Federal_Debt__c;
    clonedapp.Assurances__c  = previousprimeapp.Assurances__c;
    clonedapp.Authorization__c = previousprimeapp.Authorization__c;
    clonedapp.Certification__c = previousprimeapp.Certification__c;
    clonedapp.CNCS_Status__c  = previousprimeapp.CNCS_Status__c;
    clonedapp.Date__c  = previousprimeapp.Date__c;
    clonedapp.Demonstrates_Ethics_Integrity__c  = previousprimeapp.Demonstrates_Ethics_Integrity__c;
    clonedapp.EO_12372_Process__c = previousprimeapp.EO_12372_Process__c;
    clonedapp.Ex_Officer_Cost_Share__c = previousprimeapp.Ex_Officer_Cost_Share__c;
    clonedapp.Executive_Officer__c = previousprimeapp.Executive_Officer__c;
    clonedapp.FAPIIS_Review_Comments__c = previousprimeapp.FAPIIS_Review_Comments__c;
    clonedapp.Grants_Officer__c = previousprimeapp.Grants_Officer__c;
    clonedapp.If_yes_please_explain__c = previousprimeapp.If_yes_please_explain__c;
    clonedapp.If_yes_please_explain_app_delinque__c = previousprimeapp.If_yes_please_explain_app_delinque__c;
    clonedapp.Information_available__c= previousprimeapp.Information_available__c;
    clonedapp.Issue_Area__c = previousprimeapp.Issue_Area__c;
 // clonedapp.Link__c = previousprimeapp.Link__c;
    clonedapp.Mitigating_Circumstances__c = previousprimeapp.Mitigating_Circumstances__c;
  //  clonedapp.NOFA_RFP_ID__c= previousprimeapp.NOFA_RFP_ID__c;
    clonedapp.Prime_Application_Configured_BudgetForms__c= previousprimeapp.Prime_Application_Configured_BudgetForms__c;
    clonedapp.Program_End_Date__c = previousprimeapp.Program_End_Date__c;
    clonedapp.Program_Office_Director__c = previousprimeapp.Program_Office_Director__c;
    clonedapp.Program_Officer__c = previousprimeapp.Program_Officer__c;
    clonedapp.Program_Start_Date__c= previousprimeapp.Program_Start_Date__c;
   // clonedapp.Project_Name__r.Project_Director__c = previousprimeapp.Project_Name__r.Project_Director__c;
    clonedapp.Project_Name__c = previousprimeapp.Project_Name__c;
    clonedapp.Project_Website_URL__c= previousprimeapp.Project_Website_URL__c;
    clonedapp.Recommended_Award_Amount__c = previousprimeapp.Recommended_Award_Amount__c;
    clonedapp.Satisfactory_Record_Executing_Programs__c = previousprimeapp.Satisfactory_Record_Executing_Programs__c;
    clonedapp.Senior_Grants_Officer__c = previousprimeapp.Senior_Grants_Officer__c;
    clonedapp.Senior_Program_Officer__c= previousprimeapp.Senior_Program_Officer__c;
    clonedapp.State_Application_Identifier__c= previousprimeapp.State_Application_Identifier__c;
    clonedapp.Sub_Application_Due_Date__c= previousprimeapp.Sub_Application_Due_Date__c;
    clonedapp.Sub_Concept_Paper_Due_Date__c = previousprimeapp.Sub_Concept_Paper_Due_Date__c;
    clonedapp.Subject_to_FAPIIS_Review__c = previousprimeapp.Subject_to_FAPIIS_Review__c;
    clonedapp.Total_Recommended_MSYs__c = previousprimeapp.Total_Recommended_MSYs__c;
    clonedapp.Type_of_Application__c = previousprimeapp.Type_of_Application__c;
    clonedapp.NOFO_RFP__c =primapp.NOFO_RFP__c;
    insert clonedapp;
    
    for(Master_Award__c m : master )
    {
    m.id = null;
    m.Prime_Application__c = clonedapp.id;
    mastertoinsert.add(m);
    }
    
     for(Application3__c app : Application  )
    {
    app.id = null;
    app.NOFA_RFP__c= primapp.NOFO_RFP__c;
    app.Prime_Application__c = clonedapp.id;
    Applicationtoinsert.add(app);
    }
    for(Slot__C sl : slot  )
    {
    sl.id = null;
    sl.Prime_Application__c = clonedapp.id;
    slottoinsert.add(sl);
    }
 /* for(cb3__Budget_Settings__c bf : Budgetforms  )
  {
    bf.id = null;
    bf.Prime_Application__c = clonedapp.id;
    Budgetformstoinsert.add(bf);
    }
*/
    
    
    
    insert mastertoinsert;
     insert Applicationtoinsert;
     insert slottoinsert;
 // insert Budgetformstoinsert;
    
       pagereference Redirect = new PageReference('/apex/PrimeApplicationDetail?id='+clonedapp.id);
            return Redirect;
  
    }

}