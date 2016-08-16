public class FundCommitmentForAwardCntrl{

    public ApexPages.StandardController stdcontroller;
    public Award__c objAward{get;set;}
    public List<Fund_Commitment__c> lstFundCommitment{get;set;}
    public String strAwardId{get;set;}
    
    public ParseJSONUtil.CommitmentFundsForGrantIdJSON objDeserializedJson{get;set;}
    public List<ParseJSONUtil.CommitmentFundsForGrantIdData> lstCommitmentFundsForGrantIdData{get;set;}
    public boolean opFlg{get;set;}
    public boolean ipFlg{get;set;}
    Public Boolean showXOButton{get;set;}
    
    public boolean showPopup {get;set;}
    public Fund_Commitment__c objFormFundCommitment{get;set;}
    public String Start_FY{get;set;}
    public Fund_Commitment__c objFund_Commitment{get;set;}
    public List<Funding_Source__c> lstFundingSource{get;set;}
    
    public String strGrantLocationNo{get;set;}
    public String strObjectCode{get;set;}
    public String strAcctPurpose{get;set;}
    public String strFiscalYrBasis{get;set;}
    
    public String strBudgetPeriodStart{get;set;}
    public String strBudgetPeriodEnd{get;set;}
    
    public Integer totalResponseFundCommitmentlines{get;set;}
    public String strApplicationType{get;set;}
    public String strPrmApplicationType{get;set;}
    
    public FundCommitmentForAwardCntrl(){

    }
  
    public FundCommitmentForAwardCntrl(ApexPages.StandardController p_controller){
       try{
    
       this.stdcontroller= p_controller;
      //stdcontroller.addFields(new List<String>{'name'});
       this.objAward= (Award__c )stdController.getrecord();
       strAwardId=objAward.name;
       strApplicationType=objAward.Application_Type__c;
       System.debug('***strApplicationType***'+strApplicationType);
       strPrmApplicationType=objAward.Prime_Application_Type__c;
        System.debug('***strPrmApplicationType***'+strPrmApplicationType);
       System.debug('***objAward***'+objAward);
      // lstCommitmentFundsForGrantIdDataWrapper=new List<CommitmentFundsForGrantIdDataWrapper>();
       opFlg=true;
       ipFlg=false;
       showPopup = false;
       String strId=objAward.id;
       strBudgetPeriodStart=(objAward.Budget_Period_Start__c!=null)?(String.valueOf(objAward.Budget_Period_Start__c)):'';
       strBudgetPeriodEnd=(objAward.Budget_Period_End__c!=null)?(String.valueOf(objAward.Budget_Period_End__c)):'';
       
       
       retrieveFundSourceRecs();
       initMethod();
       }
       catch(Exception exc){
         System.debug('***exception in FundCommitmentForAwardCntrl constructor***'+ exc);
       }
       String gmid = Apexpages.currentPage().getParameters().get('gmid'); 
       List<String> allGroupIDs = new List<String>();
        for (GroupMember gm : [SELECT Id, group.id, group.name, group.type FROM GroupMember where (UserOrGroupId = :UserInfo.getUserId() AND group.type='Regular')]){
        allGroupIDs.add(gm.group.id);
        system.debug('tets@@'+gm);
        }
        gmid=userinfo.getUserId();
      If(gmid!=null) 
     List<GroupMember> gm=[Select id,UserOrGroupId from GroupMember where UserOrGroupId=:gmid];
     System.debug('@@@groupmember'+gmid);
    }
    
    Public void initMethod(){
  
          List<String> grouplist = new List<String>{'PO Group','GO Group','SPO Group','XO Group','SGO Group'};
          List<GroupMember> gmlist=[Select Id, UserOrGroupId, group.name From GroupMember where group.name IN: grouplist];
          Set<String> XOGroupUserlist = new Set<String>();
          String loggedinUserId = Userinfo.getuserid();
           
          for(groupmember gm:gmlist){
              if(gm.group.name=='XO Group'){
                       XOGroupUserlist.add(gm.UserOrGroupid);  
              }
          }        
          If(XOGroupUserlist.contains(loggedinUserId)){
                   showXOButton=True;     
          }  
          System.debug('***showXOButton***'+showXOButton);            
    }
    
    public void retrieveFundSourceRecs(){
        String strAwardId=objAward.id;//ApexPages.currentPage().getParameters().get('idfield');
        System.debug('***strAwardId***'+strAwardId);
        string strRecordTypeName = Schema.SObjectType.Award__c.getRecordTypeInfosById().get(objAward.recordtypeid).getname();
        System.debug('***strRecordTypeName for FundSource ***'+strRecordTypeName );
        Award__c tempObjAward;
        
        String  strQueryForNofaId=(strRecordTypeName!=null && strRecordTypeName!='' && strRecordTypeName.equalsIgnoreCase('Prime Award'))
                             ? ('select id,name, Prime_Application__r.NOFO_RFP__c from Award__c where id= ' + '\''+strAwardId+'\'') 
                             : ('select id,name,Application_ID__r.NOFA_RFP__c from Award__c where id= '+ '\''+strAwardId+'\'');
          
                     
        
        String strWhereClauseValueForFundingSource='';                     
        if(strAwardId!=null && strQueryForNofaId!=null && strQueryForNofaId!=''){
             tempObjAward=Database.query(strQueryForNofaId);  
             System.debug('tempObjAward'+tempObjAward); 
             strWhereClauseValueForFundingSource=(strRecordTypeName!=null && strRecordTypeName!='' && strRecordTypeName.equalsIgnoreCase('Prime Award'))
                                                 ?(tempObjAward.Prime_Application__r.NOFO_RFP__c  ) 
                                                 :(tempObjAward.Application_ID__r.NOFA_RFP__c  );
                                                 
            if(strWhereClauseValueForFundingSource !=null && strWhereClauseValueForFundingSource!=''){
                lstFundingSource=[SELECT id,name,Object_code__r.name,Grant_location_number__r.name,Account_Purpose__r.name,
                                          Fiscal_Yr_Basis__r.name,Funds_Remaining__c 
                                  FROM Funding_Source__c 
                                  WHERE NOFA__c= :strWhereClauseValueForFundingSource ];
                System.debug('lstFundingSource'+lstFundingSource);
            }                                   
        }              
          
      
       ////
       /*
        if(strAwardId!=null){
            tempObjAward= [Select id,Application_ID__r.NOFA_RFP__c from Award__c where id=:strAwardId];
            System.debug('tempObjAward'+tempObjAward);
            if(tempObjAward!=null && tempObjAward.Application_ID__r.NOFA_RFP__c!=null){
                lstFundingSource=[Select id,name,Object_code__r.name,Grant_location_number__r.name,Account_Purpose__r.name,Fiscal_Yr_Basis__r.name,Funds_Remaining__c 
                                  from Funding_Source__c 
                                  where NOFA__c=:tempObjAward.Application_ID__r.NOFA_RFP__c];
                System.debug('lstFundingSource'+lstFundingSource);
            }
        }
        */
        ////
       
    }
    
    public void composeFundSrcRecord(){
        System.debug('****ActionFunMethode****');
        showPopup = false;
        objFormFundCommitment.Grant_Location__c=strGrantLocationNo;
        objFormFundCommitment.Object_Class__c=strObjectCode;
        objFormFundCommitment.Start_FY__c=strBudgetPeriodStart;
        //please verify the following field in fc
        objFormFundCommitment.End_FY__c=strBudgetPeriodEnd;
        //strBudgetPeriodEnd
        
       /// List<String> lstStrAcctPurpose=strAcctPurpose.split('-');
        List<String> lstStrAcctPurpose=new List<String>();
        if(strAcctPurpose!=null && strAcctPurpose.length()>0){
             lstStrAcctPurpose=strAcctPurpose.split('-');   
             objFormFundCommitment.Purpose__c=lstStrAcctPurpose[0];
             objFormFundCommitment.Program__c=lstStrAcctPurpose[1];
        }
        
        ///List<String> lstStrFiscalYrBasis=strFiscalYrBasis.split('-');
        List<String> lstStrFiscalYrBasis=new List<String>();
        if(strFiscalYrBasis!=null && strFiscalYrBasis.length()>0){
             lstStrFiscalYrBasis=strFiscalYrBasis.split('-');   
             objFormFundCommitment.Beginning_FY__c=lstStrFiscalYrBasis[0];
             objFormFundCommitment.Fund__c=lstStrFiscalYrBasis[1];
        }
       
     
        //objFormFundCommitment.Start_FY__c=(objAward.Budget_Period_Start__c!=null)?(String.valueOf(objAward.Budget_Period_Start__c)):'';
       // objFormFundCommitment.Ending_FY__c=(objAward.Budget_Period_End__c!=null)?(String.valueOf(objAward.Budget_Period_End__c)):'';
        System.debug('***composeFundSrcRecord***'+objFormFundCommitment);
        if(lstFundCommitment==null){  
            lstFundCommitment= new  List<Fund_Commitment__c>();
        }
        lstFundCommitment.add(objFormFundCommitment);
        System.debug('***lstFundCommitment***'+lstFundCommitment);
    
    }
    
    public void composeFundSrcRecord_old(){
        System.debug('****ActionFunMethode****');
        showPopup = false;
        
       /// List<String> lstStrAcctPurpose=strAcctPurpose.split('-');
        List<String> lstStrAcctPurpose=new List<String>();
        if(strAcctPurpose!=null && strAcctPurpose.length()>0){
             lstStrAcctPurpose=strAcctPurpose.split('-');   
        
        
        }
        
        
        List<String> lstStrFiscalYrBasis=strFiscalYrBasis.split('-');
        
        objFormFundCommitment.Grant_Location__c=strGrantLocationNo;
        objFormFundCommitment.Object_Class__c=strObjectCode;
        
        objFormFundCommitment.Purpose__c=lstStrAcctPurpose[0];
        objFormFundCommitment.Program__c=lstStrAcctPurpose[1];
        objFormFundCommitment.Beginning_FY__c=lstStrFiscalYrBasis[0];
        objFormFundCommitment.Fund__c=lstStrFiscalYrBasis[1];
       
        objFormFundCommitment.Start_FY__c=strBudgetPeriodStart;
        
        //objFormFundCommitment.Start_FY__c=(objAward.Budget_Period_Start__c!=null)?(String.valueOf(objAward.Budget_Period_Start__c)):'';
       // objFormFundCommitment.Ending_FY__c=(objAward.Budget_Period_End__c!=null)?(String.valueOf(objAward.Budget_Period_End__c)):'';
        System.debug('***composeFundSrcRecord***'+objFormFundCommitment);
        lstFundCommitment.add(objFormFundCommitment);
        System.debug('***lstFundCommitment***'+lstFundCommitment);
    
    }
    
    public PageReference openPopup(){
        System.debug('****openPopup****');
        showPopup = true;
        objFormFundCommitment=new Fund_Commitment__c ();
        return null;
    }
    
    public PageReference Cancel(){
        System.debug('****Cancel****');
        showPopup = false;
        System.debug('***objFormFundCommitment***'+objFormFundCommitment);
        System.debug('***lstFundCommitment***'+lstFundCommitment);
        return null;
    }
    
    public string hidePopup(){
        //string MyString_From_Methode = 'Method called from js using Action function';
        System.debug('****ActionFunMethode****');
        showPopup = false;
        System.debug('***Start_FY***'+Start_FY);
        System.debug('***objFormFundCommitment***'+objFormFundCommitment);
        System.debug('***lstFundCommitment***'+lstFundCommitment);
        lstFundCommitment.add(objFormFundCommitment);
        System.debug('***lstFundCommitment***'+lstFundCommitment);
        return null;
    }
    
    public void invokeFcLines(){
        System.debug('***objAward.Committed__c***'+objAward.Committed__c);
        if(objAward!=null && objAward.Committed__c){
       
            HttpResponse hResp;
            String json='';
            String strWSname='fcLines';
            String strHost=URL.getSalesforceBaseUrl().getHost();
            System.debug('Host: ' + strHost);
            String endPointuri='';
            String uName='';
            String upassword='';
            String contenttype='';
            String httpMethodName='';
            
            
            
            CNCS_AuthorizeHttp objCNCS_AuthorizeHttp=new CNCS_AuthorizeHttp();
            try{
                /*       
                Map<String, Intgr_MuleSoft__c> mapStatusCodeCustomSetting = Intgr_MuleSoft__c.getAll();
                for(Intgr_MuleSoft__c objIntgr_MuleSoft : mapStatusCodeCustomSetting.values()){
                    System.debug('strHost->'+strHost);
                    System.debug('objIntgr_MuleSoft.sandbox__c ->'+objIntgr_MuleSoft.sandbox__c);
                    System.debug('objIntgr_MuleSoft.sandbox__c.equals(strHost)->'+objIntgr_MuleSoft.sandbox__c.equals(strHost));
                    System.debug('objIntgr_MuleSoft.name->'+objIntgr_MuleSoft.name);
                    if(objIntgr_MuleSoft.sandbox__c.equals(strHost) && objIntgr_MuleSoft.name.equals('fcLines')){
                        System.debug('found');
                        endPointuri=objIntgr_MuleSoft.endPointuri__c;
                        httpMethodName=objIntgr_MuleSoft.httpMethodName__c;
                        uName=objIntgr_MuleSoft.uName__c;
                        upassword=objIntgr_MuleSoft.upassword__c;
                        contenttype=objIntgr_MuleSoft.contenttype__c;
                        System.debug(objIntgr_MuleSoft);
                        break;
                    }
                }*/
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
                    String strBody=composeBodyForFCLines(strAwardId);
                    System.debug('endPointuri'+endPointuri+''+'httpMethodName'+httpMethodName+'uName'+uName+'upassword'+upassword+'contenttype'+contenttype);
                    //  DemoHandShakingMuleSoft objDemo= new DemoHandShakingMuleSoft();
                    // resp= objDemo.makeACall(strAwardId);
                    hResp=objCNCS_AuthorizeHttp.wsConnectAndSend(endPointuri,uName,upassword,httpMethodName,contenttype,strBody,false);
                    System.debug('***hResp***'+hResp);
                    if(hResp!=null && hResp.getStatusCode()!=200){
                             throw new CNCS_ObjectUtility.CustomException('Status-->'+hResp.getStatus()+' StatusCode-->'+hResp.getStatusCode()+'  Message-->'+hResp.getBody().replace('\n', ''));
                    }
                    // the service is returning a line feed so parse it out
                    json = hResp.getBody().replace('\n', '');
                    System.debug('***json***'+json );
                
                    ParseJSONUtil objParseJSONUtil= new ParseJSONUtil();
                    objDeserializedJson= new ParseJSONUtil.CommitmentFundsForGrantIdJSON();
                    objDeserializedJson=objParseJSONUtil.parseCommitmentFundsForGrantId(json);
                    System.debug('***objDeserializedJson in invokeFcLines***'+objDeserializedJson);
                    lstCommitmentFundsForGrantIdData = objDeserializedJson.lstData;
                    System.debug('***lstCommitmentFundsForGrantIdData '+lstCommitmentFundsForGrantIdData );
                    if(lstCommitmentFundsForGrantIdData !=null && lstCommitmentFundsForGrantIdData.size() >0){
                        if(lstCommitmentFundsForGrantIdData[0].ERROR!=null && lstCommitmentFundsForGrantIdData[0].ERROR!=''){
                            throw new CNCS_ObjectUtility.CustomException('Error-'+ lstCommitmentFundsForGrantIdData[0].ERROR);
                        }
                    }
                    copyJSONDataToFundCommitmentStruct();
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
                    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,exc.getMessage()));
                }
         }   
    }
    
    public String composeBodyForFCLines(String strGrantId){
        //strGrantId='14SR178827';
        String strBody ='{ "grant_id":"'+ strGrantId +'" }';    //'{  "grant_id":"14SR178827" }'
        return strBody;
    }
   
    public void copyJSONDataToFundCommitmentStruct(){
        System.debug('***lstCommitmentFundsForGrantIdData '+lstCommitmentFundsForGrantIdData );
        lstFundCommitment =new List<Fund_Commitment__c>();
        Fund_Commitment__c objFundCommitment;
        for(ParseJSONUtil.CommitmentFundsForGrantIdData itrCommitmentFundsForGrantIdData   :lstCommitmentFundsForGrantIdData ){
            System.debug('***itrCommitmentFundsForGrantIdData***'+itrCommitmentFundsForGrantIdData  );  
            objFundCommitment=new Fund_Commitment__c();
            /*
            //objFundCommitment.Award__c=objAward.id;//itrCommitmentFundsForGrantIdData.DOC_NUM;
            objFundCommitment.Beginning_FY__c=itrCommitmentFundsForGrantIdData.FISCAL_YR_1_NBR;
            objFundCommitment.Ending_FY__c =itrCommitmentFundsForGrantIdData.FISCAL_YR_2_NBR;
            objFundCommitment.Fund__c=itrCommitmentFundsForGrantIdData.FUND_CD;
            objFundCommitment.Grant_Location__c=itrCommitmentFundsForGrantIdData.GRNT_LOCATION_NBR;
            objFundCommitment.Object_Class__c=itrCommitmentFundsForGrantIdData.OBJ_CLASS_CD;
            objFundCommitment.Program__c=itrCommitmentFundsForGrantIdData.PGM_MGR_CD;//PROG_ID;
            objFundCommitment.Purpose__c=itrCommitmentFundsForGrantIdData.PURPOSE_CD;
            objFundCommitment.Current_Amount__c=(itrCommitmentFundsForGrantIdData!=null && itrCommitmentFundsForGrantIdData.LINE_COMMITTED_AMT!=null)? Decimal.Valueof(itrCommitmentFundsForGrantIdData.LINE_COMMITTED_AMT):0;
            objFundCommitment.Start_FY__c=itrCommitmentFundsForGrantIdData.START_DT;
            objFundCommitment.End_FY__c=itrCommitmentFundsForGrantIdData.END_DT;
            */
            
            //objFundCommitment.Award__c=objAward.id;//itrCommitmentFundsForGrantIdData.DOC_NUM;
            objFundCommitment.Grant_Location__c=itrCommitmentFundsForGrantIdData.GRNT_LOCATION_NBR;
            objFundCommitment.Ending_FY__c =itrCommitmentFundsForGrantIdData.FISCAL_YR_2_NBR;
            objFundCommitment.Program__c=itrCommitmentFundsForGrantIdData.PGM_MGR_CD;//PROG_ID;
            objFundCommitment.FUND_ID__c=itrCommitmentFundsForGrantIdData.FUND_ID;
            objFundCommitment.Purpose__c=itrCommitmentFundsForGrantIdData.PURPOSE_CD;
            objFundCommitment.MRN_UIDY_ID__c=itrCommitmentFundsForGrantIdData.MRN_UIDY_ID;
            objFundCommitment.Current_Amount__c=(itrCommitmentFundsForGrantIdData!=null && itrCommitmentFundsForGrantIdData.LINE_COMMITTED_AMT!=null)? Decimal.Valueof(itrCommitmentFundsForGrantIdData.LINE_COMMITTED_AMT):0;
            objFundCommitment.Object_Class__c=itrCommitmentFundsForGrantIdData.OBJ_CLASS_CD;
            objFundCommitment.PROG_ID__c=itrCommitmentFundsForGrantIdData.PROG_ID;
            //DOC_NUM --not needed as it is a formula and think its grantid
            objFundCommitment.Fund__c=itrCommitmentFundsForGrantIdData.FUND_CD;
            objFundCommitment.BDOB_ID__c=itrCommitmentFundsForGrantIdData.BDOB_ID;
            objFundCommitment.Beginning_FY__c=itrCommitmentFundsForGrantIdData.FISCAL_YR_1_NBR;
            /*
            objFundCommitment.End_FY__c=itrCommitmentFundsForGrantIdData.END_DT;
            objFundCommitment.Start_FY__c=itrCommitmentFundsForGrantIdData.START_DT;
            */
            objFundCommitment.End_FY__c=strBudgetPeriodEnd;
            objFundCommitment.Start_FY__c=strBudgetPeriodStart;
            objFundCommitment.PARN_OF_LINE_ID__c=itrCommitmentFundsForGrantIdData.PARN_OF_LINE_ID;
            //LNUM -field not needed as it provides line no
            objFundCommitment.ORGN_ID__c=itrCommitmentFundsForGrantIdData.ORGN_ID;
            objFundCommitment.ACTY_ID__c=itrCommitmentFundsForGrantIdData.ACTY_ID;
            objFundCommitment.CHANGE__c=(itrCommitmentFundsForGrantIdData!=null && itrCommitmentFundsForGrantIdData.CHANGE!=null && itrCommitmentFundsForGrantIdData.CHANGE!='')? Decimal.Valueof(itrCommitmentFundsForGrantIdData.CHANGE):0;
            
            
            lstFundCommitment.add(objFundCommitment);
        }
         System.debug('***lstFundCommitment***'+lstFundCommitment);   
         totalResponseFundCommitmentlines=(lstFundCommitment!=null) ? (lstFundCommitment.size()):0;
    }
   
   public void addNewRecord(){
       Fund_Commitment__c objFundCommitment=new Fund_Commitment__c();
       lstFundCommitment.add(objFundCommitment);
       ipFlg=true;
       System.debug('***lstFundCommitment***'+lstFundCommitment);
       System.debug('***ipFlg***'+ipFlg);
    }
   
   public void updateFundCommitment( ){
        
       
        
       String strBuildData='"buildData":"';
       boolean concatfromSecItr=false;
       integer line_num=1;
       if(lstFundCommitment!=null){
            System.debug('***lstFundCommitment.size()***'+lstFundCommitment.size());
       }
       if(lstFundCommitment!=null && lstFundCommitment.size()>0){
       for( Fund_Commitment__c itrObjFund_Commitment  :lstFundCommitment){
            
            Double chng=(itrObjFund_Commitment!=null && itrObjFund_Commitment.Change__c!=null)? Double.valueof(itrObjFund_Commitment.Change__c) : 0;
           // Decimal chng=(objCommitmentFundsForGrantIdData!=null && objCommitmentFundsForGrantIdData.Change!=null)? Decimal.valueof(objCommitmentFundsForGrantIdData.Change) : 0;
           /* if(itrObjFund_Commitment  !=null && itrObjFund_Commitment.Change__c!=null){
                chng= double.valueof(itrObjFund_Commitment.Change__c) ;
            }
            else{
               chng=0; 
            }*/
          
           Double total_amt=(itrObjFund_Commitment!=null && itrObjFund_Commitment.Current_Amount__c!=null) ? (Double.valueof(itrObjFund_Commitment.Current_Amount__c))+chng: chng;
           if (concatfromSecItr==true) {
                strBuildData+='~';
            }
            strBuildData+=line_num+'~';
            strBuildData+=total_amt+'~';
            strBuildData+='01'+'~';
            
            System.debug('***itrObjFund_Commitment.Start_FY__c***'+itrObjFund_Commitment.Start_FY__c);
            String strStart_FY_2_NBR='';
            if(itrObjFund_Commitment!=null && itrObjFund_Commitment.Start_FY__c!=null && itrObjFund_Commitment.Start_FY__c.contains('-')){
               strStart_FY_2_NBR= itrObjFund_Commitment.Start_FY__c.split('-')[0];
            }
            else if(itrObjFund_Commitment!=null && itrObjFund_Commitment.Start_FY__c!=null && itrObjFund_Commitment.Start_FY__c.contains('/')){
                strStart_FY_2_NBR= itrObjFund_Commitment.Start_FY__c.split('/')[2];
            }
            
            ///strBuildData+=itrObjFund_Commitment.Start_FY__c+'~';
            strBuildData+=strStart_FY_2_NBR+'~';
            
            String tempFISCAL_YR_2_NBR='';
            tempFISCAL_YR_2_NBR=(itrObjFund_Commitment.Ending_FY__c!=null) ?(itrObjFund_Commitment.Ending_FY__c):tempFISCAL_YR_2_NBR;
            strBuildData+=tempFISCAL_YR_2_NBR+'~';
       
            strBuildData+=itrObjFund_Commitment.Fund__c+'~';
            ///strBuildData+=objCommitmentFundsForGrantIdData.PURPOSE_CD+'~';//-first char
            strBuildData+=(itrObjFund_Commitment.Purpose__c!=null )?(itrObjFund_Commitment.Purpose__c.SubString(0,1)):(itrObjFund_Commitment.Purpose__c);  ////-first char
            strBuildData+='~';
            
            strBuildData+=itrObjFund_Commitment.Purpose__c+'~';   
            strBuildData+=itrObjFund_Commitment.Grant_Location__c+'~';  
            strBuildData+=itrObjFund_Commitment.Object_Class__c+'~'; 
            
            strBuildData+=itrObjFund_Commitment.Program__c+'~';
            strBuildData+='~';
            
            String strBdgStartFY_2_NBR='';
            System.debug('***itrObjFund_Commitment.Start_FY__c***'+itrObjFund_Commitment.Start_FY__c+'***itrObjFund_Commitment.End_FY__c '+itrObjFund_Commitment.End_FY__c);
            if(itrObjFund_Commitment.Start_FY__c!=null && itrObjFund_Commitment.Start_FY__c!=''){
               strBdgStartFY_2_NBR=CNCS_ObjectUtility.convertStringFormatOfDateFromHyphenToSlash(itrObjFund_Commitment.Start_FY__c);
            }
            String strBdgEndFY_2_NBR='';
            if(itrObjFund_Commitment.End_FY__c!=null && itrObjFund_Commitment.End_FY__c!=''){
               strBdgEndFY_2_NBR=CNCS_ObjectUtility.convertStringFormatOfDateFromHyphenToSlash(itrObjFund_Commitment.End_FY__c);
            }
             
           /// strBuildData+= itrObjFund_Commitment.Start_FY__c+'~'; // '07/01/2014'+'~'; //itrObjFund_Commitment.Start_FY__c+'~'; //this line has to be replced with the field assignment which is commented next to it  after having proper data
           /// strBuildData+= itrObjFund_Commitment.End_FY__c+'~';  //'06/30/2015'+'~'; //itrObjFund_Commitment.End_FY__c+'~';//this line has to be replced with the field assignment which is commented next to it  after having proper data
               
            strBuildData+=  strBdgStartFY_2_NBR+'~';
            strBuildData+=  strBdgEndFY_2_NBR+'~';
           
           
            strBuildData+='~~';
            concatfromSecItr=true;   
            line_num++;  
       }
      //  strAwardId ='14SR178827';  //this line has to be commented after having proper data
        String strBody ='{ "grnt_id":"'+ strAwardId +'",';
        strBody +=strBuildData +'",';
        /*
        String strFormActionValue=(totalResponseFundCommitmentlines==0)? 'NEW' :'AMEND';
        //String strFormAction='"formAction":"AMEND",';
        String strFormAction='"formAction":"'+ strFormActionValue+'",';
        strBody +=strFormAction;
         String strAmendJustificationTxtValue=(totalResponseFundCommitmentlines==0)? null :'amendjustificationTxt';
       // String strAmendJustificationTxt='"amendjustificationTxt": "Testing Mule Trasfer"'; 
        String strAmendJustificationTxt='"amendjustificationTxt": "'+strAmendJustificationTxtValue+'"'; 
        strBody +=strAmendJustificationTxt+'       }' ;
        */
       
       String strFormAction='';
       String strFormActionValue='';
       String strAmendJustificationTxt='';
       String  strAmendJustificationTxtValue='';
       strApplicationType=objAward.Application_Type__c;
       System.debug('***strApplicationType***'+strApplicationType);
        System.debug('***strPrmApplicationType***'+strPrmApplicationType);
       if((strApplicationType!=null && strApplicationType!='' && strApplicationType.equalsignoreCase('New') )
                   || (strPrmApplicationType!=null && strPrmApplicationType!='' && (strPrmApplicationType.equalsignoreCase('New') ))){
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
        invokeFundCommitment(strBody );
      }  
   }
   
   public void invokeFundCommitment(String strBody){
       HttpResponse hResp;
       String json;
       String strHost=URL.getSalesforceBaseUrl().getHost();
       System.debug('Host: ' + strHost);
       String  endPointuri;
       String  uName;
       String  upassword;
       String  httpMethodName;
       String  contenttype;
        
        String strWSname='fundcommitment';
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
            //String strBody=composeBodyForFCLines(strAwardId);
        System.debug('endPointuri->'+endPointuri+''+'httpMethodName->'+httpMethodName+'uName->'+uName+'upassword->'+upassword+'contenttype->'+contenttype);
        CNCS_AuthorizeHttp objCNCS_AuthorizeHttp=new CNCS_AuthorizeHttp();

        try{
               //resp= objDemo.makeCallFundCommitmentSave(strAwardId,strBody);
               hResp=objCNCS_AuthorizeHttp.wsConnectAndSend(endPointuri,uName,upassword,httpMethodName,contenttype,strBody,false);
               System.debug('***resp***'+hResp);
               if(hResp!=null && hResp.getStatusCode()!=200){
                         throw new CNCS_ObjectUtility.CustomException('Status-->'+hResp.getStatus()+' StatusCode-->'+hResp.getStatusCode()+'  Message-->'+hResp.getBody().replace('\n', ''));
               }
               // the service is returning a line feed so parse it out
               json = hResp.getBody().replace('\n', '');
               System.debug('***json***'+json );
               
               ParseJSONUtil objParseJSONUtil= new ParseJSONUtil();
               ParseJSONUtil.FundCommitmentTransaction_JSON objDeserializedJsonForFundCommitmentTransaction_JSON=new ParseJSONUtil.FundCommitmentTransaction_JSON();
               List<ParseJSONUtil.FundCommitmentTransaction> lstFundCommitmentTransaction=new List<ParseJSONUtil.FundCommitmentTransaction>();
               objDeserializedJsonForFundCommitmentTransaction_JSON=objParseJSONUtil.parseFundCommitmentTransaction(json);
               lstFundCommitmentTransaction= objDeserializedJsonForFundCommitmentTransaction_JSON.lstData;
               System.debug('***lstFundCommitmentTransaction'+lstFundCommitmentTransaction);
               //ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Info,json ));
               if(lstFundCommitmentTransaction!=null && lstFundCommitmentTransaction.size() >0){
                     String strResultTxt=lstFundCommitmentTransaction[0].RESULT_TXT;
                     if(strResultTxt!=null && strResultTxt!='' && strResultTxt.equalsignoreCase('0~')){
                         //update;
                         objAward.Grant_Status__c='Awaiting GO Certification'; 
                         objAward.Committed__c = True;
                         update objAward;
                     }else{
                        
                          throw new CNCS_ObjectUtility.CustomException('Exception -> '+ strResultTxt+' .'); 
                     } 
                }
              
        }catch(System.DMLException de) {
                  System.debug('DML error: '+ de);
                  ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,de.getMessage()));
        }catch(System.CalloutException ce) {
                  System.debug('Callout error: '+ ce);
                  ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,ce.getMessage()));
                  //System.debug(resp.toString());
        } catch(CNCS_ObjectUtility.CustomException custExc) {
                  System.debug('Custom Exception '+ custExc);
                  ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,custExc.getMessage()));
        } catch(Exception exc){
                System.debug('***exc***'+exc.getMessage());
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,exc.getMessage()));
        }
    }
    
    //below method is no longer used
   /*
    public void invokeFundCommitment1(String strBody){
       HttpResponse resp;
       String json;
       // if(flagRecordsExists==false){
       DemoHandShakingMuleSoft objDemo= new DemoHandShakingMuleSoft();
       try{
               resp= objDemo.makeCallFundCommitmentSave(strAwardId,strBody);
               System.debug('***resp***'+resp);
               // the service is returning a line feed so parse it out
               json = resp.getBody().replace('\n', '');
               System.debug('***resp***'+resp );
               System.debug('***json***'+json );
               ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Info,json ));
        }catch(System.CalloutException ce) {
                  System.debug('Callout error: '+ ce);
                  ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,ce.getMessage()));
                  //System.debug(resp.toString());
        }
        catch(Exception exc){
                System.debug('***exc***'+exc.getMessage());
        }
   }
   */
}