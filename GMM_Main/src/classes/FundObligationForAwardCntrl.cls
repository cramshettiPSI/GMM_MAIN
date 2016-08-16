Public Class FundObligationForAwardCntrl{
    public ApexPages.StandardController stdcontroller;
    public Award__c objAward{get;set;}
    public String strAwardId{get;set;}
    public String strGrant_Number{get;set;}
    public ParseJSONUtil.ObligationDataFor_supp_mech_cd_JSON objObligationDataFor_supp_mech_cd_JSON{get;set;}
    public List<ParseJSONUtil.ObligationDataFor_supp_mech_cd> lstObligationDataFor_supp_mech_cd{get;set;}
    Public Boolean showSGOButton{get;set;}
    public List<Obligation__c> lstFundObligation{get;set;}
    
    public boolean showPopup {get;set;}
    public Obligation__c objFormFundObligation{get;set;}
    public String Start_FY{get;set;}
    
    //public ParseJSONUtil.ObligationFundTransaction_JSON objDeserializedJsonForObligationFundTransaction_JSON=new ParseJSONUtil.ObligationFundTransaction_JSON();
    public List<ParseJSONUtil.ObligationFundTransaction> lstObligationFundTransaction{get;set;}
    public String strBudgetPeriodStart{get;set;}
    public String strBudgetPeriodEnd{get;set;}
    public String strApplicationType{get;set;}
    public String strApplicationId{get;set;}
    public String strPrmApplicationType{get;set;}
     
    public Integer totalResponseFundObligationlines{get;set;}
    
    public FundObligationForAwardCntrl(ApexPages.StandardController p_controller){
        this.stdcontroller= p_controller;
       // stdcontroller.addFields(new List<String>{'name','Grant_Number__c'});
        this.objAward= (Award__c )stdController.getrecord();
        strAwardId=objAward.name;
        strGrant_Number=objAward.Master_Award__r.name;//objAward.Grant_Number__c;
        strApplicationType=objAward.Application_Type__c;
        System.debug('***strApplicationType***'+strApplicationType);
        strPrmApplicationType=objAward.Prime_Application_Type__c;
        System.debug('***strPrmApplicationType***'+strPrmApplicationType);
        System.debug('***objAward***'+objAward);
        showPopup = false;
        strBudgetPeriodStart=(objAward.Budget_Period_Start__c!=null)?(String.valueOf(objAward.Budget_Period_Start__c)):'';
        strBudgetPeriodEnd=(objAward.Budget_Period_End__c!=null)?(String.valueOf(objAward.Budget_Period_End__c)):'';
        System.debug('***strBudgetPeriodStart***'+strBudgetPeriodStart);
        System.debug('***strBudgetPeriodEnd***'+strBudgetPeriodEnd);
        System.debug('***strApplicationType***'+strApplicationType);
        initMethod();
        
    }
    
    public PageReference openPopup()
    {   System.debug('****openPopup****');
        showPopup = true;
        objFormFundObligation=new Obligation__c();
        return null;
    }
    
    public PageReference Cancel()
    {
        System.debug('****Cancel****');
        showPopup = false;
        System.debug('***objFormFundObligation***'+objFormFundObligation);
        System.debug('***lstFundObligation***'+lstFundObligation);
        
        return null;
    }
    
    public string hidePopup(){
     //string MyString_From_Methode = 'Method called from js using Action function';
     System.debug('****ActionFunMethode****');
     showPopup = false;
     System.debug('***Start_FY***'+Start_FY);
     System.debug('***objFormFundObligation***'+objFormFundObligation);
     System.debug('***lstFundObligation***'+lstFundObligation);
     lstFundObligation.add(objFormFundObligation);
     System.debug('***lstFundObligation***'+lstFundObligation);
     
     return null;
    }
    
    public void invokeObligationDataFor_supp_mech_cd(){
    
    //System.debug('***objAward.Committed__c***'+objAward.Committed__c);
     if(objAward!=null && objAward.Committed__c){
       HttpResponse hResp;
       String json='';
                
        String strWSname='oblData';
        String  endPointuri='';
        String  uName='';
        String  upassword='';
        String  httpMethodName='';
        String  contenttype='';
        String strBody='';
        
        CNCS_AuthorizeHttp objCNCS_AuthorizeHttp=new CNCS_AuthorizeHttp();
        System.debug('***objAward.Committed__c***'+objAward.Committed__c);
       
        
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
            strBody=composeBodyForObligationData(strGrant_Number);
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
            objObligationDataFor_supp_mech_cd_JSON= new ParseJSONUtil.ObligationDataFor_supp_mech_cd_JSON();
            lstObligationDataFor_supp_mech_cd= objParseJSONUtil.parseObligationDataFor_supp_mech_cd(json);
            System.debug('***lstObligationDataFor_supp_mech_cd'+lstObligationDataFor_supp_mech_cd);
            if(lstObligationDataFor_supp_mech_cd!=null && lstObligationDataFor_supp_mech_cd.size() >0){
                if(lstObligationDataFor_supp_mech_cd[0].ERROR!=null && lstObligationDataFor_supp_mech_cd[0].ERROR!=''){
                    throw new CNCS_ObjectUtility.CustomException('Error-'+ lstObligationDataFor_supp_mech_cd[0].ERROR);
                }
            }
            copyJSONDataToFundObligationStruct();
          }catch(System.CalloutException ce) {
              System.debug('Callout error: '+ ce);
              ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,ce.getMessage()));
              //System.debug(resp.toString());
         }catch(CNCS_ObjectUtility.CustomException custExc) {
                  System.debug('Custom Exception '+ custExc);
                  ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,custExc.getMessage()));
         }
         catch(Exception exc){
            System.debug('***exc***'+exc.getMessage());
         }
        }
       
    }
    
    public String composeBodyForObligationData(String strsupp_mech_cd){
          //strsupp_mech_cd='12SRSFL022';
          String strBody ='{ "supp_mech_cd":'+'"'+ strsupp_mech_cd+'" }';
          return strBody;
    }
    
     public void copyJSONDataToFundObligationStruct(){
           System.debug('***lstObligationDataFor_supp_mech_cd'+lstObligationDataFor_supp_mech_cd);
           lstFundObligation =new List<Obligation__c>();
           Obligation__c objObligation;
           
           for(ParseJSONUtil.ObligationDataFor_supp_mech_cd itrObligationDataFor_supp_mech_cd   :lstObligationDataFor_supp_mech_cd){
               System.debug('***itrObligationDataFor_supp_mech_cd   ***'+itrObligationDataFor_supp_mech_cd   );
               objObligation=new Obligation__c();
              /* objObligation.Begin_Fiscal_Yr__c=itrObligationDataFor_supp_mech_cd.FISCAL_YR_1_NBR;
               objObligation.End_Fiscal_Yr__c=itrObligationDataFor_supp_mech_cd.FISCAL_YR_2_NBR;
               objObligation.Fund__c=itrObligationDataFor_supp_mech_cd.FUND_CD;
               objObligation.Grant_Location__c=itrObligationDataFor_supp_mech_cd.GRNT_LOCATION_NBR;
               objObligation.Object_Class__c=itrObligationDataFor_supp_mech_cd.OBJ_CLASS_CD;
               objObligation.Program_Manager__c=itrObligationDataFor_supp_mech_cd.PGM_MGR_CD;
               objObligation.Purpose__c=itrObligationDataFor_supp_mech_cd.PURPOSE_CD;
               //objObligation.Commitment_Amount__c=(itrObligationDataFor_supp_mech_cd!=null && itrObligationDataFor_supp_mech_cd.LINE_COMMITTED_AMT!=null)? Decimal.Valueof(itrObligationDataFor_supp_mech_cd.LINE_COMMITTED_AMT):0;
               objObligation.Commitment_Amount__c=itrObligationDataFor_supp_mech_cd.LINE_COMMITTED_AMT;
               objObligation.Start_FY__c= itrObligationDataFor_supp_mech_cd.START_DT;
               objObligation.End_FY__c=itrObligationDataFor_supp_mech_cd.END_DT;
               
               objObligation.COMLN_UIDY_ID__c=itrObligationDataFor_supp_mech_cd.COMLN_UIDY_ID;
               objObligation.OBL_TRANS_TYPE__c=itrObligationDataFor_supp_mech_cd.OBL_TRANS_TYPE;
               objObligation.COM_DOC_NUM__c=itrObligationDataFor_supp_mech_cd.COM_DOC_NUM;
               objObligation.COM_LNUM__c=itrObligationDataFor_supp_mech_cd.COM_LNUM;
               
               */
               
                objObligation.Grant_Location__c=itrObligationDataFor_supp_mech_cd.GRNT_LOCATION_NBR; 
                objObligation.COMLN_UIDY_ID__c=itrObligationDataFor_supp_mech_cd.COMLN_UIDY_ID;
               // objObligation.LINE_EXPENSE_AMT__c=itrObligationDataFor_supp_mech_cd.LINE_EXPENSE_AMT;
                objObligation.LINE_EXPENSE_AMT__c= (itrObligationDataFor_supp_mech_cd!=null && itrObligationDataFor_supp_mech_cd.LINE_EXPENSE_AMT!=null && itrObligationDataFor_supp_mech_cd.LINE_EXPENSE_AMT!='' )? Decimal.Valueof(itrObligationDataFor_supp_mech_cd.LINE_EXPENSE_AMT):0;
                
                objObligation.COM_STAE_OF_LINE__c=itrObligationDataFor_supp_mech_cd.COM_STAE_OF_LINE;
                objObligation.FUND_ID__c=itrObligationDataFor_supp_mech_cd.FUND_ID;
                objObligation.Program_Manager__c=itrObligationDataFor_supp_mech_cd.PGM_MGR_CD;
                objObligation.REFD_LINE_ID__c=itrObligationDataFor_supp_mech_cd.REFD_LINE_ID;
                objObligation.COM_PARN_OF_LINE_ID__c=itrObligationDataFor_supp_mech_cd.COM_PARN_OF_LINE_ID;
                objObligation.OBL_TRANS_TYPE__c=itrObligationDataFor_supp_mech_cd.OBL_TRANS_TYPE;
                objObligation.PROG_ID__c=itrObligationDataFor_supp_mech_cd.PROG_ID;
                objObligation.End_FY__c=itrObligationDataFor_supp_mech_cd.END_DT;
                objObligation.Start_FY__c= itrObligationDataFor_supp_mech_cd.START_DT;
                objObligation.ORGN_ID__c= itrObligationDataFor_supp_mech_cd.ORGN_ID;
                objObligation.OBL_DOC_TYPE__c= itrObligationDataFor_supp_mech_cd.OBL_DOC_TYPE;
                //objObligation.LINE_PAID_AMT__c= itrObligationDataFor_supp_mech_cd.LINE_PAID_AMT;
                objObligation.LINE_PAID_AMT__c= (itrObligationDataFor_supp_mech_cd!=null && itrObligationDataFor_supp_mech_cd.LINE_PAID_AMT!=null && itrObligationDataFor_supp_mech_cd.LINE_PAID_AMT!='' )? Decimal.Valueof(itrObligationDataFor_supp_mech_cd.LINE_PAID_AMT):0;
                objObligation.COM_DOC_NUM__c=itrObligationDataFor_supp_mech_cd.COM_DOC_NUM;
                objObligation.End_Fiscal_Yr__c=itrObligationDataFor_supp_mech_cd.FISCAL_YR_2_NBR;
                objObligation.Purpose__c=itrObligationDataFor_supp_mech_cd.PURPOSE_CD;
                //objObligation.Commitment_Amount__c=(itrObligationDataFor_supp_mech_cd!=null && itrObligationDataFor_supp_mech_cd.LINE_COMMITTED_AMT!=null)? Decimal.Valueof(itrObligationDataFor_supp_mech_cd.LINE_COMMITTED_AMT):0;
                objObligation.Commitment_Amount__c=itrObligationDataFor_supp_mech_cd.LINE_COMMITTED_AMT;
                objObligation.COM_TRANS_TYPE__c=itrObligationDataFor_supp_mech_cd.COM_TRANS_TYPE;
                objObligation.Object_Class__c=itrObligationDataFor_supp_mech_cd.OBJ_CLASS_CD;
                objObligation.Fund__c=itrObligationDataFor_supp_mech_cd.FUND_CD;
                objObligation.BDOB_ID__c=itrObligationDataFor_supp_mech_cd.BDOB_ID;
                objObligation.Begin_Fiscal_Yr__c=itrObligationDataFor_supp_mech_cd.FISCAL_YR_1_NBR;
                objObligation.OBLN_UIDY_ID__c=itrObligationDataFor_supp_mech_cd.OBLN_UIDY_ID;
                //objObligation.OLINE_AVAIL_DEOB_AMT__c=itrObligationDataFor_supp_mech_cd.LINE_AVAIL_DEOB_AMT;
                objObligation.LINE_AVAIL_DEOB_AMT__c =(itrObligationDataFor_supp_mech_cd!=null && itrObligationDataFor_supp_mech_cd.LINE_AVAIL_DEOB_AMT!=null && itrObligationDataFor_supp_mech_cd.LINE_AVAIL_DEOB_AMT!='' )? Decimal.Valueof(itrObligationDataFor_supp_mech_cd.LINE_AVAIL_DEOB_AMT):0;
                
                //OBL_LNUM{get;set;} -- not done  --field not needed as it provides line no
               // objObligation.LINE_OBLIGATED_AMT__c=itrObligationDataFor_supp_mech_cd.LINE_OBLIGATED_AMT;
                objObligation.LINE_OBLIGATED_AMT__c= (itrObligationDataFor_supp_mech_cd!=null && itrObligationDataFor_supp_mech_cd.LINE_OBLIGATED_AMT!=null && itrObligationDataFor_supp_mech_cd.LINE_OBLIGATED_AMT!='' )? Decimal.Valueof(itrObligationDataFor_supp_mech_cd.LINE_OBLIGATED_AMT):0;
                
                 
                //OBL_DOC_NUM  --need to think about it
                objObligation.ACTY_ID__c=itrObligationDataFor_supp_mech_cd.ACTY_ID;
                objObligation.COM_LNUM__c=itrObligationDataFor_supp_mech_cd.COM_LNUM;
               
               lstFundObligation.add(objObligation);
           }
           
           System.debug('***lstFundObligation***'+lstFundObligation);   
           totalResponseFundObligationlines=(lstFundObligation!=null) ? (lstFundObligation.size()):0;
      }
      
      private String determineDocType(String p_COMLN_UIDY_ID,String p_refd_line_id){
       String v_doc_type ='';
       if(p_COMLN_UIDY_ID ==null){
                    v_doc_type = ''; 
       } else if(p_refd_line_id!=null && p_refd_line_id!='' && p_refd_line_id.indexOf('RG',0)>0) {
                     v_doc_type = 'RG';
       } else if(p_refd_line_id!=null && p_refd_line_id!='' && p_refd_line_id.indexOf('RQ',0)>0) {
                     v_doc_type = 'RQ';
       } else if(p_refd_line_id!=null && p_refd_line_id!='' && p_refd_line_id.indexOf('RX',0)>0) {
                     v_doc_type = 'RX';
       } else if(p_refd_line_id!=null && p_refd_line_id!='' && p_refd_line_id.indexOf('R1',0)>0) {
                     v_doc_type = 'R1';
       } else  {
                 v_doc_type = 'RG';
       }
       return v_doc_type ;
   }
      
      public Intgr_MuleSoft__c retrieveWSDetails(String strWSname){
        String strHost=URL.getSalesforceBaseUrl().getHost();
        System.debug('Host: ' + strHost);
        Intgr_MuleSoft__c objIntgr_MuleSoftMatched;
        Map<String, Intgr_MuleSoft__c> mapStatusCodeCustomSetting = Intgr_MuleSoft__c.getAll();
        for(Intgr_MuleSoft__c objIntgr_MuleSoft : mapStatusCodeCustomSetting.values()){
                System.debug('found');
                objIntgr_MuleSoftMatched=objIntgr_MuleSoft;
                break;
        }
        return objIntgr_MuleSoftMatched;
   
     }
      
     public PageReference updateObligationFundTransaction(){
         if (objAward.Grant_Status__c == 'Awaiting SGO Approval' || objAward.Grant_Status__c == 'Awaiting SGO Obligation'){
             composeRequestBodyForObligationFundTransaction();
         }
         else{
              ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error, 'You cannot Obligated this Award. '));                    
         }  
         return null;   
     }
      
      public void composeRequestBodyForObligationFundTransaction( ){
       String strBuildData='"buildData":"';
       boolean concatfromSecItr=false;
       integer line_num=1;
       String  v_doc_type='';
       if(lstFundObligation!=null){
            System.debug('***lstFundObligation***'+lstFundObligation);
            System.debug('***lstFundObligation.size()***'+lstFundObligation.size());
       }
       for( Obligation__c itrObjFund_Obligation  :lstFundObligation){
            Double chng=(itrObjFund_Obligation!=null && itrObjFund_Obligation.Change__c!=null)? Double.valueof(itrObjFund_Obligation.Change__c) : 0;
            //Double total_amt=(itrObjFund_Obligation!=null && itrObjFund_Obligation.Commitment_Amount__c!=null) ? (Double.valueof(itrObjFund_Obligation.Commitment_Amount__c))+chng: chng;
            Double total_amt=chng;
            System.debug('****chng****'+chng);
            System.debug('****total_amt****'+total_amt);
            if (concatfromSecItr==true) {
                strBuildData+='~';
            }
            
            v_doc_type='';
            if( itrObjFund_Obligation!=null ){
               v_doc_type =determineDocType(itrObjFund_Obligation.COMLN_UIDY_ID__c,itrObjFund_Obligation.refd_line_id__c);
            }    
            
            strBuildData+=line_num+'~';
            strBuildData+=total_amt+'~';
            String strTranstype='01';//(itrObjFund_Obligation!=null && itrObjFund_Obligation.OBL_TRANS_TYPE__c!=null)?itrObjFund_Obligation.OBL_TRANS_TYPE__c:'01';
            strBuildData+=strTranstype+'~';
            
           // strBuildData+='01'+'~';
            strBuildData+=itrObjFund_Obligation.Begin_Fiscal_Yr__c+'~';
            
            String tempFISCAL_YR_2_NBR='';
            tempFISCAL_YR_2_NBR=(itrObjFund_Obligation.End_Fiscal_Yr__c!=null) ?(itrObjFund_Obligation.End_Fiscal_Yr__c):tempFISCAL_YR_2_NBR;
            strBuildData+=tempFISCAL_YR_2_NBR+'~';
       
            strBuildData+=itrObjFund_Obligation.Fund__c+'~';
            ///strBuildData+=objCommitmentFundsForGrantIdData.PURPOSE_CD+'~';//-first char
            strBuildData+=(itrObjFund_Obligation.Purpose__c!=null )?(itrObjFund_Obligation.Purpose__c.SubString(0,1)):(itrObjFund_Obligation.Purpose__c);  ////-first char
            strBuildData+='~';
            
            strBuildData+=itrObjFund_Obligation.Purpose__c+'~';   
            strBuildData+=itrObjFund_Obligation.Grant_Location__c+'~';  
            strBuildData+=itrObjFund_Obligation.Object_Class__c+'~'; 
            
            strBuildData+=itrObjFund_Obligation.Program_Manager__c+'~';
            strBuildData+='~';
            
            /*
            strBuildData+=itrObjFund_Obligation.Start_FY__c+'~'; //'07/01/2014'+'~';   //itrObjFund_Obligation.Start_FY__c
            strBuildData+=itrObjFund_Obligation.End_FY__c+'~'; //'06/30/2015'+'~';   //itrObjFund_Obligation.End_FY__c
            */
           strBudgetPeriodStart=(objAward.Budget_Period_Start__c!=null)?(String.valueOf(objAward.Budget_Period_Start__c)):'';
           strBudgetPeriodEnd=(objAward.Budget_Period_End__c!=null)?(String.valueOf(objAward.Budget_Period_End__c)):'';
            System.debug('***strBudgetPeriodStart***'+strBudgetPeriodStart);
           System.debug('***strBudgetPeriodEnd***'+strBudgetPeriodEnd);
            String strBdgStartFY_2_NBR='';
            //if(itrObjFund_Obligation.Start_FY__c!=null && itrObjFund_Obligation.Start_FY__c!=''){
            if(strBudgetPeriodStart!=null && strBudgetPeriodStart!=''){
              // strBdgStartFY_2_NBR=CNCS_ObjectUtility.convertStringFormatOfDateFromHyphenToSlash(itrObjFund_Obligation.Start_FY__c);
               strBdgStartFY_2_NBR=CNCS_ObjectUtility.convertStringFormatOfDateFromHyphenToSlash(strBudgetPeriodStart);

            }
            String strBdgEndFY_2_NBR='';
           // if(itrObjFund_Obligation.End_FY__c!=null && itrObjFund_Obligation.End_FY__c!=''){
            if(strBudgetPeriodEnd!=null && strBudgetPeriodEnd!=''){
               //strBdgEndFY_2_NBR=CNCS_ObjectUtility.convertStringFormatOfDateFromHyphenToSlash(itrObjFund_Obligation.End_FY__c);
                strBdgEndFY_2_NBR=CNCS_ObjectUtility.convertStringFormatOfDateFromHyphenToSlash(strBudgetPeriodEnd);
            }
            
            strBuildData+=  strBdgStartFY_2_NBR+'~';
            strBuildData+=  strBdgEndFY_2_NBR+'~';
            
            strBuildData+=v_doc_type +'~'; 
            strBuildData+=itrObjFund_Obligation.COM_DOC_NUM__c +'~';
            strBuildData+=itrObjFund_Obligation.COM_LNUM__c;
            
            
           /// strBuildData+='~~';
            concatfromSecItr=true;   
            line_num++;  
       }
       
       String strBody ='{ "grnt_id":"'+ strAwardId +'",';
       strBody +=strBuildData +'",';
      
      /* //commented for the purpose of new logic
       //String strFormActionValue=(totalResponseFundObligationlines==0)? 'NEW' :'AMEND';
       String strFormActionValue='NEW' ;
       //String strFormAction='"formAction":"AMEND",';
       String strFormAction='"formAction":"'+ strFormActionValue+'",';
       strBody +=strFormAction;
       ///String strAmendJustificationTxtValue=(totalResponseFundObligationlines==0)? null :'amendjustificationTxt';
       //String strAmendJustificationTxt='"amendjustificationTxt": "Testing Mule Trasfer"'; 
       ///String strAmendJustificationTxt='"amendjustificationTxt": "'+strAmendJustificationTxtValue+'"'; 
       
        
       if(strAmendmentType!=null && strAmendmentType!='' && strAmendmentType.equalsignoreCase('New') )
       String strAmendJustificationTxt='"amendjustificationTxt": "'+strAmendJustificationTxtValue+'"'; 
       strBody +=strAmendJustificationTxt+'       }' ;
       */
       String strFormAction='';
       String strFormActionValue='';
       String strAmendJustificationTxt='';
       String  strAmendJustificationTxtValue='';
       
       if((strApplicationType!=null && strApplicationType!='' && strApplicationType.equalsignoreCase('New'))
                      || (strPrmApplicationType!=null && strPrmApplicationType!='' && (strPrmApplicationType.equalsignoreCase('New') )) ){
           strFormActionValue= 'NEW';    
           strAmendJustificationTxtValue='';  
       }else{
           strFormActionValue= 'AMEND'; 
           strAmendJustificationTxtValue='amendjustificationTxt';
       }
       strFormAction='"formAction":"'+ strFormActionValue+'",';
       strBody +=strFormAction;
       strAmendJustificationTxt='"amendjustificationTxt": "'+strAmendJustificationTxtValue+'"'; 
       
       strBody +=strAmendJustificationTxt+'       }' ;
       System.debug('***strBody***'+strBody );
       invokeFundObligation(strBody );
      
       

   }
    Public void initMethod(){
  
          List<String> grouplist = new List<String>{'PO Group','GO Group','SPO Group','XO Group','SGO Group'};
          List<GroupMember> gmlist=[Select Id, UserOrGroupId, group.name From GroupMember where group.name IN: grouplist];
          Set<String> SGOGroupUserlist = new Set<String>();
           String loggedinUserId = Userinfo.getuserid();
           
            for(groupmember gm:gmlist)
                      {
                      if(gm.group.name=='SGO Group')
                       SGOGroupUserlist.add(gm.UserOrGroupid);  
               }        
                  If(SGOGroupUserlist.contains(loggedinUserId))
                   showSGOButton=True;       
                      
           }
   
   public void invokeFundObligation(String strBody){
        HttpResponse hResp;
        String json='';
        String strHost=URL.getSalesforceBaseUrl().getHost();
        System.debug('Host: ' + strHost);
        
        String strWSname='obligation';
        Intgr_MuleSoft__c objIntgr_MuleSoft=CNCS_ObjectUtility.retrieveWSDetails(strWSname);
        System.debug(objIntgr_MuleSoft);
        String  endPointuri=objIntgr_MuleSoft.endPointuri__c;
        String  uName=objIntgr_MuleSoft.uName__c;
        String  upassword=objIntgr_MuleSoft.upassword__c;
        String  httpMethodName=objIntgr_MuleSoft.httpMethodName__c;
        String  contenttype=objIntgr_MuleSoft.contenttype__c;
        //String strBody=composeBodyForFCLines(strAwardId);
        System.debug('endPointuri'+endPointuri+''+'httpMethodName'+httpMethodName+'uName'+uName+'upassword'+upassword+'contenttype'+contenttype);
        CNCS_AuthorizeHttp objCNCS_AuthorizeHttp=new CNCS_AuthorizeHttp();
        
        try{
               hResp=objCNCS_AuthorizeHttp.wsConnectAndSend(endPointuri,uName,upassword,httpMethodName,contenttype,strBody,false);
               System.debug('***hResp***'+hResp);
               if(hResp!=null && hResp.getStatusCode()!=200){
                         throw new CNCS_ObjectUtility.CustomException('Status-->'+hResp.getStatus()+' StatusCode-->'+hResp.getStatusCode()+'  Message-->'+hResp.getBody().replace('\n', ''));
               }
               // the service is returning a line feed so parse it out
               json = hResp.getBody().replace('\n', '');
               System.debug('***json***'+json );
               
               ParseJSONUtil objParseJSONUtil= new ParseJSONUtil();
               ParseJSONUtil.ObligationFundTransaction_JSON objDeserializedJsonForObligationFundTransaction_JSON=new ParseJSONUtil.ObligationFundTransaction_JSON();
               objDeserializedJsonForObligationFundTransaction_JSON=objParseJSONUtil.parseObligationFundTransaction(json);
               lstObligationFundTransaction=new List<ParseJSONUtil.ObligationFundTransaction>();
               //lstObligationFundTransaction=objParseJSONUtil.parseObligationFundTransaction(json);
               lstObligationFundTransaction= objDeserializedJsonForObligationFundTransaction_JSON.lstData;
               System.debug('***lstObligationFundTransaction'+lstObligationFundTransaction);
               
               //copyJSONDataToFundCommitmentStruct();
               if(lstObligationFundTransaction!=null && lstObligationFundTransaction.size() >0){
                     String strResultTxt=lstObligationFundTransaction[0].RESULT_TXT;
                     if(strResultTxt!=null && strResultTxt!='' && strResultTxt.equalsignoreCase('0~')){
                         //update
                         objAward.Grant_Status__c='Obligated'; 
                         update objAward; 
                     }else{
                        
                          throw new CNCS_ObjectUtility.CustomException('Exception -> '+ strResultTxt+' .'); 
                     } 
                }
               
            }catch(System.CalloutException ce) {
                  System.debug('Callout error: '+ ce);
                  ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,ce.getMessage()));
                  //System.debug(resp.toString());
            }
            catch(CNCS_ObjectUtility.CustomException custExc) {
                  System.debug('Custom Exception '+ custExc);
                  ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,custExc.getMessage()));
            }
            catch(Exception exc){
                System.debug('***exc***'+exc.getMessage());
            }
            
   }      
  

}