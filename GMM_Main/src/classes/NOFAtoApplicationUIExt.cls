/********************************************************************************************
Class Name: NOFAtoApplicationUIExt
Description: An apex controller that supports Nofa set up and configuration.
             Rendering NofatoApplicationUI page section based on Checkboxes in NOFA Setup

**********************************************************************************************
Modified By:Prashant 
Modified On:8/10/2015
Purpose:To populate organization filed form organization
**********************************************************************************************/

public with sharing  class NOFAtoApplicationUIExt 
{
    Public Application3__c applicationInput{get;set;}
    Public Id tempid;
    Public String rectype{get;set;}
   // Public String rectypename{get;set;}
    public boolean isDraft{get;set;}
    public String id;
    public Boolean displayMsg{get;set;}
    Public Project__c pro{get;set;}
    Public NOFA__c Nofa{get;set;}
   // Public String proj;
  //  Public Project__c pro{get;set;}
   // public list<selectOption> availableList {get;set;}     
    public list<selectOption> chosenList {get;set;}
    public boolean isLate{get;set;}
    
    public NOFAtoApplicationUIExt getThis(){
        return this;
    }
    
    public NOFAtoApplicationUIExt (ApexPages.StandardController controller) 
    {
            isDraft = false;
            isLate = false;
            applicationInput= new Application3__c();
            applicationInput.Type_of_Application__c = 'New';
            displayMsg=False;
            chosenList =  new list<SelectOption>();
            tempid=controller.getRecord().id;
            id=Apexpages.currentPage().getParameters().get('id');
            String projectid = Apexpages.currentPage().getParameters().get('projectid'); 
            String lateSubmission = Apexpages.currentPage().getParameters().get('submittedLate'); 
            if(lateSubmission!=null && lateSubmission == 'Yes'){
                isLate = true;
                applicationInput.Submitted_Late__c = true;               
            }
            String primeApplicationId = Apexpages.currentPage().getParameters().get('primeApplicationId'); 
            if(primeApplicationId!=null){
                applicationInput.Prime_Application__c = primeApplicationId;
            }
                
            // proj=Apexpages.currentPage().getParameters().get('proj');
            If(projectid!=null) 
                applicationInput.Project__c=projectid;
               //  System.debug('testing'+pro.Project_Director__c);
          pro=[select id,name,Project__c.Project_Director__c,Organization__c,Project_Start_Date__c,Project_End_Date__c,Project_Site_URL__c from Project__c where id=:projectid];
            System.debug('testing'+pro.Project_Director__c);
           applicationInput.Project_Directorss__c=pro.Project_Director__c;
           applicationInput.Proposed_Start_Date__c = pro.Project_Start_Date__c;
           applicationInput.Proposed_End_Date__c = pro.Project_End_Date__c;
           applicationInput.Project_Directorss__c=pro.Project_Director__c;
           applicationInput.Project_website_urls__c=pro.Project_Site_URL__c;
            applicationInput.Applicant_User__c = Userinfo.getUserId();
            applicationInput.Grantee_Status__c='In Progress';
            applicationInput.Status__c='In Progress';
            
            User loggedinUser = [Select name,isPortalEnabled,contactid,contact.AccountId from user where id=:userinfo.getUserId()];
              // if(loggedinUser.isPortalEnabled)
            applicationInput.Organization__c = pro.Organization__c;
          
          
            
            If(id!=null && id!='')
                 Nofa=[Select NOFA_name__c,CNCS_Corporate_Program__r.Module__c,SC_Other__c,NCCC_Other__c,Other_other_section__c,Focus_Areas_and_Objectives_AP__c,Economic_Opportunities_AP__c,Education_AP__c,Veterans_Military_Families_AP__c,Capacity_Building_AP__c,Disaster_Services_AP__c,
                 Required__c,Organization_Docs__c,Environmental_Stewardship_AP__c,Healthy_Futures_AP__c,Standard__c,Safety_and_Security_AP__c,Tools_and_Equipment_AP__c,S_N__c,SIF__c,VISTA__c,Characteristics_and_Priorities__c,
                 Organization__c,Proposed_Dates__c,Target_Populations__c,NCCC_Dates_and_Questions__c,NCC_for_Focus_Areas_and_Objectives__c,Other_for_Focus_Areas_and_Objectives__c,Intermediary_Justification__c,Need__c,
                 Clarification_Summary__c,Continuation_Changes__c,VISTA_Assignment__c,Summary_of_Accomplishments__c,Leadership_and_Team__c,Cost_Effectiveness_and_Budget_Adequacy__c,Organizational_Capability__c,
                 Executive_Summary__c,Other__c,Amendment_Justification__c,Strengthening_Communities__c,Recruitment_and_Development__c,Foster_Grandparents_Only__c,Evaluation_Summary_of_Plan__c,Standard_424__c,Program_Design__c,
                 Program_Management__c,RSVP_Only__c,Review_Cycle__c from NOFA__c where id=:id];
            System.debug('Valueofid'+id+'$$$$$'+Nofa.Foster_Grandparents_Only__c);  
            rectype=[Select id,name from Recordtype where SObjectType='Application3__c' and name='Application'].id;     
          // pro=[select id,name,Project_Director__c from Project__c where id=:id];
     applicationInput.Module__c=nofa.CNCS_Corporate_Program__r.Module__c;
  }
   
   Public PageReference SaveAsDraft(){                              //Save as draft - Overide the required field 
         PageReference Redirect;
     
         try{
         applicationInput.recordtypeid=rectype;
         applicationInput.NOFA_RFP__c=id;
         applicationInput.Grantee_Status__c='In Progress';
             insert applicationInput;
             Redirect = new PageReference('/'+applicationInput.id);
             
             return Redirect;
            }
         Catch(DMLException e){
          System.debug('@@@@@@@@!!!!!'+e.getmessage());
        }
  
        return null;
         
       }
        public pagereference createProject(){                                    //Project lookup from project object 
         return new Pagereference('/a0W/e?retURL=%2Fa0W%2Fo');
          }      
   
   /*public PageReference save1(){
         //boolean checkAllRequiredDocs = true;  
         map<String,Boolean> checkRequiredNarrativeFields = new map<String,Boolean>();
       //  applicationInput.Grantee_Status__c='Submitted';
        // applicationInput.Status__c='Submitted';
         string RequiredDocs;
         PageReference Redirect;
         try{
    if(!Validate())
  return null;
       
                                  
              
              checkRequiredNarrativeFields = ApplicationCheck.checkNarrativeFields(applicationInput,Nofa.Id);
              if(checkRequiredNarrativeFields.size()>0){
                    string fieldNames = '';
                    for(String fieldName: checkRequiredNarrativeFields.keyset()){
                      fieldNames += fieldName +', ';
                    }
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error, 'Application----- cannot be Submitted, Due to the following reason: Please enter values for Required fields: '+fieldNames));                    
                    return null;
              } 
              RequiredDocs = checkRequiredDocsAttached();
              //system.debug('check = '+checkAllRequiredDocs);
        
             if(RequiredDocs != null  && RequiredDocs != ''){
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error, 'Application cannot be Submitted, Due to the following reason: Required Document not attached to Application: '+RequiredDocs));
                return null;
             }
             
             if(Nofa.Review_Cycle__c == 'Rolling'){
                applicationInput.Grantee_Status__c = 'Submitted';
                applicationInput.Status__c = 'Submitted';
              }
              else if(Nofa.Review_Cycle__c == 'Post-Deadline'){
                applicationInput.Grantee_Status__c = 'Pre - Submitted';
                applicationInput.Status__c = 'Pre - Submitted';
              }
              
             applicationInput.recordtypeid=rectype;
             applicationInput.NOFA_RFP__c=id;
             Insert applicationInput;
             
              //add attachments to organization when app is submitted      
             if(applicationInput.NOFA_RFP__r.Organization_Docs__c!=null){
                ApplicationCheck.attachOrgDocs(applicationInput, Nofa.Organization_Docs__c);
             }
              
             Redirect = new PageReference('/'+applicationInput.id);
             return Redirect;
         }
         Catch(DMLException e){
             System.debug('@@@@@@@@!!!!!'+e.getmessage());
         }
             return null;
         }*/
  
    public boolean Validate()                                                                               //Required filed method for save as draft
     {
    if(((applicationInput.Authorized_Representative__c==null || applicationInput.Proposed_End_Date_is__c==null ||applicationInput.Proposed_Start_Date_is__c==null) &&(Nofa.Proposed_Dates__c!=True))||(applicationInput.Proposed_Start_Date__c==null || applicationInput.Proposed_End_Date__c==null)||((applicationInput.Number_of_members_wearing_logo_every_day__c==null||applicationInput.Number_of_ongoing_volunteers__c==null|| applicationInput.AmeriCorps_logo_will_display_on_website__c  == null || applicationInput.Other_Revenue__c==null ||applicationInput.Number_of_elevator_speeches_created__c==null || applicationInput.Number_of_episodic_volunteers_generated__c==null || applicationInput.Total_Match_Dollars__c==null ||applicationInput.Private_Match__c==null ||applicationInput.Local_State_Federal_Government_Match__c==null) && Nofa.S_N__c )||((applicationInput.How_many_teams_are_being_requested__c==null || applicationInput.Primary_State_of_Service_Activities__c==null || applicationInput.Select_a_round__c==null || applicationInput.Specify_if_you_want_to_be_in_more_rounds__c==null) && Nofa.NCCC_Dates_and_Questions__c)||((applicationInput.Counties__c==null||applicationinput.State_and_or_Territories__c==null||applicationInput.Other_Area_Affected_by_Project__c==null)&& Nofa.Standard__c)) 
         {
        // applicationInput.Counties__c.addError('Counties');

           applicationInput.Authorized_Representative__c.addError('Authorized Representative');
           applicationInput.Proposed_Start_Date__c.addError('Proposed Start Date');
           applicationInput.Proposed_End_Date__c.addError('Proposed End daate');
           applicationInput.Proposed_End_Date_is__c.addError('');
           applicationInput.Proposed_Start_Date_is__c.addError('Proposed Start Date is');
           applicationInput.AmeriCorps_logo_will_display_on_website__c.addError('');
           applicationInput.Number_of_elevator_speeches_created__c.addError('No of Elevator Speeches');
           applicationInput.Number_of_episodic_volunteers_generated__c.addError('No of Eposodic Volunteers Generated');
           applicationInput.Total_Match_Dollars__c.addError('Total Match Dolloars');
           applicationInput.Private_Match__c.addError('Private Match');
           applicationInput.Local_State_Federal_Government_Match__c.addError('Local State Federal Governmnet Match');
            applicationInput.Other_Revenue__c.addError('Other Revenue');
             applicationInput.Number_of_ongoing_volunteers__c.addError('No of ongoin Volunteers');
          applicationInput.Number_of_members_wearing_logo_every_day__c.addError('No of Members wearing logo evry day');
           applicationInput.Counties__c.addError('Country');
     applicationInput.State_and_or_Territories__c.addError('State and Territories');
      applicationInput.Other_Area_Affected_by_Project__c.addError('Other Area affected by project');
      applicationInput.How_many_teams_are_being_requested__c.addError('How many team are being requested');
       applicationInput.Primary_State_of_Service_Activities__c.addError('Primary State Service Activities');
        applicationInput.Select_a_round__c.addError('Select A Round');
         applicationInput.Specify_if_you_want_to_be_in_more_rounds__c.addError('Specify if you want to be in more rounds');
   return false;
    }
    else
    return true;
    }
      /*public String checkRequiredDocsAttached(){                                                                   //Attachment 
        
        boolean check = true; 
        string requiredDocs = '';
        String s;
        string allAttachmentTypes='';
    
        if(Nofa.Required__c !=null){
            system.debug('boolean in !=null = '+check);
        
            s = Nofa.Required__c;
            list<String> docTypes = s.split(';');
        
            system.debug('app Id = '+applicationInput.Id);
            list<Attachment__c> attachments = new list<Attachment__c>();
            if(applicationInput.Id!=null)
                 attachments = new list<Attachment__c>([Select Id,Type__c from Attachment__c where Application__c = :applicationInput.Id]);
            
            if(attachments.size()>0){           
                for(Attachment__c a: attachments){              
                    if(a.Type__c!=null)
                    {   
                        allAttachmentTypes += a.Type__c+';';                    
                    }                   
                }
                system.debug('allAttachmentTypes '+allAttachmentTypes);
            }else{
                check = false;
            }
            
            system.debug('docTypes ='+docTypes);
            for(String dType: docTypes){
                if(allAttachmentTypes!=null){
                    if(allAttachmentTypes.Contains(dType)){
                        check = true;
                    }else{
                        check = false;    
                        requiredDocs += dType + ', ';                
                    }
                }else{
                    check = false; 
                }
            }
        }
    
         return requiredDocs;
     } */

 }