public class FFRForAwardReportingCntrl{

    public ApexPages.StandardController stdcontroller;
    public Award_Reporting__c objAward_Reporting{get;set;}
    public String strAwardName{get;set;}
    public String recRecordTypeId;
    
    public FFRForAwardReportingCntrl(ApexPages.StandardController p_controller){
        this.stdcontroller= p_controller;
        stdcontroller.addFields(new List<String>{'name','FAIN__c','RecordTypeId'});
        this.objAward_Reporting= (Award_Reporting__c )stdController.getrecord();
        strAwardName=objAward_Reporting.FAIN__c;
        recRecordTypeId=objAward_Reporting.RecordTypeId;
        System.debug('***objAward_Reporting***'+objAward_Reporting);
   }
   
   public PageReference invokeFFRData(){
       
       HttpResponse hResp;
       String json='';
       String strWSname='ffrData';
       String  endPointuri='';
       String  uName='';
       String  upassword='';
       String  httpMethodName='';
       String  contenttype='';
          
       CNCS_AuthorizeHttp objCNCS_AuthorizeHttp=new CNCS_AuthorizeHttp();
       try{
            String ffrRecordTypeId=CNCS_ObjectUtility.getObjectRecordTypeId( Award_Reporting__c.SObjectType,'Federal Financial Reports');
            System.debug('***ffrRecordTypeId***'+ffrRecordTypeId);
            //CNCS_ObjectUtility.getObjectRecordTypeId(Award__c.SObjectType,'App Award');
            
            if(recRecordTypeId!=null && ffrRecordTypeId!=null && recRecordTypeId.equals(ffrRecordTypeId)){
                System.debug('*** recordTypeIds matching***');
            
                Intgr_MuleSoft__c objIntgr_MuleSoft=CNCS_ObjectUtility.retrieveWSDetails(strWSname);
                System.debug(objIntgr_MuleSoft);
                if(objIntgr_MuleSoft==null){
                        ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'Configuration for Web Service Grant Closeout is not setUp'));
                        throw new RecordTypeException();
                }
                endPointuri=objIntgr_MuleSoft.endPointuri__c;
                uName=objIntgr_MuleSoft.uName__c;
                upassword=objIntgr_MuleSoft.upassword__c;
                httpMethodName=objIntgr_MuleSoft.httpMethodName__c;
                contenttype=objIntgr_MuleSoft.contenttype__c;
                String strBody=composeBodyForFFRData();
                System.debug('endPointuri'+endPointuri+''+'httpMethodName'+httpMethodName+'uName'+uName+'upassword'+upassword+'contenttype'+contenttype);
                
                hResp=objCNCS_AuthorizeHttp.wsConnectAndSend(endPointuri,uName,upassword,httpMethodName,contenttype,strBody,false);
                System.debug('***hResp***'+hResp);
                if(hResp!=null && hResp.getStatusCode()!=200){
                         throw new CNCS_ObjectUtility.CustomException('Status-->'+hResp.getStatus()+' StatusCode-->'+hResp.getStatusCode()+'  Message-->'+hResp.getBody().replace('\n', ''));
                }
                // the service is returning a line feed so parse it out
                json = hResp.getBody().replace('\n', '');
                System.debug('***json***'+json );
                
                ParseJSONUtil objParseJSONUtil= new ParseJSONUtil();
                ParseJSONUtil.FFRDataForGrantIdJSON    objFFRDataForGrantIdJSON= new ParseJSONUtil.FFRDataForGrantIdJSON();
                objFFRDataForGrantIdJSON= objParseJSONUtil.parseFFRDataForGrantIdJSON(json);
                System.debug('***objFFRDataForGrantIdJSON'+objFFRDataForGrantIdJSON);
                List<ParseJSONUtil.FFRDataForGrantId> lstFFRDataForGrantId=objFFRDataForGrantIdJSON.lstData;
                System.debug('***lstFFRDataForGrantId'+lstFFRDataForGrantId);
                updateMomentumDataForFFRAwardReporting(lstFFRDataForGrantId);
            }    
           }catch(System.CalloutException ce) {
              System.debug('Callout error: '+ ce);
              ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,ce.getMessage()));
              //System.debug(resp.toString());
         }catch(CNCS_ObjectUtility.CustomException custExc) {
                  System.debug('Custom Exception '+ custExc);
                  ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,custExc.getMessage()));
         }
         catch(System.DmlException de) {
              System.debug('Callout error: '+ de);
              ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,de.getMessage()));
         }
         catch(Exception exc){
            System.debug('***exc***'+exc.getMessage());
         }
         return null;
   }
   
   public String composeBodyForFFRData(){
       //strAwardName='15CAHOR001';
       String strBody ='{ "grant_id":'+'"'+ strAwardName+'" }';
       return strBody;
   
   }
   
   public void updateMomentumDataForFFRAwardReporting(List<ParseJSONUtil.FFRDataForGrantId> lstFFRDataForGrantId){
       List<Award_Reporting__c> lstAward_Reporting =new List<Award_Reporting__c>();
       Award_Reporting__c objTempAward_Reporting;
       for( ParseJSONUtil.FFRDataForGrantId objFFRDataForGrantId :lstFFRDataForGrantId){
          objTempAward_Reporting=new Award_Reporting__c();
          /*
          objTempAward_Reporting.id=objAward_Reporting.id;
          objTempAward_Reporting.Balance_Undrawn__c =(objFFRDataForGrantId.BALANCE_UNDRAWN_AMT!=null && objFFRDataForGrantId.BALANCE_UNDRAWN_AMT!='')? Double.valueOf(objFFRDataForGrantId.BALANCE_UNDRAWN_AMT):0;
          objTempAward_Reporting.Balance_of_Expenditures__c =(objFFRDataForGrantId.BALANCE_UNEXPENDED_AMT!=null & objFFRDataForGrantId.BALANCE_UNEXPENDED_AMT!='')?Double.valueOf(objFFRDataForGrantId.BALANCE_UNEXPENDED_AMT):0; 
          objTempAward_Reporting.Disbursed_Amount__c =(objFFRDataForGrantId.DISBURSED_AMT!=null && objFFRDataForGrantId.DISBURSED_AMT!='')?Double.valueOf(objFFRDataForGrantId.DISBURSED_AMT):0 ;
          objTempAward_Reporting.Authorized_Amount__c =(objFFRDataForGrantId.FED_EXPENDITURES_AMT!=null && objFFRDataForGrantId.FED_EXPENDITURES_AMT!='')?Double.valueOf(objFFRDataForGrantId.FED_EXPENDITURES_AMT):0 ;
          objTempAward_Reporting.Drawdowns__c =(objFFRDataForGrantId.OBLIGATION_AMT!=null && objFFRDataForGrantId.OBLIGATION_AMT!='')?Double.valueOf(objFFRDataForGrantId.OBLIGATION_AMT):0; 
          */
          objTempAward_Reporting.id=objAward_Reporting.id;
          objTempAward_Reporting.Authorized_Amount__c =(objFFRDataForGrantId.OBLIGATION_AMT!=null && objFFRDataForGrantId.OBLIGATION_AMT!='')? Double.valueOf(objFFRDataForGrantId.OBLIGATION_AMT):0;
          objTempAward_Reporting.Disbursed_Amount__c =(objFFRDataForGrantId.FED_EXPENDITURES_AMT!=null & objFFRDataForGrantId.FED_EXPENDITURES_AMT!='')?Double.valueOf(objFFRDataForGrantId.FED_EXPENDITURES_AMT):0; 
          objTempAward_Reporting.Drawdowns__c =(objFFRDataForGrantId.DISBURSED_AMT!=null && objFFRDataForGrantId.DISBURSED_AMT!='')?Double.valueOf(objFFRDataForGrantId.DISBURSED_AMT):0 ;
          objTempAward_Reporting.Balance_of_Expenditures__c =(objFFRDataForGrantId.BALANCE_UNEXPENDED_AMT!=null && objFFRDataForGrantId.BALANCE_UNEXPENDED_AMT!='')?Double.valueOf(objFFRDataForGrantId.BALANCE_UNEXPENDED_AMT):0 ;
          objTempAward_Reporting.Balance_Undrawn__c =(objFFRDataForGrantId.BALANCE_UNDRAWN_AMT!=null && objFFRDataForGrantId.BALANCE_UNDRAWN_AMT!='')?Double.valueOf(objFFRDataForGrantId.BALANCE_UNDRAWN_AMT):0; 
         
          
          lstAward_Reporting.add(objTempAward_Reporting);
       }
       try{
           if(lstAward_Reporting!=null && lstAward_Reporting.size()>0){
               update lstAward_Reporting;
           }   
       }catch(DMLException dmlExc){
           System.debug('***dmlExc***'+dmlExc);
           System.debug('***dmlExc.getMessage()***'+dmlExc.getMessage());
       
       }catch(Exception exc){
           System.debug('***exc***'+exc);
           System.debug('***exc.getMessage()***'+exc.getMessage());
       }
   }
   
    public class RecordTypeException extends Exception{}

}