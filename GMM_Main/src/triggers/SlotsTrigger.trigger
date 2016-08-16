/*
Trigger for Slot object. 
Created by Krishna Yama. 
*/

trigger SlotsTrigger on Slot__c (after insert,after update, after delete) {
    if(trigger.isAfter){
        if(trigger.isUpdate || trigger.isInsert || trigger.isDelete){
           SlotHelper.TotalSlots(trigger.newMap,trigger.oldMap);
        }
    }
}