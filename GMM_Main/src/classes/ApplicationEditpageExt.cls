/********************************************************************************************
Class Name: ApplicationEditpageExt
Description: An apex controller for ApplicationEditpage.
             Displaying NofatoApplicationUI page section based on Checkboxes in NOFA Setup and after edit/Reopen the application detials page 

**********************************************************************************************
Modified By:Prashant 
Modified On:8/10/2015
Purpose:Coomment
**********************************************************************************************/





Public Class ApplicationEditpageExt{

    public Application3__c applicationInput {get; set;}
    public Boolean displayMsg{get;set;}
    public String id;
    Public NOFA__c Nofa{get;set;}
   //public ComponentData TargetPopulations {get;set;}
    public Boolean isContinuingApp {get;set;}

    public ApplicationEditpageExt getThis(){
     return this;
    }

    public ApplicationEditpageExt(ApexPages.StandardController controller){
          applicationInput=new Application3__c();
          displayMsg=False;
          id=Apexpages.currentPage().getParameters().get('id'); 
          String isContinuing = apexPages.currentPage().getParameters().get('isContinuingApp');
          isContinuingApp = false; 
          if(isContinuing == 'true')
             isContinuingApp = true;          
              
          If(id!=null && id!='')
             applicationInput=[Select id,NOFA_RFP__r.Name,Amendable__c,Withdraw_Justification__c,Legacy_App_ID__c,Application_Feedback_Summary__c,Former_SPR_Code__c, Opt_in_to_the_National_Service_Registry__c,Addendum_to__c, SPR_Code__c, If_Yes_Please_Explain_Applicant_Deliquen__c ,If_Yes_Please_Explain_EO_12372__c,Project_Priority__c, Disaster_Number_Funding_DOE__c, Partner_Project_Code__c, Team_Mobility__c, Campus__c,Other_Area_Affected_by_Project__c,Project_Director__c,Primary_State_of_Service_Activities__c,Approved_Amount__c,Executive_Officer__c,Grants_Officer__c,Senior_Grants_Officer__c,Year_of_Grant__c,Program_Officer__c,Tools_and_Equipment__c,Safety_and_Security__c,Cost_Effectiveness_Budget_Adequacy__c,If_other_please_specify_Infrastructure__c,
                              Infrastructure_Improvement__c,Other_Narrative__c,If_other_please_specify_Enivronment__c,Environmental_Stewardship_Conservation__c,Organizational_Capability__c,
                              If_other_please_specify_Energy__c,Energy_Conservation__c,Focus_Area__c,Otherobjectives__c,Natural_and_Other_Disasters__c,If_other_please_specify_capacity__c ,
                              If_other_please_specify_education__c ,If_other_please_specify_disaster__c,Program_Design__c ,Cost_Share__c,Need__c,VISTA_Assignment__c ,Characteristics_Priorities__c,
                              Program_Type__c,If_other_please_specify_Economic__c,AmeriCorps_logo_will_display_on_website__c,Economic_Opportunities__c,Number_of_elevator_speeches_created__c,
                              Capacity_Building__c,Number_of_members_wearing_logo_every_day__c,If_other_please_specify_Health__c,Healthy_Futures__c,If_other_please_specify_Enivironment_Ste__c,
                              Environmental_Stewardship__c,Disaster_Services__c,If_other_please_specify_Veterns__c,Education__c,Veterans_Military_Families__c,Strengthening_Communities__c,Number_of_ongoing_volunteers__c,
                              Number_of_episodic_volunteers_generated__c,Other_Revenue__c,Total_Match_Dollars__c,Private_Match__c,Local_State_Federal_Government_Match__c,Have_funding_history_with_any_CNCS_org__c,EO_12372_Process__c,
                              Counties__c,State_and_or_Territories__c,Specify_if_you_want_to_be_in_more_rounds__c,Disaster_Type__c,How_many_teams_are_being_requested__c,Select_a_round__c,Proposed_End_Date_is__c,
                              Proposed_Start_Date_is__c,Project_website_urls__c,Applicant_User__c,Assignee__c,Authorized_Representative__c,Point_of_Contact__c,Grantee_Status__c,Organization__c,Summary_of_Accomplishments__c ,
                              Intermediary_Justification__c ,Leadership_and_Team__c ,NOFA_RFP__r.Proposed_Dates__c,Comments__c,
                              Executive_Summary__c ,Target_Populations1__c,If_other_please_specify_Urban__c,Urban_and_Rural_Development__c,Organizational_Capacity__c, Cost_Effectiveness_and_Budget_Adequacy__c ,Clarification_Summary__c ,Continuation_Changes__c ,
                              Amendment_Justification__c,Strengthen_Communities__c ,Evaluation_Summary_or_Plan__c,Recruitment_and_Development__c  ,
                              Program_Management__c ,NOFA_RFP__r.id,Date_Received__c,Status__c,Type_of_Submission__c,Type_of_Application__c,
                              State_Application_Identifier__c,Option__c,Applicant_Delinquent_on_any_Federal_Debt__c,Additional_Information__c,If_Yes_provide_your_explination_here__c,
                              Review_by_State_Under_Executive_Order__c,Date_Received_by_State__c,Prefix__c,Organizational_Affiliation__c,First_Name__c,Title__c,Middle_Name__c,
                              Telephone_Number__c,Last_Name__c,Email__c,Suffix__c,Project__c,Areas_Affected_by_Project_Cities_Coutn__c,Proposed_Start_Date__c,rank__c,
                              Proposed_End_Date__c,Documents_RSVP_Only__c,of_Unduplicated_Volunteers__c,Documents_Foster_Grandparents_Only__c,NOFA_RFP__r.Required__c,NOFA_RFP__r.Organization_Docs__c,NOFA_RFP__r.Review_Cycle__c,City__c,
                              Application_Signed__c,Certifications_Clicked__c,Assurances_Clicked__c  FROM Application3__c where id = :id];
    }
    
    
     
    
    
     
     
     
    public PageReference edit() {                                                //Edit button logic 
        PageReference Redirect;
        If(id!=null && id!=''){
            Redirect = new PageReference('/'+id);
            update applicationInput;
            return Redirect;
        }       
        return null;
    }


    public PageReference SaveAsDraft(){
         PageReference Redirect;      
         try{    
             if(applicationInput.Application_Signed__c){
                applicationInput.Application_Signed__c = false;
                applicationInput.Authorized_Representative__c = null;
                applicationInput.Certifications_Clicked__c = false;
                applicationInput.Assurances_Clicked__c = false;
             }                
             update applicationInput;
             Redirect = new PageReference('/'+applicationInput.id);
             
             return Redirect;
         }
         catch(DMLException e){
            System.debug('@@@@@@@@!!!!!'+e.getmessage());
         }
  
         return null;
         
    }

    
    public boolean Validate()                                                                               //Required filed method for save as draft
    {
        if((applicationInput.Proposed_End_Date_is__c==null ||  applicationInput.Proposed_Start_Date_is__c==null) &&(applicationInput.NOFA_RFP__r.Proposed_Dates__c!=True)) 
        {
           applicationInput.Counties__c.addError('counties');
           applicationInput.Proposed_End_Date_is__c.addError('');
           applicationInput.Proposed_Start_Date_is__c.addError('');              
           return false;  
        }
 
        else
           return true;
    }
     
     
    public PageReference cancel(){
        PageReference pg; 
        system.debug('isContinuingApp = '+isContinuingApp);
        if(isContinuingApp){
            delete applicationInput;
            pg = new PageReference('/'+Apexpages.currentPage().getParameters().get('parentId'));
        }else{
            system.debug('got here 2');
            pg = new PageReference('/'+applicationInput.Id);  
        }               
        pg.setRedirect(true);
        return pg;
        
    }
 
}