trigger UpdateTaskStatus on Grant_Close_Out__c (after update) {
    set<id> gCOIds = new set<id>();
    set<id>masterAwardIDs=new set<id>();
    list<id>ProjectIDs=new list<id>();
    for (Grant_Close_Out__c gc:Trigger.new){
        gCOIds.add(gc.Id);
        masterAwardIDs.add(gc.Master_Award__c);
    }
    //map<Id,list<Task>> gcoTaskMap = new map<Id,list<Task>>();
    list<Master_Award__c> MasterawardList = new list<Master_Award__c>([Select Id,Status__c,Project_Name__c,(Select Id,Grant_Status__c,Grant_Performance_Period_End__c from Award__r) from Master_Award__c where Id =: masterAwardIDs]);
    
    //list<Grant_Close_Out__c> gcList = new list<Grant_Close_Out__c>([Select Id,Status__c,Master_Award__c,(Select WhatId,Status from Tasks) from Grant_Close_Out__c where Id =: gCOIds]);
    /*for(Grant_Close_Out__c gcList1 : gcList){
        gcoTaskMap.put(gcList1.Id,gcList1.Tasks);
    }*/
    //list<Task> taskstoUpdate = new list<Task>();
    list<Master_Award__c> MasterAwardtoUpdate = new list<Master_Award__c>();   
    list<Award__c> AwardtoUpdate = new list<Award__c>();
    list<Application3__c> apptoUpdate = new list<Application3__c>();
    list<Project__c> projToUpdate = new list<Project__c>();
    for(Grant_Close_Out__c gc1:Trigger.new){
        if(MasterawardList!=null && !MasterawardList.isEmpty()){
        //if(gcoTaskMap.containsKey(gc1.Id)&&gcoTaskMap.get(gc1.Id)!=null){
            //If(gc1.Status__c == 'PO Certified' || gc1.Status__c == 'Financial Closeout Complete'){
            if(gc1.Status__c == 'In Progress'){
                for(Master_Award__c ma1:MasterawardList){
                    for(Award__c awar:ma1.Award__r){
                        awar.Grant_Status__c = 'Being Closed';
                        AwardtoUpdate.add(awar);
                    }
                }
                /*for(Task t : gcoTaskMap.get(gc1.Id)){
                    t.Status = gc1.Status__c;
                    taskstoUpdate.add(t);
                }*/
            }else if(gc1.Status__c == 'Complete'){
                for(Master_Award__c ma1:MasterawardList){
                    ma1.Status__c = 'Complete';
                    if(ma1.Project_Name__c != null){
                        ProjectIDs.add(ma1.Project_Name__c);
                    }
                    MasterAwardtoUpdate.add(ma1);
                    if(ma1.Award__r != null &&  !ma1.Award__r.isEmpty()){
                        for(Award__c awar : ma1.Award__r){
                          if(awar.Grant_Performance_Period_End__c < ma1.Project_Period_End_Date__c){ 
                            awar.Grant_Status__c = 'Closed';
                            AwardtoUpdate.add(awar);
                          }
                        }
                    }                   
                } 
                //if(gc1.Close_Project__c=='Yes'){  
                            
                if(ProjectIDs != null && !ProjectIDs.isEmpty()){
                    list<Project__c> projList = new list<Project__c>([Select Id, Name, Status__c, (Select Id, Name, Status__c, Grantee_Status__c from Application__r) from Project__c where ID IN : ProjectIDs]);
                    if(projList != null && !projList.isEmpty()){
                        for(Project__c proj : projList){
                        	for(Application3__c app : proj.Application__r){
                        		app.Status__c = 'Closed';
                        		app.Grantee_Status__c = 'Closed';
                        		apptoUpdate.add(app);
                        	}
                        		if(gc1.Close_Project__c=='Yes'){
                            	proj.Status__c ='Closed'; 
                            	projToUpdate.add(proj);
                        		}                              
                        	}
                    	}
                	}
                //}
                /*for (Task t : gcoTaskMap.get(gc1.Id)){
                    t.Status = 'Completed';
                    taskstoUpdate.add(t);
                }*/
            }
        }
    //}
    //update taskstoUpdate;
    update MasterAwardtoUpdate;
    update AwardtoUpdate;
    update projToUpdate;
    update apptoUpdate;
    }
}