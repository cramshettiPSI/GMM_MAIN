public with sharing class NOFAtoNotificationUIExt 

{
    Public Application3__c applicationInput{get;set;}
    Public Id tempid;
    Public String rectype{get;set;}
    Public String rectypename{get;set;}
    public boolean isDraft{get;set;}
    public String id;
    public Boolean displayMsg{get;set;}
    Public NOFA__c Nofa{get;set;}
    Public User Usr {get;set;}
    public NOFAtoNotificationUIExt (ApexPages.StandardController controller) 
    {
        isDraft = false;
    applicationInput= new Application3__c();
    Usr=new User();
    displayMsg=False;
    tempid=controller.getRecord().id;
     id=Apexpages.currentPage().getParameters().get('id');
     String projectid = Apexpages.currentPage().getParameters().get('projectid');
     If(projectid!=null) 
    applicationInput.Project__c=projectid;
   //applicationInput.Organization__c=$User.Accoutid; 
    System.debug('Valueofid'+id);
     If(id!=null && id!='')
      Nofa=[Select NCCC_Dates_CP__c,Standard_424__c,Evaluation_Summary_or_Plan_CP__c,Program_Design_CP__c, Program_Management_CP__c, Recruitment_and_Development_CP__c, Strengthening_Communities_CP__c, Amendment_Justification_CP__c, 
            Other_CP__c, Continuation_Changes_CP__c, Clarification_Summary_CP__c, Cost_Effectiveness_and_Budget_Adequacy_C__c, Organizational_Capability_CP__c, Need_CP__c,
            Intermediary_Justification_CP__c, Executive_Summary_CP__c, Focus_Areas_and_Objectives_NCCC_CP__c, Target_Populations_CP__c,
            Have_funding_history_with_a_CNCS_Prog_CP__c, Other_NCCC_CP__c from NOFA__c where id=:id];
            
            rectype=[Select id,name from Recordtype where SObjectType='Application3__c' and name='Notification of Intent to Apply'].id;    
 Usr = [SELECT Phone,Accountid, Id FROM User WHERE Id = : UserInfo.getUserId()];
 
  applicationInput.Organization__c=Usr.Accountid;
  }
   
     Public PageReference SaveAsDraft(){
         PageReference Redirect;
     
         try{
         applicationInput.recordtypeid=rectype;
         applicationInput.NOFA_RFP__c=id;
             insert applicationInput;
            Redirect = new PageReference('/'+applicationInput.id);
             
            return Redirect;
            }
         Catch(DMLException e){
         ApexPages.addMessages(e);
         System.debug('@@@@@@@@!!!!!'+e.getmessage());
 }
  
return null; 
                }   
       
              
      
       /* public pagereference createProject(){
         return new Pagereference('/a0W/e?retURL=%2Fa0W%2Fo');
          }    
   
   public PageReference save(){
 applicationInput.Status__c='Submitted';
     PageReference Redirect;
         try{  
            applicationInput.recordtypeid=rectype;        
            applicationInput.NOFA_RFP__c=id;
            Insert applicationInput;
            Redirect = new PageReference('/'+applicationInput.id);
            return Redirect;
           }
         Catch(DMLException e){
         System.debug('@@@@@@@@!!!!!'+e.getmessage());
         }
             return null;
         }         */
   

 }