global Class UpdateGrantCloseOut {
    //Constructor
    public UpdateGrantCloseOut(){
    	
    }
    
    //method for updating grant Close
    static webservice string updateGrantValue(string recId){
    	string errorMessage = '';
    	Profile  prof = [Select id, Name from Profile where Name = 'PO' limit 1];
        if(UserInfo.getProfileId()==prof.id){
    	if(recId != null && recId != ''){
    		list<Grant_Close_Out__c> closeOutList = [Select Id,Status__c,Name,Members_Exited_From_System__c,Award_Reporting_Requirements_Met__c,Cost_Share_Balance_Outstanding__c,Open_Monitoring_Activities__c,Closeout_Reporting_Requirements_Met__c from Grant_Close_Out__c Where Id = :recId Limit 1];
    		if(closeOutList != null && !closeOutList.isEmpty()){
    			if(closeOutList[0].Members_Exited_From_System__c=='Yes' && closeOutList[0].Award_Reporting_Requirements_Met__c=='Yes' && closeOutList[0].Cost_Share_Balance_Outstanding__c=='No' && closeOutList[0].Open_Monitoring_Activities__c==0.0 && closeOutList[0].Closeout_Reporting_Requirements_Met__c=='Yes'){
    				closeOutList[0].Status__c='PO Certified';
    				closeOutList[0].PO_Certified_Date__c=system.date.today();
    				closeOutList[0].PO_Name__c=UserInfo.getName();
    			}else if(closeOutList[0].Members_Exited_From_System__c!='Yes'){
					errorMessage = 'Members are still serving on this grant. Please close all members before closing this grant.';				
				}else if(closeOutList[0].Award_Reporting_Requirements_Met__c!='Yes'){
					errorMessage = 'Reporting activities have not been met. Please make sure that all reporting activities have been met before closing this grant.';
				}else if(closeOutList[0].Cost_Share_Balance_Outstanding__c!='No'){
					errorMessage = 'Cost share balance is outstanding. Please make sure that there is no outstanding costshare balance before closing this grant.';
				}else if(closeOutList[0].Open_Monitoring_Activities__c>0){
					errorMessage = 'Open monitoring activities exist for this grant. Please close all monitoring activities before closing this grant.';
    			}else if(closeOutList[0].Closeout_Reporting_Requirements_Met__c!='Yes'){
					errorMessage = 'Closeout Reporting Requirements have not been met. Please make sure that all closeout reporting requirements have been met before closing this grant.';
    			}
    			update closeOutList[0];
    		}
    	}
     }else{
     	errorMessage = 'Please login as a PO and perform Certification';
     }
    	return errorMessage;
    }
    
}