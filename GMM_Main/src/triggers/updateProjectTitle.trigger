trigger updateProjectTitle on Grant_Monitoring__c (before insert) {
    
    list<id> AwardIds = new list<id>();
    //list<Grant_Monitoring__c> updateGrantMon = new list<Grant_Monitoring__c>();
    for(Grant_Monitoring__c GM : Trigger.new){
    	AwardIds.add(GM.Grant__c);
    }
    if(AwardIds != null && !AwardIds.isEmpty()){
    	list<Award__c> awar = new list<Award__c>([Select id, Name, Project_Title__c from Award__c where ID IN : AwardIds]);
    	for(Grant_Monitoring__c gmc : Trigger.new){
    		for(Award__c aw : awar){
    			gmc.Project_Title__c = aw.Project_Title__c;
    			//updateGrantMon.add(gmc);
    		}
    	}
    	//update updateGrantMon;
    }
}