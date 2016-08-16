Public Class AwardExtension{

    public AwardExtension() {

    }

public Award__c awarddetail {get; set;}
public Award__c awardinput {get; set;}
Public List<Application3__c> app_Clonedfrom_List;
public Application3__c applicationInput {get; set;}
public String id;
public String appid;
public GroupMember gm {get;set;}
Public Boolean showPOButton{get;set;}
Public Boolean showSPOButton{get;set;}
Public Boolean showGOButton{get;set;}
Public Boolean showXOButton{get;set;}
Public Boolean showSGOButton{get;set;}
Public Boolean showEditButton{get;set;}

 public string userpwd {get;set;}

  // esign
  public string  Name{get;set;}
  public Boolean Check{get;set;}
  Public Id Recordid{get;set;}  
  // esign
  
  
  public String strAwardName;    //added for MomIntg

Public Awardextension(ApexPages.StandardController controller){
awarddetail=new Award__c();
controller.addFields(new List<String>{'name','Grant_Number__c','Budget_Period_Start__c','Budget_Period_End__c','Master_Award__c','Master_Award__r.name',
                                        'Committed__c','Grant_Status__c','Application_Type__c','Prime_Application_Type__c','Application_ID__r.Type_of_Application__c',
                                        'NOFA_Name__r.Cash_Grants_Awards__c','Application_ID__r.Program_Type__c','NOFA_Name__r.Cooperative_Agreement__c','Application_ID__c'});
 awarddetail = (Award__c)controller.getRecord();
 
 id=Apexpages.currentPage().getParameters().get('id');
 appid=Apexpages.currentPage().getParameters().get('appid');
 System.debug('emails'+appid +'jhjh'+id);
 System.debug('emails'+userinfo.getuseremail());
 strAwardName=awarddetail.name;                   //added for MomIntg
 System.debug('***strAwardName***'+strAwardName); //added for MomIntg

 try{
 
 if(userinfo.getuseremail()!=null){
    User u = [Select Id,Name,AccountId from User where Id = :userInfo.getUserId()];
    userpwd  = [select Encryptpassword__c from contact where email =: userinfo.getuseremail() and AccountId = :u.AccountId limit 1].Encryptpassword__c;    
    System.debug('userpwdd'+userpwd);
 }
 }
 catch(exception e)
 {
 }
 String gmid = Apexpages.currentPage().getParameters().get('gmid'); 
List<String> allGroupIDs = new List<String>();
for (GroupMember gm : [SELECT Id, group.id, group.name, group.type FROM GroupMember where (UserOrGroupId = :UserInfo.getUserId() AND group.type='Regular')]){
allGroupIDs.add(gm.group.id);
system.debug('tets@@'+gm);
}
gmid=userinfo.getUserId();
  If(gmid!=null) 
 List<GroupMember> gm=[Select id,UserOrGroupId from GroupMember where UserOrGroupId=:gmid];
 System.debug('@@@groupmember'+gmid);
 //For(GroupMember m:[Select id,UserOrGroupId from GroupMember where GroupId=:gmid]){
 //System.debug('@@@groupmember'+m);
 //}
 // User loggedinUser = [Select id,name from user where id=:userinfo.getUserId()];
     //awarddetail.PO__c = loggedinUser;
 //awarddetail.PO__c= Userinfo.getUserId();
   
  If(id!=null && id!='')
  awarddetail=[select id,Name,Organization__c,Project_Title__c,Grants_Office_Comments__c,Approved_Amount__c,Application_ID__r.NOFA_RFP__r.Fiscal_Yr__c, Application_ID__r.NOFA_RFP__r.Corporate_Program__r.Short_Code__c,Corporate_Program1__c,Prime_Application__c,Master_Award__c,Being_Committed__c,Application_ID__r.Satisfactory_Record_Executing_Programs__c,Application_ID__r.Organization__r.Name,Application_ID__r.Demonstrates_Ethics_Integrity__c,Application_ID__r.Mitigating_Circumstances__c,Organization_re_Signature__c,Application_ID__r.Organization__r.Registration_Active_until__c,Application_ID__r.Organization__r.CCR_Verified__c,Award_Flow__c,Application_ID__r.Type_of_Application__c,Max_of_sub_budgets_per_application__c,Obligated__c,eSigned__c,Awaiting_SGO_Approval__c,Match_Status__c,Sub_budgets_for_multi_year_grants__c,Budget_Period_End__c,Budget_Period_Start__c,Amendment__c,NOFA_Name__r.Corporate_Program__c,NOFA_Name__r.Cash_Grants_Awards__c,Grant_Performance_Period_Start__c,Grant_Performance_Period_End__c,Sponsor_e_Signature__c,NOFA_Name__r.Cooperative_Agreement__c ,Committed__c, Amendment_Reason__c,OwnerId,Amendment_Type__c,Application_ID__c,
  Cost_Share__c,Application_Type__c,Award_Description__c,Executive_Officer__c,XO_CSHR__c,Fund_Commitment_Comments__c,Grant__c,Grants_Officer__c,Grant_Status__c,NOFA_Name__c,Corporate_Program__c,CNCS_Corporate_Program__c,Organization_Legal_Name__c,
  POs__c,PO__c,PO_Certification_Date__c,PO_Comments__c,Program_Officer__c,Project_End_Date__c,Project_Name__c,Project_Start_Date__c,Senior_Grants_Officer__c,Senior_Program_Officer__c,Special_Conditions__c,SPO__c,SPO_Certification_Date__c,
  Red_Flag_Count__c, Red_Flags__c,  Year_of_Grant__c,FAPIIS_Review_Comments__c,Application_ID__r.Organization__r.IG_Audit_in_progress__c,Mitigating_Circumstances__c,Information_Available__c,Subject_to_FAPIIS_Review__c,FAPIIS_Review_Date__c,Demonstrates_Ethics_Integrity__c,Satisfactory_Record_Executing_Programs__c,Master_Award__r.name,
  Application_ID__r.Executive_Summary__c,Application_ID__r.Organizational_Capability__c,Application_ID__r.Program_Design__c,Application_ID__r.Program_Management__c,Application_ID__r.Evaluation_Summary_or_Plan__c,
Application_ID__r.Recruitment_and_Development__c,Application_ID__r.Strengthen_Communities__c,Application_ID__r.Continuation_Changes__c,Application_ID__r.Clarification_Summary__c,Application_ID__r.Cost_Effectiveness_Budget_Adequacy__c,
Application_ID__r.Need__c,Application_ID__r.Intermediary_Justification__c,Application_ID__r.Tools_and_Equipment__c,Application_ID__r.Safety_and_Security__c,Application_ID__r.Other_Narrative__c,Application_ID__r.Summary_of_Accomplishments__c,Application_ID__r.VISTA_Assignment__c,Application_ID__r.Natural_and_Other_Disasters__c,Application_ID__r.Otherobjectives__c,Application_ID__r.Energy_Conservation__c,
Application_ID__r.If_other_please_specify_Energy__c,Application_ID__r.Environmental_Stewardship_Conservation__c,Application_ID__r.If_other_please_specify_Enivronment__c,Application_ID__r.Infrastructure_Improvement__c,Application_ID__r.If_other_please_specify_Infrastructure__c,Application_ID__r.Urban_and_Rural_Development__c,
Application_ID__r.If_other_please_specify_Urban__c,Application_ID__r.Education__c,Application_ID__r.If_other_please_specify_education__c,Application_ID__r.Veterans_Military_Families__c,Application_ID__r.If_other_please_specify_Veterns__c,Application_ID__r.Disaster_Services__c,
Application_ID__r.If_other_please_specify_disaster__c,Application_ID__r.Environmental_Stewardship__c,Application_ID__r.If_other_please_specify_Enivironment_Ste__c,Application_ID__r.Healthy_Futures__c,Application_ID__r.If_other_please_specify_Health__c,Application_ID__r.Economic_Opportunities__c,
Application_ID__r.If_other_please_specify_Economic__c,Application_ID__r.Capacity_Building__c,Application_ID__r.If_other_please_specify_capacity__c,Application_ID__r.Target_Populations1__c,Application_ID__r.Characteristics_Priorities__c,
Application_ID__r.NOFA_RFP_Summary__c,Application_ID__r.Organization__c,Application_ID__r.Authorized_Representative__c,Application_ID__r.Point_of_Contact__c,Application_ID__r.Assignee__c,Application_ID__r.Applicant_User__c,Application_ID__r.Withdraw_Justification__c,Application_ID__r.Amendment_Justification__c,
Application_ID__r.Project__c,Application_ID__r.Project_website_urls__c,Application_ID__r.Project_Directorss__c,Application_ID__r.Proposed_Start_Date_is__c,Application_ID__r.Proposed_End_Date_is__c,Application_ID__r.Select_a_round__c,Application_ID__r.How_many_teams_are_being_requested__c,Application_ID__r.Disaster_Type__c,
Application_ID__r.Campus__c,Application_ID__r.Project_Priority__c,Application_ID__r.Disaster_Number_Funding_DOE__c,Application_ID__r.Team_Mobility__c,Application_ID__r.Specify_if_you_want_to_be_in_more_rounds__c,Application_ID__r.Partner_Project_Code__c,
Application_ID__r.State_and_or_Territories__c,Application_ID__r.Counties__c,Application_ID__r.Other_Area_Affected_by_Project__c,Application_ID__r.EO_12372_Process__c,Application_ID__r.Additional_Information__c,Application_ID__r.Applicant_Delinquent_on_any_Federal_Debt__c,
Application_ID__r.If_Yes_provide_your_explination_here__c,Application_ID__r.State_Application_Identifier__c,Application_ID__r.Have_funding_history_with_any_CNCS_org__c,
Application_ID__r.Local_State_Federal_Government_Match__c,Application_ID__r.Private_Match__c,Application_ID__r.Total_Match_Dollars__c,Application_ID__r.Other_Revenue__c,Application_ID__r.Number_of_episodic_volunteers_generated__c,Application_ID__r.Number_of_ongoing_volunteers__c,
Application_ID__r.Number_of_members_wearing_logo_every_day__c,Application_ID__r.Number_of_elevator_speeches_created__c,Application_ID__r.AmeriCorps_logo_will_display_on_website__c,Application_ID__r.Focus_Area__c,Application_ID__r.Program_Type__c,Application_ID__r.Cost_Share__c,
Prime_Application__r.CNCS_Corporate_Program__c,Prime_Application__r.Competitive_or_Formula__c,Prime_Application__r.Project_Name__c,Prime_Application__r.Project_Title__c,Prime_Application__r.Program_Start_Date__c,Prime_Application__r.Program_End_Date__c,
Prime_Application__r.EO_12372_Process__c,Prime_Application__r.If_yes_please_explain__c,Prime_Application__r.Applicant_Delinquent_on_any_Federal_Debt__c,Application_ID__r.flagReturnForRework__c,
Prime_Application__r.If_yes_please_explain_app_delinque__c,Prime_Application__r.Sub_Concept_Paper_Due_Date__c,Prime_Application__r.Sub_Application_Due_Date__c,Application_ID__r.Status__c,
NOFO_RFP_Name_New__c,Issuing_Officer__c,Grants_Officer_Comments__c,of__c,
Application_ID__r.Sub_Application__c,Sub_Award__c,NOFO_RFP_Name_Prime__c,Prime_Application_Type__c,Issuing_Office__c,Organization_Legal_Name_Prime__c,Project_Title_Prime__c,Corporate_Program_Prime__c,Fiscal_Year_Prime__c,
Agreement_Period_Start_Date__c,Agreement_Period_End_Date__c,Grant_Performance_Period_Start_Date__c,Grant_Performance_Period_End_Date__c,Enrollment_Period_Start_Date__c,Enrollment_Period_End_Date__c,Project__c
from Award__c where id=:id];

  if ((awarddetail.Grant_Status__c == 'Awaiting SPO Approval') || (awarddetail.Grant_Status__c == 'Awaiting SPO Award') ){
  awarddetail.OwnerId = awarddetail.Senior_Program_Officer__c;
  }
  else if(awarddetail.Grant_Status__c == 'Being Committed')  {
   awarddetail.OwnerId = awarddetail.Executive_Officer__c;
   }
   else if(awarddetail.Grant_Status__c == 'Awaiting GO Certification'){
   awarddetail.OwnerId = awarddetail.Grants_Officer__c;
   }
   else if(awarddetail.Grant_Status__c == 'Awaiting SGO Approval'){
   awarddetail.OwnerId = awarddetail.Senior_Grants_Officer__c;
   }   
  else if(awarddetail.Grant_Status__c == 'Awaiting XO CSHR Approval'){
   awarddetail.OwnerId = awarddetail.XO_CSHR__c;
   system.debug('@@@@@PRASS');
   } 
   else if(awarddetail.Grant_Status__c == 'Awaiting PO Certification'){
   awarddetail.OwnerId = awarddetail.Program_Officer__c;
   }  
   else
  {
awarddetail.OwnerId = awarddetail.OwnerId;
  }
  }
 //Rendering Logic----
Public void initMethod(){
  
  List<String> grouplist = new List<String>{'PO Group','GO Group','SPO Group','XO Group','SGO Group'};
  List<GroupMember> gmlist=[Select Id, UserOrGroupId, group.name From GroupMember where group.name IN: grouplist];
  showPOButton=False;
  showSPOButton=False;
  Set<String> POGroupUserlist = new Set<String>();
  Set<String> SPOGroupUserlist = new Set<String>();
  Set<String> GOGroupUserlist = new Set<String>();
  Set<String> XOGroupUserlist = new Set<String>();
  Set<String> SGOGroupUserlist = new Set<String>();
  String loggedinUserId = Userinfo.getuserid();
  
  for(groupmember gm:gmlist)
  {
    if(gm.group.name == 'PO Group')
       POGroupUserlist.add(gm.UserOrGroupid);
    if(gm.group.name == 'SPO Group')
       SPOGroupUserlist.add(gm.UserOrGroupid);  
    if(gm.group.name == 'GO Group')  
       GOGroupUserlist.add(gm.UserOrGroupid);  
    if(gm.group.name=='XO Group')
       XOGroupUserlist.add(gm.UserOrGroupid);  
    if(gm.group.name=='SGO Group')
       SGOGroupUserlist.add(gm.UserOrGroupid);  
      }   
  if( awarddetail.Ownerid==loggedinUserId)
  showEditButton=True;
  If(POGroupUserlist.contains(loggedinUserId))
  showPOButton=True;
  
  If(SPOGroupUserlist.contains(loggedinUserId))
  showSPOButton=True;
  
   If(GOGroupUserlist.contains(loggedinUserId))
   showGOButton=True;
   
    If(XOGroupUserlist.contains(loggedinUserId))
   showXOButton=True;
   
    If(SGOGroupUserlist.contains(loggedinUserId))
   showSGOButton=True;
  }
    
 
 /*Award Action  
  public PageReference AwardApp() {           
if (awarddetail.Grant_Status__c != 'Obligated' || awarddetail.Grant_Status__c != 'Awaiting SGO Award'){
  ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error, 'You cannot Award the record. '));                    
  return null;
}
else {
    awarddetail.Grant_Status__c='Awarded';
    }
update awarddetail;
//return Redirect;
return null;
} */

//Award Action  

//Amedment Button and method award and/or application has "Yes" for the "Allow Prime and Sub Applications,"
public PageReference Amend(){
PageReference pg;
Id SubAward = Schema.SObjectType.Award__c.getRecordTypeInfosByName().get('Sub App Award').getRecordTypeId();
Id AppAward= Schema.SObjectType.Award__c.getRecordTypeInfosByName().get('App Award').getRecordTypeId();
List<Application3__c> app_List = new List<Application3__c>();
Application3__c applicationInput;
           // List<Application3__c> awd=new List<Application3__c>();     
            app_List=[select id,Name,NOFA_RFP__r.Fiscal_Yr__c,NOFA_Name__c ,Grantee_Status__c,Executive_Summary__c from Application3__c where id=:awarddetail.Application_ID__c];
         System.debug('pp#'+awarddetail.Recordtypeid);  
if(SubAward==awarddetail.Recordtypeid && awarddetail.Application_ID__c!=null){
            system.debug('%%%%%*****prashant'+SubAward);
 For(Application3__c aa:app_List){
 
 aa.Grantee_Status__c='In Progress';
 
aa.Type_of_Application__c='Amendment';
 // copyapp.clone(false,true);
     //update aa;
      
    //   pg = new PageReference('/'+aa.id+'/e');
           }
           
           if(!app_List.isEmpty()){
           update app_List;
           pg = new PageReference('/'+app_List[0].id+'/e');
           return pg;
    }       
     return null;
   } //Logic to clone prime application and relatedsub application
    else if(awarddetail.Prime_Application__c!=null){ 
    List<Prime_Application__c> pa=new List<Prime_Application__c>(); 
    app_Clonedfrom_List = new List<Application3__c>();
   
      List<Award__c> paw=new List<Award__c>();
     Award__c primeappCloneFrom;
   Prime_Application__c primeapp;
     Prime_Application__c newClonedprimeapp = new Prime_Application__c();
    System.debug('######@@@@#'+newClonedprimeapp);
   // if(id!=null&& id!='')
      newClonedprimeapp.clone(false,true);
      newClonedprimeapp.Prime_Application_ID_Number__c=awarddetail.Name+'FromAwd';
      newClonedprimeapp.NOFO_RFP__c=awarddetail.NOFA_Name__c;
      newClonedprimeapp.Type_of_Application__c='Amendment';
      newClonedprimeapp.CNCS_Status__c='In Progress';
    /*  newClonedprimeapp.CNCS_Corporate_Program__c= awarddetail.Prime_Application__r.CNCS_Corporate_Program__c;
     newClonedprimeapp.Competitive_or_Formula__c= awarddetail.Prime_Application__r.Competitive_or_Formula__c;
   //  newClonedprimeapp.Project_Name__c= awarddetail.Prime_Application__r.Project_Name__c;
   //  newClonedprimeapp.Project_Title__c= awarddetail.Prime_Application__r.Project_Title__c;
     newClonedprimeapp.Program_Start_Date__c= awarddetail.Prime_Application__r.Program_Start_Date__c;
     newClonedprimeapp.Program_End_Date__c= awarddetail.Prime_Application__r.Program_End_Date__c;
     newClonedprimeapp.EO_12372_Process__c= awarddetail.Prime_Application__r.EO_12372_Process__c;
     newClonedprimeapp.If_yes_please_explain__c= awarddetail.Prime_Application__r.If_yes_please_explain__c;
     newClonedprimeapp.Applicant_Delinquent_on_any_Federal_Debt__c= awarddetail.Prime_Application__r.Applicant_Delinquent_on_any_Federal_Debt__c;
     newClonedprimeapp.If_yes_please_explain_app_delinque__c= awarddetail.Prime_Application__r.If_yes_please_explain_app_delinque__c;
     newClonedprimeapp.Sub_Concept_Paper_Due_Date__c= awarddetail.Prime_Application__r.Sub_Concept_Paper_Due_Date__c;
     newClonedprimeapp.Sub_Application_Due_Date__c= awarddetail.Prime_Application__r.Sub_Application_Due_Date__c; */
     
      
      Insert newClonedprimeapp;
    System.debug('New_Cloned_Record_ID'+newClonedprimeapp.id);
  //Sub Application clone      

     app_Clonedfrom_List = [Select id,name,Prime_Application__c from Application3__c where Prime_Application__c=:awarddetail.Prime_Application__c];
        System.debug('######@@@@#'+awarddetail.Prime_Application__c);
         System.debug('############'+app_Clonedfrom_List.Size());
    for(Application3__c app : app_Clonedfrom_List){
          System.debug('############'+app.name);
         Application3__c appCopy = app.clone(false,true);
         appCopy.name = app.name + '-Cloned';
         appCopy.Prime_Application__c = newClonedprimeapp.Id;
         

         appCopy.Amendable__c=true;
         app_List.add(appCopy);
         
        }
 
    if(!app_List.isEmpty())
      Insert app_List;
      
   if(!app_Clonedfrom_List.isEmpty())  
         Update app_Clonedfrom_List;
        
   pg= new PageReference('/'+newClonedprimeapp.id);
       
        System.debug('pp#');
  return pg;   
    }
  if(AppAward==awarddetail.Recordtypeid && awarddetail.Application_ID__c!=null){
  PageReference pag;
  For(Application3__c aap:app_List){
  
  applicationInput= aap.clone(false,true);
  applicationInput.Name=awarddetail.Application_ID__r.NOFA_RFP__r.Fiscal_Yr__c+ awarddetail.Application_ID__r.NOFA_RFP__r.Corporate_Program__r.Short_Code__c;
  applicationInput.Status__c='In Progress'; 
  applicationInput.Type_of_Application__c='Amendment';
  applicationInput.Executive_Summary__c = awarddetail.Application_ID__r.Executive_Summary__c;
  applicationInput.Organizational_Capability__c = awarddetail.Application_ID__r.Organizational_Capability__c;
  applicationInput.Program_Design__c = awarddetail.Application_ID__r.Program_Design__c;
  applicationInput.Program_Management__c = awarddetail.Application_ID__r.Program_Management__c;
  applicationInput.Evaluation_Summary_or_Plan__c = awarddetail.Application_ID__r.Evaluation_Summary_or_Plan__c;
  applicationInput.Recruitment_and_Development__c = awarddetail.Application_ID__r.Recruitment_and_Development__c;
  applicationInput.Strengthen_Communities__c = awarddetail.Application_ID__r.Strengthen_Communities__c;
  applicationInput.Amendment_Justification__c = awarddetail.Application_ID__r.Amendment_Justification__c;
  applicationInput.Continuation_Changes__c = awarddetail.Application_ID__r.Continuation_Changes__c;
  applicationInput.Clarification_Summary__c = awarddetail.Application_ID__r.Clarification_Summary__c;
  applicationInput.Cost_Effectiveness_Budget_Adequacy__c = awarddetail.Application_ID__r.Cost_Effectiveness_Budget_Adequacy__c;
  applicationInput.Need__c = awarddetail.Application_ID__r.Need__c;
  applicationInput.Intermediary_Justification__c = awarddetail.Application_ID__r.Intermediary_Justification__c;
  applicationInput.Tools_and_Equipment__c = awarddetail.Application_ID__r.Tools_and_Equipment__c;
  applicationInput.Safety_and_Security__c = awarddetail.Application_ID__r.Safety_and_Security__c;
  applicationInput.Other_Narrative__c = awarddetail.Application_ID__r.Other_Narrative__c;
  applicationInput.Summary_of_Accomplishments__c = awarddetail.Application_ID__r.Summary_of_Accomplishments__c;
  applicationInput.VISTA_Assignment__c = awarddetail.Application_ID__r.VISTA_Assignment__c;
 applicationInput.Natural_and_Other_Disasters__c = awarddetail.Application_ID__r.Natural_and_Other_Disasters__c;
  applicationInput.Otherobjectives__c = awarddetail.Application_ID__r.Otherobjectives__c;
  applicationInput.Energy_Conservation__c = awarddetail.Application_ID__r.Energy_Conservation__c;
  applicationInput.If_other_please_specify_Energy__c = awarddetail.Application_ID__r.If_other_please_specify_Energy__c;
  applicationInput.Environmental_Stewardship_Conservation__c = awarddetail.Application_ID__r.Environmental_Stewardship_Conservation__c;
  applicationInput.If_other_please_specify_Enivronment__c = awarddetail.Application_ID__r.If_other_please_specify_Enivronment__c;
  applicationInput.Infrastructure_Improvement__c = awarddetail.Application_ID__r.Infrastructure_Improvement__c;
  applicationInput.If_other_please_specify_Infrastructure__c = awarddetail.Application_ID__r.If_other_please_specify_Infrastructure__c;
  applicationInput.Urban_and_Rural_Development__c = awarddetail.Application_ID__r.Urban_and_Rural_Development__c;
  applicationInput.If_other_please_specify_Urban__c = awarddetail.Application_ID__r.If_other_please_specify_Urban__c;
  applicationInput.Education__c = awarddetail.Application_ID__r.Education__c;
  applicationInput.If_other_please_specify_education__c = awarddetail.Application_ID__r.If_other_please_specify_education__c;
  applicationInput.Veterans_Military_Families__c = awarddetail.Application_ID__r.Veterans_Military_Families__c;
  applicationInput.If_other_please_specify_Veterns__c = awarddetail.Application_ID__r.If_other_please_specify_Veterns__c;
  applicationInput.Disaster_Services__c = awarddetail.Application_ID__r.Disaster_Services__c;
  applicationInput.If_other_please_specify_disaster__c = awarddetail.Application_ID__r.If_other_please_specify_disaster__c;
  applicationInput.Environmental_Stewardship__c = awarddetail.Application_ID__r.Environmental_Stewardship__c;
  applicationInput.If_other_please_specify_Enivironment_Ste__c = awarddetail.Application_ID__r.If_other_please_specify_Enivironment_Ste__c;
  applicationInput.Healthy_Futures__c = awarddetail.Application_ID__r.Healthy_Futures__c;
  applicationInput.If_other_please_specify_Health__c = awarddetail.Application_ID__r.If_other_please_specify_Health__c;
  applicationInput.Economic_Opportunities__c = awarddetail.Application_ID__r.Economic_Opportunities__c;
  applicationInput.If_other_please_specify_Economic__c = awarddetail.Application_ID__r.If_other_please_specify_Economic__c;
  applicationInput.Capacity_Building__c = awarddetail.Application_ID__r.Capacity_Building__c;
  applicationInput.If_other_please_specify_capacity__c = awarddetail.Application_ID__r.If_other_please_specify_capacity__c;
  applicationInput.Target_Populations1__c = awarddetail.Application_ID__r.Target_Populations1__c;
  applicationInput.Characteristics_Priorities__c = awarddetail.Application_ID__r.Characteristics_Priorities__c;
  applicationInput.NOFA_RFP_Summary__c = awarddetail.Application_ID__r.NOFA_RFP_Summary__c;
  applicationInput.Organization__c = awarddetail.Application_ID__r.Organization__c;
  applicationInput.Authorized_Representative__c = awarddetail.Application_ID__r.Authorized_Representative__c;
  applicationInput.Point_of_Contact__c = awarddetail.Application_ID__r.Point_of_Contact__c;
  applicationInput.Assignee__c = awarddetail.Application_ID__r.Assignee__c;
  applicationInput.Applicant_User__c = awarddetail.Application_ID__r.Applicant_User__c;
  applicationInput.Withdraw_Justification__c = awarddetail.Application_ID__r.Withdraw_Justification__c;
  applicationInput.Amendment_Justification__c = awarddetail.Application_ID__r.Amendment_Justification__c;
  applicationInput.Project__c = awarddetail.Application_ID__r.Project__c;
  applicationInput.Project_website_urls__c = awarddetail.Application_ID__r.Project_website_urls__c;
  applicationInput.Project_Directorss__c = awarddetail.Application_ID__r.Project_Directorss__c;
  applicationInput.Proposed_Start_Date_is__c = awarddetail.Application_ID__r.Proposed_Start_Date_is__c;
  applicationInput.Proposed_End_Date_is__c = awarddetail.Application_ID__r.Proposed_End_Date_is__c;
  applicationInput.Select_a_round__c = awarddetail.Application_ID__r.Select_a_round__c;
  applicationInput.How_many_teams_are_being_requested__c = awarddetail.Application_ID__r.How_many_teams_are_being_requested__c;
  applicationInput.Disaster_Type__c = awarddetail.Application_ID__r.Disaster_Type__c;
  applicationInput.Campus__c = awarddetail.Application_ID__r.Campus__c;
  applicationInput.Project_Priority__c = awarddetail.Application_ID__r.Project_Priority__c;
  applicationInput.Disaster_Number_Funding_DOE__c = awarddetail.Application_ID__r.Disaster_Number_Funding_DOE__c;
  applicationInput.Partner_Project_Code__c = awarddetail.Application_ID__r.Partner_Project_Code__c;
  applicationInput.Team_Mobility__c = awarddetail.Application_ID__r.Team_Mobility__c;
  applicationInput.Specify_if_you_want_to_be_in_more_rounds__c = awarddetail.Application_ID__r.Specify_if_you_want_to_be_in_more_rounds__c;
  applicationInput.Partner_Project_Code__c = awarddetail.Application_ID__r.Partner_Project_Code__c;
  applicationInput.State_and_or_Territories__c = awarddetail.Application_ID__r.State_and_or_Territories__c;
  applicationInput.Counties__c = awarddetail.Application_ID__r.Counties__c;
  applicationInput.Other_Area_Affected_by_Project__c = awarddetail.Application_ID__r.Other_Area_Affected_by_Project__c;
  // Add below to SOQL query - Line 71 
  applicationInput.EO_12372_Process__c = awarddetail.Application_ID__r.EO_12372_Process__c;
  applicationInput.Additional_Information__c = awarddetail.Application_ID__r.Additional_Information__c;
  applicationInput.Applicant_Delinquent_on_any_Federal_Debt__c = awarddetail.Application_ID__r.Applicant_Delinquent_on_any_Federal_Debt__c;
  applicationInput.If_Yes_provide_your_explination_here__c = awarddetail.Application_ID__r.If_Yes_provide_your_explination_here__c;
  applicationInput.State_Application_Identifier__c = awarddetail.Application_ID__r.State_Application_Identifier__c;
  applicationInput.Have_funding_history_with_any_CNCS_org__c = awarddetail.Application_ID__r.Have_funding_history_with_any_CNCS_org__c;
  applicationInput.Local_State_Federal_Government_Match__c = awarddetail.Application_ID__r.Local_State_Federal_Government_Match__c;
  applicationInput.Private_Match__c = awarddetail.Application_ID__r.Private_Match__c;
  applicationInput.Total_Match_Dollars__c = awarddetail.Application_ID__r.Total_Match_Dollars__c;
  applicationInput.Other_Revenue__c = awarddetail.Application_ID__r.Other_Revenue__c;
  applicationInput.Number_of_episodic_volunteers_generated__c = awarddetail.Application_ID__r.Number_of_episodic_volunteers_generated__c;
  applicationInput.Number_of_ongoing_volunteers__c = awarddetail.Application_ID__r.Number_of_ongoing_volunteers__c;
  applicationInput.Number_of_members_wearing_logo_every_day__c = awarddetail.Application_ID__r.Number_of_members_wearing_logo_every_day__c;
  applicationInput.Number_of_elevator_speeches_created__c = awarddetail.Application_ID__r.Number_of_elevator_speeches_created__c;
  applicationInput.AmeriCorps_logo_will_display_on_website__c = awarddetail.Application_ID__r.AmeriCorps_logo_will_display_on_website__c;
  applicationInput.Focus_Area__c = awarddetail.Application_ID__r.Focus_Area__c;
  applicationInput.Program_Type__c = awarddetail.Application_ID__r.Program_Type__c;
  applicationInput.Cost_Share__c = awarddetail.Application_ID__r.Cost_Share__c;
  
  
  
  
  
  
  
  
  
  
  
  insert applicationInput;
   
   }
    pag= new PageReference('/'+applicationInput.id); 
    return pag;
  }
     
    return null;
      }
   
               

  public PageReference AwardApp() { 
  
      ///invokeMomentumIntgForAward();          
    if ((awarddetail.Grant_Status__c == 'Obligated' && awarddetail.Sponsor_e_Signature__c==true) || (awarddetail.Grant_Status__c == 'Awaiting SGO Award' && awarddetail.Sponsor_e_Signature__c==true) || (awarddetail.Grant_Status__c == 'Obligated'&& awarddetail.NOFA_Name__r.Cash_Grants_Awards__c=='Yes' && awarddetail.NOFA_Name__r.Cooperative_Agreement__c=='No')){
          //if(awarddetail.Corporate_Program1__c!=null && awarddetail.Corporate_Program1__c.equalsIgnoreCase('AmeriCorps') && (
          
          ///
          //if(validateAwardAsAmericas()){
      
                Boolean goAheadFlag=invokeMomentumIntgForAward();
                if(!goAheadFlag) {
                    return null;
                 } 
          //}
          ///
    
       
        awarddetail.Grant_Status__c='Awarded'; 
        update awarddetail;
    }
    else {
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error, 'You cannot Award the record. '));                    
  
    }
    return null;
   }

    public Boolean invokeMomentumIntgForAward(){
       
       HttpResponse hResp;
       String json='';
       String strWSname='Award';
       String  endPointuri='';
       String  uName='';
       String  upassword='';
       String  httpMethodName='';
       String  contenttype='';
       Boolean goAheadFlag=false;
          
       CNCS_AuthorizeHttp objCNCS_AuthorizeHttp=new CNCS_AuthorizeHttp();
       try{
            
                Intgr_MuleSoft__c objIntgr_MuleSoft=CNCS_ObjectUtility.retrieveWSDetails(strWSname);
                System.debug(objIntgr_MuleSoft);
                if(objIntgr_MuleSoft==null){
                        //ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'Configuration for Web Service momentum integration for Award is not setUp'));
                        throw new CNCS_ObjectUtility.CustomException('Configuration for Web Service momentum integration for Award is not setUp');
                }
                endPointuri=objIntgr_MuleSoft.endPointuri__c;
                uName=objIntgr_MuleSoft.uName__c;
                upassword=objIntgr_MuleSoft.upassword__c;
                httpMethodName=objIntgr_MuleSoft.httpMethodName__c;
                contenttype=objIntgr_MuleSoft.contenttype__c;
                String strBody=composeBodyForMomIntgForAward();
                System.debug('endPointuri'+endPointuri+''+'httpMethodName'+httpMethodName+'uName'+uName+'upassword'+upassword+'contenttype'+contenttype);
                
                hResp=objCNCS_AuthorizeHttp.wsConnectAndSend(endPointuri,uName,upassword,httpMethodName,contenttype,strBody,false);
                System.debug('***hResp***'+hResp);
                // the service is returning a line feed so parse it out
                json = hResp.getBody().replace('\n', '');
                System.debug('***json***'+json );
                
                ParseJSONUtil objParseJSONUtil= new ParseJSONUtil();
                ParseJSONUtil.AwardForgrnt_idJSON    objAwardForgrnt_idJSON= new ParseJSONUtil.AwardForgrnt_idJSON();
                objAwardForgrnt_idJSON= objParseJSONUtil.parseAwardForgrnt_idJSON(json);
                System.debug('***objAwardForgrnt_idJSON'+objAwardForgrnt_idJSON);
                List<ParseJSONUtil.AwardForgrnt_id> lstAwardForgrnt_id=objAwardForgrnt_idJSON.lstData;
                System.debug('***lstAwardForgrnt_id'+lstAwardForgrnt_id);
                if(lstAwardForgrnt_id!=null && lstAwardForgrnt_id.size() >0){
                     String p_status_cd=lstAwardForgrnt_id[0].p_status_cd;
                     if(p_status_cd!=null && p_status_cd!='' && p_status_cd.equalsignoreCase('Ok')){
                         goAheadFlag=true;
                     }else{
                          goAheadFlag=false;
                          throw new CNCS_ObjectUtility.CustomException('Exception -> '+ p_status_cd+' .'); 
                     } 
                     
                     /* if(p_status_cd!=null && p_status_cd!='' && !p_status_cd.equalsIgnoreCase('~Ok')){
                         throw new CNCS_ObjectUtility.CustomException('Exception -> '+ p_status_cd+' .'); 
                     }*/
                }
              
           }
          catch(System.CalloutException ce) {
              System.debug('Callout error: '+ ce);
              ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,ce.getMessage()));
              //System.debug(resp.toString());
          }
          catch(System.DmlException de) {
              System.debug('Callout error: '+ de);
              ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,de.getMessage()));
         }
         catch(CNCS_ObjectUtility.CustomException custExc) {
              System.debug('Custom Exception '+ custExc);
              ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,custExc.getMessage()));
         }
         catch(Exception exc){
            System.debug('***exc***'+exc.getMessage());
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,exc.getMessage()));
         }
         return goAheadFlag;
    }
    
    
    
    public String composeBodyForMomIntgForAward(){
        String strBody ='{ "grnt_id":'+'"'+ strAwardName+'" }';
        return strBody;
    
    }
    
    public Boolean validateAwardAsAmericas(){
        Boolean flagAmericas=false;
        
       // List<Account> matchingAccounts = Database.query('SELECT id from Account where Name = \''+String.escapeSingleQuotes(your-account-name-var)+'\'' AND CustomName__c = \''+String.escapeSingleQuotes(your-customer-name-var)+'\''');
    
        String strQry='[ Select id,name,Application_ID__c,Grant_Number__c,Application_ID__r.name,Application_ID__r.NOFA_RFP__r.name,';
        strQry+=' Application_ID__r.NOFA_RFP__r.CNCS_Corporate_Program__r.id,';
        strQry+=' Application_ID__r.NOFA_RFP__r.CNCS_Corporate_Program__r.name,';
        strQry+=' Application_ID__r.NOFA_RFP__r.CNCS_Corporate_Program__r.CNCS_Corporate_Program_Name__c,';
        strQry+=' Application_ID__r.NOFA_RFP__r.CNCS_Corporate_Program__r.CNCS_Corporate_Program_Name__r.name';
        strQry+=' FROM Award__c ';
       // strQry+=' WHERE ID='' ';
        strQry+=' WHERE ID=\'' +strAwardName+'\'';   
        strQry+=' ORDER by name]';                            
                                    
         Award__c objAward;
         /*   Award__c objAward= [Select id,name,Application_ID__c,Grant_Number__c,Application_ID__r.name,Application_ID__r.NOFA_RFP__r.name,
                                            Application_ID__r.NOFA_RFP__r.CNCS_Corporate_Program__r.id,
                                            Application_ID__r.NOFA_RFP__r.CNCS_Corporate_Program__r.name,
                                            Application_ID__r.NOFA_RFP__r.CNCS_Corporate_Program__r.CNCS_Corporate_Program_Name__c,
                                            Application_ID__r.NOFA_RFP__r.CNCS_Corporate_Program__r.CNCS_Corporate_Program_Name__r.name
                                    FROM Award__c 
                                    WHERE ID=''
                                    ORDER by name]; */
        try{                            
            objAward=    Database.query(strQry);
        } catch(Exception exc){
        
             System.debug('***exc***'+exc.getMessage()); 
        }                 
                                
        System.debug('***objAward***'+objAward);    
        if(objAward!=null &&objAward.Application_ID__r!=null && objAward.Application_ID__r.NOFA_RFP__r!=null  && 
                            objAward.Application_ID__r.NOFA_RFP__r.CNCS_Corporate_Program__r!=null &&
                            objAward.Application_ID__r.NOFA_RFP__r.CNCS_Corporate_Program__r.name!=null &&
                            objAward.Application_ID__r.NOFA_RFP__r.CNCS_Corporate_Program__r.name.equalsIgnoreCase('AmeriCorps') &&
                            objAward.Application_ID__r.NOFA_RFP__r.CNCS_Corporate_Program__r.CNCS_Corporate_Program_Name__r!=null &&
                            objAward.Application_ID__r.NOFA_RFP__r.CNCS_Corporate_Program__r.CNCS_Corporate_Program_Name__r.name!=null &&
                            !objAward.Application_ID__r.NOFA_RFP__r.CNCS_Corporate_Program__r.CNCS_Corporate_Program_Name__r.name.contains('NCCC') )    {
            flagAmericas    =true;          
                            
        }
        return flagAmericas;
    
 }
    

// Certifiy Application by PO (PO, SPO) 
 public PageReference CertifiyApplicationbyPO () {    
  PageReference Redirect;
if (awarddetail.Grant_Status__c != 'Awaiting PO Certification'){
ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error, 'You cannot Certify this Award". '));                    
  return null;
}
else {  
awarddetail.Grant_Status__c='Awaiting SPO Approval';
// awarddetail.PO__c= Userinfo.getUserId();
}
update awarddetail;
Redirect = new PageReference('/'+awarddetail.id);
//return Redirect;
return Redirect;
}

// Certifiy Application by SPO              
public PageReference ApproveGrantpreviouslycertifiedbyPO () {    
PageReference Redirect;
if (awarddetail.Committed__c == True ){
ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error, 'You cannot Approve this Award. '));                    
  return null;
}
/*else if
(awarddetail.NOFA_Name__r.Cash_Grants_Awards__c == 'Yes' && awarddetail.Application_ID__r.Cost_Share__c == 'Yes') {
awarddetail.Grant_Status__c = 'Awaiting XO CSHR Approval' ;  
             
  update awarddetail;
  Redirect = new PageReference('/'+awarddetail.id);
   system.debug('@@@@@PRASSSSSSSHANT');
  return Redirect;
} */
else if
(awarddetail.Grant_Status__c != 'Awaiting SPO Approval') {
ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error, 'You cannot Approve this Award. '));                    
  return null;
}
else {
awarddetail.Grant_Status__c='Being Committed';

update awarddetail;
Redirect = new PageReference('/'+awarddetail.id);
return Redirect;
}
return null;
}

// Certify Application Previously Committed (SPO). This button works only if the Committed checkbox is checked. 
public PageReference CertifyApplicationCommitted () {  
    PageReference Redirect; 
    if (awarddetail.OwnerId != Userinfo.getUserId()){
ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error, 'You cannot Certify this Award. '));                    
  return null;  
    } 

//if ((PRIORVALUE(awarddetail.Grant_Status__c == 'Awaiting PO Certification')))
else if (awarddetail.Committed__c == True && awarddetail.Grant_Status__c != 'Awaiting SGO Approval')

{
    awarddetail.Grant_Status__c='Awaiting GO Certification';
    update awarddetail;
    Redirect = new PageReference('/'+awarddetail.id);
return Redirect;
}
else{
ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error, 'You cannot Certify this Award. '));                    
  return null;
}

}


 
 // Send to PO
 public PageReference sendtopo () {     
 if (awarddetail.OwnerId != Userinfo.getUserId()){
ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error, 'You cannot Send this Award to PO. '));                    
  return null;
}
else {
awarddetail.Grant_Status__c='Awaiting PO Certification';}
update awarddetail;
//return Redirect;
return null;
}

// Send to SPO
public PageReference sendtospo () {     
if (awarddetail.OwnerId != Userinfo.getUserId()){
ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error, 'You cannot Send this Award to SPO. '));                    
  return null;
}
else {
awarddetail.Grant_Status__c='Awaiting SPO Approval';}
update awarddetail;
//return Redirect;
return null;
}
 
 // Send BACK AWARD to GO - from PO, SGO
 public PageReference sendtoGO () {    // Certifiy Application by GO
if (awarddetail.OwnerId != Userinfo.getUserId() || awarddetail.Grant_Status__c!='Awaiting SGO Approval'){
ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error, 'You cannot Send this Award to GO". '));                    
  return null;
}
else {
awarddetail.Grant_Status__c='Awaiting GO Certification';}
update awarddetail;
//return Redirect;
return null;
}
 
 // Send to SGO - from GO ONLY
 
 public PageReference sendtoSGO () {    // Certifiy Application by GO 
if (awarddetail.Grant_Status__c != 'Awaiting GO Certification'){
ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error, 'You cannot send this Award to SGO". '));                    
  return null;
}
awarddetail.Grant_Status__c='Awaiting SGO Approval';
update awarddetail;
//return Redirect;
return null;
}


// Certify, Send to SGO
public PageReference CertifytoSGO () {    
PageReference Redirect;
if (awarddetail.Grant_Status__c != 'Awaiting GO Certification'){
ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error, 'You cannot Certify this Award". '));                    
  return null;
}
awarddetail.Grant_Status__c='Awaiting SGO Approval';
update awarddetail;
Redirect = new PageReference('/'+awarddetail.id);
return Redirect;
}



public PageReference commitfromSGO() {    

awarddetail.Grant_Status__c='Being Committed';
update awarddetail;
//return Redirect;
return null;
}
 
 
    public PageReference  Obligatepgmtypenull() {    // Obligate if Program Type null and Cash 'yes' and Cost share 'No' // "Obligate" button for SGO. 
        if (awarddetail.Grant_Status__c == 'Awaiting SGO Approval' || awarddetail.Grant_Status__c == 'Awaiting SGO Obligation'){
            ///
             // if(validateAwardAsAmericas()){
                Boolean goAheadFlag=invokeMomentumIntgForAward();
                if(!goAheadFlag) {
                    return null;
                 } 
             //  }
           ///  
        
            awarddetail.Grant_Status__c='Obligated';
            update awarddetail;
        }else{
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error, 'You cannot Obligated this Award. '));                    
            return null;
        }
        return null;
    }
 
 public PageReference CertifiyApplicationbyPO1 () {    // Certifiy Application by PO   sendtoXO

awarddetail.Grant_Status__c='Awaiting Organization e-Signature';
// awarddetail.POs__c= Userinfo.getUserId();
//awarddetail.PO__c= gmid;
update awarddetail;
//return Redirect;
return null;
}

 //Send to XO - from GO, SGO
 public PageReference sendtoXO () {    // Certifiy Application by PO   
if (awarddetail.OwnerId != Userinfo.getUserId()){
ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error, 'You cannot Send this Award to XO". '));                    
  return null;
}
else {
awarddetail.Grant_Status__c='Awaiting XO CSHR Approval';}
update awarddetail;
//return Redirect;
return null;
}

 //Withdraw Award - ONLY by PO. 
 public PageReference Withdraw() {            
if (awarddetail.Grant_Status__c != 'Awaiting PO Certification'){
ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error, 'You cannot Withdraw this Award". '));                    
  return null;
}
awarddetail.Grant_Status__c='Withdrawn';
update awarddetail;
//return Redirect;
return null;
}

// CSHR XO will send the Award to XO
public PageReference CSHRtoXO() {            
if (awarddetail.Grant_Status__c != 'Awaiting XO CSHR Approval'){
ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error, 'You cannot send this Award to XO". '));                    
  return null;
}
awarddetail.Grant_Status__c='Being Committed';
update awarddetail;
//return Redirect;
return null;
}

//Reject Award - ONLY by PO. 
 public PageReference reject() {            
if (awarddetail.Grant_Status__c != 'Awaiting PO Certification'){
ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error, 'You cannot Reject this Award". '));                    
  return null;
}
awarddetail.Grant_Status__c='Rejected';
update awarddetail;
//return Redirect;
return null;
}

//Return to Rework - ONLY by PO. 
 public PageReference ReturntoRework() {            
  PageReference Redirect;  
if (awarddetail.Grant_Status__c != 'Awaiting PO Certification'){
ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error, 'You cannot Return this Award to Rework". '));                    
  return null;
}
// Updated the Status picklist value on 6.7.16
applicationinput =[select id,flagReturnForRework__c,Status__c from Application3__c where id=:awarddetail.Application_ID__c];
 system.debug('^^^^^^Return^^^^^'+applicationinput.flagReturnForRework__c);
 system.debug('^^^^^^Return1^^^^^'+applicationinput.Status__c);
//if(awarddetail.flagReturnForRework__c)
awarddetail.Grant_Status__c='Returned for Rework';
applicationinput.Status__c = 'Returned for Rework';
applicationinput.Grantee_Status__c = 'Return for Re-work';
applicationinput.Return_For_Rework__c=true;
applicationinput.flagReturnForRework__c=true;
update applicationinput;
update awarddetail;
System.debug('*****&&&&&&)))))'+applicationinput.Status__c);

//return Redirect;
return null;
}

// Send BACK to XO - from GO, SGO
public PageReference returntoXO () {       
//if (awarddetail.OwnerId != Userinfo.getUserId()|| awarddetail.Grant_Status__c!='Awaiting SGO Approval'){
if (awarddetail.OwnerId != Userinfo.getUserId() && (awarddetail.Grant_Status__c=='Awaiting SGO Approval' || awarddetail.Grant_Status__c =='Awaiting GO Certification' ) ){
ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error, 'You cannot Send this Award to XO". '));                    
  return null;
}
awarddetail.Grant_Status__c='Being Committed';
update awarddetail;
//return Redirect;
return null;
 }
 
 // Approve Agreement by XO - Commit Funds button. 
    public PageReference ApproveAgreementbyXO() {  
        PageReference Redirect; 
         if (awarddetail.Being_Committed__c != True ) {    
          //  if (awarddetail.OwnerId != Userinfo.getUserId()){ // Commented on 6.8.16. Bug 7151
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error, 'You cannot Commit the Funds. '));                    
            return null;
            }
        else {
              ///
              //if(validateAwardAsAmericas()){
               /*     Boolean goAheadFlag=invokeMomentumIntgForAward();
                    if(!goAheadFlag) {
                        return null;
                     } */
              //   }
              ///   
               // awarddetail.Grant_Status__c='Awaiting GO Certification'; Status getting updated in "FundCommitmentForAwardCntrl" based on the response from Momentum. 
                awarddetail.Committed__c = True;
             // add new field created by Naveen.   
                update awarddetail;
                Redirect = new PageReference('/'+awarddetail.id);
                return Redirect;
        }
        //return Redirect;
        return null;
    }
 
 // Certify & Send to Organization for e-Signature (PO,SPO) (#2,#6-1)
public PageReference esign() {    
if (awarddetail.Grant_Status__c == 'Awaiting PO Certification' ){
awarddetail.Grant_Status__c='Awaiting Organization e-Signature';
update awarddetail;
}else
{
    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error, 'You cannot send this Award for e-Signature". '));                    
  return null;
}
return null;
}

// External user e-signs the Award 
public PageReference esignature() {    
if (awarddetail.Grant_Status__c == 'Awaiting Organization e-Signature' && awarddetail.Sponsor_e_Signature__c==true && awarddetail.Obligated__c != true && awarddetail.Awaiting_SGO_Approval__c == true && awarddetail.NOFA_Name__r.Cash_Grants_Awards__c=='Yes' && awarddetail.NOFA_Name__r.Cooperative_Agreement__c=='Yes')
{
awarddetail.Grant_Status__c='Awaiting SGO Obligation';
update awarddetail; 
}
else 
if (awarddetail.Grant_Status__c == 'Awaiting Organization e-Signature' && awarddetail.Sponsor_e_Signature__c==true && awarddetail.Obligated__c == true && awarddetail.Awaiting_SGO_Approval__c == true && awarddetail.NOFA_Name__r.Cash_Grants_Awards__c=='Yes' && awarddetail.NOFA_Name__r.Cooperative_Agreement__c=='Yes')
{
awarddetail.Grant_Status__c='Awaiting SGO Award';
update awarddetail; 
}
else if (awarddetail.Grant_Status__c == 'Awaiting Organization e-Signature' && awarddetail.Sponsor_e_Signature__c==true && awarddetail.NOFA_Name__r.Cash_Grants_Awards__c=='Optional'&& awarddetail.Application_ID__r.Program_Type__c=='Standard')
{
awarddetail.Grant_Status__c='Awaiting SPO Award';
update awarddetail;
}
else if (awarddetail.Grant_Status__c == 'Awaiting Organization e-Signature' && awarddetail.Sponsor_e_Signature__c==true && awarddetail.NOFA_Name__r.Cash_Grants_Awards__c=='No')
{
awarddetail.Grant_Status__c='Awaiting SPO Award';
update awarddetail;
}
else if (awarddetail.Grant_Status__c == 'Awaiting Organization e-Signature' && awarddetail.Sponsor_e_Signature__c==true  && awarddetail.NOFA_Name__r.Cash_Grants_Awards__c=='Optional'){
awarddetail.Grant_Status__c='Awaiting SPO Approval';
update awarddetail;
}

else
{
    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error, 'Please Edit and Check "Sponsor e-Signature" before signing Agreement. '));                    
  return null;
}
return null;
}

// SPO signs the Award and Sends to XO
public PageReference esignaturebySPO() {    
if (awarddetail.Grant_Status__c == 'Awaiting SPO Approval' && awarddetail.Sponsor_e_Signature__c==true){
awarddetail.Grant_Status__c='Awaiting XO CSHR Approval';
update awarddetail;
}else
{
    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error, 'You cannot e-sign this Award. '));                    
  return null;
}
return null;
}

// Move application to next status without committing - XO moves the Award to GO for a previously committed funds
public PageReference moveWithoutCommitting() {    
if (awarddetail.Grant_Status__c == 'Awaiting XO CSHR Approval' || awarddetail.Grant_Status__c == 'Being Committed'){
awarddetail.Grant_Status__c='Awaiting GO Certification';
update awarddetail;
}else
{
    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error, 'You cannot send this Award to GO". '));                    
  return null;
}
return null;
}

// Sign and Award Agreement (#6)
public PageReference AwardnonCS() {           
if (awarddetail.Grant_Status__c != 'Awaiting SPO Award'){
  ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error, 'You cannot Award the record. '));                    
  return null;
}
else {
    awarddetail.Grant_Status__c='Awarded';
    }
update awarddetail;
//return Redirect;
return null;
}

// Move to Next Status without Obligating (SGO)
public PageReference MovetoAward() {           
if (awarddetail.Grant_Status__c != 'Awaiting SGO Approval'){
  ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error, 'You cannot Award the record if the Status is not "Awaiting SGO Approval". '));                    
  return null;
}
else {
    awarddetail.Grant_Status__c='Awarded';
    }
update awarddetail;
//return Redirect;
return null;
}

// Certify and Send for Organization eSignature - Sent by SGO
public PageReference eSignaturebySGO () {    
awarddetail.Grant_Status__c='Awaiting Organization e-Signature';
update awarddetail;
//return Redirect;
return null;
}


// Sign Agreement and send to XO - SPO Action
public PageReference SignAgreementtoXO () { 
PageReference Redirect;
awarddetail.Grant_Status__c='Being Committed';
update awarddetail;
Redirect = new PageReference('/'+awarddetail.id);
return Redirect;
//return null;
}

// eisgn
Public Void confirmsign(){
    // esign
    Recordid = ApexPages.currentPage().getParameters().get('id');
    System.debug('Award is');
    Award__c Award = [select eSigned__c from Award__c where id =: Recordid];
    System.debug('Award is'+Award );
        if(!Award.eSigned__c){
              Award.eSigned__c = true;      
    }
   
    
    try{
        update Award;
    }
    Catch(exception e){
      //   System.debug('The following exception has occurred: ' + e.getMessage());
    }
    //return null;
}

Public pagereference reload(){
        PageReference pageRef = new PageReference(ApexPages.currentPage().getUrl());
        pageRef.setRedirect(true);
        return pageRef;
    }



//esign


//esign

 }