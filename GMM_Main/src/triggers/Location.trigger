trigger Location on Location__c (after insert, after update) {
	
	if(trigger.isAfter){
		if(trigger.isInsert || trigger.isUpdate){
			LocationHelper.shareLocationWithStateCommission(trigger.new);
		}
		if(trigger.isInsert){
			LocationHelper.shareLocations(trigger.new);
		}
	}
	

}