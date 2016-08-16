// Combined Trigger for Application Object. 
// Logic for all existing triggers is moved to ONE class - "ApplicationHandler" Class


trigger ApplicationTrigger on Application3__c (after delete, after insert, after undelete, 
    after update, before delete, before insert, before update) {
new ApplicationHandler().handleTrigger(trigger.new, trigger.old);
}