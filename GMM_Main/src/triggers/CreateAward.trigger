trigger CreateAward on Application3__c (After update) {

    string a;
    if(checkRecursive.runOnce()){
        Map<Id,Id> MA_Map = new Map<Id,Id>();
        List<Master_Award__c> MA_List = new List<Master_Award__c>();
        List <Award__c> AwardInsert = new List <Award__c> ();
        List<id> Proj_List = new List<id>();
        set<Id> parentIds = new set<Id>();
        list<Application3__c> parentApps = new list<Application3__c> ();
        Id ApplicationID=Schema.SObjectType.Application3__c.getRecordTypeInfosByName().get('Application').getRecordTypeId();
        //System.debug('@@@@@'+ApplicationID);
        Id AMARecordTypeId = Schema.SObjectType.Master_Award__c.getRecordTypeInfosByName().get('App Master Award').getRecordTypeId();
        Id SAMARecordTypeId = Schema.SObjectType.Master_Award__c.getRecordTypeInfosByName().get('Sub App Master Award').getRecordTypeId();
        Id AARecordTypeId = Schema.SObjectType.Award__c.getRecordTypeInfosByName().get('App Award').getRecordTypeId();
        Id SAARecordTypeId = Schema.SObjectType.Award__c.getRecordTypeInfosByName().get('Sub App Award').getRecordTypeId();
        
        Schema.DescribeSObjectResult resSchema = Application3__c.sObjectType.getDescribe();
        map<Id,Id> parentAppIdtoAppId = new map<Id,Id>();
        //getting all Recordtype  Application
        Map<String,Schema.RecordTypeInfo> recordTypeInfo = resSchema.getRecordTypeInfosByName();         
        //Getting Application Record Type Id
        Id rtId = recordTypeInfo.get('Application').getRecordTypeId();
        a=String.valueOf(rtid).substring(0, 15);
        System.debug('$$$$$'+a);
            
        for (Application3__c App: Trigger.new)
        {
            Proj_List.add(App.Project__c);
            //for Contniuation & Amendments
            if(app.Type_of_Application__c != 'New'){
                parentIds.add(app.Parent_Application__c); 
                parentAppIdtoAppId.put(app.Parent_Application__c,app.Id);               
            }
            
            if(trigger.oldMap.get(app.Id).Status__c != trigger.newMap.get(app.Id).Status__c && trigger.newMap.get(app.Id).Status__c == 'Accepted'){
                if ( App.RecordTypeID == ApplicationID && App.Type_of_Application__c == 'New') {
                
                //&& App.flagReturnForRework__c == False
                if(App.Sub_Application__c=='Yes' && App.Status__c == 'Accepted' && App.Competitive_or_Formula_new__c=='Competitive' ){
                    Master_Award__c MA = new Master_Award__c ();
                    MA.recordtypeid=SAMARecordTypeId;
                    MA.Project_Name__c = App.Project__c;
                    MA.Application__c = App.id;
                     MA_List.add(MA);
                     System.debug('MA1'+MA_List);
                }
                else if (App.Sub_Application__c == 'No' && App.Status__c == 'Accepted' ) {
                    Master_Award__c MA = new Master_Award__c ();
                    MA.recordtypeid=AMARecordTypeId;
                    MA.Project_Name__c = App.Project__c;
                    MA.Application__c = App.id;
                     MA_List.add(MA);
                     
                     System.debug('MA2'+MA_List);
                }
                
                else if (App.Sub_Application__c=='Yes' && App.Status__c == 'Awarded' && App.Competitive_or_Formula_new__c=='Formula' )
                {
                  Master_Award__c MA = new Master_Award__c ();      
                  MA.recordtypeid=SAMARecordTypeId;
                  MA.Application__c = App.id;
                  MA_List.add(MA);
                  System.debug('MA3'+MA_List);
                }
                
               
                }
            }
        /*    else if (App.Status__c == 'Awarded' && App.RecordTypeID == ApplicationID && App.Type_of_Application__c == 'New' && App.Competitive_or_Formula_new__c=='Formula') {
            
            Master_Award__c MA = new Master_Award__c ();
            {
                MA.recordtypeid=SAMARecordTypeId;
                MA.Application__c = App.id;
            }
        } */
        }
        
        system.debug('in create Award = '+MA_List);
        if(MA_List.size()>0){
            Insert MA_List;
        }
        system.debug('parentIds = '+parentIds);
        for(Master_Award__c ma : [Select id,name,Application__c from Master_Award__c where ID IN: MA_List or Application__c in :parentIds])
        {
            MA_Map.put(ma.Application__c,ma.Id);
            if(parentAppIdtoAppId.get(ma.Application__c)!=null){
                MA_Map.put(parentAppIdtoAppId.get(ma.Application__c),ma.Id);
            }
        }
        
        system.debug('MA_Map = '+MA_Map);
        List<Award__c> aw_List = new List<Award__c>();
        Map<Id,project__c> UpdateProjList = new Map<Id,Project__c>([Select Id, Name, Project_Title__c from Project__c where id IN : Proj_List]);
        for (Application3__c App: Trigger.new)
        {
          if(trigger.oldMap.get(app.Id).Status__c != trigger.newMap.get(app.Id).Status__c){ 
          System.debug('App_ID'+App.id);
          if ( App.RecordTypeID == ApplicationID) {
             
             //&& App.flagReturnForRework__c == False
             if(App.Status__c == 'Accepted' && App.Sub_Application__c=='Yes' && App.Competitive_or_Formula_new__c=='Competitive' && App.Return_For_Rework__c!=True){
                Award__c Aw = new Award__c ();
                if(MA_Map.containsKey(App.id))
                    Aw.Master_Award__c=MA_Map.get(App.id);
                Aw.Name = App.Name;
                Aw.recordtypeid=SAARecordTypeId;
                Aw.NOFA_Name__c = App.NOFA_RFP__c;
                Aw.Project__c = App.Project__c;
                
                system.debug('app Id = '+app.Id);
                Aw.Application_ID__c = App.ID;
                Aw.Organization__c = app.Organization__c;
                //Aw.Project_Title__c = App.Project__r.Project_Title__c;
                Aw.Program_Officer__c = App.Program_Officer__c;
                Aw.Senior_Program_Officer__c = App.Senior_Program_Officer__c;
                Aw.Executive_Officer__c = App.Executive_Officer__c;
                Aw.XO_CSHR__c = App.Ex_Officer_Cost_Share__c;
                Aw.Senior_Grants_Officer__c = App.Senior_Grants_Officer__c;
                Aw.Grants_Officer__c = App.Grants_Officer__c; 
                Aw.Budget_Period_Start__c = App.Proposed_Start_Date__c;
                Aw.Budget_Period_End__c = App.Proposed_End_Date__c;
                Aw.Prime_Application__c = App.Prime_Application__c;
                Aw.Approved_Amount__c=App.Recommended_Award_Amount__c;
                Aw.Subject_to_FAPIIS_Review__c = App.Subject_to_FAPIIS_Review__c;
                Aw.FAPIIS_Review_Date__c = App.Date_FAPIIS_Review__c;
                Aw.Information_Available__c = App.Information_available_FAPIIS_Review__c;
                Aw.Satisfactory_Record_Executing_Programs__c = App.Satisfactory_Record_Executing_Programs__c;
                Aw.Demonstrates_Ethics_Integrity__c = App.Demonstrates_Ethics_Integrity__c;
                Aw.Mitigating_Circumstances__c = App.Mitigating_Circumstances__c;
                Aw.FAPIIS_Review_Comments__c = App.FAPIIS_Review_Comments__c;
                //Aw.Total_Recommended_MSYs__c = App.Total_Recommended_MSYs__c;
                //Aw.Recommended_Award_Amount__c = App.Recommended_Award_Amount__c;
                if(App.Cost_Share__c=='Yes')
                    Aw.Cost_Share__c=true;
                Aw.Project_Title__c = UpdateProjList.get(App.Project__c).Project_Title__c;
                aw_List.add(Aw);
            }
            else if (App.Status__c == 'Accepted' && App.Sub_Application__c=='No' && App.Return_For_Rework__c!=True ) {            
                Award__c Aw = new Award__c ();
                if(MA_Map.containsKey(App.id))
                       Aw.Master_Award__c=MA_Map.get(App.id);
                Aw.Name = App.Name;
                Aw.recordtypeid=AARecordTypeId;
                Aw.NOFA_Name__c = App.NOFA_RFP__c;
                Aw.Project__c = App.Project__c;
                system.debug('app Id = '+app.Id);
                Aw.Application_ID__c = App.ID;
                Aw.Organization__c =  app.Organization__c;
                Aw.Program_Officer__c = App.Program_Officer__c;
                Aw.Senior_Program_Officer__c = App.Senior_Program_Officer__c;
                Aw.Executive_Officer__c = App.Executive_Officer__c;
                Aw.XO_CSHR__c = App.Ex_Officer_Cost_Share__c;
                Aw.Senior_Grants_Officer__c = App.Senior_Grants_Officer__c;
                Aw.Grants_Officer__c = App.Grants_Officer__c; 
                Aw.Budget_Period_Start__c = App.Proposed_Start_Date__c;
                Aw.Budget_Period_End__c = App.Proposed_End_Date__c;
                Aw.Approved_Amount__c=App.Recommended_Award_Amount__c;
                Aw.Subject_to_FAPIIS_Review__c = App.Subject_to_FAPIIS_Review__c;
                Aw.FAPIIS_Review_Date__c = App.Date_FAPIIS_Review__c;
                Aw.Information_Available__c = App.Information_available_FAPIIS_Review__c;
                Aw.Satisfactory_Record_Executing_Programs__c = App.Satisfactory_Record_Executing_Programs__c;
                Aw.Demonstrates_Ethics_Integrity__c = App.Demonstrates_Ethics_Integrity__c;
                Aw.Mitigating_Circumstances__c = App.Mitigating_Circumstances__c;
                Aw.FAPIIS_Review_Comments__c = App.FAPIIS_Review_Comments__c;
                //Aw.Total_Recommended_MSYs__c = App.Total_Recommended_MSYs__c;
                //Aw.Recommended_Award_Amount__c = App.Recommended_Award_Amount__c;
                if(App.Cost_Share__c=='Yes')
                    Aw.Cost_Share__c=true;
                Aw.Project_Title__c = UpdateProjList.get(App.Project__c).Project_Title__c;
                aw_List.add(Aw);
           }
           
             
          else if(App.Status__c == 'Awarded' && App.Sub_Application__c=='Yes' && App.Competitive_or_Formula_new__c=='Formula' && App.Return_For_Rework__c!=True ){
                Award__c Aw = new Award__c ();
                if(MA_Map.containsKey(App.id))
                    Aw.Master_Award__c=MA_Map.get(App.id);
                Aw.Name = App.Name;
                Aw.recordtypeid=SAARecordTypeId;
                Aw.NOFA_Name__c = App.NOFA_RFP__c;
                Aw.Project__c = App.Project__c;
                system.debug('app Id = '+app.Id);
                Aw.Application_ID__c = App.ID;
                Aw.Organization__c = app.Organization__c;
                Aw.Program_Officer__c = App.Program_Officer__c;
                Aw.Senior_Program_Officer__c = App.Senior_Program_Officer__c;
                Aw.Executive_Officer__c = App.Executive_Officer__c;
                Aw.XO_CSHR__c = App.Ex_Officer_Cost_Share__c;
                Aw.Senior_Grants_Officer__c = App.Senior_Grants_Officer__c;
                Aw.Grants_Officer__c = App.Grants_Officer__c; 
                Aw.Budget_Period_Start__c = App.Proposed_Start_Date__c;
                Aw.Budget_Period_End__c = App.Proposed_End_Date__c;
                Aw.Prime_Application__c = App.Prime_Application__c;
                Aw.Approved_Amount__c=App.Recommended_Award_Amount__c;
                Aw.Subject_to_FAPIIS_Review__c = App.Subject_to_FAPIIS_Review__c;
                Aw.FAPIIS_Review_Date__c = App.Date_FAPIIS_Review__c;
                Aw.Information_Available__c = App.Information_available_FAPIIS_Review__c;
                Aw.Satisfactory_Record_Executing_Programs__c = App.Satisfactory_Record_Executing_Programs__c;
                Aw.Demonstrates_Ethics_Integrity__c = App.Demonstrates_Ethics_Integrity__c;
                Aw.Mitigating_Circumstances__c = App.Mitigating_Circumstances__c;
                Aw.FAPIIS_Review_Comments__c = App.FAPIIS_Review_Comments__c;
                //Aw.Total_Recommended_MSYs__c = App.Total_Recommended_MSYs__c;
                //Aw.Recommended_Award_Amount__c = App.Recommended_Award_Amount__c;
                if(App.Cost_Share__c=='Yes')
                    Aw.Cost_Share__c=true;
                Aw.Grant_Status__c = 'Awarded';
                Aw.Project_Title__c = UpdateProjList.get(App.Project__c).Project_Title__c;
                aw_List.add(Aw);
            }
           
        }
      } 
      }
        
      if(aw_List.size()>0){
        insert aw_List; 
      }
    }
}