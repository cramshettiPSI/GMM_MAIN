public class NOFAtoApplicationUIExt2 
{
    Public Application3__c applicationInput{get;set;}
    Public id tempid;
    public String id;
    public String projectid; 
     public String corporateprogramid;
    public boolean isDraft{get;set;}
    Public NOFA__c Nofa{get;set;}
    Project__c pro{get;set;}
    public String cid{get;set;} 
    public string lic{get;set;}
     
     
    public NOFAtoApplicationUIExt2 (ApexPages.StandardController controller) 
  
    {
        User u= [select id, name, profile.userlicense.name from user where id=:userinfo.getUserId()];
        lic=u.profile.userlicense.name;
        isDraft = false;
        applicationInput= new Application3__c();
        system.debug('params = '+Apexpages.currentPage().getParameters());
        tempid=controller.getRecord().id;
        id=Apexpages.currentPage().getParameters().get('id');
        projectid=Apexpages.currentPage().getParameters().get('projectid');
        corporateprogramid=Apexpages.currentPage().getParameters().get('corporateprogramid');
        System.debug('Valueofid'+id+'*****'+projectid);
        //  applicationInput.Project__c=projectid; 
        If(id!=null && id!='')
        Nofa=[Select ID, Allow_Concept_Paper__c,Name,Fiscal_Yr__c,Corporate_Program__r.Short_Code__c,CNCS_Corporate_Program__r.Name,NOFA_Sequence__c,Intermediary_Justification__c,Need__c,Clarification_Summary__c,Continuation_Changes__c,VISTA_Assignment__c,Project_Name__c,Summary_of_Accomplishments__c,Leadership_and_Team__c,Cost_Effectiveness_and_Budget_Adequacy__c,Organizational_Capability__c,Executive_Summary__c,Other__c,Amendment_Justification__c,Strengthening_Communities__c,Recruitment_and_Development__c,Foster_Grandparents_Only__c,Evaluation_Summary_of_Plan__c,Standard_424__c,Program_Design__c,Program_Management__c,RSVP_Only__c from NOFA__c where id=:id];
       // System.debug('Valueofid'+id+'$$$$$'+Nofa.CNCS_Corporate_Program__r.Module__c);   
       applicationInput.NOFA_RFP__c=id; 
       //if(Nofa.CNCS_Corporate_Program__r.Module__c!=null)
      // applicationInput.Module__c=Nofa.CNCS_Corporate_Program__r.Module__c;
        //  applicationInput.Project__c=projectid; 
    }
   
   public PageReference Apply(){
   	 if(applicationInput.Project__c==null){
   	 	ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.error,'Please Select a Project to Proceed'));
        return null;
   	 }
     projectid=applicationInput.Project__c;
     Profile p = [Select Id,Name from Profile where Name = 'State Commission Profile'];
     Project__c project = [Select Id,name from Project__c where Id = :applicationInput.Project__c];
     
     if(Apexpages.currentPage().getParameters().get('frmPrimeApp')=='Yes'){
     	Schema.DescribeSObjectResult r = Prime_Application__c.sObjectType.getDescribe();
     	String keyPrefix = r.getKeyPrefix();
     	String PrimeAppName;
     	if(nofa.Fiscal_Yr__c!=null && nofa.Corporate_Program__r.Short_Code__c!=null && nofa.NOFA_Sequence__c!=null){
      		PrimeAppName = nofa.Fiscal_Yr__c.Right(2)+nofa.Corporate_Program__r.Short_Code__c+'00'+nofa.NOFA_Sequence__c;
     	}
        if(userInfo.getProfileId()==p.Id){
            return new PageReference('/statecommission/'+keyPrefix+'/e?retURL=%2F'+nofa.Id+'&'+System.Label.NOFO_Name+'='+nofa.Name+'&'+System.Label.Corp_Structure_Prime_App+'='+nofa.CNCS_Corporate_Program__r.Name+'&'+System.Label.Project_Prime_Application+'='+project.Name+'&Name='+PrimeAppName);
        }else{
            return new PageReference('/'+keyPrefix+'/e?retURL=%2F'+nofa.Id+'&'+System.Label.NOFO_Name+'='+nofa.Name+'&'+System.Label.Corp_Structure_Prime_App+'='+nofa.CNCS_Corporate_Program__r.Name+'&'+System.Label.Project_Prime_Application+'='+project.Name+'&Name='+PrimeAppName);
        }       
     }
    // corporateprogramid=Nofa.CNCS_Corporate_Program__r.Module__c;
     if(Nofa.Allow_Concept_Paper__c == 'Yes'){
       if(Apexpages.currentPage().getParameters().get('primeApplicationId')!=null){
          string primeApplicationId = Apexpages.currentPage().getParameters().get('primeApplicationId');
          return new Pagereference('/apex/NOFAtoConceptPaperUI?id='+id+'&projectid='+projectid+'&primeApplicationId='+primeApplicationId);
       }else{   
          return new Pagereference('/apex/NOFAtoConceptPaperUI?id='+id+'&projectid='+projectid+'&corporateprogramid='+corporateprogramid);
       }
     }
     else
     {  
        
        if(Apexpages.currentPage().getParameters().get('submittedLate')!=null){
             if(Apexpages.currentPage().getParameters().get('primeApplicationId')!=null && Apexpages.currentPage().getParameters().get('opentoApps') == 'Accepting Sub-Applications'){
                string primeApplicationId = Apexpages.currentPage().getParameters().get('primeApplicationId');
                return new Pagereference('/apex/NOFAtoApplicationUI?id='+id+'&projectid='+projectid+'&submittedLate=Yes'+'&primeApplicationId='+primeApplicationId);            
             }
             else if(Apexpages.currentPage().getParameters().get('primeApplicationId')!=null && Apexpages.currentPage().getParameters().get('opentoApps') != 'Accepting Sub-Applications'){                 
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.error,'Sub Applications can be only created if Prime Application is Accpeting Sub-Applications'));
                    return null;                
             }
             else{
                return new Pagereference('/apex/NOFAtoApplicationUI?id='+id+'&projectid='+projectid+'&submittedLate=Yes');
             }
             
        }else{
            if(Apexpages.currentPage().getParameters().get('primeApplicationId')!=null && Apexpages.currentPage().getParameters().get('opentoApps') == 'Accepting Sub-Applications'){
                string primeApplicationId = Apexpages.currentPage().getParameters().get('primeApplicationId');
                return new Pagereference('/apex/NOFAtoApplicationUI?id='+id+'&projectid='+projectid+'&submittedLate=Yes'+'&primeApplicationId='+primeApplicationId);            
            }
            else if(Apexpages.currentPage().getParameters().get('primeApplicationId')!=null && Apexpages.currentPage().getParameters().get('opentoApps') != 'Accepting Sub-Applications'){              
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.error,'Sub Applications can be only created if Prime Application is Accpeting Sub-Applications'));
                    return null;                
            }else{
                return new Pagereference('/apex/NOFAtoApplicationUI?id='+id+'&projectid='+projectid);
            }
        }
     
     }
     
     
  }
   
      
  public pagereference createProject(){ 
    String userid = UserInfo.getUserID();
    system.debug('####getuserID###' + userid);
    User u = [Select ID,AccountID,ContactID  From User where ID= : userid];
    contact con = [select id,accountid,account.name from contact where ID=:u.contactID];
    string OrgIDinURL = con.account.Name;
    Field_Ids__c f = Field_Ids__c.getInstance('Project Organization');
    String fieldId = f.Id__c;
    system.debug('####OrgIDinURL ###' + OrgIDinURL);

    Schema.DescribeSObjectResult r = Project__c.sObjectType.getDescribe();
    String keyPrefix = r.getKeyPrefix();
   return new Pagereference('/'+keyPrefix+'/e?'+fieldId+'='+OrgIDinURL+ '&' +System.Label.Corporate_Program_Name+'='+nofa.CNCS_Corporate_Program__r.Name);   
   
  }
  
  public pagereference cancel(){    
      return new Pagereference('/a2c/o');
  }
 }