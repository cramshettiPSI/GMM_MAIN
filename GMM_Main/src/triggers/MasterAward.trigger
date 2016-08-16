trigger MasterAward on Master_Award__c (after delete, after insert, after undelete, 
after update, before delete, before insert, before update) {
    
    if(trigger.isBefore){
        if(trigger.isInsert){
            System.debug('**Before Insert***');
            //MasterAwardHelperForCustomAutoNumber.manipulateAutoNumber(Trigger.new);
           // Integer i,tlen=trigger.new.size();
        
           String strAppMasterAwardRecTypeId=CNCS_ObjectUtility.getObjectRecordTypeId(Master_Award__c.SObjectType, 'App Master Award');
           String  strSubAppMasterAwardRecTypeId=CNCS_ObjectUtility.getObjectRecordTypeId(Master_Award__c.SObjectType, 'Sub App Master Award');
           String  strPrimeMasterAwardRecTypeId=CNCS_ObjectUtility.getObjectRecordTypeId(Master_Award__c.SObjectType, 'Prime Master Award');
           List<Master_Award__c> lstMasterAward =[SELECT id,name,Custom_Auto_Number__c,Prime_Application__r.NOFO_RFP__r.Fiscal_Yr__c,
                                                         Prime_Application__r.NOFO_RFP__r.CNCS_Corporate_Program__r.Short_Code__c,
                                                         Application__r.NOFA_RFP__r.Fiscal_Yr__c,
                                                         Application__r.NOFA_RFP__r.CNCS_Corporate_Program__r.Short_Code__c,Application__r.Project__r.State__c 
                                                  FROM   Master_Award__c];
           set<string> setCustomAutoNumber = new set<string>();
           for(Master_Award__c itrMasterAward :lstMasterAward ){
               setCustomAutoNumber.add(itrMasterAward.Custom_Auto_Number__c);
           }
           String strConcatedValue='';
            
           Set<Id> appIds=new Set<Id>();
           Set<Id> primeAppIds=new Set<Id>();
           for(Master_Award__c itrMasterAward: Trigger.new){
              if( itrMasterAward.Application__c!=null){
                appIds.add(itrMasterAward.Application__c);
              }
              if(itrMasterAward.Prime_Application__c!=null){
                primeAppIds.add(itrMasterAward.Prime_Application__c);
              }
           }
           System.debug('**appIds***'+appIds);
           System.debug('**primeAppIds***'+primeAppIds);
        
            MAP<ID,Application3__c> mpApps;
            if(appIds!=null && appIds.size()>0){                             
                mpApps= new MAP<id,Application3__c>([SELECT id,name,NOFA_RFP__r.Fiscal_Yr__c,NOFA_RFP__r.CNCS_Corporate_Program__r.Short_Code__c,Project__r.State__c,
                                                            Sub_App_Auto_Number__c,NOFA_RFP__r.Issuing_Officer__c
                                                     FROM Application3__c 
                                                     WHERE id in :appIds ]);
            }
            System.debug('**mpApps***'+mpApps ); 
            
            MAP<ID,Prime_Application__c> mpPrimeApps;
            if(primeAppIds!=null && primeAppIds.size()>0){  
                mpPrimeApps= new MAP<id,Prime_Application__c>([SELECT id,name,NOFO_RFP__r.Fiscal_Yr__c ,NOFO_RFP__r.CNCS_Corporate_Program__r.Short_Code__c,
                                                                       Project_Name__r.State__c,NOFO_RFP__r.Issuing_Officer__c
                                                     FROM Prime_Application__c
                                                     WHERE id in :primeAppIds]);
            
            
            }
            System.debug('**mpPrimeApps***'+mpPrimeApps); 
            
            Application3__c objApplication=new Application3__c();
            Prime_Application__c objPrime_Application=new Prime_Application__c();
            String strFiscalYr='';
            String strYearInTwoDigits='';
            String strCustomAutoNumber='';
            Boolean flagHQOfficeOfGrantsManagement=true;
            MAP<String,Integer> mapCodeValueForAppMasterAwardRecTypeWithHQ=new Map<String,Integer>();
            //mapCodeValueForAppMasterAwardRecType= MasterAwardHelperForCustomAutoNumber.processValueForCriteria(flagHQOfficeOfGrantsManagement);
            mapCodeValueForAppMasterAwardRecTypeWithHQ= MasterAwardHelperForCustomAutoNumber.processAggregateDataForAppMasterAwardRecType(flagHQOfficeOfGrantsManagement,strAppMasterAwardRecTypeId);
           // System.debug('***mapCodeValueForAppMasterAwardRecTypeWithHQ***'+mapCodeValueForAppMasterAwardRecTypeWithHQ);
            MAP<String,Integer> mapCodeValueForAppMasterAwardRecTypeWithOutHQ=new Map<String,Integer>();
            mapCodeValueForAppMasterAwardRecTypeWithOutHQ= MasterAwardHelperForCustomAutoNumber.processAggregateDataForAppMasterAwardRecType(!flagHQOfficeOfGrantsManagement,strAppMasterAwardRecTypeId);
           // System.debug('***mapCodeValueForAppMasterAwardRecTypeWithOutHQ***'+mapCodeValueForAppMasterAwardRecTypeWithOutHQ);
            
            MAP<String,Integer> mapCodeValueForSubAppMasterAwardRecTypeWithHQ=new Map<String,Integer>();
            mapCodeValueForSubAppMasterAwardRecTypeWithHQ= MasterAwardHelperForCustomAutoNumber.processAggregateDataForSubAppMasterAwardRecType(flagHQOfficeOfGrantsManagement,strSubAppMasterAwardRecTypeId);
           // System.debug('***mapCodeValueForSubAppMasterAwardRecTypeWithHQ***'+mapCodeValueForSubAppMasterAwardRecTypeWithHQ);
            MAP<String,Integer> mapCodeValueForSubAppMasterAwardRecTypeWithOutHQ=new Map<String,Integer>();
            mapCodeValueForSubAppMasterAwardRecTypeWithOutHQ= MasterAwardHelperForCustomAutoNumber.processAggregateDataForSubAppMasterAwardRecType(!flagHQOfficeOfGrantsManagement,strSubAppMasterAwardRecTypeId);
           // System.debug('***mapCodeValueForSubAppMasterAwardRecTypeWithOutHQ***'+mapCodeValueForSubAppMasterAwardRecTypeWithOutHQ);
            
            MAP<String,Integer> mapCodeValueForPrimeMasterAwardRecTypeWithHQ=new Map<String,Integer>();
            mapCodeValueForPrimeMasterAwardRecTypeWithHQ= MasterAwardHelperForCustomAutoNumber.processAggregateDataForPrimeMasterAwardRecType(flagHQOfficeOfGrantsManagement,strPrimeMasterAwardRecTypeId);
          //  System.debug('***mapCodeValueForPrimeMasterAwardRecTypeWithHQ***'+mapCodeValueForPrimeMasterAwardRecTypeWithHQ);
            MAP<String,Integer> mapCodeValueForPrimeMasterAwardRecTypeWithOutHQ=new Map<String,Integer>();
            mapCodeValueForPrimeMasterAwardRecTypeWithOutHQ= MasterAwardHelperForCustomAutoNumber.processAggregateDataForPrimeMasterAwardRecType(!flagHQOfficeOfGrantsManagement,strPrimeMasterAwardRecTypeId);
          //  System.debug('***mapCodeValueForPrimeMasterAwardRecType***'+mapCodeValueForPrimeMasterAwardRecTypeWithOutHQ);
            
            String strMapValue='';
            
            for(Master_Award__c itrMasterAward: Trigger.new){
                  String currRecordTypeId=itrMasterAward.recordtypeid;
                  System.debug('**currRecordTypeId***'+currRecordTypeId);  
                  System.debug('**itrMasterAward.Application__c***'+itrMasterAward.Application__c);  
                  if( currRecordTypeId!=null && currRecordTypeId.equals(strAppMasterAwardRecTypeId)){
                       if(itrMasterAward.Prime_Application__c!=null){
                          objPrime_Application=(Prime_Application__c)(mpPrimeApps.get(itrMasterAward.Prime_Application__c));
                          System.debug('***objPrime_Application***'+objPrime_Application);
                       }
                      if(itrMasterAward.Application__c!=null){
                          if(itrMasterAward.Prime_Application__c!=null){
                              objPrime_Application=(Prime_Application__c)(mpPrimeApps.get(itrMasterAward.Prime_Application__c));
                              System.debug('***objPrime_Application***'+objPrime_Application);
                          }
                          objApplication =(Application3__c)(mpApps.get(itrMasterAward.Application__c));
                          System.debug('***objApplication***'+objApplication);
                          //Application__r.NOFA_RFP__r.Issuing_Officer__c, "HQ(Office of Grants Management)"
                          String strIssuingOfficer=objApplication.NOFA_RFP__r.Issuing_Officer__c;
                          //flagHQOfficeOfGrantsManagement=true;
                          flagHQOfficeOfGrantsManagement=(strIssuingOfficer!=null && strIssuingOfficer.equals('HQ(Office of Grants Management)') ) ? true  : false;
                          if(flagHQOfficeOfGrantsManagement){
                              //strCustomAutoNumber = MasterAwardHelperForCustomAutoNumber.processForAppMasterAwardRecType(itrMasterAward,objApplication,mapCodeValueForAppMasterAwardRecType,flagHQOfficeOfGrantsManagement);
                              strCustomAutoNumber = MasterAwardHelperForCustomAutoNumber.processForAppAndSubAppMasterAwardRecType(itrMasterAward,objApplication,objPrime_Application,mapCodeValueForAppMasterAwardRecTypeWithHQ,strAppMasterAwardRecTypeId,strSubAppMasterAwardRecTypeId,strPrimeMasterAwardRecTypeId,flagHQOfficeOfGrantsManagement);                       
                          }
                          else{
                              //strCustomAutoNumber = MasterAwardHelperForCustomAutoNumber.processForAppMasterAwardRecType(itrMasterAward,objApplication,mapCodeValueForAppMasterAwardRecType,(!flagHQOfficeOfGrantsManagement));
                             strCustomAutoNumber = MasterAwardHelperForCustomAutoNumber.processForAppAndSubAppMasterAwardRecType(itrMasterAward,objApplication,objPrime_Application,mapCodeValueForAppMasterAwardRecTypeWithOutHQ,strAppMasterAwardRecTypeId,strSubAppMasterAwardRecTypeId,strPrimeMasterAwardRecTypeId,(!flagHQOfficeOfGrantsManagement));
                          }
                      }
                  }
                  else if (currRecordTypeId !=null && currRecordTypeId.equals(strSubAppMasterAwardRecTypeId)){
                         if(itrMasterAward.Prime_Application__c!=null){
                              objPrime_Application=(Prime_Application__c)(mpPrimeApps.get(itrMasterAward.Prime_Application__c));
                              System.debug('***objPrime_Application***'+objPrime_Application);
                         }
                         if(itrMasterAward.Application__c!=null){
                              objApplication =(Application3__c)(mpApps.get(itrMasterAward.Application__c));
                              System.debug('***objApplication***'+objApplication);
                              String strIssuingOfficer=objApplication.NOFA_RFP__r.Issuing_Officer__c;
                              flagHQOfficeOfGrantsManagement=(strIssuingOfficer!=null && strIssuingOfficer.equals('HQ(Office of Grants Management)') ) ? true  : false;
                              if(flagHQOfficeOfGrantsManagement){
                                  //strCustomAutoNumber = MasterAwardHelperForCustomAutoNumber.processForAppMasterAwardRecType(itrMasterAward,objApplication,mapCodeValueForSubAppMasterAwardRecType,flagHQOfficeOfGrantsManagement);
                                 strCustomAutoNumber = MasterAwardHelperForCustomAutoNumber.processForAppAndSubAppMasterAwardRecType(itrMasterAward,objApplication,objPrime_Application,mapCodeValueForSubAppMasterAwardRecTypeWithHQ,strAppMasterAwardRecTypeId,strSubAppMasterAwardRecTypeId,strPrimeMasterAwardRecTypeId,flagHQOfficeOfGrantsManagement);
                              }
                              else{
                                 strCustomAutoNumber = MasterAwardHelperForCustomAutoNumber.processForAppAndSubAppMasterAwardRecType(itrMasterAward,objApplication,objPrime_Application,mapCodeValueForSubAppMasterAwardRecTypeWithOutHQ,strAppMasterAwardRecTypeId,strSubAppMasterAwardRecTypeId,strPrimeMasterAwardRecTypeId,(!flagHQOfficeOfGrantsManagement));
                              }
                         }
                  }
                  else if (currRecordTypeId !=null && currRecordTypeId.equals(strPrimeMasterAwardRecTypeId)){
                       if(itrMasterAward.Application__c!=null){
                              objApplication =(Application3__c)(mpApps.get(itrMasterAward.Application__c));
                              System.debug('***objApplication***'+objApplication);
                       }
                       if(itrMasterAward.Prime_Application__c!=null){
                          objPrime_Application=(Prime_Application__c)(mpPrimeApps.get(itrMasterAward.Prime_Application__c));
                          System.debug('***objPrime_Application***'+objPrime_Application);
                          String strIssuingOfficer=objPrime_Application.NOFO_RFP__r.Issuing_Officer__c;
                          flagHQOfficeOfGrantsManagement=(strIssuingOfficer!=null && strIssuingOfficer.equals('HQ(Office of Grants Management)') ) ? true  : false;
                          if(flagHQOfficeOfGrantsManagement){
                                 strCustomAutoNumber = MasterAwardHelperForCustomAutoNumber.processForAppAndSubAppMasterAwardRecType(itrMasterAward,objApplication,objPrime_Application,mapCodeValueForPrimeMasterAwardRecTypeWithHQ,strAppMasterAwardRecTypeId,strSubAppMasterAwardRecTypeId,strPrimeMasterAwardRecTypeId,flagHQOfficeOfGrantsManagement);
                          }
                          else{
                                 strCustomAutoNumber = MasterAwardHelperForCustomAutoNumber.processForAppAndSubAppMasterAwardRecType(itrMasterAward,objApplication,objPrime_Application,mapCodeValueForPrimeMasterAwardRecTypeWithOutHQ,strAppMasterAwardRecTypeId,strSubAppMasterAwardRecTypeId,strPrimeMasterAwardRecTypeId,(!flagHQOfficeOfGrantsManagement));
                          }
                       }
                  }
                  
                  System.debug('***strCustomAutoNumber***'+strCustomAutoNumber);
                  itrMasterAward.Custom_Auto_Number__c=strCustomAutoNumber;
                  
                  
                  
                /*   if(itrMasterAward.Application__c!=null){
                       objApplication =(Application3__c)(mpApps.get(itrMasterAward.Application__c));
                       System.debug('***objApplication***'+objApplication);
                       System.debug('***objApplication.NOFA_RFP__r.Fiscal_Yr__c***'+objApplication.NOFA_RFP__r.Fiscal_Yr__c);
                       strConcatedValue='';
                       strFiscalYr = objApplication.NOFA_RFP__r.Fiscal_Yr__c;
                       strYearInTwoDigits = (strFiscalYr !=null && strFiscalYr .length()>0)?strFiscalYr.right(2):'';
                       strConcatedValue=strYearInTwoDigits +objApplication.NOFA_RFP__r.CNCS_Corporate_Program__r.Short_Code__c+'H'+objApplication.Project__r.State__c;
                       System.debug('***strConcatedValue***'+strConcatedValue);
                      
                       if (mapCodevalue==null){
                            System.debug('***mapCodevalue==null***');
                            strCustomAutoNumber='001';
                       }
                       else if(mapCodevalue!=null && mapCodevalue.size() >0 && !mapCodevalue.containsKey(strConcatedValue)){
                           System.debug('***mapCodevalue!=null && mapCodevalue.size() >0 && !mapCodevalue.containsKey(strConcatedValue)***');
                           strCustomAutoNumber='001';
                       }
                       else if (mapCodevalue!=null && mapCodevalue.size() > 0  && mapCodevalue.containsKey(strConcatedValue)){
                                
                                    Integer temp_local=mapCodevalue.get(strConcatedValue); 
                                    System.debug('***temp_local***'+temp_local); 
                                    System.debug('***mapCodevalue!=null && mapCodevalue.size() > 0  && mapCodevalue.containsKey(strConcatedValue)***');
                                    temp_local++;
                                    if(temp_local >=0 && temp_local<=9){
                                             strCustomAutoNumber='00'+temp_local;
                                    }else if(temp_local >=10 && temp_local<=99){
                                            strCustomAutoNumber='0'+temp_local;
                                    }else{
                                        strCustomAutoNumber=String.valueOf(temp_local);
                                    }
                               
                       }
                       System.debug('***strCustomAutoNumber***'+strCustomAutoNumber);
                       itrMasterAward.Custom_Auto_Number__c=strCustomAutoNumber;
                   } */
            }                     
       }
    }
    
    if(trigger.isAfter){
        /*if(trigger.isInsert || trigger.isUpdate){
            MasterAwardHelper.shareMasterAwardWithStateCommission(trigger.new);
        }*/
       if(trigger.isInsert){
            MasterAwardHelper.shareMasterAwards(trigger.new);
        }
    }

}