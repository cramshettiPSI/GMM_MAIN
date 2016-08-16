trigger CreateAwardReportfromAward on Award__c (after Insert) {
    
    Id PrimeAwardRecordTypeId = Schema.SObjectType.Award__c.getRecordTypeInfosByName().get('Prime Award').getRecordTypeId();
    Id FFRRecordTypeId = Schema.SObjectType.Award_Reporting__c.getRecordTypeInfosByName().get('Federal Financial Reports').getRecordTypeId();    
    Id VISTAPRSRecordTypeId = Schema.SObjectType.Award_Reporting__c.getRecordTypeInfosByName().get('VISTA Progress Report Supplements').getRecordTypeId();
    Id PRRecordTypeId = Schema.SObjectType.Award_Reporting__c.getRecordTypeInfosByName().get('Progress Reports').getRecordTypeId();
    Id EIRecordTypeId = Schema.SObjectType.Award_Reporting__c.getRecordTypeInfosByName().get('Equipment Inventory').getRecordTypeId();
    Id SCRecordTypeId = Schema.SObjectType.Award_Reporting__c.getRecordTypeInfosByName().get('Subgrantee Certification').getRecordTypeId();
    Id IURSRecordTypeId = Schema.SObjectType.Award_Reporting__c.getRecordTypeInfosByName().get('Inventory of Unused or Residual Supplies').getRecordTypeId();
    Id FFPRSPRRecordTypeId = Schema.SObjectType.Award_Reporting__c.getRecordTypeInfosByName().get('FGP/FGPF Progress Report Supplement').getRecordTypeId();
    Id RSPVPRSRecordTypeId = Schema.SObjectType.Award_Reporting__c.getRecordTypeInfosByName().get('RSVP Progress Report Supplement').getRecordTypeId();
   
    List<Award_Reporting__c> newAwardReport =new List<Award_Reporting__c>();
    List<ID> idList = new List<ID>();
    set<Id> goIds = new set<Id>();

    for(Award__c awards:Trigger.new){
        idList.add(awards.id);
        goIds.add(awards.Grants_Officer__c);
    }

    system.debug('!!!!!!!!!!!!!!!!!!!!!!!!'+ idList );

    system.debug('!!!!!!!!!!!!!!!!!!!!!!!!'+ goIds );

    map<Id,User> userMap = new map<Id,User>([Select Id,Email from User where Id in :goIds]);
    Map<ID,Award__c> award_Map = new Map<ID,Award__c>();
    List<ID> nofaID_List = new List<ID>();
    For(Award__c aw : [Select Application_ID__r.NOFA_RFP__r.id,Project_Title__c  from Award__c where id IN: idList])
    {
        nofaID_List.add(aw.Application_ID__r.NOFA_RFP__r.id);
        award_Map.put(aw.id,aw);
    }
    system.debug('!!!!!!!!!!!!!!!!!!!!!!!!'+ userMap );

    system.debug('!!!!!!!!!!!!!!!!!!!!!!!!'+ nofaID_List );

    system.debug('!!!!!!!!!!!!!!!!!!!!!!!!'+ award_Map );

    List<Action_Reports__c> ar_List = [Select Name,Due_Date__c,Sequence_Number__c,Report_Activity__c,Reporting_Period_End_Date__c,Reporting_Period_Start_Date__c,NOFA_ID__c, Corporate_Program_Code__c, NOFA_ID__r.CNCS_Corporate_Program__r.Module__c from Action_Reports__c where NOFA_ID__c IN: nofaID_List];

    system.debug('!!!!!!!!!!!!!!!!!!!!!!!!'+ ar_List);
    system.debug('!!!!!!!!!!!!!!!!!!!!!!!!***'+ ar_List.size());

    for(Award__c awards:Trigger.new)
    { 
       
        for(Action_Reports__c aw:ar_List)
        {
            Award_Reporting__c Awardreport=New Award_Reporting__c();
            Awardreport.Project_Title__c = award_Map.get(awards.Id).Project_Title__c;
            Awardreport.Sequence_Number__c = aw.Sequence_Number__c;
            if(awards.RecordTypeId == PrimeAwardRecordTypeId)
            {
                Awardreport.RecordTypeId = SCRecordTypeId;
            }
            else
            {
                if(aw.Report_Activity__c=='FFR')
                {
                    Awardreport.recordtypeid=FFRRecordTypeId;
                    Awardreport.Due_Date__c=aw.Due_Date__c;                   
                    Awardreport.Grant_Year__c=awards.Year_of_Grant__c;
                    Awardreport.Status__c='Draft';                 
                    Awardreport.Reporting_Start_Date__c=aw.Reporting_Period_Start_Date__c;
                    Awardreport.Reporting_End_Date__c=aw.Reporting_Period_End_Date__c; 
                    Awardreport.Reporting_Periods__c = aw.Reporting_Period_Start_Date__c + '-' + aw.Reporting_Period_End_Date__c;
                    Awardreport.Award__c=awards.id;
                    Awardreport.Report_Name1__c= aw.Corporate_Program_Code__c;
                    Awardreport.PM_Module__c = aw.NOFA_ID__r.CNCS_Corporate_Program__r.Module__c;                    
                  }
                   
                 else if(aw.Report_Activity__c=='FSR'){
                    Awardreport.recordtypeid=PRRecordTypeId;
                    Awardreport.Due_Date__c=aw.Due_Date__c;
                    Awardreport.Status__c='Draft';
                    Awardreport.Reporting_Start_Date__c=aw.Reporting_Period_Start_Date__c;
                    Awardreport.Reporting_End_Date__c=aw.Reporting_Period_End_Date__c; 
                    Awardreport.Reporting_Periods__c = aw.Reporting_Period_Start_Date__c + '-' + aw.Reporting_Period_End_Date__c;
                    Awardreport.Award__c=awards.id;
                    Awardreport.Report_Name1__c= aw.Corporate_Program_Code__c;
                    Awardreport.PM_Module__c = aw.NOFA_ID__r.CNCS_Corporate_Program__r.Module__c;
                    
                }                    
                else if(aw.Report_Activity__c=='Equipment Inventory')
                {
                    Awardreport.recordtypeid=EIRecordTypeId;
                    Awardreport.Due_Date__c=aw.Due_Date__c;
                    Awardreport.Status__c='Draft';
                    Awardreport.Award__c=awards.id;
                    Awardreport.Reporting_Start_Date__c=aw.Reporting_Period_Start_Date__c;
                    Awardreport.Reporting_End_Date__c=aw.Reporting_Period_End_Date__c; 
                    Awardreport.Reporting_Periods__c = aw.Reporting_Period_Start_Date__c + '-' + aw.Reporting_Period_End_Date__c;
                    Awardreport.Report_Name1__c= aw.Corporate_Program_Code__c;
                    Awardreport.PM_Module__c = aw.NOFA_ID__r.CNCS_Corporate_Program__r.Module__c;
                    
                }                
                else if(aw.Report_Activity__c=='Subgrantee Certification')
                {
                    Awardreport.recordtypeid=SCRecordTypeId;
                    Awardreport.Due_Date__c=aw.Due_Date__c;
                    Awardreport.Status__c='Draft';
                    Awardreport.Award__c=awards.id;
                    Awardreport.Reporting_Start_Date__c=aw.Reporting_Period_Start_Date__c;
                    Awardreport.Reporting_End_Date__c=aw.Reporting_Period_End_Date__c; 
                    Awardreport.Reporting_Periods__c = aw.Reporting_Period_Start_Date__c + '-' + aw.Reporting_Period_End_Date__c;
                    Awardreport.Report_Name1__c= aw.Corporate_Program_Code__c;
                    Awardreport.PM_Module__c = aw.NOFA_ID__r.CNCS_Corporate_Program__r.Module__c;
                    
                }
                else if(aw.Report_Activity__c=='Federal Financial Reports')
                {
                    Awardreport.recordtypeid=FFRRecordTypeId;
                    Awardreport.Grant_Number__c=String.valueOf(awards.Grant_Number__c);
                    AwardReport.Reporting_End_Date__c = aw.Reporting_Period_End_Date__c;
                    AwardReport.GO_Email__c = userMap.get(awards.Grants_Officer__c).Email;
                    Awardreport.Status__c='Draft';
                    Awardreport.Due_Date__c=aw.Due_Date__c;
                    Awardreport.Award__c=awards.id;
                    Awardreport.Reporting_Start_Date__c=aw.Reporting_Period_Start_Date__c;
                    Awardreport.Reporting_End_Date__c=aw.Reporting_Period_End_Date__c; 
                    Awardreport.Reporting_Periods__c = aw.Reporting_Period_Start_Date__c + '-' + aw.Reporting_Period_End_Date__c;
                    Awardreport.Report_Name1__c= aw.Corporate_Program_Code__c;
                    Awardreport.PM_Module__c = aw.NOFA_ID__r.CNCS_Corporate_Program__r.Module__c;
                    
                }
                else if(aw.Report_Activity__c=='VISTA PRS')
                {
                    Awardreport.recordtypeid=VISTAPRSRecordTypeId;
                    Awardreport.Due_Date__c=aw.Due_Date__c;
                    Awardreport.Status__c='Draft';                 
                    Awardreport.Award__c=awards.id;
                    Awardreport.Reporting_Start_Date__c=aw.Reporting_Period_Start_Date__c;
                    Awardreport.Reporting_End_Date__c=aw.Reporting_Period_End_Date__c; 
                    Awardreport.Reporting_Periods__c = aw.Reporting_Period_Start_Date__c + '-' + aw.Reporting_Period_End_Date__c;
                    Awardreport.Report_Name1__c= aw.Corporate_Program_Code__c;
                    Awardreport.PM_Module__c = aw.NOFA_ID__r.CNCS_Corporate_Program__r.Module__c;
                    
                }
                else if(aw.Report_Activity__c=='FGP/FGPF PRS')
                {
                    Awardreport.recordtypeid=FFPRSPRRecordTypeId;
                    Awardreport.Due_Date__c=aw.Due_Date__c;
                    Awardreport.Status__c='Draft';
                    Awardreport.Award__c=awards.id;
                    Awardreport.Reporting_Start_Date__c=aw.Reporting_Period_Start_Date__c;
                    Awardreport.Reporting_End_Date__c=aw.Reporting_Period_End_Date__c; 
                    Awardreport.Reporting_Periods__c = aw.Reporting_Period_Start_Date__c + '-' + aw.Reporting_Period_End_Date__c;
                    Awardreport.Report_Name1__c= aw.Corporate_Program_Code__c;
                    Awardreport.PM_Module__c = aw.NOFA_ID__r.CNCS_Corporate_Program__r.Module__c;
                    
                }
                else if(aw.Report_Activity__c=='RSVP PRS')
                {
                    Awardreport.recordtypeid=RSPVPRSRecordTypeId ;
                    Awardreport.Due_Date__c=aw.Due_Date__c;                    
                    Awardreport.Award__c=awards.id;
                    Awardreport.Status__c='Draft';
                    Awardreport.Reporting_Start_Date__c=aw.Reporting_Period_Start_Date__c;
                    Awardreport.Reporting_End_Date__c=aw.Reporting_Period_End_Date__c; 
                    Awardreport.Reporting_Periods__c = aw.Reporting_Period_Start_Date__c + '-' + aw.Reporting_Period_End_Date__c;
                    Awardreport.Report_Name1__c= aw.Corporate_Program_Code__c;
                    Awardreport.PM_Module__c = aw.NOFA_ID__r.CNCS_Corporate_Program__r.Module__c;
                   
                }
                else if(aw.Report_Activity__c=='Progress Report' ||aw.Report_Activity__c=='Progress Report Annual'||aw.Report_Activity__c=='Progress Report Lite'||aw.Report_Activity__c=='Progress Report Lite Quarterly'||aw.Report_Activity__c=='Progress Report Lite Semiannual')
                {
                    Awardreport.recordtypeid=PRRecordTypeId ;
                    Awardreport.Due_Date__c=aw.Due_Date__c;
                    Awardreport.Award__c=awards.id;
                    Awardreport.Status__c='Draft';
                    if(aw.Report_Activity__c=='Progress Report')
                      Awardreport.Progress_Report_Type__c='PR';
                    if(aw.Report_Activity__c=='Progress Report Annual')
                      Awardreport.Progress_Report_Type__c='PRA';
                    if(aw.Report_Activity__c=='Progress Report Lite')
                      Awardreport.Progress_Report_Type__c='PRL';
                    if(aw.Report_Activity__c=='Progress Report Lite Quarterly')
                      Awardreport.Progress_Report_Type__c='PRQ';
                    if(aw.Report_Activity__c=='Progress Report Lite Semiannual')
                      Awardreport.Progress_Report_Type__c='PRS';
                    Awardreport.Reporting_Start_Date__c=aw.Reporting_Period_Start_Date__c;
                    Awardreport.Reporting_End_Date__c=aw.Reporting_Period_End_Date__c; 
                    Awardreport.Reporting_Periods__c = aw.Reporting_Period_Start_Date__c + '-' + aw.Reporting_Period_End_Date__c;
                    Awardreport.Report_Name1__c= aw.Corporate_Program_Code__c;
                    Awardreport.PM_Module__c = aw.NOFA_ID__r.CNCS_Corporate_Program__r.Module__c;
                   
                }
                else if(aw.Report_Activity__c=='Inventory of Unused or Residual Supplies')
                {
                    Awardreport.recordtypeid=IURSRecordTypeId;
                    Awardreport.Due_Date__c=aw.Due_Date__c;
                    Awardreport.Award__c=awards.id;
                    Awardreport.Status__c='Draft';
                    Awardreport.Reporting_Start_Date__c=aw.Reporting_Period_Start_Date__c;
                    Awardreport.Reporting_End_Date__c=aw.Reporting_Period_End_Date__c; 
                    Awardreport.Reporting_Periods__c = aw.Reporting_Period_Start_Date__c + '-' + aw.Reporting_Period_End_Date__c;
                    Awardreport.Report_Name1__c= aw.Corporate_Program_Code__c;
                    Awardreport.PM_Module__c = aw.NOFA_ID__r.CNCS_Corporate_Program__r.Module__c;
                   
                }
                else
                {
                    Awardreport.Award__c=awards.id;
                    Awardreport.Status__c='Draft';
                    Awardreport.Report_Name1__c= aw.Corporate_Program_Code__c;
                    Awardreport.PM_Module__c = aw.NOFA_ID__r.CNCS_Corporate_Program__r.Module__c;
                     
                   
                }
                
            }
            newAwardReport.add(Awardreport);
        }
        
    }

    if(newAwardReport.size()>0){
        insert newAwardReport;
          
   }       

   system.debug('@@@@'+newAwardReport);
   
}