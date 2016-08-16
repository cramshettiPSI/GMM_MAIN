public without sharing class AwardReportingHelper {

    public static void lockFFR(map<Id,Award_Reporting__c> newMap, map<Id,Award_Reporting__c> oldMap){
        system.debug('in lock method');
        Id ffrRTId = Schema.SObjectType.Award_Reporting__c.getRecordTypeInfosByName().get('Federal Financial Reports').getRecordTypeId();
        map<String, Schema.SObjectField> awardReportfields= Schema.getGlobalDescribe().get('Award_Reporting__c').getDescribe().fields.getMap();
        for(Id i:newMap.keyset()){
            if(newMap.get(i).RecordTypeId == ffrRTId){
                if((oldMap.get(i).Status__c == 'Submitted' && newMap.get(i).Status__c == 'Submitted') || (oldMap.get(i).Status__c == 'Re-submitted' && newMap.get(i).Status__c == 'Re-submitted')){             
                    Award_Reporting__c oldRec = oldMap.get(i);
                    Award_Reporting__c newRec = newMap.get(i);
                    for(String s:awardReportFields.keyset()){
                       if(oldRec.get(s) != newRec.get(s)){                       
                            newMap.get(i).addError('FFR cannot be edited when its submitted status');
                        }
                    }                   
                }
            }
        }
    }
    
    /*public static void fieldUpdates(map<Id,Award_Reporting__c> newMap, map<Id,Award_Reporting__c> oldMap){
        Id ffrRTId = Schema.SObjectType.Award_Reporting__c.getRecordTypeInfosByName().get('Federal Financial Reports').getRecordTypeId();
        for(Id i:newMap.keyset()){
            if(newMap.get(i).RecordTypeId == ffrRTId){
                if((oldMap.get(i).Status__c != newMap.get(i).Status__c) &&  (oldMap.get(i).Status__c != 'Submitted' && newMap.get(i).Status__c == 'Submitted')){
                    Award_Reporting__c oldRec = oldMap.get(i);
                    Award_Reporting__c newRec = newMap.get(i);
                    if((newRec.Unobligated_balance_of_federal_funds__c/newRec.Total_federal_share__c) <= (0.2 * newRec.FedShareUnliquidatedObligation_ThisPerio__c))
                        newRec.Drawdowns_within_20_of_reported_OBG__c = 'Yes';
                    else
                        newRec.Drawdowns_within_20_of_reported_OBG__c = 'No';
                        
                    if(newRec.Submitted_Date__c <= newRec.Due_Date__c)
                        newRec.Timely_Submission__c = 'On-Time';
                    else
                        newRec.Timely_Submission__c = 'Late';                       
                    
                }
            }
        }
    }*/
    
    public static void  updateExpenditure(List<Award_Reporting__c> awardReports)
    {
    Set<ID> awardIDs=new Set<ID>();  
    for(Award_Reporting__c ar: awardReports){
        awardIds.add(ar.Id);
    }
    Map<ID,Award_Reporting__c> awardMap=new Map<ID,Award_Reporting__c>([SELECT ID,Award__r.Grant_Performance_Period_Start__c FROM Award_Reporting__c
                                                                        WHERE ID IN :awardIds]);
    for(Award_Reporting__c ar:awardReports)
    {
    
     //System.debug('Testing1:'+ar.Submitted_Date__c);
     //System.debug('Testing2:'+ar.Award__r.Grant_Performance_Period_Start__c);
     if(ar.Submitted_Date__c!=NULL && awardMap.get(ar.ID).Award__r.Grant_Performance_Period_Start__c!=NULL && ar.Expenditure_Threshold__c != NULL)  
     {
         // System.debug('Testing:'+(ar.Submitted_Date__c.month()- ar.Award__r.Grant_Performance_Period_Start__c.month()));
         if((awardMap.get(ar.ID).Award__r.Grant_Performance_Period_Start__c.monthsBetween(ar.Submitted_Date__c))>= 3 && (awardMap.get(ar.ID).Award__r.Grant_Performance_Period_Start__c.monthsBetween(ar.Submitted_Date__c))<6)
         {
             if(ar.Expenditure_Threshold__c<2)
             {
                 ar.Expenditures__c='Low';
             }
             else if(ar.Expenditure_Threshold__c>50)
             {
                 ar.Expenditures__c='High';
             }
             else
             {
                 ar.Expenditures__c='On Target';
             }
         }
         else if((awardMap.get(ar.ID).Award__r.Grant_Performance_Period_Start__c.monthsBetween(ar.Submitted_Date__c))>= 6 && (awardMap.get(ar.ID).Award__r.Grant_Performance_Period_Start__c.monthsBetween(ar.Submitted_Date__c))<12)
         {
             if(ar.Expenditure_Threshold__c<20)
             {
                 ar.Expenditures__c='Low';
             }
             else if(ar.Expenditure_Threshold__c>75)
             {
                 ar.Expenditures__c='High';
             }
             else
             {
                 ar.Expenditures__c='On Target';
             }
         }
         else if((awardMap.get(ar.ID).Award__r.Grant_Performance_Period_Start__c.monthsBetween(ar.Submitted_Date__c))>= 12 && (awardMap.get(ar.ID).Award__r.Grant_Performance_Period_Start__c.monthsBetween(ar.Submitted_Date__c))<18)
         {
             if(ar.Expenditure_Threshold__c<50)
             {
                 ar.Expenditures__c='Low';
             }
             else if(ar.Expenditure_Threshold__c>100)
             {
                 ar.Expenditures__c='High';
             }
             else
             {
                 ar.Expenditures__c='On Target';
             }
         }
         else if((awardMap.get(ar.ID).Award__r.Grant_Performance_Period_Start__c.monthsBetween(ar.Submitted_Date__c))>= 18 && (awardMap.get(ar.ID).Award__r.Grant_Performance_Period_Start__c.monthsBetween(ar.Submitted_Date__c))<24)
         {
             if(ar.Expenditure_Threshold__c<60)
             {
                 ar.Expenditures__c='Low';
             }
             else if(ar.Expenditure_Threshold__c>90)
             {
                 ar.Expenditures__c='High';
             }
             else
             {
                 ar.Expenditures__c='On Target';
             }
         }
         else if((awardMap.get(ar.ID).Award__r.Grant_Performance_Period_Start__c.monthsBetween(ar.Submitted_Date__c))>= 24 && (awardMap.get(ar.ID).Award__r.Grant_Performance_Period_Start__c.monthsBetween(ar.Submitted_Date__c))<30)
         {
             if(ar.Expenditure_Threshold__c<75)
             {
                 ar.Expenditures__c='Low';
             }
             else if(ar.Expenditure_Threshold__c>100)
             {
                 ar.Expenditures__c='High';
             }
             else
             {
                 ar.Expenditures__c='On Target';
             }
         }
         else if((awardMap.get(ar.ID).Award__r.Grant_Performance_Period_Start__c.monthsBetween(ar.Submitted_Date__c))>= 30 && (awardMap.get(ar.ID).Award__r.Grant_Performance_Period_Start__c.monthsBetween(ar.Submitted_Date__c))<36)
         {
             if(ar.Expenditure_Threshold__c<80)
             {
                 ar.Expenditures__c='Low';
             }
             else if(ar.Expenditure_Threshold__c>90)
             {
                 ar.Expenditures__c='High';
             }
             else
             {
                 ar.Expenditures__c='On Target';
             }
         }
         else if(awardMap.get(ar.ID).Award__r.Grant_Performance_Period_Start__c.monthsBetween(ar.Submitted_Date__c) >= 36)
         {
             if(ar.Expenditure_Threshold__c<90)
             {
                 ar.Expenditures__c='Low';
             }
             else if(ar.Expenditure_Threshold__c>100)
             {
                 ar.Expenditures__c='High';
             }
             else
             {
                 ar.Expenditures__c='On Target';
             }
         }
     
    }
}
        
    }
    public static void  updateObligation(List<Award_Reporting__c> awardReports)
    {
    Set<ID> awardIDs=new Set<ID>();  
    for(Award_Reporting__c ar: awardReports){
        awardIds.add(ar.Id);
    }
    Map<ID,Award_Reporting__c> awardMap=new Map<ID,Award_Reporting__c>([SELECT ID,Award__r.Grant_Performance_Period_Start__c,Award__r.Master_Award__r.Unobligated__c
                                                                        FROM Award_Reporting__c
                                                                        WHERE ID IN :awardIds]);
    for(Award_Reporting__c ar:awardReports)
    {
    
     //System.debug('Testing1:'+ar.Submitted_Date__c);
     //System.debug('Testing2:'+ar.Award__r.Grant_Performance_Period_Start__c);
        
      //  System.debug('test3:'+ar.Award__r.Master_Award__r.Unobligated__c);
     if(ar.Submitted_Date__c!=NULL && awardMap.get(ar.ID).Award__r.Grant_Performance_Period_Start__c!=NULL && awardMap.get(ar.ID).Award__r.Master_Award__r.Unobligated__c!=NULL)    
     {
        //ar.Unobligated_funds__c='Low';
         // System.debug('Testing:'+(ar.Submitted_Date__c.month()- ar.Award__r.Grant_Performance_Period_Start__c.month()));
         if((awardMap.get(ar.ID).Award__r.Grant_Performance_Period_Start__c.monthsBetween(ar.Submitted_Date__c))>= 12 && (awardMap.get(ar.ID).Award__r.Grant_Performance_Period_Start__c.monthsBetween(ar.Submitted_Date__c))<24)
         {
                             // ar.Unobligated_funds__c='Low';
             if(awardMap.get(ar.ID).Award__r.Master_Award__r.Unobligated__c<30)
             {
                 ar.Unobligated_funds__c='Low';
             }
             else if(awardMap.get(ar.ID).Award__r.Master_Award__r.Unobligated__c>30)
             {
                 ar.Unobligated_funds__c='High';
             }
             else
             {
                 ar.Unobligated_funds__c='On Target';
             }
         }
         else if((awardMap.get(ar.ID).Award__r.Grant_Performance_Period_Start__c.monthsBetween(ar.Submitted_Date__c))>= 24 && (awardMap.get(ar.ID).Award__r.Grant_Performance_Period_Start__c.monthsBetween(ar.Submitted_Date__c))<36)
         {
             if(awardMap.get(ar.ID).Award__r.Master_Award__r.Unobligated__c<25)
             {
                 ar.Unobligated_funds__c='Low';
             }
             else if(awardMap.get(ar.ID).Award__r.Master_Award__r.Unobligated__c>25)
             {
                 ar.Unobligated_funds__c='High';
             }
             else
             {
                 ar.Unobligated_funds__c='On Target';
             }
         }
         else if((awardMap.get(ar.ID).Award__r.Grant_Performance_Period_Start__c.monthsBetween(ar.Submitted_Date__c))>= 36 && (awardMap.get(ar.ID).Award__r.Grant_Performance_Period_Start__c.monthsBetween(ar.Submitted_Date__c))<48)
         {
             if(awardMap.get(ar.ID).Award__r.Master_Award__r.Unobligated__c<20)
             {
                 ar.Unobligated_funds__c='Low';
             }
             else if(awardMap.get(ar.ID).Award__r.Master_Award__r.Unobligated__c>20)
             {
                 ar.Unobligated_funds__c='High';
             }
             else
             {
                 ar.Unobligated_funds__c='On Target';
             }
         }
         else if((awardMap.get(ar.ID).Award__r.Grant_Performance_Period_Start__c.monthsBetween(ar.Submitted_Date__c))>= 48 && (awardMap.get(ar.ID).Award__r.Grant_Performance_Period_Start__c.monthsBetween(ar.Submitted_Date__c))<60)
         {
             if(awardMap.get(ar.ID).Award__r.Master_Award__r.Unobligated__c<15)
             {
                 ar.Unobligated_funds__c='Low';
             }
             else if(awardMap.get(ar.ID).Award__r.Master_Award__r.Unobligated__c>15)
             {
                 ar.Unobligated_funds__c='High';
             }
             else
             {
                 ar.Unobligated_funds__c='On Target';
             }
         }
         
         else if(awardMap.get(ar.ID).Award__r.Grant_Performance_Period_Start__c.monthsBetween(ar.Submitted_Date__c) >= 60)
         {
             if(awardMap.get(ar.ID).Award__r.Master_Award__r.Unobligated__c<10)
             {
                 ar.Unobligated_funds__c='Low';
             }
             else if(awardMap.get(ar.ID).Award__r.Master_Award__r.Unobligated__c>10)
             {
                 ar.Unobligated_funds__c='High';
             }
             else
             {
                 ar.Unobligated_funds__c='On Target';
             }
         }
     
    }
}
        
    }
    
    public static void  updateMatch(List<Award_Reporting__c> awardReports)
    {
     system.debug('in match');
    Set<ID> awardIDs=new Set<ID>();  
   // if(awardReports.size()>0)
    for(Award_Reporting__c ar: awardReports){
        awardIds.add(ar.Id);
    }
   
    Map<ID,Award_Reporting__c> awardMap=new Map<ID,Award_Reporting__c>([SELECT ID,Award__r.Grant_Performance_Period_Start__c FROM Award_Reporting__c
                                                                        WHERE ID IN:awardIds]);
    for(Award_Reporting__c ar:awardReports)
    {
    
   //  System.debug('Testing1:'+ar.Submitted_Date__c);
   //  System.debug('Testing2:'+ar.Award__r.Grant_Performance_Period_Start__c);
     if((ar.of_match_required__c == NULL || ar.of_match_required__c == 0) && ar.Submitted_Date__c!=NULL && awardMap.get(ar.ID).Award__r.Grant_Performance_Period_Start__c!=NULL)
     {
         ar.Match__c='On Target';
     }
    else if(ar.Submitted_Date__c!=NULL && awardMap.get(ar.ID).Award__r.Grant_Performance_Period_Start__c!=NULL && ar.Match_Threshold__c != NULL)    
     {
         // System.debug('Testing:'+(ar.Submitted_Date__c.month()- ar.Award__r.Grant_Performance_Period_Start__c.month()));
         if((awardMap.get(ar.ID).Award__r.Grant_Performance_Period_Start__c.monthsBetween(ar.Submitted_Date__c))>= 6 && (awardMap.get(ar.ID).Award__r.Grant_Performance_Period_Start__c.monthsBetween(ar.Submitted_Date__c))<12)
         {
                 ar.Match__c='On Target';
             
         }
       else if((awardMap.get(ar.ID).Award__r.Grant_Performance_Period_Start__c.monthsBetween(ar.Submitted_Date__c))>= 12 && (awardMap.get(ar.ID).Award__r.Grant_Performance_Period_Start__c.monthsBetween(ar.Submitted_Date__c))<18)
         {
             if(ar.Match_Threshold__c<50)
             {
                 ar.Match__c='Low';
             }
             else if(ar.Match_Threshold__c>=50)
             {
                 ar.Match__c='On Target';
             }
         }
         else if((awardMap.get(ar.ID).Award__r.Grant_Performance_Period_Start__c.monthsBetween(ar.Submitted_Date__c))>= 18 && (awardMap.get(ar.ID).Award__r.Grant_Performance_Period_Start__c.monthsBetween(ar.Submitted_Date__c))<24)
         {
             if(ar.Match_Threshold__c<60)
             {
                 ar.Match__c='Low';
             }
             else if(ar.Match_Threshold__c>=60)
             {
                 ar.Match__c='On Target';
             }
             
         }
         else if((awardMap.get(ar.ID).Award__r.Grant_Performance_Period_Start__c.monthsBetween(ar.Submitted_Date__c))>= 24 && (awardMap.get(ar.ID).Award__r.Grant_Performance_Period_Start__c.monthsBetween(ar.Submitted_Date__c))<30)
         {
             if(ar.Match_Threshold__c<70)
             {
                 ar.Match__c='Low';
             }
             else if(ar.Match_Threshold__c>=70)
             {
                 ar.Match__c='On Target';
             }
            
         }
         else if((awardMap.get(ar.ID).Award__r.Grant_Performance_Period_Start__c.monthsBetween(ar.Submitted_Date__c))>= 30 && (awardMap.get(ar.ID).Award__r.Grant_Performance_Period_Start__c.monthsBetween(ar.Submitted_Date__c))<36)
         {
             if(ar.Match_Threshold__c<80)
             {
                 ar.Match__c='Low';
             }
             else if(ar.Match_Threshold__c>=80)
             {
                 ar.Match__c='On Target';
             }
            
         }
         else if((awardMap.get(ar.ID).Award__r.Grant_Performance_Period_Start__c.monthsBetween(ar.Submitted_Date__c))>= 36 )
         {
             if(ar.Match_Threshold__c<90)
             {
                 ar.Match__c='Low';
             }
             else if(ar.Match_Threshold__c>=90)
             {
                 ar.Match__c='On Target';
             }
             
         }
         
     
    }
}
        
    }
    
    public static void shareAwardReportingWithStateCommission(list<Award_Reporting__c> newAwardReports){
           system.debug('in sharing w state');
            Profile p = [Select Id,Name from Profile where Name = 'System Administrator'];
            if(userInfo.getProfileId()!=p.Id){
            
                set<Id> awIds = new set<Id>();
                set<Id> primeAppIds = new set<Id>();
                list<Award_Reporting__c> awrList = new list<Award_Reporting__c>();
                for(Award_Reporting__c a:newAwardReports){
                    if(a.Award__c!=null){
                        awIds.add(a.Award__c);
                        awrList.add(a);
                    }
                }
                if(awIds.size()>0){
                    Map<Id,Award__c> awardMap = new Map<Id,Award__c>([Select Id,Name,Prime_Application__c from Award__c where Id in :awIds]);
                    for(Id i:awardMap.keyset()){
                        if(awardMap.get(i).Prime_Application__c!=null){
                            primeAppIds.add(awardMap.get(i).Prime_Application__c);
                        }
                    }
                    if(primeAppIds.size()>0){
                        Map<Id,Prime_Application__c> primeApps = new Map<Id,Prime_Application__c>([Select Id,createdById,Project_Name__r.Organization__c from Prime_Application__c where id in :primeAppids]);
                        list<Award_Reporting__Share> awShares = new list<Award_Reporting__Share>();
                        
                        if(primeApps.size()>0){
                            for(Award_Reporting__c a:awrList){
                                if(awardMap.get(a.Award__c).Prime_Application__c !=null){
                                    Award_Reporting__Share aShare = new Award_Reporting__Share ();
                                    aShare.ParentId = a.Id;
                                    aShare.userorgroupId = primeApps.get(awardMap.get(a.Award__c).Prime_Application__c).createdById;
                                    aShare.AccessLevel = 'Edit';
                                    awShares.add(aShare);
                                
                                }
                            }
                        }
                        if(awShares.size()>0){
                            insert awShares;
                        }
                    }
                }
            }
            
    
        
    
    }
    
    public static void shareAwardReports(list<Award_Reporting__c> newAwardReports){
        system.debug('in share');
        
        Profile p = [Select Id,Name from Profile where Name = 'System Administrator'];
        if(userInfo.getProfileId()!=p.Id){
            set<Id> orgIds = new set<Id>();
            set<Id> conIds = new set<Id>();
            map<Id,list<Id>> accIdtoAppId = new map<Id,list<Id>>();
            map<Id,Id> conNametoAccId = new map<Id,Id>();
            list<Award_Reporting__Share> awshares = new list<Award_Reporting__Share>();
            for(Award_Reporting__c a: newAwardReports){
                if(a.Org_Id__c != null){
                    orgIds.add(a.Org_Id__c);
                    //accIdtoAppId.put(a.Organization_Name__c,a.Id); 
                    if(accIdtoAppId.keyset().contains(a.Org_Id__c)){
                        accIdtoAppId.get(a.Organization_Name__c).add(a.Id);
                    }
                    else{
                    //if it is the first time on the loop
                        accIdtoAppId.put(a.Org_Id__c,new list<Id>());
                        accIdtoAppId.get(a.Org_Id__c).add(a.Id);
                    }
                    
                }   
            }
            
            
          
                  
            
            if(orgIds.size()>0){
                list<Account> accs = new list<Account>([Select (Select Id, LastName, FirstName, Name,AccountId From Contacts) From Account a where Id in :orgIds]);
                if(accs.size()>0){
                    for(Account a: accs){
                        if(a.Contacts.size()>0){
                            for(Contact c: a.Contacts){
                                conIds.add(c.Id);
                                conNametoAccId.put(c.Id,c.AccountId);
                            }
                        }
                    }
                }
                if(conIds.size()>0){
                    set<Id> roleIds = new set<Id>();
                    list<User> users = new list<User>([Select Id,FirstName,LastName,Name,userRoleId,contactId from User where ContactId in :conIds]);
                    if(users.size()>0){
                        for(User u: users){                                         
                                  if(u.Id!=userInfo.getUserId() && accIdtoAppId.get(conNametoAccId.get(u.contactId))!=null ){
                                    list<Id> awIds = accIdtoAppId.get(conNametoAccId.get(u.contactId)); 
                                    system.debug('awIds = '+awIds);
                                    for(Id i:awIds){       
                                        Award_Reporting__Share aShare = new Award_Reporting__Share();
                                        aShare.ParentId = i; //accIdtoAppId.get(conNametoAccId.get(u.contactId));
                                        aShare.userorgroupId = u.Id;
                                        aShare.AccessLevel = 'Edit';
                                        awshares.add(aShare); 
                                    }
                                  }   
                             }                      
                        }
                    }                   
                }
                if(awshares.size()>0){
                    insert awshares;
                }
                
                
            }
    }    
    
    public static void updateModule(List<Award_Reporting__c> arl)
{
    system.debug('in module');
    set<Id> awardIds = new set<Id>();
    for(Award_Reporting__c ar:arl){
        awardIds.add(ar.Award__c);
    } 
    List<Award__c> arList=[SELECT ID,NOFA_Name__r.CNCS_Corporate_Program__r.Module__c FROM Award__c WHERE id IN :awardIds];
    Map<ID,String> arMap=new Map<ID,String>();
    for(Award__c ar:arList)
    {
        if(ar.NOFA_Name__r.CNCS_Corporate_Program__r.Module__c != null)
        {
            arMap.put(ar.id,ar.NOFA_Name__r.CNCS_Corporate_Program__r.Module__c);
        }
    }
    for(Award_Reporting__c ar:arl)
    {
       ar.PM_Module__c=arMap.get(ar.Award__c);
      //  ar.PM_Module__c='vista';
    }
  /*  if(!arlist.isEmpty())
        update arlist; */
}
    


    
}