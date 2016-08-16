trigger Award_Trigger on Award__c (after delete, after insert, after undelete, after update, before delete, before insert, before update) {
    UpdateAwardCountOnMasterAward uACOMA = new UpdateAwardCountOnMasterAward();
    
    if(trigger.isAfter){
        if(trigger.isInsert || trigger.isUpdate){
            AwardHelper.shareAwardswithStateCommission(trigger.new);
            AwardHelper.shareAwards(trigger.oldmap,trigger.newMap);
        } 
        if(trigger.isInsert || trigger.isUpdate || trigger.isUndelete){
            if(trigger.isUpdate){
                uACOMA.updateAwardCount(trigger.new,trigger.OldMap);
            }
            uACOMA.updateAwardCount(trigger.new,null);
        }
        
        if(trigger.isDelete){
            uACOMA.updateAwardCount(trigger.old,null);
        }
        if(trigger.isUpdate){
            AwardHelper.awardSubAwardsCompetitive(trigger.oldmap,trigger.newmap);
            AwardHelper.updateAppstoAwarded(trigger.oldmap,trigger.newmap);
        }
    }
}