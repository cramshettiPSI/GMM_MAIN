/**
 * Trigger to handle events of Before(insert,update),After(insert,update,delete) events for the Requirement#812 
 * ======================================================================
 *          Date        Purpose
 * Created: 12/03/2015  Initial version.
 *                          - validates that application rank is unique with respect to NOFA
 *                          - validates application rank is in the valid range of Rank Limit
 *                          - updates  Nofa's field(Sub Application Count) with the number of children for that Nofa
 * Changes:  
 *          
 *          
 *          
 * ======================================================================
 **/


trigger PopulateChildRecordsCount on Application3__c(before insert, before update,after insert,after update, after delete) {
    System.debug('***PopulateChildRecordsCount ***');
    List<Application3__c> lstApp = new List<Application3__c>();
    Set<String> setNofaId=new Set<String>();
    Set<String> setPrmAppId=new Set<String>();///
    String prevNofaId;
    String prevPrmAppId;///
    Map<String,List<Application3__c>> mpNofaIdToApplication= new Map<String,List<Application3__c>>(); 
     Map<String,List<Application3__c>> mpPrmAppToApplication= new Map<String,List<Application3__c>>(); ///
    List<Application3__c> lstQryApprecs;
    List<Application3__c> lstAppRecsByNofaId = new List<Application3__c>();
    List<Application3__c> lstTempApp;
    Boolean alreadyRanked=false;
    Boolean flagRecursive=false;
    
    List<Application3__c> lstUpdApp=new List<Application3__c>();
    static boolean recFld=false;
    if(recFld==false){
    if (Trigger.isBefore && (Trigger.isInsert || Trigger.isUpdate )){
       //lstApp = Trigger.isInsert || Trigger.isUpdate  ? Trigger.new : Trigger.old;
       lstApp =  Trigger.new ;
       
       for(Application3__c objApp:lstApp){
            setNofaId.add(objApp.NOFA_RFP__c);
            if(objApp.Prime_Application__c!=null){
                setPrmAppId.add(objApp.Prime_Application__c); 
            }
            system.debug('objApp.Sub_Application__c'+objApp.Sub_Application__c);///
        }
        System.debug('***setPrmAppId***'+setPrmAppId);
        
        if(setPrmAppId != null && !setPrmAppId.isEmpty() && setPrmAppId.size()>0) {
            System.debug('***setPrmAppId***'+setPrmAppId);
            lstQryApprecs=[SELECT id,rank__c,rank_limit__c,nofa_rfp__c,Prime_Application__c
                           FROM Application3__c
                           WHERE    Prime_Application__c in :setPrmAppId 
                           Order By Prime_Application__c ]; ///nofa_rfp__c in :setNofaId];
                                              
            System.debug('***lstQryApprecs***'+lstQryApprecs);                                     
            if(lstQryApprecs!=null && lstQryApprecs.size()>0){
                prevNofaId= lstQryApprecs[0].nofa_rfp__c;   
                prevPrmAppId= lstQryApprecs[0].Prime_Application__c;                     
                
                for(Application3__c iterObjApp: lstQryApprecs){
                    if(iterObjApp.Prime_Application__c!=  prevPrmAppId){ 
                        System.debug('not equal prmapp');                                                  
                        mpPrmAppToApplication.put(prevPrmAppId,lstAppRecsByNofaId);                                           
                        lstAppRecsByNofaId = new List<Application3__c>();          
                    }
                    else{
                        System.debug(' equal prmapp'); 
                        lstAppRecsByNofaId.add(iterObjApp);
                        prevNofaId= iterObjApp.nofa_rfp__c;
                        prevPrmAppId=iterObjApp.Prime_Application__c;
                    }
                }
                mpPrmAppToApplication.put(prevPrmAppId,lstAppRecsByNofaId);
                System.debug(' *** mpPrmAppToApplication*** '+ mpPrmAppToApplication ); 
                //if(trigger.oldMap!=null){ 
                if(trigger.new!=null){             
                    for(Application3__c objIterApp: Trigger.new){
                        System.debug('iter');
                        lstTempApp=mpPrmAppToApplication.get(objIterApp.Prime_Application__c);
                        System.debug('from Map-Apps'+lstTempApp);
                        if(lstTempApp!=null && lstTempApp.size()>0){
                       // if(!flagRecursive){
                            for(Application3__c temp:lstTempApp){
                               // if(objIterApp.rank__c !=trigger.oldMap.get(objIterApp.id).rank__c){
                                     System.debug('condition');
                                     System.debug('temp.rank__c'+temp.rank__c);
                                     System.debug('objIterApp.rank__c'+objIterApp.rank__c);
                                     System.debug('***new Value***'+objIterApp.rank__c);
                                     //System.debug('***old Value***'+trigger.oldMap.get(objIterApp.id).rank__c);
                                     if((temp.Rank_Limit__c >= 1 && temp.Rank_Limit__c <= 12 && objIterApp.Rank__c > 5) ||
                                                    (temp.Rank_Limit__c >= 13 && temp.Rank_Limit__c <= 24 && objIterApp.Rank__c >10) ||
                                                    (temp.Rank_Limit__c >= 25 && objIterApp.Rank__c > 15)){
                                                    System.debug('**cv***');
                                                        objIterApp.rank__c.addError('Rank value should be in the valid Range of Rank Limit');
                                    }   
                                    if( objIterApp.rank__c!=null && objIterApp.id!=temp.id && objIterApp.rank__c == temp.rank__c){
                                        alreadyRanked=true;
                                        System.debug('***jamboree***');
                                        objIterApp.rank__c.addError('Rank already assigned, provide another rank not assigned');
                                    }
                               // }
                           } 
                         //  flagRecursive=true;
                         // }
                        }
                    }
                 }
               }
            }   
        }  //end of Before Insert, Before Update
    
    if (Trigger.isAfter && (Trigger.isInsert || Trigger.isUpdate || Trigger.isDelete )){
                   
            lstApp = Trigger.isInsert ? Trigger.new : Trigger.old;
            List<Id> lstChildRefIds = new List<Id>();
            for (Application3__c objApp : lstApp) {
                if(objApp.Prime_Application__c!=null){
                    lstChildRefIds.add(objApp.Prime_Application__c);
                }
            }
            
            if(lstChildRefIds!=null && lstChildRefIds.size()> 0 ){
                System.debug('*** lstChildRefIds ***'+ lstChildRefIds +'lstChildRefIds.size()'+lstChildRefIds.size());
            
                 List<Prime_Application__c>  lstPrmApp = [ SELECT id,Ready_for_Ranking__c,
                                                            (SELECT id,name,RecordType.Name,Rank_Limit__c FROM Applications__r),
                                                            Sub_Application_Count__c
                                                          FROM    Prime_Application__c
                                                            WHERE   id in :lstChildRefIds  ];
                                                            
               /* List<Prime_Application__c>  lstPrmApp = [ SELECT id,Ready_for_Ranking__c,
                                                            (SELECT id,name,RecordType.Name,Rank_Limit__c FROM Applications__r),
                                                            Sub_Application_Count__c
                                                          FROM    Prime_Application__c
                                                            WHERE   id in :lstChildRefIds and Ready_for_Ranking__c='Yes' ];  */                      
                  
                  
                    
                 
                    
                                          
                 if(lstPrmApp !=null && lstPrmApp.size() > 0) {
                    for (Prime_Application__c objPrmApp : lstPrmApp ) {
                        if(objPrmApp.Ready_for_Ranking__c !=null && objPrmApp.Ready_for_Ranking__c.equalsIgnoreCase('Yes')){
                          objPrmApp.Sub_Application_Count__c = objPrmApp.Applications__r.size();
                        }
                        objPrmApp.Sub_Application_Count_For_FAIN__c = objPrmApp.Applications__r.size();
                        System.debug('*** objPrmApp .Applications__r.size() ***'+objPrmApp .Applications__r.size());
                       /* for(Application3__c itrObjApp: objPrmApp.Applications__r){
                            itrObjApp.Rank_Limit__c=objPrmApp.Sub_Application_Count__c;
                            lstUpdApp.add(itrObjApp);
                        
                        }*/
                        
                    }
                    try{
                        if(lstPrmApp !=null && lstPrmApp.size()>0){
                            update lstPrmApp;
                        }
                    }catch(DMLException exc){
                        System.debug('DML Exception-trigger PopulateChildRecordsCount on Application3__c -lstPrmApp Update Exception ***'+exc.getMessage());
                    }
                    catch(Exception exc){
                        System.debug('trigger PopulateChildRecordsCount on Application3__c -lstPrmApp Update Exception ***'+exc.getMessage());
                    }
                  /*  try{
                        update lstUpdApp;
                    }catch(Exception exc){
                        System.debug('trigger PopulateChildRecordsCount on Application3__c -lstUpdApp Update Exception ***'+exc.getMessage());
                    } */
                }                            
            
          }
           
    }                 
    
 
    recFld=true;
    }                               
}