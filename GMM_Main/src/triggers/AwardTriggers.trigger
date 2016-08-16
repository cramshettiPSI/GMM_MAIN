trigger AwardTriggers on Award__c (after delete, after insert, after undelete, 
after update, before delete, before insert, before update) {
new AwardHandler().handleTrigger(trigger.new, trigger.old);
}