public class PreviewExtension {
 

    Public Application3__c apppreview{get;set;}    
    public String id;
    public String Applicationid;
   // public String Id;
    Public String nofaid;
   // public Application3__c Application {get;set;}
    public NOFA__c Nofa{get;set;}
    public String queryString {get;set;}
    private ApexPages.StandardController scontroller;
	
	public PreviewExtension (ApexPages.StandardController controller) 
    {           
            sController = controller;
            apppreview= new Application3__c();
           // System.debug('State_####'+apppreview.State__c);
          Applicationid=Apexpages.currentPage().getParameters().get('Applicationid');  
           // nofaid=Apexpages.currentPage().getParameters().get('nofaid');  
            id=Apexpages.currentPage().getParameters().get('id');    
             If(id!=null && id!='')
            Nofa=[Select Id,Name,Standard_Information__c,Proposed_Dates__c,NCCC_Dates_and_Questions__c,Standard__c,Other_other_section__c,S_N__c,SIF__c,VISTA__c,NCCC_Other__c,SC_Other__c,
            Program_Design__c,Program_Management__c,Evaluation_Summary_of_Plan__c,Recruitment_and_Development__c,Strengthening_Communities__c,Amendment_Justification__c,Continuation_Changes__c,Clarification_Summary__c,
            Cost_Effectiveness_and_Budget_Adequacy__c,Organizational_Capability__c,Executive_Summary__c,Intermediary_Justification__c,Need__c,Safety_and_Security_AP__c,Tools_and_Equipment_AP__c,Other__c,Focus_Areas_and_Objectives_AP__c,
            Education_AP__c,Veterans_Military_Families_AP__c,Disaster_Services_AP__c,Environmental_Stewardship_AP__c,Healthy_Futures_AP__c,Capacity_Building_AP__c,Economic_Opportunities_AP__c,Target_Populations__c,
            Characteristics_and_Priorities__c,Executive_Summary_CP__c,Organizational_Capability_CP__c,Program_Design_CP__c,Program_Management_CP__c,Evaluation_Summary_or_Plan_CP__c,Recruitment_and_Development_CP__c,
            Strengthening_Communities_CP__c,Amendment_Justification_CP__c,Continuation_Changes_CP__c,Clarification_Summary_CP__c,Cost_Effectiveness_and_Budget_Adequacy_C__c,Need_CP__c,Intermediary_Justification_CP__c,
            Other_CP__c,Education_CP__c,Veterans_Military_Families_CP__c,Disaster_Services_CP__c,Environmental_Stewardship_CP__c,Energy_Efficiency_CP__c,Healthy_Futures_CP__c,Capacity_Building_CP__c,Economic_Opportunities_CP__c,
            Focus_Areas_and_Objectives_NCCC_CP__c,Have_funding_history_with_a_CNCS_Prog_CP__c,Other_NCCC_CP__c,Standard_CP__c   from NOFA__c where id=:id]; 
            apppreview.NOFA_RFP__c=id; 

 apppreview.NOFA_RFP__c =id;
  }
  
  }