Public class MasterAwardHelperForCustomAutoNumber{
    
    public static void manipulateAutoNumber(List<Master_Award__c> lstNewMasterAwardRecs){
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
         for(Master_Award__c itrMasterAward: lstNewMasterAwardRecs){
                appIds.add(itrMasterAward.Application__c);
         }
         System.debug('**appIds***'+appIds);
         List<Application3__c> lstApps=[SELECT id,name,NOFA_RFP__r.Fiscal_Yr__c,NOFA_RFP__r.CNCS_Corporate_Program__r.Short_Code__c,Project__r.State__c,Sub_App_Auto_Number__c 
                                        FROM Application3__c 
                                        WHERE id in :appIds];
         System.debug('**lstApps***'+lstApps);
         
         MAP<ID,Application3__c> mpApps;
         if(lstApps!=null && lstApps.size()>0){                             
            mpApps= new MAP<id,Application3__c>([SELECT id,name,NOFA_RFP__r.Fiscal_Yr__c,NOFA_RFP__r.CNCS_Corporate_Program__r.Short_Code__c,Project__r.State__c,Sub_App_Auto_Number__c
                                                 FROM Application3__c 
                                                 WHERE id in :appIds ]);
         }
         System.debug('**mpApps***'+mpApps ); 
         Application3__c objApplication=new Application3__c();
         String strFiscalYr='';
         String strYearInTwoDigits='';
         String strCustomAutoNumber='';  
         
         MAP<String,Integer> mapCodevalue=new Map<String,Integer>();
       //  mapCodevalue= processValueForCriteria(true);
         System.debug('***mapCodevalue***'+mapCodevalue);
         String strMapValue='';
         
         for(Master_Award__c itrMasterAward: lstNewMasterAwardRecs){
                   System.debug('**itrMasterAward.Application__c***'+itrMasterAward.Application__c);  
                   if(itrMasterAward.Application__c!=null){
                       objApplication =(Application3__c)(mpApps.get(itrMasterAward.Application__c));
                      /// System.debug('***objApplication***'+objApplication);
                      /// System.debug('***objApplication.NOFA_RFP__r.Fiscal_Yr__c***'+objApplication.NOFA_RFP__r.Fiscal_Yr__c);
                       strConcatedValue='';
                       strFiscalYr = objApplication.NOFA_RFP__r.Fiscal_Yr__c;
                       strYearInTwoDigits = (strFiscalYr !=null && strFiscalYr .length()>0)?strFiscalYr.right(2):'';
                       strConcatedValue=strYearInTwoDigits +objApplication.NOFA_RFP__r.CNCS_Corporate_Program__r.Short_Code__c+'H'+objApplication.Project__r.State__c;
                      /// System.debug('***strConcatedValue***'+strConcatedValue);
                      
                       if(setCustomAutoNumber==null){
                           strCustomAutoNumber='001';
                       }
                       else if(setCustomAutoNumber!=null && setCustomAutoNumber.size()>0 && !setCustomAutoNumber.contains(strConcatedValue)){
                           strCustomAutoNumber='001';
                       }
                       else if (mapCodevalue!=null && mapCodevalue.size() > 0 ){
                                if(mapCodevalue.containsKey(strConcatedValue)){
                                    Integer temp_local=mapCodevalue.get(strConcatedValue); 
                                   /// System.debug('***temp_local***'+temp_local); 
                                    temp_local++;
                                    if(temp_local >=0 && temp_local<=9){
                                             strCustomAutoNumber='00'+temp_local;
                                    }else if(temp_local >=10 && temp_local<=99){
                                            strCustomAutoNumber='0'+temp_local;
                                    }else{
                                        strCustomAutoNumber=String.valueOf(temp_local);
                                    }
                                    
                                }
                       }
                       System.debug('***strCustomAutoNumber***'+strCustomAutoNumber);
                   }
         }                                        
    
    }
    
    public static MAP<String,Integer> processAggregateDataForAppMasterAwardRecType(Boolean flagGrantsOffice,String strAppMasterAwardRecTypeId){
         
         AggregateResult[] groupedResults;
    
         if(flagGrantsOffice){
                 groupedResults =[SELECT count(Custom_Auto_Number__c),Application__r.NOFA_RFP__r.Fiscal_Yr__c fy,
                                                   Application__r.NOFA_RFP__r.CNCS_Corporate_Program__r.Short_Code__c sc,
                                                   Application__r.Project__r.State__c  st
                                  FROM   Master_Award__c 
                                  WHERE  Application__r.NOFA_RFP__r.Issuing_Officer__c='HQ(Office of Grants Management)'
                                         and recordtypeid= :strAppMasterAwardRecTypeId
                                  GROUP BY Application__r.NOFA_RFP__r.Fiscal_Yr__c,
                                           Application__r.NOFA_RFP__r.CNCS_Corporate_Program__r.Short_Code__c,
                                           Application__r.Project__r.State__c 
                                  ];
           }else{
               groupedResults =[SELECT count(Custom_Auto_Number__c),Application__r.NOFA_RFP__r.Fiscal_Yr__c fy,
                                                   Application__r.NOFA_RFP__r.CNCS_Corporate_Program__r.Short_Code__c sc,
                                                   Application__r.Project__r.State__c  st,
                                                   Dummy_State_CLR_Code__c clrCode
                                FROM   Master_Award__c 
                                WHERE  Application__r.NOFA_RFP__r.Issuing_Officer__c!='HQ(Office of Grants Management)'
                                        and recordtypeid= :strAppMasterAwardRecTypeId
                                GROUP BY Application__r.NOFA_RFP__r.Fiscal_Yr__c,
                                         Application__r.NOFA_RFP__r.CNCS_Corporate_Program__r.Short_Code__c,
                                         Dummy_State_CLR_Code__c,
                                         Application__r.Project__r.State__c
                                  ];
           
           }                       
                                            
                                            
         MAP<String,Integer> mapCodevalue=new Map<String,Integer>();
         String strFiscalYr='' ;
         String  strYearInTwoDigits='';                                   
                                            
         for (AggregateResult ar : groupedResults)  {
          ///  System.debug('count' + ar.get('expr0'));
            strFiscalYr =((String)ar.get('fy'));
            strYearInTwoDigits = (strFiscalYr !=null && strFiscalYr .length()>0)?strFiscalYr.right(2):'';
          ///  System.debug('Fiscal Yr' + ar.get('fy'));
          ///  System.debug('Short Code' + ar.get('sc'));
         ///   System.debug('State' + ar.get('st'));
            //String code=(String)ar.get('expr1');
           // mapCodevalue.put(((String)ar.get('fy'))+((String)ar.get('sc'))+'H'+((String)ar.get('st')),((Integer)ar.get('expr0')));
           if(flagGrantsOffice){
                 mapCodevalue.put(strYearInTwoDigits +((String)ar.get('sc'))+'H'+((String)ar.get('st')),((Integer)ar.get('expr0')));
           }else{
                mapCodevalue.put(strYearInTwoDigits +((String)ar.get('sc'))+((String)ar.get('clrCode'))+((String)ar.get('st')),((Integer)ar.get('expr0')));
           }      

         }
         return mapCodevalue;
    }
    
     public static MAP<String,Integer> processAggregateDataForSubAppMasterAwardRecType(Boolean flagGrantsOffice, String strSubAppMasterAwardRecTypeId){
         
         AggregateResult[] groupedResults;
    
         if(flagGrantsOffice){
                 groupedResults =[SELECT count(Custom_Auto_Number__c),Application__r.NOFA_RFP__r.Fiscal_Yr__c fy,
                                                                      Application__r.Project__r.State__c  st
                                  FROM   Master_Award__c 
                                  WHERE  Application__r.NOFA_RFP__r.Issuing_Officer__c='HQ(Office of Grants Management)' 
                                         and recordtypeid= :strSubAppMasterAwardRecTypeId
                                  GROUP BY Application__r.NOFA_RFP__r.Fiscal_Yr__c,
                                           Application__r.Project__r.State__c
                                           
                                  ];
           }else{
               groupedResults =[SELECT count(Custom_Auto_Number__c),Application__r.NOFA_RFP__r.Fiscal_Yr__c fy,
                                                   Application__r.Project__r.State__c  st,
                                                   Dummy_State_CLR_Code__c clrCode
                                FROM   Master_Award__c 
                                WHERE  Application__r.NOFA_RFP__r.Issuing_Officer__c!='HQ(Office of Grants Management)'
                                       and recordtypeid= :strSubAppMasterAwardRecTypeId
                                GROUP BY Application__r.NOFA_RFP__r.Fiscal_Yr__c,
                                         Application__r.Project__r.State__c,
                                         Dummy_State_CLR_Code__c 
                                         
                                ];
           }                       
                                            
                                            
         MAP<String,Integer> mapCodevalue=new Map<String,Integer>();
         String strFiscalYr='' ;
         String  strYearInTwoDigits='';                                   
                                            
         for (AggregateResult ar : groupedResults)  {
           /// System.debug('count' + ar.get('expr0'));
            strFiscalYr =((String)ar.get('fy'));
            strYearInTwoDigits = (strFiscalYr !=null && strFiscalYr .length()>0)?strFiscalYr.right(2):'';
          ///  System.debug('Fiscal Yr' + ar.get('fy'));
          //  System.debug('Short Code' + ar.get('sc'));
            ///System.debug('State' + ar.get('st'));
            //String code=(String)ar.get('expr1');
           // mapCodevalue.put(((String)ar.get('fy'))+((String)ar.get('sc'))+'H'+((String)ar.get('st')),((Integer)ar.get('expr0')));
           if(flagGrantsOffice){
                 mapCodevalue.put(strYearInTwoDigits +'AC'+'H'+((String)ar.get('st')),((Integer)ar.get('expr0')));
           }else{
                mapCodevalue.put(strYearInTwoDigits +'AC'+((String)ar.get('clrCode'))+((String)ar.get('st')),((Integer)ar.get('expr0')));
           }      

         }
         return mapCodevalue;
    }
    
    public static MAP<String,Integer> processAggregateDataForPrimeMasterAwardRecType(Boolean flagGrantsOffice, String strPrimeMasterAwardRecTypeId){
         
         AggregateResult[] groupedResults;
    
         if(flagGrantsOffice){
                 groupedResults =[SELECT count(Custom_Auto_Number__c),Prime_Application__r.NOFO_RFP__r.Fiscal_Yr__c  fy,
                                                                      Prime_Application__r.Project_Name__r.State__c  st
                                  FROM   Master_Award__c 
                                  WHERE  Prime_Application__r.NOFO_RFP__r.Issuing_Officer__c='HQ(Office of Grants Management)' 
                                         and recordtypeid= :strPrimeMasterAwardRecTypeId
                                  GROUP BY Prime_Application__r.NOFO_RFP__r.Fiscal_Yr__c,
                                           Prime_Application__r.Project_Name__r.State__c
                                           
                                  ];
           }else{
               groupedResults =[SELECT count(Custom_Auto_Number__c),Prime_Application__r.NOFO_RFP__r.Fiscal_Yr__c  fy,
                                                   Prime_Application__r.Project_Name__r.State__c  st,
                                                   Dummy_State_CLR_Code__c clrCode
                                FROM   Master_Award__c 
                                WHERE  Prime_Application__r.NOFO_RFP__r.Issuing_Officer__c!='HQ(Office of Grants Management)'
                                       and recordtypeid= :strPrimeMasterAwardRecTypeId
                                GROUP BY Prime_Application__r.NOFO_RFP__r.Fiscal_Yr__c ,
                                         Dummy_State_CLR_Code__c,
                                         Prime_Application__r.Project_Name__r.State__c
                               ];
           }                       
                                            
                                            
         MAP<String,Integer> mapCodevalue=new Map<String,Integer>();
         String strFiscalYr='' ;
         String  strYearInTwoDigits='';                                   
                                            
         for (AggregateResult ar : groupedResults)  {
           /// System.debug('count' + ar.get('expr0'));
            strFiscalYr =((String)ar.get('fy'));
            strYearInTwoDigits = (strFiscalYr !=null && strFiscalYr .length()>0)?strFiscalYr.right(2):'';
          ///  System.debug('Fiscal Yr' + ar.get('fy'));
            //System.debug('Short Code' + ar.get('sc'));
          ///  System.debug('State' + ar.get('st'));
            //String code=(String)ar.get('expr1');
           // mapCodevalue.put(((String)ar.get('fy'))+((String)ar.get('sc'))+'H'+((String)ar.get('st')),((Integer)ar.get('expr0')));
           if(flagGrantsOffice){
                 mapCodevalue.put(strYearInTwoDigits +'AC'+'H'+((String)ar.get('st')),((Integer)ar.get('expr0')));
           }else{
                mapCodevalue.put(strYearInTwoDigits +'AC'+((String)ar.get('clrCode'))+((String)ar.get('st')),((Integer)ar.get('expr0')));
           }      

         }
         return mapCodevalue;
    }
    
    public static String processForAppAndSubAppMasterAwardRecType(Master_Award__c  itrMasterAward,Application3__c objApplication,Prime_Application__c objPrime_Application,
                                                                            MAP<String,Integer> mapCodevalue,String strAppMasterAwardRecTypeId,
                                                                            String strSubAppMasterAwardRecTypeId,String  strPrimeMasterAwardRecTypeId,
                                                                            Boolean flagHQOfficeOfGrantsManagement){
            String strConcatedValue='';
            String strFiscalYr ='';
            String strYearInTwoDigits ='';
            String strCustomAutoNumber='';
          ///  System.debug('**itrMasterAward.Application__c***'+itrMasterAward.Application__c);  
            //if(itrMasterAward.Application__c!=null){
               //objApplication =(Application3__c)(mpApps.get(itrMasterAward.Application__c));
           ///    System.debug('***objApplication***'+objApplication);
          ///     System.debug('***objApplication.NOFA_RFP__r.Fiscal_Yr__c***'+objApplication.NOFA_RFP__r.Fiscal_Yr__c);
               strConcatedValue='';
               strFiscalYr = objApplication.NOFA_RFP__r.Fiscal_Yr__c;
               strYearInTwoDigits = (strFiscalYr !=null && strFiscalYr.length()>0)?strFiscalYr.right(2):'';
               String currRecordTypeId=itrMasterAward.recordtypeid;
          ///     System.debug('**currRecordTypeId***'+currRecordTypeId);  
               
               if(currRecordTypeId.equals(strAppMasterAwardRecTypeId)){
                   if(flagHQOfficeOfGrantsManagement){
                       strConcatedValue=strYearInTwoDigits +objApplication.NOFA_RFP__r.CNCS_Corporate_Program__r.Short_Code__c+'H'+objApplication.Project__r.State__c;               
                   }
                   else{
                       strConcatedValue=strYearInTwoDigits +objApplication.NOFA_RFP__r.CNCS_Corporate_Program__r.Short_Code__c+itrMasterAward.Dummy_State_CLR_Code__c+objApplication.Project__r.State__c;
                   }
               }
               else if(currRecordTypeId.equals(strSubAppMasterAwardRecTypeId)){
                   if(flagHQOfficeOfGrantsManagement){
                       strConcatedValue=strYearInTwoDigits +'AC'+'H'+objApplication.Project__r.State__c;               
                   }
                   else{
                       strConcatedValue=strYearInTwoDigits +'AC'+itrMasterAward.Dummy_State_CLR_Code__c+objApplication.Project__r.State__c;
                   }
               
               }
               else if(currRecordTypeId.equals(strPrimeMasterAwardRecTypeId)){
                   if(flagHQOfficeOfGrantsManagement){
                       strConcatedValue=strYearInTwoDigits +'AC'+'H'+objPrime_Application.Project_Name__r.State__c;               
                   }
                   else{
                       strConcatedValue=strYearInTwoDigits +'AC'+itrMasterAward.Dummy_State_CLR_Code__c+objPrime_Application.Project_Name__r.State__c;
                   }
               
               }
               System.debug('***strConcatedValue***'+strConcatedValue);
              
               if (mapCodevalue==null){
                   /// System.debug('***mapCodevalue==null***');
                    strCustomAutoNumber='001';
               }
               else if(mapCodevalue!=null && mapCodevalue.size() >0 && !mapCodevalue.containsKey(strConcatedValue)){
                ///   System.debug('***mapCodevalue!=null && mapCodevalue.size() >0 && !mapCodevalue.containsKey(strConcatedValue)***');
                   strCustomAutoNumber='001';
               }
               else if (mapCodevalue!=null && mapCodevalue.size() > 0  && mapCodevalue.containsKey(strConcatedValue)){
                           Integer temp_local=mapCodevalue.get(strConcatedValue); 
                       ///   System.debug('***temp_local***'+temp_local); 
                      ///     System.debug('***mapCodevalue!=null && mapCodevalue.size() > 0  && mapCodevalue.containsKey(strConcatedValue)***');
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
           //}
         return strCustomAutoNumber;
    
    }
    
    public class FiscalYearShortCodeState{
       String fYSCSTValue;
       String maxValue;
       
       public FiscalYearShortCodeState(){
           fYSCSTValue='';
           maxValue='';
       }
    }
    
    
    

}