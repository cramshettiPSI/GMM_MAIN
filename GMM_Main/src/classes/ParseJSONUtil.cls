public  class ParseJSONUtil {
   
    public class CommitmentFundsForGrantIdData{
        public String  GRNT_LOCATION_NBR{get;set;}
        public String  FISCAL_YR_2_NBR{get;set;}
        public String  PGM_MGR_CD{get;set;}
        public String  FUND_ID{get;set;}
        public String  PURPOSE_CD{get;set;}
        public String  MRN_UIDY_ID{get;set;}
        public String  LINE_COMMITTED_AMT{get;set;}
        public String  OBJ_CLASS_CD{get;set;}
        public String  PROG_ID{get;set;}
        public String  DOC_NUM{get;set;}
        public String  FUND_CD{get;set;}
        public String  BDOB_ID{get;set;}
        public String  FISCAL_YR_1_NBR{get;set;}
        public String  END_DT{get;set;}
        public String  START_DT{get;set;}
        public String  PARN_OF_LINE_ID{get;set;}
        public String  LNUM{get;set;}
        public String  ORGN_ID{get;set;}
        public String  ACTY_ID{get;set;}
        public String  CHANGE{get;set;}
        public String  ERROR{get;set;}
        
        public CommitmentFundsForGrantIdData(){
            
        }

    }
    
    
    public class CommitmentFundsForGrantIdJSON{
        
        public string status;
        public string error_code;
        public string error_message;
        public List<CommitmentFundsForGrantIdData> lstData;
         
        public  CommitmentFundsForGrantIdJSON(){
            lstData= new List<CommitmentFundsForGrantIdData>();
        }
        
        public  CommitmentFundsForGrantIdJSON(String p_status,String p_error_code,String p_error_message){
            status=p_status;
            error_code=p_error_code;
            error_message=p_error_message;
            lstData= new List<CommitmentFundsForGrantIdData>();
        }
        
    }
    
   public CommitmentFundsForGrantIdJSON parseCommitmentFundsForGrantId(String strJSON){
       /* CommitmentFundsForGrantIdJSON objCommitmentFundsForGrantIdJSON =new CommitmentFundsForGrantIdJSON();
        objCommitmentFundsForGrantIdJSON =(CommitmentFundsForGrantIdJSON)JSON.deserialize(strJSON, ParseJSONUtil.CommitmentFundsForGrantIdJSON.class);
        System.debug('**objCommitmentFundsForGrantIdJSON**'+objCommitmentFundsForGrantIdJSON);
        System.debug('data***'+objCommitmentFundsForGrantIdJSON.lstData);
        return objCommitmentFundsForGrantIdJSON ;
        */
        
        CommitmentFundsForGrantIdJSON objCommitmentFundsForGrantIdJSON =new CommitmentFundsForGrantIdJSON();
        objCommitmentFundsForGrantIdJSON.lstData =(List<CommitmentFundsForGrantIdData>)JSON.deserialize(strJSON, List<ParseJSONUtil.CommitmentFundsForGrantIdData>.class);
        System.debug('**objCommitmentFundsForGrantIdJSON**'+objCommitmentFundsForGrantIdJSON);
        System.debug('data***'+objCommitmentFundsForGrantIdJSON.lstData);
        return objCommitmentFundsForGrantIdJSON ;
   }
    
    //below method is no longer used
     public List<CommitmentFundsForGrantIdData> parseCommitmentFundsForGrantId1(String strJSON){
       
       List<CommitmentFundsForGrantIdData> objCommitmentFundsForGrantIdData =(List<CommitmentFundsForGrantIdData>)JSON.deserialize(strJSON, List<ParseJSONUtil.CommitmentFundsForGrantIdData>.class);
        System.debug('**CommitmentFundsForGrantIdData**'+objCommitmentFundsForGrantIdData );
        //System.debug('data***'+objCommitmentFundsForGrantIdJSON.lstData);
        return objCommitmentFundsForGrantIdData ;
    }
    
    
    public class FundCommitmentTransaction{
        public    String STATUS_CD{get;set;}
        public    String GRNT_ID{get;set;}
        public    String RESULT_TXT{get;set;}
        public FundCommitmentTransaction(){
        }
    }
    
    public class FundCommitmentTransaction_JSON{
        public string status;
        public string error_code;
        public string error_message;
        public List<FundCommitmentTransaction> lstData;
         
        public  FundCommitmentTransaction_JSON(){
            lstData= new List<FundCommitmentTransaction>();
        }
        
        public  FundCommitmentTransaction_JSON(String p_status,String p_error_code,String p_error_message){
            status=p_status;
            error_code=p_error_code;
            error_message=p_error_message;
            lstData= new List<FundCommitmentTransaction>();
        }
    }
    
    public FundCommitmentTransaction_JSON  parseFundCommitmentTransaction(String strJSON){
        FundCommitmentTransaction_JSON objFundCommitmentTransaction_JSON=new FundCommitmentTransaction_JSON();
        objFundCommitmentTransaction_JSON.lstData=(List<FundCommitmentTransaction>)JSON.deserialize(strJSON, List<ParseJSONUtil.FundCommitmentTransaction>.class);
        System.debug('**objFundCommitmentTransaction_JSON**'+objFundCommitmentTransaction_JSON);
        System.debug('data***'+objFundCommitmentTransaction_JSON.lstData);
        return objFundCommitmentTransaction_JSON;
    }
    
    
    
    public class ObligationDataFor_supp_mech_cd{
      public   String OBL_PARN_OF_LINE_ID{get;set;}
      public   String  GRNT_LOCATION_NBR{get;set;}
      public   String  COMLN_UIDY_ID{get;set;}
      public   String  LINE_EXPENSE_AMT{get;set;}
      public   String  COM_STAE_OF_LINE{get;set;}
      public   String  FUND_ID{get;set;}
      public   String  PGM_MGR_CD{get;set;}
      public   String  REFD_LINE_ID{get;set;}
      public   String  COM_PARN_OF_LINE_ID{get;set;}
      public   String  OBL_TRANS_TYPE{get;set;}
      public   String  PROG_ID{get;set;}
      public   String  END_DT{get;set;}
      public   String  START_DT{get;set;}
      public   String  ORGN_ID{get;set;}
      public   String  OBL_DOC_TYPE{get;set;}
      public   String  LINE_PAID_AMT{get;set;}
      public   String  COM_DOC_NUM{get;set;}
      public   String  FISCAL_YR_2_NBR{get;set;}
      public   String  PURPOSE_CD{get;set;}
      public   String  LINE_COMMITTED_AMT{get;set;}
      public   String  COM_TRANS_TYPE{get;set;}
      public   String  OBJ_CLASS_CD{get;set;}
      public   String  FUND_CD{get;set;}
      public   String  BDOB_ID{get;set;}
      public   String  FISCAL_YR_1_NBR{get;set;}
      public   String  OBLN_UIDY_ID{get;set;}
      public   String  LINE_AVAIL_DEOB_AMT{get;set;}
      public   String  OBL_LNUM{get;set;}
      public   String  LINE_OBLIGATED_AMT{get;set;}
      public   String  OBL_DOC_NUM{get;set;}
      public   String  ACTY_ID{get;set;}
      public   String  COM_LNUM{get;set;}
      public    String ERROR{get;set;}
      
        
      public ObligationDataFor_supp_mech_cd(){
            
        }
  
    }
    
    
    public class ObligationDataFor_supp_mech_cd_JSON{
        
        public string status;
        public string error_code;
        public string error_message;
        public List<ObligationDataFor_supp_mech_cd> lstData;
         
        public  ObligationDataFor_supp_mech_cd_JSON(){
            lstData= new List<ObligationDataFor_supp_mech_cd>();
        }
        
        public  ObligationDataFor_supp_mech_cd_JSON(String p_status,String p_error_code,String p_error_message){
            status=p_status;
            error_code=p_error_code;
            error_message=p_error_message;
            lstData= new List<ObligationDataFor_supp_mech_cd>();
        }
        
    }
    
    
    
    
    public List<ObligationDataFor_supp_mech_cd> parseObligationDataFor_supp_mech_cd(String strJSON){
       
       List<ObligationDataFor_supp_mech_cd> objObligationDataFor_supp_mech_cd =(List<ObligationDataFor_supp_mech_cd>)JSON.deserialize(strJSON, List<ParseJSONUtil.ObligationDataFor_supp_mech_cd>.class);
        System.debug('**objObligationDataFor_supp_mech_cd **'+objObligationDataFor_supp_mech_cd );
        //System.debug('data***'+objCommitmentFundsForGrantIdJSON.lstData);
        return objObligationDataFor_supp_mech_cd ;
    }
    
    public class ObligationFundTransaction{
        public    String STATUS_CD{get;set;}
        public    String GRNT_ID{get;set;}
        public    String RESULT_TXT{get;set;}
    
        public ObligationFundTransaction(){
        
        }
    }
    
    public class ObligationFundTransaction_JSON{
        
        public string status;
        public string error_code;
        public string error_message;
        public List<ObligationFundTransaction> lstData;
         
        public  ObligationFundTransaction_JSON(){
            lstData= new List<ObligationFundTransaction>();
        }
        
        public  ObligationFundTransaction_JSON(String p_status,String p_error_code,String p_error_message){
            status=p_status;
            error_code=p_error_code;
            error_message=p_error_message;
            lstData= new List<ObligationFundTransaction>();
        }
        
    }
    
    public ObligationFundTransaction_JSON  parseObligationFundTransaction(String strJSON){
    
     /* CommitmentFundsForGrantIdJSON objCommitmentFundsForGrantIdJSON =new CommitmentFundsForGrantIdJSON();
        objCommitmentFundsForGrantIdJSON.lstData =(List<CommitmentFundsForGrantIdData>)JSON.deserialize(strJSON, List<ParseJSONUtil.CommitmentFundsForGrantIdData>.class);
        System.debug('**objCommitmentFundsForGrantIdJSON**'+objCommitmentFundsForGrantIdJSON);
        System.debug('data***'+objCommitmentFundsForGrantIdJSON.lstData);
        return objCommitmentFundsForGrantIdJSON ; */
        
        ObligationFundTransaction_JSON objObligationFundTransaction_JSON=new ObligationFundTransaction_JSON();
        objObligationFundTransaction_JSON.lstData=(List<ObligationFundTransaction>)JSON.deserialize(strJSON, List<ParseJSONUtil.ObligationFundTransaction>.class);
        System.debug('**objObligationFundTransaction_JSON**'+objObligationFundTransaction_JSON);
        System.debug('data***'+objObligationFundTransaction_JSON.lstData);
        return objObligationFundTransaction_JSON;
       
       /*List<ObligationFundTransaction> lstObligationFundTransaction =(List<ObligationFundTransaction>)JSON.deserialize(strJSON, List<ParseJSONUtil.ObligationFundTransaction>.class);
       System.debug('**lstObligationFundTransaction **'+lstObligationFundTransaction );
       return lstObligationFundTransaction ;*/
    }
  
  //below method is no longer used  
    public List<ObligationFundTransaction> parseObligationFundTransaction1(String strJSON){
    
     /* CommitmentFundsForGrantIdJSON objCommitmentFundsForGrantIdJSON =new CommitmentFundsForGrantIdJSON();
        objCommitmentFundsForGrantIdJSON.lstData =(List<CommitmentFundsForGrantIdData>)JSON.deserialize(strJSON, List<ParseJSONUtil.CommitmentFundsForGrantIdData>.class);
        System.debug('**objCommitmentFundsForGrantIdJSON**'+objCommitmentFundsForGrantIdJSON);
        System.debug('data***'+objCommitmentFundsForGrantIdJSON.lstData);
        return objCommitmentFundsForGrantIdJSON ; */
       
       List<ObligationFundTransaction> lstObligationFundTransaction =(List<ObligationFundTransaction>)JSON.deserialize(strJSON, List<ParseJSONUtil.ObligationFundTransaction>.class);
       System.debug('**lstObligationFundTransaction **'+lstObligationFundTransaction );
       return lstObligationFundTransaction ;
    }
    
    public class FFRDataForGrantId{
       public String BALANCE_UNDRAWN_AMT{get;set;}
       public String  DISBURSED_AMT{get;set;}
       public String  FED_EXPENDITURES_AMT{get;set;}
       public String  OBLIGATION_AMT{get;set;}
       public String  BALANCE_UNEXPENDED_AMT{get;set;}
       
       public FFRDataForGrantId(){
       
       }
    }

   public class FFRDataForGrantIdJSON{

        public string status;
        public string error_code;
        public string error_message;
        public List<FFRDataForGrantId> lstData;
         
        public  FFRDataForGrantIdJSON(){
            lstData= new List<FFRDataForGrantId>();
        }
        
        public  FFRDataForGrantIdJSON(String p_status,String p_error_code,String p_error_message){
            status=p_status;
            error_code=p_error_code;
            error_message=p_error_message;
            lstData= new List<FFRDataForGrantId>();
        }
   }
    
    public FFRDataForGrantIdJSON parseFFRDataForGrantIdJSON(String strJSON){
      
        FFRDataForGrantIdJSON objFFRDataForGrantIdJSON =new FFRDataForGrantIdJSON();
        objFFRDataForGrantIdJSON.lstData =(List<FFRDataForGrantId>)JSON.deserialize(strJSON, List<ParseJSONUtil.FFRDataForGrantId>.class);
        System.debug('**objFFRDataForGrantIdJSON**'+objFFRDataForGrantIdJSON);
        System.debug('data***'+objFFRDataForGrantIdJSON.lstData);
        return objFFRDataForGrantIdJSON;
   }
   
   
   public class GrantCloseOutForSuppMechCD{
   
        public String BALANCE_UNDRAWN_AMT{get;set;}
        public String CLOSED_IND{get;set;}
        public String EXCESS_CASH_RETURN_AMT{get;set;}
        public String DEOBLIGATION_AMT{get;set;}
        public String ADVANCED_AMT{get;set;}
        public String BALANCE_UNEXPENDED_AMT{get;set;}
        public String DOC_NUM{get;set;}
        public String ACCEPTED_AMT{get;set;}
        public String DISBURSED_AMT{get;set;}
        public String FED_EXPENDITURES_AMT{get;set;}
        public String EXPENDED_AMT{get;set;}
        public String OBLIGATION_AMT{get;set;}
        public String APPLIED_ADVANCED_AMT{get;set;}
   
       
       public GrantCloseOutForSuppMechCD(){
       
       }
    }
    
     public class GrantCloseOutForSuppMechCDJSON{
        public string status;
        public string error_code;
        public string error_message;
        public List<GrantCloseOutForSuppMechCD> lstData;
         
        public  GrantCloseOutForSuppMechCDJSON(){
            lstData= new List<GrantCloseOutForSuppMechCD>();
        }
        
        public  GrantCloseOutForSuppMechCDJSON(String p_status,String p_error_code,String p_error_message){
            status=p_status;
            error_code=p_error_code;
            error_message=p_error_message;
            lstData= new List<GrantCloseOutForSuppMechCD>();
        }
     }
    
     public GrantCloseOutForSuppMechCDJSON    parseGrantCloseOutForSuppMechCDJSON(String strJSON){
     
        GrantCloseOutForSuppMechCDJSON    objGrantCloseOutForSuppMechCDJSON=new GrantCloseOutForSuppMechCDJSON();
        objGrantCloseOutForSuppMechCDJSON.lstData =(List<GrantCloseOutForSuppMechCD>)JSON.deserialize(strJSON, List<ParseJSONUtil.GrantCloseOutForSuppMechCD>.class);
        System.debug('**objGrantCloseOutForSuppMechCDJSON**'+objGrantCloseOutForSuppMechCDJSON);
        System.debug('data***'+objGrantCloseOutForSuppMechCDJSON.lstData);
        return objGrantCloseOutForSuppMechCDJSON;
      
     }
     
     public class AwardForgrnt_id{
   
       public String p_status_cd{get;set;}
       public AwardForgrnt_id(){
       
       }
    }
    
    public class AwardForgrnt_idJSON{
        public string status;
        public string error_code;
        public string error_message;
        public List<AwardForgrnt_id> lstData;
         
        public  AwardForgrnt_idJSON(){
            lstData= new List<AwardForgrnt_id>();
        }
        
        public  AwardForgrnt_idJSON(String p_status,String p_error_code,String p_error_message){
            status=p_status;
            error_code=p_error_code;
            error_message=p_error_message;
            lstData= new List<AwardForgrnt_id>();
        }
     }
     
     public AwardForgrnt_idJSON    parseAwardForgrnt_idJSON(String strJSON){
     
        System.debug('**parseAwardForgrnt_idJSON->strJSON***'+strJSON);
        AwardForgrnt_idJSON    objAwardForgrnt_idJSON=new AwardForgrnt_idJSON();
        objAwardForgrnt_idJSON.lstData =(List<AwardForgrnt_id>)JSON.deserialize(strJSON, List<ParseJSONUtil.AwardForgrnt_id>.class);
        System.debug('**objAwardForgrnt_idJSON**'+objAwardForgrnt_idJSON);
        System.debug('data***'+objAwardForgrnt_idJSON.lstData);
        return objAwardForgrnt_idJSON;
        
        
      /*  GrantCloseOutForSuppMechCDJSON    objGrantCloseOutForSuppMechCDJSON=new GrantCloseOutForSuppMechCDJSON();
        objGrantCloseOutForSuppMechCDJSON.lstData =(List<GrantCloseOutForSuppMechCD>)JSON.deserialize(strJSON, List<ParseJSONUtil.GrantCloseOutForSuppMechCD>.class);
        System.debug('**objGrantCloseOutForSuppMechCDJSON**'+objGrantCloseOutForSuppMechCDJSON);
        System.debug('data***'+objGrantCloseOutForSuppMechCDJSON.lstData);
        return objGrantCloseOutForSuppMechCDJSON;
      */
     }
    
    
    public class MomCloseOutForgrnt_id{
   
       public String GRNT_ID{get;set;}
       public String RESULT_TXT{get;set;}
       public MomCloseOutForgrnt_id(){
       
       }
    }
    
    public class MomCloseOutForgrnt_idJSON{
        public string status;
        public string error_code;
        public string error_message;
        public List<MomCloseOutForgrnt_id> lstData;
         
        public  MomCloseOutForgrnt_idJSON(){
            lstData= new List<MomCloseOutForgrnt_id>();
        }
        
        public  MomCloseOutForgrnt_idJSON(String p_status,String p_error_code,String p_error_message){
            status=p_status;
            error_code=p_error_code;
            error_message=p_error_message;
            lstData= new List<MomCloseOutForgrnt_id>();
        }
     }
     
     public MomCloseOutForgrnt_idJSON parseMomCloseOutForgrnt_idJSON(String strJSON){
     
     
        MomCloseOutForgrnt_idJSON    objMomCloseOutForgrnt_idJSON=new MomCloseOutForgrnt_idJSON();
        objMomCloseOutForgrnt_idJSON.lstData =(List<MomCloseOutForgrnt_id>)JSON.deserialize(strJSON, List<ParseJSONUtil.MomCloseOutForgrnt_id>.class);
        System.debug('**objMomCloseOutForgrnt_idJSON**'+objMomCloseOutForgrnt_idJSON);
        System.debug('data***'+objMomCloseOutForgrnt_idJSON.lstData);
        return objMomCloseOutForgrnt_idJSON;
     
      
     }
     
     
     public class ValidatePMForgrnt_id{
   
       public String status_cd{get;set;}
       public validatePMForgrnt_id(){
       
       }
    }
    
    public class ValidatePMForgrnt_idJSON{
        public string status;
        public string error_code;
        public string error_message;
        public List<ValidatePMForgrnt_id> lstData;
         
        public  ValidatePMForgrnt_idJSON(){
            lstData= new List<ValidatePMForgrnt_id>();
        }
        
        public  ValidatePMForgrnt_idJSON(String p_status,String p_error_code,String p_error_message){
            status=p_status;
            error_code=p_error_code;
            error_message=p_error_message;
            lstData= new List<ValidatePMForgrnt_id>();
        }
     }
     
     public ValidatePMForgrnt_idJSON parseValidatePMForgrnt_idJSON(String strJSON){

       ValidatePMForgrnt_idJSON    objValidatePMForgrnt_idJSON=new ValidatePMForgrnt_idJSON();
        objValidatePMForgrnt_idJSON.lstData =(List<ValidatePMForgrnt_id>)JSON.deserialize(strJSON, List<ParseJSONUtil.ValidatePMForgrnt_id>.class);
        System.debug('**objMomCloseOutForgrnt_idJSON**'+objValidatePMForgrnt_idJSON);
        System.debug('data***'+objValidatePMForgrnt_idJSON.lstData);
        return objValidatePMForgrnt_idJSON;
           
     }
 
/*
   public ActiveServiceJSON parseGetActiveServices(String strJSON){
        
        
        //Department d = (Department)JSON.deserialize(jsonToParse, JsonParserTests.Department.class);
        
        ActiveServiceJSON objActiveServiceJSON =new ActiveServiceJSON();
        ActiveServiceJSON objActiveServiceJSON2 =new ActiveServiceJSON();
        
        ///ActiveServiceData x= new ActiveServiceData(); 
        ///x=(ActiveServiceData)JSON.deserialize(strJSON, ParseJSONUtil.ActiveServiceData.class);
        ///System.debug('**ActiveServiceData x**'+x);
        //objActiveServiceJSON=(ActiveServiceJSON)JSON.deserialize(strJSON, ParseJSONUtil.ActiveServiceJSON.class);
        
        objActiveServiceJSON2=(ActiveServiceJSON)JSON.deserialize(strJSON, ParseJSONUtil.ActiveServiceJSON.class);
        System.debug('**objActiveServiceJSON2**'+objActiveServiceJSON2);
        
        System.debug('data***'+objActiveServiceJSON2.data);
        
        
        
        
        
        
        /*Map<String, Object> mpParent = (Map<String, Object>)JSON.deserializeUntyped(strJSON);
        Map<String, Object>  mpChild=(Map<String, Object>)mpParent.get('data'); 
        //List<decimal> d=new List<decimal>();
       ActiveServiceData objActiveServiceData;
       List<ActiveServiceData> lstTempActiveServiceData;
       
       objActiveServiceJSON.status=(String)mpParent.get('status');
       objActiveServiceJSON.error_code=(String)mpParent.get('error_code');
       objActiveServiceJSON.error_message=(String)mpParent.get('error_message');
      
       for(String chd:mpChild.keyset()){
            System.debug('***'+chd);
            objActiveServiceData=new ActiveServiceData();
         //     objActiveServiceData=s;
                
            //decimal t=(decimal)m2.get(s);
            //d.add(t);
        }*/
       ///// return objActiveServiceJSON2;
        
   ///// }

  
}