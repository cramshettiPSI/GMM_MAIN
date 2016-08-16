trigger BudgetApplicationTrg on cb3__Budget__c (Before insert, before update, after insert,after update) {
     String tempAppId;
     List<String> lstAppId=new List<String>();
     Map<String,String> mpBdgAppIdToAppId=new Map<String,String>();
     Map<String,String> mpAppIdToBdgAppId=new Map<String,String>();
     Set<String> stAppId =new Set<String>();
     String errAppId='';
     
     String errMsg='Cannot create Budget Applications more than the limit configured against respective NOFA';
     Boolean flag=false;
     
     if (Trigger.isBefore){
         if(Trigger.isInsert){
                  System.debug('***BudgetApplicationTrg- IsBefore, isInsert***');
                  System.debug('***BudgetApplicationTrg- IsBefore, isInsert***');
                  
                for (cb3__Budget__c  objTemp : Trigger.new) {
                    tempAppId =objTemp.Parent__c; 
                    System.debug('***tempAppId ***'+tempAppId );
                    System.debug('***tempAppId ***'+objTemp);
                    if(tempAppId!=null){ 
                         lstAppId.add(tempAppId); 
                         //stAppId.add(objTemp.id);
                         stAppId.add(tempAppId );
                         
                         mpBdgAppIdToAppId.put(objTemp.id,objTemp.parent__c);
                         
                    }    
                }
                //List<Application3__c> lstApp=[select id,name from Application3__c where id in :lstAppIds];
                //System.debug('***lstApp***');
                
                Integer lmt=0;
                System.debug('stAppId'+stAppId);
                List<Application3__c> lstAppForNofaLimit_BdgApp= [select id,name,NOFA_RFP__r.Budget_Application_Limit__c,(select id,name from Budget_Applications__r) from application3__c where id in :stAppId];  
                
                for(Application3__c objApp:lstAppForNofaLimit_BdgApp) {
                      if(objApp.NOFA_RFP__r!=null && objApp.NOFA_RFP__r.Budget_Application_Limit__c!=null){
                           lmt=Integer.valueof(objApp.NOFA_RFP__r.Budget_Application_Limit__c);
                      }
                      System.debug('objApp.NOFA_RFP__r.Budget_Application_Limit__c'+objApp.NOFA_RFP__r.Budget_Application_Limit__c); 
                      if(objApp.Budget_Applications__r!=null){
                         System.debug('objApp.Budget_Applications__r.size()'+objApp.Budget_Applications__r.size());  
                      }
                       
                      if(objApp.Budget_Applications__r!=null && lmt!=null && ( objApp.Budget_Applications__r.size() >= lmt && lmt !=0)){
                            System.debug('condition error');  
                            errAppId=objApp.id;
                            flag=true;
                            break;
                            //Trigger.addError('Cannot create Budget Applications more than the limit configured against respective NOFA');        
                      }
                     
                }
                  
                
                for (cb3__Budget__c  objTemp : Trigger.new) {
                  if(flag==true && errAppId.equals(objTemp.Parent__c)){
                     System.debug('error'); 
                    /* Application3__c objApp= new Application3__c();
                     objApp.id=objtemp.parent__c;
                     objApp.Display_Alert__c=true;
                     try{
                         update objApp;
                     }Catch(Exception exc){
                         System.debug('**err***');
                     }
                     */
                     objTemp.addError(errMsg);
                  }
                     break;
                }  
                  
                 
                 /* Map<Id, cb3__Budget__c > bdgMap 
                                = new Map<Id, cb3__Budget__c >([SELECT Id,
                                                                        Parent__r.NOFA_RFP__r.ConfiguredBudgetForms__c,Parent__r.NOFA_RFP__r.Budget_Application_Limit__c,
                                                                        Parent__r.NOFA_RFP__r.name
                                                                 FROM cb3__Budget__c  
                                                                 WHERE Id IN :Trigger.New]);
                                                    
                  System.debug('**bdgMap***'+bdgMap);  
                  
                  for (cb3__Budget__c  objTemp :Trigger.New)   {
                       System.debug('**objTemp.Parent__c ***'+objTemp.Parent__c ); 
                       System.debug('**objTemp.Parent__r.NOFA_RFP__r***'+objTemp.Parent__r ); 
                        System.debug('**objTemp.Parent__r.NOFA_RFP__r***'+objTemp.Parent__r.NOFA_RFP__c ); 
                      System.debug('***objTemp.Parent__r.NOFA_RFP__r.Budget_Application_Limit__c***'+ objTemp.Parent__r.NOFA_RFP__r.Budget_Application_Limit__c);
                  }
                  */
                  /*
                  for (cb3__Budget__c  objTemp : Trigger.new) {
                       tempAppId =objTemp.Parent__c; 
                       System.debug('***tempAppId ***'+tempAppId );
                       System.debug('***tempAppId ***'+objTemp);
                           if(tempAppId!=null){ 
                               lstAppIds.add(tempAppId); 
                           }    
                 }
                 List<Application3__c> lstApp=[select id,name from Application3__c where id in :lstAppIds];
                 System.debug('***lstApp***');
                 */
        }
     }
     
     //
    /*
     if (Trigger.isAfter){
         if (Trigger.isInsert || Trigger.isUpdate){
             AppSlotInformation objSlotInformation= new AppSlotInformation();
             objSlotInformation.spawnInformation(Trigger.old,Trigger.new,Trigger.oldMap,Trigger.newMap);
         
         }
     } 
    */
    
    if(trigger.isAfter){
     if(trigger.isUpdate || trigger.isInsert){
        set<Id> appIds = new set<Id>();
        for(cb3__Budget__c ba:trigger.new){
            if(ba.Parent__c != null){
                appIds.add(ba.Parent__c);   
            }
        }
        Id appRT = Schema.SObjectType.Application3__c.getRecordTypeInfosByName().get('Application').getRecordTypeId();
        list<Application3__c> apps = new list<Application3__c>([Select Id,Name,RecordTypeId,Application_Signed__c,Authorized_Representative__c,Certifications_Clicked__c,Assurances_Clicked__c from Application3__c where id in :appIds 
                                                                and RecordTypeId = :appRT]);
        if(apps.size()>0){ 
            for(Application3__c a: apps){
                if(a.Application_Signed__c){
                    a.Application_Signed__c = false;
                    a.Authorized_Representative__c = null;
                    a.Certifications_Clicked__c = false;
                    a.Assurances_Clicked__c = false;
                }   
            }             
            update apps;
        } 
     }
    }

}