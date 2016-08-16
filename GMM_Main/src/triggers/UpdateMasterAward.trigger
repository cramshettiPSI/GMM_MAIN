trigger UpdateMasterAward on Award__c (after insert,after update) {
    
    map<Id,Master_Award__c> masterAwardMap = new map<Id,Master_Award__c>();
    //map<Id,Project__c> projectMap = new map<Id,Project__c>();
    List<Id> listMasterAwardIDs = new List<Id>();
       map<Id,Application3__c> appMap = new map<Id,Application3__c>();
    set<Id> appIds = new set<Id>();
    //set<Id> ProjectIDs = new set<Id>();
    
    for(Award__c a:Trigger.new){
       if(a.Master_Award__c!=null)
            listMasterAwardIDs.add(a.Master_Award__c);
        if(a.Application_ID__c!=null)
            appIds.add(a.Application_ID__c); 
       // if(a.Project__c!=null)       
            //ProjectIDs.add(a.Project__c);
    }
    if(appIds != null && !appIds.isEmpty()){
        List<Application3__c> lstappname=[Select Id,Grants_Officer__r.Phone,Grants_Officer__r.Title,Project__r.Project_Director__r.Email,
                                                Authorized_Representative__r.Email,Project__r.Organization__r.Name,
                                                Project__r.Organization__r.Address_1__c ,Project__r.Organization__r.Address_2__c,Project__r.Organization__r.City__c ,
                                                Project__r.Organization__r.States__c,Project__r.Project_Director__r.Title,Grants_Officer__r.Email,
                                                Project__r.Project_Director__r.FirstName, Project__r.Project_Director__r.LastName,
                                                Grants_Officer__r.Name,Program_Officer__r.Name, Project__r.Name from Application3__c where Id in :appIds];
    for(Application3__c app: lstappname){
             appMap.put(app.id,app);
        }
   
    }    
    if(listMasterAwardIDs != null && !listMasterAwardIDs.isEmpty()){
    masterAwardMap = new map<Id,Master_Award__c>([Select Id,Award_ID__c,GO_Phone__c,GO_Title__c,PD_Email__c,AR_Email__c,Legal_Applicant_Name__c,
                                                    Project_Director_Name__c,Project_Director_Title__c,Org_Address__c,Org_Name__c,
                                                    Grants_Officer__c,Program_Officer__c,Project__c,(Select Id,Project_End_Date__c,Project_Start_Date__c,Grant__c,Organization_Legal_Name__c from Award__r) from Master_Award__c where ID IN:listMasterAwardIDs]);
    }
    /*if(ProjectIDs!=null && !ProjectIDs.isEmpty()){
    projectMap = new map<Id,Project__c>([Select Id, Name, Project_Start_Date__c,Project_End_Date__c,(Select Id,Project_End_Date__c,Project_Start_Date__c from Award__r)from Project__c where Id =: ProjectIDs]);
    }*/
    for(Award__c aw:Trigger.new){
        /*if(aw.Project__c!=null && aw.Grant_Status__c == 'Awarded'){
            Project__c pr = projectMap.get(aw.Project__c);
            //pr.Project_Start_Date__c = aw.Project_Start_Date__c;
            //pr.Project_End_Date__c = aw.Project_End_Date__c;
        }*/
        if(aw.Master_Award__c!=null){
            if(masterAwardMap.get(aw.Master_Award__c)!=null){ 
                Master_Award__c ma = masterAwardMap.get(aw.Master_Award__c);
                ma.Award_ID__c = aw.Grant__c;
                //ma.Project_Period_Start_Date__c = aw.Project_Start_Date__c;
                //ma.Project_Period_End_Date__c = aw.Project_End_Date__c;
                //ma.Project_Period_Start_Date__c = aw.Agreement_Period_Start_Date__c;
                //ma.Project_Period_End_Date__c = aw.Agreement_Period_End_Date__c;
                ma.Legal_Applicant_Name__c = aw.Organization_Legal_Name__c;
                 if(appMap.get(aw.Application_ID__c)!=null){
                ma.GO_Phone__c = appMap.get(aw.Application_ID__c).Grants_Officer__r.Phone;
                ma.Grants_Officer_Email__c = appMap.get(aw.Application_ID__c).Grants_Officer__r.Email;
                ma.GO_Title__c = appMap.get(aw.Application_ID__c).Grants_Officer__r.Title;
                ma.PD_Email__c = appMap.get(aw.Application_ID__c).Project__r.Project_Director__r.Email;
                ma.Org_Name__c = appMap.get(aw.Application_ID__c).Authorized_Representative__r.Email;
                ma.Project_Director_Name__c = appMap.get(aw.Application_ID__c).Project__r.Project_Director__r.FirstName +' '+appMap.get(aw.Application_ID__c).Project__r.Project_Director__r.LastName;
                ma.Project_Director_Title__c = appMap.get(aw.Application_ID__c).Project__r.Project_Director__r.Title;
                ma.Org_Address__c = appMap.get(aw.Application_ID__c).Project__r.Organization__r.Address_1__c + ' ' + appMap.get(aw.Application_ID__c).Project__r.Organization__r.Address_2__c +' '+
                                        appMap.get(aw.Application_ID__c).Project__r.Organization__r.City__c + ' ' + appMap.get(aw.Application_ID__c).Project__r.Organization__r.States__c;
                ma.Org_Name__c = appMap.get(aw.Application_ID__c).Project__r.Organization__r.Name;                      
                ma.Grants_Officer__c = appMap.get(aw.Application_ID__c).Grants_Officer__r.Name;
                ma.Program_Officer__c = appMap.get(aw.Application_ID__c).Program_Officer__r.Name;
                if(appMap.get(aw.Application_ID__c).Project__r.Name.length()>40)
                    ma.Project__c = appMap.get(aw.Application_ID__c).Project__r.Name.substring(0,38);
                else
                    ma.Project__c = appMap.get(aw.Application_ID__c).Project__r.Name;
               }
            
            }
            
        }
    }
    //update projectMap.values();
    update masterAwardMap.values();
}