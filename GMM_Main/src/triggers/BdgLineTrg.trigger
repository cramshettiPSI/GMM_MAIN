trigger BdgLineTrg on cb3__BudgetLine__c (after insert, after update) {
    System.debug('***BudgetLine***');
    if (Trigger.isAfter){
         if (Trigger.isInsert || Trigger.isUpdate){
             AppSlotInformation objSlotInformation= new AppSlotInformation();
             objSlotInformation.spawnInformation(Trigger.old,Trigger.new,Trigger.oldMap,Trigger.newMap);
         
         }
     }


}