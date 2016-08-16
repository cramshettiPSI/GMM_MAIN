trigger ContactTrigger on Contact (after delete, after insert, after undelete, after update, before delete, before insert, before update) {
	
   if(trigger.isAfter){
    	if(trigger.isInsert || trigger.isUpdate){
    		//Notifying Grantee Admin about Grantee approval - Start.
    		
    		NotifyGranteeAdmin nGA = new NotifyGranteeAdmin();
			nGA.notifyEmailGranteeAdmin(trigger.new,trigger.oldmap);
    		
			//Notifying Grantee Admin about Grantee approval - End.
    	}    	
    }
    
}