public with sharing class PrimeNofaSelectionCont {
    public Prime_Application__c PrimeApp{get;set;}
    public String id;
    public String parentId;    
    public PrimeNofaSelectionCont(ApexPages.StandardController controller) {
        id=Apexpages.currentPage().getParameters().get('id');
        parentId = Apexpages.currentPage().getParameters().get('parentId');
         If(id!=null && id!=''){
             PrimeApp=[Select id,Applicant_Delinquent_on_any_Federal_Debt__c,Assurances__c,Authorization__c,AutoNumber__c,Certification__c,CNCS_Corporate_Program__c,
            CNCS_Status__c,Competitive_or_Formula__c,Corporate_Program__c,Date__c,Demonstrates_Ethics_Integrity__c,EO_12372_Process__c,
            Ex_Officer_Cost_Share__c,Executive_Officer__c,FAPIIS_Review_Comments__c,Grants_Officer__c,If_yes_please_explain__c,
            If_yes_please_explain_app_delinque__c,Information_available__c,Issue_Area__c,Link__c,Master_Award__c,Mitigating_Circumstances__c,
            NOFA_RFP_ID__c,NOFO_RFP__c,NOFO_Fiscal_Year__c,NOFO_Name__c,Prime_Application__c,Prime_Application_Configured_BudgetForms__c,
            PrmAppOrgId__c,Program_End_Date__c,Program_Office_Director__c,Program_Officer__c,Program_Start_Date__c,Project_Director__c,
            Project_Name__c,Project_Website_URL__c,Recommended_Award_Amount__c,Satisfactory_Record_Executing_Programs__c,Senior_Grants_Officer__c,
            Senior_Program_Officer__c,State_Application_Identifier__c,Sub_Application_Due_Date__c,Sub_Concept_Paper_Due_Date__c,
            Subject_to_FAPIIS_Review__c,SumOfBudgetLines__c,Total_Recommended_MSYs__c,Type_of_Application__c FROM Prime_Application__c where id = :id];
         }                              
    }
    
    public PageReference continueApp(){
        PrimeApp.CNCS_Status__c = 'Submitted to CNCS';  
        Id appRecordTypeId = Schema.SObjectType.Application3__c.getRecordTypeInfosByName().get('Application').getRecordTypeId();
        list<Application3__c> appsToInsert = new list<Application3__c>();	    
		List<Application3__c> contApps = new List<Application3__c>();
		contApps = [Select id,Application__c,Module__c,Application_ID__c,Project_Directors__c,Program_Officers__c,Program_Officer__r.name,
                  Grants_Officer__r.name,Senior_Grants_Officer__r.name,Executive_Officer__r.name, Sub_Application__c, recordtype.name,NOFA_RFP__r.Other_NCCC_CP__c,
                  Withdraw_Justification__c,NOFA_RFP__r.Standard_CP__c,City__c,Legacy_App_ID__c, Project_Directorss__c,Subject_to_FAPIIS_Review__c ,Date_FAPIIS_Review__c,
                  Mitigating_Circumstances__c,FAPIIS_Review_Comments__c,Information_available_FAPIIS_Review__c,Satisfactory_Record_Executing_Programs__c,
                  Demonstrates_Ethics_Integrity__c,Corporate_Program__c,Application_Feedback_Summary__c,Energy_Efficiency_CP__c, Other_Energy_Efficiency_CP__c,
                  If_Yes_Please_Explain_Applicant_Deliquen__c , Opt_in_to_the_National_Service_Registry__c,If_Yes_Please_Explain_EO_12372__c ,Former_SPR_Code__c,
                  Addendum_to__c, SPR_Code__c,Project_Priority__c, Disaster_Number_Funding_DOE__c, Partner_Project_Code__c, Team_Mobility__c, Campus__c,
                  Primary_State_of_Service_Activities__c,Approved_Amount__c,Executive_Officer__c,Grants_Officer__c,Senior_Grants_Officer__c,Year_of_Grant__c,
                  Program_Officer__c,Tools_and_Equipment__c,Safety_and_Security__c,Other_Area_Affected_by_Project__c,Comments__c,
                  Cost_Effectiveness_Budget_Adequacy__c,If_other_please_specify_capacity__c,Other_Narrative__c,Name,If_other_please_specify_disaster__c,
                  Other_Application_Organization__c,Target_Populations1__c,NOFA_RFP_Summary__c,Focus_Area__c,If_other_please_specify_education__c,RecordTypeid,
                  Education__c,Characteristics_Priorities__c,Cost_Share__c,If_other_please_specify_Economic__c,Economic_Opportunities__c,If_other_please_specify_Health__c,
                  Capacity_Building__c,Healthy_Futures__c,If_other_please_specify_Enivironment_Ste__c,Environmental_Stewardship__c,Disaster_Services__c,
                  If_other_please_specify_Veterns__c,Veterans_Military_Families__c, AmeriCorps_logo_will_display_on_website__c,Number_of_elevator_speeches_created__c,
                  Number_of_members_wearing_logo_every_day__c,Other_Revenue__c,Number_of_ongoing_volunteers__c,Number_of_episodic_volunteers_generated__c,
                  Total_Match_Dollars__c,Private_Match__c,Local_State_Federal_Government_Match__c,EO_12372_Process__c,Authorized_Representative__c,Point_of_Contact__c,
                  Counties__c,State_and_or_Territories__c,Specify_if_you_want_to_be_in_more_rounds__c,Select_a_round__c,Disaster_Type__c,
                  How_many_teams_are_being_requested__c,Proposed_End_Date_is__c,Proposed_Start_Date_is__c,Project_website_urls__c,Applicant_User__c,Organization__c,
                  Assignee__c,Grantee_Status__c,Have_funding_history_with_any_CNCS_org__c,How_many_teams_are_being_requested_CP__c, 
                  Number_of_teams_to_complete_this_proj_CP__c,Specify_if_you_want_to_be_in_more_rou_CP__c,Disaster_Type_CP__c,Education_CP__c,Other_Education_CP__c ,
                  Veterans_and_Military_Families_CP__c,Disaster_Services_CP__c,Infrastructure_Improvement__c,If_other_please_specify_Enivronment__c,
                  Healthy_Futures_CP__c,Environment_Stewardship_CP__c,Capacity_Building_CP__c,Economic_Opportunities_CP__c,Target_Populations_CP__c,Need1__c,
                  Program_Design__c ,Organizational_Capacity__c ,Strengthen_Communities__c,Evaluation_Summary_or_Plan__c ,Program_Management__c,
                  Intermediary_Justification__c,Need__c,Clarification_Summary__c,Continuation_Changes__c,VISTA_Assignment__c,Summary_of_Accomplishments__c,
                  Leadership_and_Team__c,Organizational_Capability__c,Executive_Summary__c,Other__c,Amendment_Justification__c,
                  Strengthening_Communities__c,Recruitment_and_Development__c,NOFA_RFP__c,Date_Received__c,Status__c,Type_of_Submission__c,Type_of_Application__c,
                  State_Application_Identifier__c,Option__c,Applicant_Delinquent_on_any_Federal_Debt__c,Additional_Information__c,If_Yes_provide_your_explination_here__c,
                  Review_by_State_Under_Executive_Order__c,Date_Received_by_State__c,Prefix__c,Organizational_Affiliation__c,First_Name__c,Title__c,Middle_Name__c,
                  Telephone_Number__c,Last_Name__c,Email__c,Suffix__c,Project__c,Areas_Affected_by_Project_Cities_Coutn__c,Proposed_Start_Date__c,Proposed_End_Date__c,
                  Documents_RSVP_Only__c,of_Unduplicated_Volunteers__c,Documents_Foster_Grandparents_Only__c,Other_Veterans_and_Military_Families_CP__c,
                  If_other_please_specify_Infrastructure__c,Program_Type__c,If_other_please_specify_Energy__c,Environmental_Stewardship_Conservation__c,
                  Otherobjectives__c,Energy_Conservation__c,Natural_and_Other_Disasters__c,Other_Disaster_Services_CP__c,Other_Healthy_Futures_CP__c,
                  Other_Environment_Stewardship_CP__c,Other_Capacity_Building_CP__c,Other_Economic_Opportunities_CP__c,Natural_and_Other_Disasters_CP__c,
                  Other_Natural_and_Other_Disasters_CP__c,Other_Environmental_Steward_Conserv_CP__c,Environmental_Stewardship_Conservation_C__c,Energy_Conservation_CP__c,
                  Other_Energy_Conservation_CP__c,Infrastructure_Improvement_CP__c,Urban_and_Rural_Development_CP__c,NOFA_RFP__r.Focus_Areas_and_Objectives_NCCC_CP__c,
                  Amendable__c,Other_Infrastructure_Improvement_CP__c,Reject_Comments__c,Other_Urban_and_Rural_Development_CP__c,Urban_and_Rural_Development__c,
                  If_other_please_specify_Urban__c,NOFA_RFP__r.Required__c, NOFA_RFP__r.Organization_Docs__c,Submitted_By__c,NOFA_RFP__r.Review_Cycle__c,Submitted_Late__c,
                  Late_Submission_Justification__c,Senior_Program_Officer__c,Program_Office_Director__c,Ex_Officer_Cost_Share__c,Recommended_Award_Amount__c,
                  Total_Recommended_MSYs__c,Issue_Area__c,Staff_Decision_Comments__c,Red_Flag_Count__c,Red_Flags__c,CreatedById,NOFA_RFP__r.CNCS_Corporate_Program__r.Name,
                  Organization__r.DUNS__C,Prime_Application__r.Project_Director__c,Prime_Application__r.CreatedBy.Email,Prime_Application__c,
                  Compliance_Determination__c,Staff_Comments__c,Response_TS__c,Compliance_Flag__c,Staff_Verified_TS__c,Response_TypeofOrg__c,Compliance_Flag_TypeofOrg__c,
                  Staff_Verified_TypeofOrg__c,Response_CoA__c,Compliance_Flag_CoA__c,Staff_Verified_CoA__c,Response_Notification__c,Compliance_Flag_Notification__c,
                  Staff_Verified_Notification__c,Response_OC__c,Compliance_Flag_OC__c,Staff_Verified_OC__c,Response_AA__c,Compliance_Flag_AA__c,Staff_Verified_AA__c,
                  Response_Atleast_80_funds__c,Compliance_Flag_Atleast_80_funds__c,Staff_Verified_Atleast_80_funds__c,Response_Match_Met__c,Compliance_Flag_Match_Met__c,
                  Staff_Verified_Match_Met__c,Nofa_Rfp__r.Compliance_Standard_Questions__c,Nofa_Rfp__r.Notice_of_Intent_to_Apply_Submitted__c,
                  Nofa_Rfp__r.Type_of_Organization__c,Nofa_Rfp__r.Award_Amount__c,Nofa_Rfp__r.At_least_80_of_funds__c,Nofa_rfp__r.Compliance_Review_Required__c,
                  Organization__r.O__c,Organization__r.Organization_Type__c,Nofa_Rfp__r.Notification_of_Intent_to_Apply_Required__c,Nofa_Rfp__r.Eligible_Org_Types__c,
                  Nofa_Rfp__r.Eligible_Org_Characteristics__c,Nofa_Rfp__r.Lower_Threshold__c,Nofa_Rfp__r.Upper_threshold__c,Re_Examination__c, 
                  Non_Compliance_Re_Examination__c,Applicant_User__r.Email,Organization__r.Name,Project_Number__c,DUNS__c,Nofa_Rfp__r.Match_Met__c,Nofa_Rfp__r.Timely_Submission__c,rank__c,
                  Nofa_Rfp__r.Organization_Characteristics__c ,NOFA_RFP__r.Performance_Measures__c,NOFA_RFP__r.Standard_Information__c,NOFA_RFP__r.EIN_Information__c,
                  NOFA_RFP__r.Site_Date_Information__c,NOFA_RFP__r.Site_Type__c,NOFA_RFP__r.Additional_Operating_Site_Information__c,
                  NOFA_RFP__r.Volunteer_Information__c,NOFA_RFP__r.Focus_Area_and_Objectives_Location__c,NOFA_RFP__r.School_Information__c,
                  NOFA_RFP__r.Site_Type_and_Summer_Associates__c,NOFA_RFP__r.Lodging_Information__c   
                  FROM Application3__c where Prime_Application__c = :parentId and RecordTypeId = :appRecordTypeId];
                  
		if(contApps.size() > 0) {
		   for(Application3__c app:contApps){
		        	Application3__c newapp = new Application3__c();		 
		        	newapp.NOFA_RFP__c = PrimeApp.NOFO_RFP__c;       	
		        	newapp = app.clone();
		        	newapp.Status__c = 'In Progress';
		        	newapp.Grantee_Status__c = 'In Progress';
		        	appsToInsert.add(newapp);		        	
		   }		       	
		}
		
		if(appsToInsert.size()>0){
		   	insert appsToInsert;
		}      
        update PrimeApp;
    	PageReference pg = new PageReference('/apex/PrimeApplicationDetail?id='+PrimeApp.Id);
    //  PageReference pg = new PageReference('/e?'+PrimeApp.Id);
        if(ApexPages.currentPage().getParameters().get('isContinuingApp')=='false')
            pg.getParameters().put('isContinuingApp','false');
        if(ApexPages.currentPage().getParameters().get('isContinuingApp')=='true')
            pg.getParameters().put('isContinuingApp','true');
        pg.getParameters().put('parentId',parentId);
        pg.setRedirect(true);
        return pg;
    }
    
    public PageReference cancel(){
        PageReference pg; 
        //system.debug('isContinuingApp = '+isContinuingApp);
        if(ApexPages.currentPage().getParameters().get('isContinuingApp')=='true'){
            delete PrimeApp;
            pg = new PageReference('/'+Apexpages.currentPage().getParameters().get('parentId'));
        }else{
            system.debug('got here 2');
            pg = new PageReference('/'+Apexpages.currentPage().getParameters().get('parentId'));  
        }               
        pg.setRedirect(true);
        return pg;
    }

}