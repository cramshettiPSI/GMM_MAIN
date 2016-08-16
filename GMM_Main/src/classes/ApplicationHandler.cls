public class ApplicationHandler {

Map<Id,Master_Award__c> MA_Map = new Map<Id,Master_Award__c>();
List<Master_Award__c> MA_List = new List<Master_Award__c>();
List <Award__c> AwardInsert = new List <Award__c> ();
Id ApplicationID=Schema.SObjectType.Application3__c.getRecordTypeInfosByName().get('Application').getRecordTypeId();
Id AMARecordTypeId = Schema.SObjectType.Master_Award__c.getRecordTypeInfosByName().get('App Master Award').getRecordTypeId();
Id SAMARecordTypeId = Schema.SObjectType.Master_Award__c.getRecordTypeInfosByName().get('Sub App Master Award').getRecordTypeId();
Id AARecordTypeId = Schema.SObjectType.Award__c.getRecordTypeInfosByName().get('App Award').getRecordTypeId();
Id SAARecordTypeId = Schema.SObjectType.Award__c.getRecordTypeInfosByName().get('Sub App Award').getRecordTypeId();


public void handleTrigger(Application3__c[] trigNew, Application3__c[] trigOld) {
      /*  if (Trigger.isBefore) {
            if (Trigger.isInsert) {
                handleBeforeInsert(trigNew);
            } else if (Trigger.isUpdate) {
                handleBeforeUpdate(trigNew, trigOld);
            }
        } else if (Trigger.isAfter) {
            if (Trigger.isUpdate) {
                handleAfterUpdate(trigNew, trigOld);
            }
        }
    
    */    
    handleAfterUpdate(trigNew, trigOld);
}


// After Update Methods
// "CreateAward" logic starts here
private void handleAfterUpdate (Application3__c[] trigNew, Application3__c[] trigOld) {

for (Application3__c App: trigNew)
{
 
if (App.Status__c == 'Accepted' && App.RecordTypeID == '012r00000004KU5' && App.Type_of_Application__c == 'New') {

Master_Award__c MA = new Master_Award__c ();
if(App.Sub_Application__c=='Yes'){
MA.recordtypeid=SAMARecordTypeId;
MA.Application__c = App.id;
}
else if (App.Sub_Application__c == 'No') {
MA.recordtypeid=AMARecordTypeId;
MA.Application__c = App.id;
}
MA_List.add(MA);
}
} 
Insert MA_List;

for(Master_Award__c ma : [Select id,name,Application__c from Master_Award__c where ID IN: MA_List])
{
    MA_Map.put(ma.Application__c,ma);
}

List<Award__c> aw_List = new List<Award__c>();
for (Application3__c App: trigNew)
{
  System.debug('App_ID'+App.id);
  if (App.Status__c == 'Accepted' && App.RecordTypeID == '012r00000004KU5') {
Award__c Aw = new Award__c ();
if(App.Sub_Application__c=='Yes'){
   if(MA_Map.containsKey(App.id))
       Aw.Master_Award__c=MA_Map.get(App.id).id;
Aw.Name = App.Name;
Aw.recordtypeid=SAARecordTypeId;
Aw.NOFA_Name__c = App.NOFA_RFP__c;
Aw.Project__c = App.Project__c;
system.debug('app Id = '+app.Id);
Aw.Application_ID__c = App.ID;
Aw.Program_Officer__c = App.Program_Officer__c;
Aw.Senior_Program_Officer__c = App.Senior_Program_Officer__c;
Aw.Executive_Officer__c = App.Executive_Officer__c;
Aw.XO_CSHR__c = App.Ex_Officer_Cost_Share__c;
Aw.Senior_Grants_Officer__c = App.Senior_Grants_Officer__c;
Aw.Grants_Officer__c = App.Grants_Officer__c; 
}
else if (App.Sub_Application__c=='No') {
if(MA_Map.containsKey(App.id))
       Aw.Master_Award__c=MA_Map.get(App.id).id;
Aw.Name = App.Name;
Aw.recordtypeid=AARecordTypeId;
Aw.NOFA_Name__c = App.NOFA_RFP__c;
Aw.Project__c = App.Project__c;
system.debug('app Id = '+app.Id);
Aw.Application_ID__c = App.ID;
Aw.Program_Officer__c = App.Program_Officer__c;
Aw.Senior_Program_Officer__c = App.Senior_Program_Officer__c;
Aw.Executive_Officer__c = App.Executive_Officer__c;
Aw.XO_CSHR__c = App.Ex_Officer_Cost_Share__c;
Aw.Senior_Grants_Officer__c = App.Senior_Grants_Officer__c;
Aw.Grants_Officer__c = App.Grants_Officer__c; 
}
aw_List.add(Aw);
      }
} 
Insert aw_List;
}
// "CreateAward" logic Ends here

}