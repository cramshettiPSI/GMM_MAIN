Public Class ConceptpapereditExt{

public Application3__c applicationInput {get; set;}
public Boolean displayMsg{get;set;}
public String id;
//Public String rectype{get;set;}
//Public String rectypename{get;set;}
Public NOFA__c Nofa{get;set;}

 public ConceptpapereditExt getThis(){
        return this;
 }

Public ConceptpapereditExt(ApexPages.StandardController controller){
  applicationInput=new Application3__c();
  displayMsg=False;
  id=Apexpages.currentPage().getParameters().get('id');
  If(id!=null && id!='')
  applicationInput=[Select Proposed_Start_Date_is__c,Point_of_Contact__c,City__c,Select_a_round__c,Specify_if_you_want_to_be_in_more_rou_CP__c,Comments__c,
                Energy_Efficiency_CP__c, Primary_State_of_Service_Activities__c,Other_Energy_Efficiency_CP__c,Proposed_End_Date_is__c,Infrastructure_Improvement_CP__c,
                NOFA_RFP__r.Economic_Opportunities_CP__c,NOFA_RFP__r.Disaster_Services_CP__c,NOFA_RFP__r.Environmental_Stewardship_CP__c,
                NOFA_RFP__r.Capacity_Building_CP__c,NOFA_RFP__r.Focus_Areas_and_Objectives_NCCC_CP__c,NOFA_RFP__r.Veterans_Military_Families_CP__c,
                NOFA_RFP__r.Education_CP__c,Tools_and_Equipment__c,Safety_and_Security__c,NOFA_RFP__r.Healthy_Futures_CP__c,Strengthen_Communities__c,
                Grantee_Status__c,Project_Website_URL_CP__c,Evaluation_Summary_or_Plan__c,Disaster_Type_CP__c,Number_of_teams_to_complete_this_proj_CP__c,
                How_many_teams_are_being_requested_CP__c,Other_Urban_and_Rural_Development_CP__c,Urban_and_Rural_Development_CP__c,Other_Infrastructure_Improvement_CP__c,
                Other_Environmental_Steward_Conserv_CP__c,Other_Energy_Conservation_CP__c,Energy_Conservation_CP__c,Environmental_Stewardship_Conservation_C__c,
                NCCC_Dates_CP__c,Other_Natural_and_Other_Disasters_CP__c,Standard_424__c,Natural_and_Other_Disasters_CP__c,   
              Cost_Effectiveness_Budget_Adequacy__c,  Organizational_Capability__c,Other_Narrative__c,Prefix__c,Need__c,Education_CP__c,
              Veterans_and_Military_Families_CP__c,Email__c,Title__c,Status__c,Have_funding_history_with_any_CNCS_org__c,Target_Populations_CP__c,
              Other_Economic_Opportunities_CP__c,Economic_Opportunities_CP__c,Other_Capacity_Building_CP__c,Capacity_Building_CP__c,Environment_Stewardship_CP__c,
              Other_Environment_Stewardship_CP__c,Other_Healthy_Futures_CP__c,Healthy_Futures_CP__c,Other_Disaster_Services_CP__c,Disaster_Services_CP__c,
              Other_Veterans_and_Military_Families_CP__c,Other_Education_CP__c,Intermediary_Justification__c ,Cost_Effectiveness_and_Budget_Adequacy__c,First_Name__c,
              Last_Name__c,Proposed_End_Date__c,Clarification_Summary__c,Continuation_Changes__c,Amendment_Justification__c,Strengthening_Communities__c,
              Recruitment_and_Development__c,Program_Management__c,Program_Design__c,Executive_Summary__c,Project_website_urls__c,Project__c,Proposed_Start_Date__c,
              Telephone_Number__c,Concept_Paper_Name__c,NOFA_RFP__c, Other_Target_Populations_CP__c,
              NOFA_RFP__r.Review_Cycle__c,NOFA_RFP__r.Energy_Efficiency_CP__c from Application3__C where id=:id];
//rectype=[Select id,name from Recordtype where SObjectType='Application3__c' and name='Application'].id;

}
public PageReference reopen1() {   
PageReference Redirect;
If(id!=null && id!=''){
Redirect = new PageReference('/apex/ConceptpaperEdit?id='+applicationInput.id);
applicationInput.Grantee_Status__c='None';
update applicationInput;
return Redirect;
}

return null;
}

public PageReference SaveAsDraft(){
    PageReference Redirect;
    If(id!=null && id!=''){
    if(applicationInput.Proposed_End_Date__c > applicationInput.Proposed_Start_Date__c)
    {
    Redirect = new PageReference('/apex/CombinedDetailPage?id='+applicationInput.id);
   // applicationInput.Status__c='Submitted';
    //applicationInput.Grantee_Status__c='Submitted';
    update applicationInput;
       return Redirect;
    }
    else
    {
    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error, 'Proposed End Date must be greater than the Proposed Start Date'));
    }
    }
    return null;
}

 /*public PageReference save1(){
        map<String,Boolean> checkRequiredNarrativeFields = new map<String,Boolean>();
       PageReference Redirect;
       try{
             if(!validate()) {
             ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error, 'Concept Paper cannot be Submitted, Due to the following reason: Please enter atleast 1 value for Focus Area and Objectives:'));
             return null;
             }
                
             checkRequiredNarrativeFields = ApplicationCheck.checkCPNarrativeFields(applicationInput,applicationInput.NOFA_RFP__c);
              
             if(checkRequiredNarrativeFields.size()>0){
                string fieldNames = '';
                for(String fieldName: checkRequiredNarrativeFields.keyset()){
                   fieldNames += fieldName +', ';
                }
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error, 'Concept Paper cannot be Submitted, Due to the following reason: Please enter values for Narrative fields: '+fieldNames));
                return null;
             }
                
  //         applicationInput.recordtypeid=rectype;
      //     applicationInput.NOFA_RFP__c=id;
      
            
              if(applicationInput.NOFA_RFP__r.Review_Cycle__c == 'Rolling'){
                applicationInput.Grantee_Status__c = 'Submitted';
                applicationInput.Status__c = 'Submitted';
              }
              else if(applicationInput.NOFA_RFP__r.Review_Cycle__c == 'Post-Deadline'){
                applicationInput.Grantee_Status__c = 'Pre - Submitted';
                applicationInput.Status__c = 'Pre - Submitted';
              }
             Update applicationInput;
             Redirect = new PageReference('/apex/CombinedDetailPage?id='+applicationInput.id);
             return Redirect;
         }
         catch(DMLException e){
         System.debug('@@@@@@@@!!!!!'+e.getmessage());
         }
             return null;
         }*/
         
     public boolean Validate()
    {   
         if(applicationInput.NOFA_RFP__r.Education_CP__c == true || applicationInput.NOFA_RFP__r.Veterans_Military_Families_CP__c == true || applicationInput.NOFA_RFP__r.Energy_Efficiency_CP__c == true || applicationInput.NOFA_RFP__r.Healthy_Futures_CP__c == true || applicationInput.NOFA_RFP__r.Economic_Opportunities_CP__c == true || applicationInput.NOFA_RFP__r.Disaster_Services_CP__c == true || applicationInput.NOFA_RFP__r.Environmental_Stewardship_CP__c == true || applicationInput.NOFA_RFP__r.Capacity_Building_CP__c == true || applicationInput.NOFA_RFP__r.Focus_Areas_and_Objectives_NCCC_CP__c == true ){
            
            if(applicationInput.Education_CP__c == null && applicationInput.Veterans_and_Military_Families_CP__c == null && applicationInput.Healthy_Futures_CP__c == null && applicationInput.Energy_Efficiency_CP__c == null && applicationInput.Economic_Opportunities_CP__c == null && applicationInput.Disaster_Services_CP__c == null && applicationInput.Environment_Stewardship_CP__c == null && applicationInput.Capacity_Building_CP__c == null
            && applicationInput.Natural_and_Other_Disasters_CP__c == null && applicationInput.Environmental_Stewardship_Conservation_C__c == null && applicationInput.Energy_Conservation_CP__c == null && applicationInput.Infrastructure_Improvement_CP__c == null && applicationInput.Urban_and_Rural_Development_CP__c == null){
                return false;
            }
         }
         return true;
         
         
    }
    
}