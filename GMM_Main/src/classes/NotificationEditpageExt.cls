Public Class NotificationEditpageExt{

public Application3__c applicationInput {get; set;}
public String id;
Public NOFA__c Nofa{get;set;}

Public NotificationEditpageExt(ApexPages.StandardController controller){
  applicationInput=new Application3__c();
  id=Apexpages.currentPage().getParameters().get('id');
  If(id!=null && id!='')
  applicationInput= [Select id,Program_Design__c ,VISTA_Assignment__c ,Summary_of_Accomplishments__c ,Intermediary_Justification__c ,Leadership_and_Team__c ,
            Executive_Summary__c ,Organizational_Capacity__c, Cost_Effectiveness_and_Budget_Adequacy__c ,Clarification_Summary__c ,Continuation_Changes__c ,
            Other__c ,Amendment_Justification__c,Strengthen_Communities__c ,Evaluation_Summary_or_Plan__c,Recruitment_and_Development__c  ,
            Program_Management__c ,NOFA_RFP__c,Date_Received__c,Status__c,Type_of_Submission__c,Type_of_Application__c,
            State_Application_Identifier__c,Withdraw_Justification__c,Option__c,Applicant_Delinquent_on_any_Federal_Debt__c,Additional_Information__c,If_Yes_provide_your_explination_here__c,
            Review_by_State_Under_Executive_Order__c,Date_Received_by_State__c,Prefix__c,Organizational_Affiliation__c,First_Name__c,Title__c,Middle_Name__c,
            Telephone_Number__c,Last_Name__c,Email__c,Suffix__c,Project__c,Areas_Affected_by_Project_Cities_Coutn__c,Proposed_Start_Date__c,
            Proposed_End_Date__c,Documents_RSVP_Only__c,of_Unduplicated_Volunteers__c,Documents_Foster_Grandparents_Only__c,NOFA_RFP__r.Required__c,Authorized_Representative__c,Point_of_Contact__c,
            Describe_the_Application_Organization__c,Other_Application_Organization__c,Primary_Focus_Area__c,Identify_program_operating_site_s__c,Other_Program_Operating_Site__c,
            New_Apps_of_Apps_org_will_submit__c,Recompete_Apps_of_Apps_org_will_subm__c,No_of_App_for_Disaster_Services__c,No_of_Apps_for_Economic_Opportunity__c,No_of_Apps_for_Education__c,
            No_of_Apps_for_Environment_Stewardship__c,No_of_Apps_for_Healthy_Futures__c,No_of_Apps_for_Vets_Military_Families__c,No_of_Apps_for_Capacity_Building__c  FROM Application3__c where id = :id];
}
public PageReference edit() {   
    PageReference Redirect;
    If(id!=null && id!=''){
    Redirect = new PageReference('/apex/NotificationofIntenttoApply?id='+applicationInput.id);
    applicationInput.Status__c='';
    system.debug('Redirect id-->'+Redirect);
    return Redirect;
    }
    
    return null;
    }
public PageReference save() {   
    PageReference Redirect;
    If(id!=null && id!=''){
    Redirect = new PageReference('/apex/CombinedDetailPage?id='+applicationInput.id);
    applicationInput.Status__c='Submitted';
    update applicationInput;
       return Redirect;
    }
    return null;
}
}