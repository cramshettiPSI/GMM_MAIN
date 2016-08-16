trigger Mon_Count_for_Master_Award on Monitoring_Activity__c (after delete, after insert, after undelete, after update, before delete, before insert, before update) {
    
    UpdateMonitoringActivityCount uMAC = new UpdateMonitoringActivityCount();
     if(trigger.isAfter){
    	if(trigger.isInsert || trigger.isUpdate || trigger.isUndelete){
    		if(trigger.isUpdate){
    			uMAC.updateActivityCount(trigger.new,trigger.oldMap);
    		}
    		uMAC.updateActivityCount(trigger.new,null);
    	}
    	
    	if(trigger.isDelete){
    		uMAC.updateActivityCount(trigger.old,null);
    	}
    }
}