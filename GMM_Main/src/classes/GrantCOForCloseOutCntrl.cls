public class GrantCOForCloseOutCntrl{
    public ApexPages.StandardController stdcontroller;
    public Grant_Close_Out__c objGrant_Close_Out{get;set;}
    public String strSupp_Mech_CD{get;set;}
    
    
     public GrantCOForCloseOutCntrl(ApexPages.StandardController p_controller){
        this.stdcontroller= p_controller;
        stdcontroller.addFields(new List<String>{'name','FAIN__c'});
        this.objGrant_Close_Out= (Grant_Close_Out__c )stdController.getrecord();
        System.debug('***objGrant_Close_Out***'+objGrant_Close_Out);
        strSupp_Mech_CD=objGrant_Close_Out.FAIN__c;
     }
     
     public PageReference invokeCloseOutWithSupp_Mech_CD(){
      
                HttpResponse hResp;
                String json='';
                                    
                String strWSname='closeOut';
                String  endPointuri='';
                String  uName='';
                String  upassword='';
                String  httpMethodName='';
                String  contenttype='';
                CNCS_AuthorizeHttp objCNCS_AuthorizeHttp=new CNCS_AuthorizeHttp();
                try{
                    Intgr_MuleSoft__c objIntgr_MuleSoft=CNCS_ObjectUtility.retrieveWSDetails(strWSname);
                    System.debug(objIntgr_MuleSoft);
                    if(objIntgr_MuleSoft==null){
                        ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'Configuration for Web Service Grant Closeout is not setUp'));
                        throw new CNCS_ObjectUtility.CustomException();
                    }
                    if(objIntgr_MuleSoft!=null){
                        endPointuri=objIntgr_MuleSoft.endPointuri__c;
                        uName=objIntgr_MuleSoft.uName__c;
                        upassword=objIntgr_MuleSoft.upassword__c;
                        httpMethodName=objIntgr_MuleSoft.httpMethodName__c;
                        contenttype=objIntgr_MuleSoft.contenttype__c;
                    }
                    String strBody=composeBodyForCloseOutWithSupp_Mech_CD();
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
                    ParseJSONUtil.GrantCloseOutForSuppMechCDJSON    objGrantCloseOutForSuppMechCDJSON= new ParseJSONUtil.GrantCloseOutForSuppMechCDJSON();
                    objGrantCloseOutForSuppMechCDJSON= objParseJSONUtil.parseGrantCloseOutForSuppMechCDJSON(json);
                    System.debug('***objGrantCloseOutForSuppMechCDJSON'+objGrantCloseOutForSuppMechCDJSON);
                    List<ParseJSONUtil.GrantCloseOutForSuppMechCD> lstGrantCloseOutForSuppMechCD=objGrantCloseOutForSuppMechCDJSON.lstData;
                    System.debug('***lstGrantCloseOutForSuppMechCD'+lstGrantCloseOutForSuppMechCD);
                    updateMomentumDataForGrantCloseOut(lstGrantCloseOutForSuppMechCD);
                  
                }catch(CalloutException exc){
                    System.debug('***exc***'+exc);
                    System.debug('***exc.getMessage()***'+exc.getMessage());
                }
                catch(CNCS_ObjectUtility.CustomException custExc) {
                  System.debug('Custom Exception '+ custExc);
                  ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,custExc.getMessage()));
                }
                catch(Exception exc){
                    System.debug('***exc***'+exc);
                    System.debug('***exc.getMessage()***'+exc.getMessage());
                }
                return null;
     
     }
     
     public String composeBodyForCloseOutWithSupp_Mech_CD(){
      // strSupp_Mech_CD='12SRSFL022';
       String strBody ='{ "supp_mech_cd":'+'"'+ strSupp_Mech_CD+'" }';
       return strBody;
   
   }
     
     public void updateMomentumDataForGrantCloseOut(List<ParseJSONUtil.GrantCloseOutForSuppMechCD> lstGrantCloseOutForSuppMechCD){
       system.debug('***in method updateMomentumDataForGrantCloseOut***');
        system.debug('***lstGrantCloseOutForSuppMechCD***'+lstGrantCloseOutForSuppMechCD);
       List<Grant_Close_Out__c > lstGrant_Close_Out =new List<Grant_Close_Out__c>();
       Grant_Close_Out__c objTempGrant_Close_Out;
       for( ParseJSONUtil.GrantCloseOutForSuppMechCD objItrGrantCloseOutForSuppMechCD :lstGrantCloseOutForSuppMechCD){
          objTempGrant_Close_Out=new Grant_Close_Out__c();
          objTempGrant_Close_Out.id=objGrant_Close_Out.id;
         // objTempGrant_Close_Out.FAIN__c=strSupp_Mech_CD; // this field is not writeable
          objTempGrant_Close_Out.Advanced_Momentum__c=(objItrGrantCloseOutForSuppMechCD .ADVANCED_AMT!=null && objItrGrantCloseOutForSuppMechCD .ADVANCED_AMT!='')? Double.valueOf(objItrGrantCloseOutForSuppMechCD .ADVANCED_AMT):0;
          objTempGrant_Close_Out.Disbursed_Momentum_SF_425__c=(objItrGrantCloseOutForSuppMechCD .DISBURSED_AMT!=null && objItrGrantCloseOutForSuppMechCD.DISBURSED_AMT!='')? Double.valueOf(objItrGrantCloseOutForSuppMechCD.DISBURSED_AMT):0;
          objTempGrant_Close_Out.Total_Federal_Expenditure_Final_FFR_SF__c=(objItrGrantCloseOutForSuppMechCD.FED_EXPENDITURES_AMT!=null && objItrGrantCloseOutForSuppMechCD.FED_EXPENDITURES_AMT!='')? Double.valueOf(objItrGrantCloseOutForSuppMechCD.FED_EXPENDITURES_AMT):0;
          lstGrant_Close_Out.add(objTempGrant_Close_Out);
       }
       try{
           system.debug('***before lstGrant_Close_Out***'+lstGrant_Close_Out);
           if(lstGrant_Close_Out!=null && lstGrant_Close_Out.size()>0){
               update lstGrant_Close_Out;
           }   
       }catch(DMLException dmlExc){
           System.debug('***dmlExc***'+dmlExc);
           System.debug('***dmlExc.getMessage()***'+dmlExc.getMessage());
       
       }catch(Exception exc){
           System.debug('***exc***'+exc);
           System.debug('***exc.getMessage()***'+exc.getMessage());
       }
   }
 

}