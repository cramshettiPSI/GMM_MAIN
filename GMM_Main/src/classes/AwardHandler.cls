// Handler class for Award Trigger. KY_8.6.15
public class AwardHandler {
public static final String Awaiting_PO_Approval = 'Awaiting PO Approval';


public void handleTrigger(Award__c[] trigNew, Award__c[] trigOld) {
        if (Trigger.isBefore) {
            if (Trigger.isInsert || Trigger.isUpdate) {
                handleBeforeUpdate(trigNew);
            } 
        }
    }

private void handleBeforeUpdate(Award__c[] trigNew) {
List <Award__c> AwardUpdate = new List <Award__c> ();
AwardUpdate = Trigger.new;
for (Award__c Award : AwardUpdate)
{
if (Award.Grant_Status__c == 'Awaiting SPO Approval') {
// Award.PO__c = Award.Program_Officer__c;  
Award.OwnerId = Award.Program_Officer__c;
// Award.PO_Certification_Date__c = Award.LastModifiedDate;
}
}}



}