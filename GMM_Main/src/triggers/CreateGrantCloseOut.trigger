trigger CreateGrantCloseOut on Master_Award__c (after update) {
    
    list<Grant_Close_Out__c> gclist = new list<Grant_Close_Out__c>();
    list<id> projIDS = new list<id>();
    for(Master_Award__c ma1 : Trigger.new){
        projIDS.add(ma1.Project_Name__c);
    }
    list<Project__c> proj = new list<Project__c>([Select id, Name, Project_End_Date__c from Project__c where id IN: projIDS]);
    for(Project__c pr : proj){
    for(Master_Award__c ma : Trigger.new){
        if(ma.Create_Grant_Close_Out__c == true){
            Grant_Close_Out__c gc = new Grant_Close_Out__c();
            gc.Master_Award__c = ma.Id;
            gc.Members_Exited_From_System__c = 'No';
            gc.Closeout_Reporting_Requirements_Met__c = 'No';
            gc.Award_Reporting_Requirements_Met__c = 'No';
            gc.Close_Project__c = 'No';
            gc.Cost_Share_Balance_Outstanding__c = 'Yes';
                if(pr.Project_End_Date__c >= system.today()){
                gc.Status__c = 'Not Started';
                system.debug('Status............' +gc.Status__c);
                }
            gclist.add(gc);
        }
    }
}
    if(gclist!=null && !gclist.isEmpty()){
    insert gclist;
    }
}