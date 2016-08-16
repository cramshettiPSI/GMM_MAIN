public with sharing class NofaSelectionCont {
    public Application3__c application{get;set;}
    public String id;
    public String parentId;    
    public NofaSelectionCont(ApexPages.StandardController controller) {
        id=Apexpages.currentPage().getParameters().get('id');
        parentId = Apexpages.currentPage().getParameters().get('parentId');
         If(id!=null && id!=''){
             application=[Select id,Withdraw_Justification__c,Legacy_App_ID__c,Application_Feedback_Summary__c,Former_SPR_Code__c, Opt_in_to_the_National_Service_Registry__c,Addendum_to__c, SPR_Code__c, If_Yes_Please_Explain_Applicant_Deliquen__c ,If_Yes_Please_Explain_EO_12372__c,Project_Priority__c, Disaster_Number_Funding_DOE__c, Partner_Project_Code__c, Team_Mobility__c, Campus__c,Other_Area_Affected_by_Project__c,Project_Director__c,Primary_State_of_Service_Activities__c,Approved_Amount__c,Executive_Officer__c,Grants_Officer__c,Senior_Grants_Officer__c,Year_of_Grant__c,Program_Officer__c,Tools_and_Equipment__c,Safety_and_Security__c,Cost_Effectiveness_and_Budget_Adequacy_C__c,If_other_please_specify_Infrastructure__c,
                              Infrastructure_Improvement__c,Other_Narrative__c,If_other_please_specify_Enivronment__c,Environmental_Stewardship_Conservation__c,Organizational_Capability__c,
                              If_other_please_specify_Energy__c,Energy_Conservation__c,Focus_Area__c,Otherobjectives__c,Natural_and_Other_Disasters__c,If_other_please_specify_capacity__c ,
                              If_other_please_specify_education__c ,If_other_please_specify_disaster__c,Program_Design__c ,Cost_Share__c,Need__c,VISTA_Assignment__c ,Characteristics_Priorities__c,
                              Program_Type__c,If_other_please_specify_Economic__c,AmeriCorps_logo_will_display_on_website__c,Economic_Opportunities__c,Number_of_elevator_speeches_created__c,
                              Capacity_Building__c,Number_of_members_wearing_logo_every_day__c,If_other_please_specify_Health__c,Healthy_Futures__c,If_other_please_specify_Enivironment_Ste__c,
                              Environmental_Stewardship__c,Disaster_Services__c,If_other_please_specify_Veterns__c,Education__c,Veterans_Military_Families__c,Strengthening_Communities__c,Number_of_ongoing_volunteers__c,
                              Number_of_episodic_volunteers_generated__c,Other_Revenue__c,Total_Match_Dollars__c,Private_Match__c,Local_State_Federal_Government_Match__c,Have_funding_history_with_any_CNCS_org__c,EO_12372_Process__c,
                              Counties__c,State_and_or_Territories__c,Specify_if_you_want_to_be_in_more_rounds__c,Disaster_Type__c,How_many_teams_are_being_requested__c,Select_a_round__c,Proposed_End_Date_is__c,
                              Proposed_Start_Date_is__c,Project_website_urls__c,Applicant_User__c,Assignee__c,Authorized_Representative__c,Point_of_Contact__c,Grantee_Status__c,Organization__c,Summary_of_Accomplishments__c ,
                              Intermediary_Justification__c ,Leadership_and_Team__c ,NOFA_RFP__r.Proposed_Dates__c,Comments__c,
                              Executive_Summary__c ,Target_Populations1__c,If_other_please_specify_Urban__c,Urban_and_Rural_Development__c,Organizational_Capacity__c, Cost_Effectiveness_and_Budget_Adequacy__c ,Clarification_Summary__c ,Continuation_Changes__c ,
                              Amendment_Justification__c,Strengthen_Communities__c ,Evaluation_Summary_or_Plan__c,Recruitment_and_Development__c  ,
                              Program_Management__c ,NOFA_RFP__c,Date_Received__c,Status__c,Type_of_Submission__c,Type_of_Application__c,
                              State_Application_Identifier__c,Option__c,Applicant_Delinquent_on_any_Federal_Debt__c,Additional_Information__c,If_Yes_provide_your_explination_here__c,
                              Review_by_State_Under_Executive_Order__c,Date_Received_by_State__c,Prefix__c,Organizational_Affiliation__c,First_Name__c,Title__c,Middle_Name__c,
                              Telephone_Number__c,Last_Name__c,Email__c,Suffix__c,Project__c,Areas_Affected_by_Project_Cities_Coutn__c,Proposed_Start_Date__c,
                              Proposed_End_Date__c,Documents_RSVP_Only__c,of_Unduplicated_Volunteers__c,Documents_Foster_Grandparents_Only__c,NOFA_RFP__r.Required__c,NOFA_RFP__r.Organization_Docs__c,NOFA_RFP__r.Review_Cycle__c FROM Application3__c where id = :id];
         }                              
    }
    
    public PageReference continueApp(){
      
      list<cb3__Budget__c> newBAs = new list<cb3__Budget__c>();
        set<Id> baIds = new set<Id>();
        map<String,Id> baNametoId = new map<String,Id>();
        list<cb3__BudgetLine__c> newBls = new list<cb3__BudgetLine__c>();
        list<cb3__BudgetLine3Lvl__c> newBlls = new list<cb3__BudgetLine3Lvl__c>();
        
        application.Status__c = 'In Progress';
        application.Grantee_Status__c = 'In Progress';
        update application;
        
        Application3__c parentApp = [Select Id,(Select Name, RecordTypeId, Accessible_for_people_with_disablities__c, Application__c, Beds_Provided__c, 
                        CNCS_Funds_Requested__c, Capacity_Building__c, City__c, Description_of_Accessibility__c, Disaster_Services__c, 
                        Distance_to_Location_of_Service__c, Economic_Opportunities__c, Education__c, Environmental_Stewardship__c, 
                        Healthy_Futures__c, Is_this_a_K_12_school__c,   Kitchen__c, Laundry__c, 
                        Legacy_Location_Id__c, Location_EIN__c, Location_Type__c, Lodging_Arrival_Date__c, Lodging_Category__c, 
                        Lodging_Departure_Date__c, Lodging_Description__c, Lodging_Type__c, NCES_IDs__c, NOFA1__c, NOFA__c, 
                        Number_of_Unduplicated_Volunteers__c, Number_of_Volunteers__c, Other_Capacity_Building__c, 
                        Other_Disaster_Services__c, Other_Economic_Opportunities__c, Other_Education__c, Other_Environmental_Stewardship__c, 
                        Other_Healthy_Futures__c, Other_Station_Type__c, Other_Veterans_Military_Families__c, Projected_End_Date__c, 
                        Projected_Start_Date__c, Refrigerator_Microwave__c, School_City__c, School_ID_NCES__c, School_Name__c, School_State__c, 
                        School_Street_Address_1__c, School_Street_Address_2__c, School_Zip__c, Shower__c, Site_Type__c, Slots__c, 
                        State__c, Station_Type__c, Street_Address_1__c, Street_Address_2__c, Summer_Associates__c, Supervisor_Email__c, 
                        Supervisor_Name__c, Supervisor_Organization__c, Supervisor_Phone_Number_Extension__c, Supervisor_Phone_Number__c, 
                        Undisclosed_Location__c, Veterans_Military_Families__c, Veterans_Served__c, Zip__c, CNCS_Corporate_Structure__c, Latitude__c, 
                        Longitude__c, NCES_ID__c, School_City_new__c, School_Zip_new__c, School_Street_Address_new__c, School_State_new__c
                        From Locations__r),
                        (Select   cb3__Title__c,  cb3__Status__c, cb3__BudgetYear__c,  cb3__BudgetForCurrentApplicationYear__c,  cb3__Application_Budget_Template__c,  
                        cb3__ApplicationBudgetSettings__c, Parent__c,  Name,  Id  From Budget_Applications__r) from Application3__c where id = :parentId];
        
        
        
        list<Location__c> newLocs = new list<Location__c>();
        if(parentApp.Locations__r.size()>0){
          for(Location__c l: parentApp.Locations__r){
              Location__c newLoc = l.clone();
              newLoc.Application__c = application.Id;
              newLocs.add(newLoc);                                               
          }
        }
        if(newLocs.size()>0){
          insert newLocs;
        }
        
        for(cb3__Budget__c ba: parentApp.Budget_Applications__r){
            cb3__Budget__c newBA = ba.clone();
            newBA.Parent__c = application.Id;
            newBAs.add(newBA);       
            baIds.add(ba.Id);                               
        }        
        if(newBAs.size()>0){
            insert newBAs;
            for(cb3__Budget__c ba: newBAs){
                baNametoId.put(ba.cb3__Title__c,ba.Id);
            }
            
        }
        
        list<cb3__Budget__c> originalBAs = new list<cb3__Budget__c>([Select Id,cb3__Title__c,(Select cb3__inUnits__c, cb3__Total__c, cb3__TotalAmount__c, 
                                                                        cb3__SelectedIndirectCostRate__c, cb3__SectionName__c, cb3__Rate__c, 
                                                                        cb3__RateError__c, cb3__QTotal__c, cb3__Q4__c, cb3__Q3__c, cb3__Q2__c, 
                                                                        cb3__Q1__c, cb3__PreDefined__c, cb3__PlannedTotal__c, cb3__Percentage__c,
                                                                         cb3__PercentageError__c, cb3__P4__c, cb3__P3__c, cb3__P2__c, 
                                                                        cb3__P1__c, cb3__Organization__c, cb3__OnlyTotalError__c, cb3__LinesTotal__c, 
                                                                        cb3__IndirectPercentage__c, cb3__IndirectPercentageError__c, 
                                                                        cb3__IndirectCost__c, cb3__IndirectCostError__c, cb3__Description__c, 
                                                                        cb3__Description2__c, cb3__Col3Error__c, cb3__Col2Error__c, 
                                                                        cb3__Col1Error__c, cb3__CTotal__c, cb3__CQ4__c, cb3__CQ3__c, 
                                                                        cb3__CQ2__c, cb3__CQ1__c, cb3__CP4__c, cb3__CP3__c, cb3__CP2__c, cb3__CP1__c, 
                                                                        cb3__CLinesTotal__c, cb3__BudgetSection__c, cb3__BudgetLine__c, cb3__BudgetApplication__c,
                                                                         cb3__BudgetApplicationName__c, cb3__AttentionMessage__c, 
                                                                        cb3__AmountError__c, cb3__Address__c, cb3__Account__c, cb3__ATotal__c, cb3__A4__c, cb3__A3__c, cb3__A2__c, cb3__A1__c, PrimeApplicationId__c, 
                                                                        Name, BudgetFormCBAPAcct4__c, BudgetFormCBAPAcct3__c, BudgetFormCBAPAcct2__c,
                                                                        BudgetFormCBAPAcct1__c, ApplicationId__c 
                                                                        From cb3__BudgetApplicationBudgetLines__r), 
                                                                                (Select cb3__Total__c, cb3__Description__c, cb3__CTotal__c, cb3__BudgetApplication__c, 
                                                                                cb3__BudgetApplicationSourceType__c, cb3__BudgetApplicationSourceTypeStr__c, 
                                                                                cb3__BudgetApplicationAmountClassification__c, cb3__BudgetApplicationAmountClassificationStr__c, 
                                                                                Name, Id From cb3__BudgetLine3Lvl__r) From cb3__Budget__c c where Id in :baIds]);
                                                                              
        for(cb3__Budget__c ba: originalBAs){
            if(ba.cb3__BudgetApplicationBudgetLines__r.size()>0){
                for(cb3__BudgetLine__c bl: ba.cb3__BudgetApplicationBudgetLines__r){
                    cb3__BudgetLine__c newBL = new cb3__BudgetLine__c();
                    newBL = bl.Clone();
                    newBL.cb3__BudgetApplication__c = baNametoId.get(ba.cb3__Title__c);
                    newBLs.add(newBL);
                }               
            }
            if(ba.cb3__BudgetLine3Lvl__r.size()>0){
                for(cb3__BudgetLine3Lvl__c  bll: ba.cb3__BudgetLine3Lvl__r){
                    cb3__BudgetLine3Lvl__c newbll = new cb3__BudgetLine3Lvl__c();
                    newbll = bll.clone();
                    newbll.cb3__BudgetApplication__c = baNametoId.get(ba.cb3__Title__c);
                    newBlls.add(newbll);
                }   
            }
        }   
        if(newBls.size()>0){
            insert newBls;
        }    
        if(newblls.size()>0){
            insert newBlls;
        }
        
        PageReference pg = new PageReference('/apex/ApplicationEditpage?id='+application.Id);
        //if(ApexPages.currentPage().getParameters().get('isContinuingApp')=='false')
            pg.getParameters().put('isContinuingApp','false');
        //if(ApexPages.currentPage().getParameters().get('isContinuingApp')=='true')
        //    pg.getParameters().put('isContinuingApp','true');
        pg.getParameters().put('parentId',parentId);
        pg.setRedirect(true);
        return pg;
    
    }
    
    public PageReference cancel(){
        PageReference pg; 
        //system.debug('isContinuingApp = '+isContinuingApp);
        if(ApexPages.currentPage().getParameters().get('isContinuingApp')=='true'){
            delete application;
            pg = new PageReference('/'+Apexpages.currentPage().getParameters().get('parentId'));
        }else{
            system.debug('got here 2');
            pg = new PageReference('/'+Apexpages.currentPage().getParameters().get('parentId'));  
        }               
        pg.setRedirect(true);
        return pg;
    }

}