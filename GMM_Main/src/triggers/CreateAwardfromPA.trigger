trigger CreateAwardfromPA on Prime_Application__c (After update) { 

Id PMARecordTypeId = Schema.SObjectType.Master_Award__c.getRecordTypeInfosByName().get('Prime Master Award').getRecordTypeId();
Id PARecordTypeId = Schema.SObjectType.Award__c.getRecordTypeInfosByName().get('Prime Award').getRecordTypeId();

Map<Id,Master_Award__c> MA_Map = new Map<Id,Master_Award__c>();
List<Master_Award__c> MA_List = new List<Master_Award__c>();
List <Award__c> AwardInsert = new List <Award__c> (); 
set<Id> primeAppIds = new set<Id>();
for(Prime_Application__c PA: Trigger.new){
    primeAppIds.add(PA.Id);
}
list<Master_Award__c> existingMA = new list<Master_Award__c>([Select Id,Name,Prime_Application__c from Master_Award__c where Prime_Application__c = :primeAppIds and recordTypeId = :PMARecordTypeId]);
system.debug('existing MA = '+existingMA);
map<Id,Id> primeAppIdtoMAId = new map<Id,Id>();
if(existingMA.size()>0){
    for(Master_Award__c ma: existingMA){
        primeAppIdtoMAId.put(ma.Prime_Application__c,ma.Id);
    }
}
system.debug('primeAppIdtoMAId = '+primeAppIdtoMAId);
for (Prime_Application__c PA: Trigger.new)
{
    
    if (PA.CNCS_Status__c == 'Accepted' && PA.Type_of_Application__c == 'New' && primeAppIdtoMAId.get(PA.Id)==null) {
        Master_Award__c MA = new Master_Award__c ();
        MA.Prime_Application__c = PA.id;
        MA.recordtypeid=PMARecordTypeId;
        MA.Project_Name__c = PA.Project_Name__c;
        MA_List.add(MA);
    }
} 
system.debug('MA_List = '+MA_List);
if(!MA_List.isEmpty())
    Insert MA_List;

for(Master_Award__c ma : [Select id,name,Prime_Application__c from Master_Award__c where ID IN: MA_List])
{
    MA_Map.put(ma.Prime_Application__c,ma);
}


list<Award__c> existingAwards = new list<Award__c>([Select Id,Name,Prime_Application__c from Award__c where Prime_Application__c = :primeAppIds and recordTypeId = :PARecordTypeId ]);
map<Id,Id> primeAppIdtoAwardId = new map<Id,Id>();
if(existingAwards.size()>0){
    for(Award__c a: existingAwards){
        primeAppIdtoAwardId.put(a.Prime_Application__c,a.Id);
    }
}
system.debug('existing Awards = '+existingAwards);
system.debug('primeAppIdtoAwardId  = '+primeAppIdtoAwardId);



List<Award__c> aw_List = new List<Award__c>();
for (Prime_Application__c PA: Trigger.new)
{
   System.debug('App_ID'+PA.id);

  if(PA.CNCS_Status__c == 'Accepted' && PA.Type_of_Application__c == 'New' && primeAppIdtoAwardId.get(PA.Id)==null) {
    Award__c Aw = new Award__c ();
    if(MA_Map.containsKey(PA.id))
        Aw.Master_Award__c=MA_Map.get(PA.id).id;
    Aw.Name = PA.Prime_Application_ID_Number__c;
    Aw.NOFA_Name__c = PA.NOFO_RFP__c;
    Aw.Project__c = PA.Project_Name__c;
    Aw.Prime_Application__c = PA.ID;
    Aw.recordtypeid=PARecordTypeId;
    system.debug('PA Id = '+PA.Id);
     //Aw.Organization__c = app.Organization__c;
    Aw.Program_Officer__c = PA.Program_Officer__c;
    Aw.Senior_Program_Officer__c = PA.Senior_Program_Officer__c;
    Aw.Executive_Officer__c = PA.Executive_Officer__c;
    Aw.XO_CSHR__c = PA.Ex_Officer_Cost_Share__c;
    Aw.Senior_Grants_Officer__c = PA.Senior_Grants_Officer__c;
    Aw.Grants_Officer__c = PA.Grants_Officer__c; 
    Aw.NOFO_RFP_Name_Prime__c = PA.NOFO_Name__c;
    Aw.Prime_Application_Type__c = PA.Type_of_Application__c;
    Aw.Corporate_Program_Prime__c = PA.Corporate_Program__c;
    Aw.Issuing_Office__c = PA.Issuing_Office__c;
    Aw.Organization_Legal_Name_Prime__c = PA.Organization_Legal_Name__c;
    Aw.Project_Title_Prime__c = PA.Project_Title__c; 
    Aw.Fiscal_Year_Prime__c = PA.NOFO_Fiscal_Year__c; 
    Aw.Program_Officer__c = PA.Program_Officer__c;
    Aw.Senior_Program_Officer__c = PA.Senior_Program_Officer__c;
    Aw.Executive_Officer__c = PA.Executive_Officer__c;
    Aw.Grants_Officer__c = PA.Grants_Officer__c;
    Aw.Senior_Grants_Officer__c = PA.Senior_Grants_Officer__c;
    Aw.Subject_to_FAPIIS_Review__c = PA.Subject_to_FAPIIS_Review__c;
    Aw.FAPIIS_Review_Date__c = PA.Date__c;
    Aw.Information_Available__c = PA.Information_available__c	;
    Aw.Satisfactory_Record_Executing_Programs__c = PA.Satisfactory_Record_Executing_Programs__c;
    Aw.Demonstrates_Ethics_Integrity__c = PA.Demonstrates_Ethics_Integrity__c;
    Aw.Mitigating_Circumstances__c = PA.Mitigating_Circumstances__c;
    Aw.FAPIIS_Review_Comments__c = PA.FAPIIS_Review_Comments__c;
    //Aw.Budget_Period_Start__c = App.Proposed_Start_Date__c;
    //Aw.Budget_Period_End__c = App.Proposed_End_Date__c;
    //Aw.Prime_Application__c = App.Prime_Application__c;
    Aw.Approved_Amount__c=PA.Recommended_Award_Amount__c; 
    aw_List.add(Aw);
  }

  else if (PA.CNCS_Status__c == 'Accepted' && PA.Type_of_Application__c == 'Amendment' && primeAppIdtoAwardId.get(PA.Id)==null)
  { 
    Award__c Aw = new Award__c ();  
    Aw.Name = PA.Prime_Application_ID_Number__c;
    Aw.NOFA_Name__c = PA.NOFO_RFP__c;
    Aw.Prime_Application__c = PA.ID;
    Aw.Project__c = PA.Project_Name__c;
    Aw.Master_Award__c = PA.Master_Award__c;
    Aw.recordtypeid=PARecordTypeId;
    Aw.Program_Officer__c = PA.Program_Officer__c;
    Aw.Senior_Program_Officer__c = PA.Senior_Program_Officer__c;
    Aw.Executive_Officer__c = PA.Executive_Officer__c;
    Aw.XO_CSHR__c = PA.Ex_Officer_Cost_Share__c;
    Aw.Senior_Grants_Officer__c = PA.Senior_Grants_Officer__c;
    Aw.Grants_Officer__c = PA.Grants_Officer__c; 
    Aw.NOFO_RFP_Name_Prime__c = PA.NOFO_Name__c;
    Aw.Prime_Application_Type__c = PA.Type_of_Application__c;
    Aw.Corporate_Program_Prime__c = PA.Corporate_Program__c;
    Aw.Issuing_Office__c = PA.Issuing_Office__c;
    Aw.Organization_Legal_Name_Prime__c = PA.Organization_Legal_Name__c;
    Aw.Project_Title_Prime__c = PA.Project_Title__c; 
    Aw.Fiscal_Year_Prime__c = PA.NOFO_Fiscal_Year__c; 
    Aw.Program_Officer__c = PA.Program_Officer__c;
    Aw.Senior_Program_Officer__c = PA.Senior_Program_Officer__c;
    Aw.Executive_Officer__c = PA.Executive_Officer__c;
    Aw.Grants_Officer__c = PA.Grants_Officer__c;
    Aw.Senior_Grants_Officer__c = PA.Senior_Grants_Officer__c;
    Aw.Subject_to_FAPIIS_Review__c = PA.Subject_to_FAPIIS_Review__c;
    Aw.FAPIIS_Review_Date__c = PA.Date__c;
    Aw.Information_Available__c = PA.Information_available__c	;
    Aw.Satisfactory_Record_Executing_Programs__c = PA.Satisfactory_Record_Executing_Programs__c;
    Aw.Demonstrates_Ethics_Integrity__c = PA.Demonstrates_Ethics_Integrity__c;
    Aw.Mitigating_Circumstances__c = PA.Mitigating_Circumstances__c;
    Aw.FAPIIS_Review_Comments__c = PA.FAPIIS_Review_Comments__c;
    //Aw.Budget_Period_Start__c = App.Proposed_Start_Date__c;
    //Aw.Budget_Period_End__c = App.Proposed_End_Date__c;
    //Aw.Prime_Application__c = App.Prime_Application__c;
    Aw.Approved_Amount__c=PA.Recommended_Award_Amount__c; 
    aw_List.add(Aw);
  }
}

if(!aw_List.isEmpty())
    Insert aw_List;
}