public with sharing class UpdateMonitoringActivityCount {
   
    //Constructor
    public UpdateMonitoringActivityCount(){
    	
    }
    
    //Method to update Monitoring Activity Count on Master Award.
    public void updateActivityCount(list<Monitoring_Activity__c> MactivityList, map<Id,Monitoring_Activity__c> oldMap){
    	//set for MasterAward Ids.
    	set<Id> masterAwardIds = new set<Id>();
    	
    	//map for Master Award and related Award records.
    	map<Id,Master_Award__c> masterAwardMap = new map<Id,Master_Award__c>();
    	
    	//Check for Monitoring Activity List Empty and Null.
    	if(MactivityList != null && !MactivityList.isEmpty()){
    		for(Monitoring_Activity__c mact: MactivityList){
    			if((mact.Status__c != null && mact.Status__c.equalsIgnorecase('Open')) || (oldMap != null && oldMap.get(mact.Id) != null && oldMap.get(mact.Id).Status__c.equalsIgnorecase('Open'))){
    				if(mact.Master_Award_Name__c != null){
    					masterAwardIds.add(mact.Master_Award_Name__c);
    				}
    			}//end of If for Status null check and value check.
    		}//end of for Loop.
    		
    		//retrieve Master Award Records with related Monitoring Activity Records.
    		if(masterAwardIds != null && !masterAwardIds.isEmpty()){
    			masterAwardMap = new map<Id,Master_Award__c>([Select Id,Number_of_Open_Monitoring_Activities__c,(Select Id,Status__c from Monitoring_Activities__r where Status__c = 'Open') from Master_Award__c where ID IN:masterAwardIds]);
    		}
    		
    		//update count on Master Award 
    		if(masterAwardMap != null && !masterAwardMap.isEmpty()){
    			for(Master_Award__c maw : masterAwardMap.values()){
    				if(maw.Monitoring_Activities__r != null && !maw.Monitoring_Activities__r.isEmpty()){
    					maw.Number_of_Open_Monitoring_Activities__c = maw.Monitoring_Activities__r.size();
    				}else{
    					maw.Number_of_Open_Monitoring_Activities__c = 0;
    				}
    			}
    			
    			update masterAwardMap.values();
    		}    		
    	}//end of IF for Monitoring Activity List Empty check
    }
    
}