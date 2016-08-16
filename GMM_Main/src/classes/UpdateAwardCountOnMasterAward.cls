public with sharing class UpdateAwardCountOnMasterAward{
	
    //Constructor
    public UpdateAwardCountOnMasterAward(){
    	
    }
    
    //Method to update Award Count on Master Award.
    public void updateAwardCount(list<Award__c> awardList, map<Id,Award__c> oldMap){
    	//set for MasterAward Ids.
    	set<Id> masterAwardIds = new set<Id>();
    	set<Id> ConAwardprojectIDs = new set<Id>();
    	set<Id> AwardedAwardProjectIDs = new set<Id>();
    	set<Id> ConAwardedAwardProjectIDs = new set<Id>();
    	
    	//map for Master Award and related Award records.
    	map<Id,Master_Award__c> masterAwardMap = new map<Id,Master_Award__c>();
    	map<Id,Project__c> ConAwardProjectMap = new map<Id,Project__c>();
    	map<Id,Project__c> AwardedAwardProjectMap = new map<Id,Project__c>();
    	map<Id,Project__c> ConAwardedProjectMap = new map<Id,Project__c>();
    	
    	//Check for award List Empty and Null.
    	if(awardList != null && !awardList.isEmpty()){
    		for(Award__c aw: awardList){
    			if((aw.Application_Type__c != null && aw.Application_Type__c.equalsIgnoreCase('Amendment')) || (oldMap != null && oldMap.get(aw.Id) != null && oldMap.get(aw.Id).Application_Type__c.equalsIgnoreCase('Amendment'))){
    				if(aw.Master_Award__c != null){
    					masterAwardIds.add(aw.Master_Award__c);
    				}
    			}//end of If for application type Amendment null check and value check.
    			if((aw.Application_Type__c != null && aw.Application_Type__c.equalsIgnoreCase('Continuation')) || (oldMap != null && oldMap.get(aw.Id) != null && oldMap.get(aw.Id).Application_Type__c.equalsIgnoreCase('Continuation'))){
    			   if(aw.Project__c !=null){
    			       ConAwardprojectIDs.add(aw.Project__c);
    				}
    			}//end of If for application type Continuation null check and value check.
    			if((aw.Grant_Status__c != null && aw.Grant_Status__c.equalsIgnoreCase('Awarded')) || (oldMap != null && oldMap.get(aw.Id) != null && oldMap.get(aw.Id).Grant_Status__c.equalsIgnoreCase('Awarded'))){
    			   if(aw.Project__c !=null){
    			       AwardedAwardProjectIDs.add(aw.Project__c);
    				}
    			}//end of If for Grant Status Awarded null check and value check.
    			if((aw.Grant_Status__c != null && aw.Application_Type__c != null && aw.Grant_Status__c.equalsIgnoreCase('Awarded') && aw.Application_Type__c.equalsIgnoreCase('Continuation')) || (oldMap != null && oldMap.get(aw.Id) != null && oldMap.get(aw.Id).Grant_Status__c.equalsIgnoreCase('Awarded') && oldMap.get(aw.Id).Application_Type__c.equalsIgnoreCase('Continuation'))){
    			   if(aw.Project__c !=null){
    			       ConAwardedAwardProjectIDs.add(aw.Project__c);
    				}
    			}//end of If for Grant Status Awarded and continuation null check and value check.
    		}//end of for Loop.
    		
    		//retrieve Master Award Records with related Award Records.
    		if(masterAwardIds != null && !masterAwardIds.isEmpty()){
    			masterAwardMap = new map<Id,Master_Award__c>([Select Id,Number_of_Amended_Awards__c,(Select Id,Application_Type__c from Award__r where Application_Type__c = 'Amendment') from Master_Award__c where ID IN:masterAwardIds]);
    		}
    		//retrieve Project Records with related Award Records for Continuation.
    		if(ConAwardprojectIDs != null && !ConAwardprojectIDs.isEmpty()){
    			ConAwardProjectMap = new map<Id,Project__c>([Select Id,Continuation_Awards__c,(Select Id,Application_Type__c from Award__r where Application_Type__c = 'Continuation') from Project__c where Id =: ConAwardprojectIDs]);
    		}
    		//retrieve Project Records with related Awarded Records.
    		if(AwardedAwardProjectIDs != null && !AwardedAwardProjectIDs.isEmpty()){
    			AwardedAwardProjectMap = new map<Id,Project__c>([Select Id,Awarded_Awards__c,Project_Start_Date__c,Project_End_Date__c,(Select Id,Grant_Status__c,Agreement_Period_End_Date__c,Agreement_Period_Start_Date__c from Award__r where Grant_Status__c = 'Awarded') from Project__c where Id =: AwardedAwardProjectIDs]);
    		}
    		//retrieve Project Records with related Awarded Records with Continuation.
    		if(ConAwardedAwardProjectIDs != null && !ConAwardedAwardProjectIDs.isEmpty()){
    			ConAwardedProjectMap = new map<Id,Project__c>([Select Id,Continuation_and_Awarded__c,(Select Id,Grant_Status__c,Application_Type__c from Award__r where (Grant_Status__c = 'Awarded' AND Application_Type__c = 'Continuation')) from Project__c where Id IN:ConAwardedAwardProjectIDs]);
    		}
    		//update count on Master Award 
    		if(masterAwardMap != null && !masterAwardMap.isEmpty()){
    			for(Master_Award__c maw : masterAwardMap.values()){
    				if(maw.Award__r != null && !maw.Award__r.isEmpty()){
    					maw.Number_of_Amended_Awards__c = maw.Award__r.size();
    				}else{
    					maw.Number_of_Amended_Awards__c = 0;
    				}
    			}
    			
    			update masterAwardMap.values();
    		}  
    		if(ConAwardProjectMap != null && !ConAwardProjectMap.isEmpty()){
    			for(Project__c prCon : ConAwardProjectMap.values()){
    				if(prCon.Award__r != null && !prCon.Award__r.isEmpty()){
    					prCon.Continuation_Awards__c = prCon.Award__r.size();
    				}else{
    					prCon.Continuation_Awards__c = 0;
    				}
    			}
    			update ConAwardProjectMap.values();
    		} 
    		if(ConAwardedProjectMap != null && !ConAwardedProjectMap.isEmpty()){
    			for(Project__c prConAwarded : ConAwardedProjectMap.values()){
    				if(prConAwarded.Award__r != null && !prConAwarded.Award__r.isEmpty()){
    					prConAwarded.Continuation_and_Awarded__c = prConAwarded.Award__r.size();
    				}else{
    					prConAwarded.Continuation_and_Awarded__c = 0;
    				}
    			}
    			update ConAwardedProjectMap.values();
    		}
    		if(AwardedAwardProjectMap != null && !AwardedAwardProjectMap.isEmpty()){
    			for(Project__c prAwarded : AwardedAwardProjectMap.values()){
    				if(prAwarded.Award__r != null && !prAwarded.Award__r.isEmpty()){
    					prAwarded.Awarded_Awards__c = prAwarded.Award__r.size();
    					Integer i = prAwarded.Award__r.size();
    					prAwarded.Project_End_Date__c = prAwarded.Award__r[i-1].Agreement_Period_End_Date__c;
    					prAwarded.Project_Start_Date__c = prAwarded.Award__r[0].Agreement_Period_Start_Date__c;
    				}else{
    					prAwarded.Awarded_Awards__c = 0;
    					//prAwarded.Project_Start_Date__c=null;
    					//prAwarded.Project_End_Date__c=null;
    				}
    			}
    	
    			update AwardedAwardProjectMap.values();
    		} 		
    	}//end of IF for Award List Empty check
    }
    
}