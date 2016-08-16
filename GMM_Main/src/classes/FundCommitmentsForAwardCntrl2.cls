public class FundCommitmentsForAwardCntrl2{

    public ApexPages.StandardController stdcontroller;
     public Award__c objAward{get;set;}
     public List<Fund_Commitment__c> lstFundCommitment{get;set;}
     public String strAwardId{get;set;}
    
     public ParseJSONUtil.CommitmentFundsForGrantIdJSON objDeserializedJson{get;set;}
     public List<ParseJSONUtil.CommitmentFundsForGrantIdData> lstCommitmentFundsForGrantIdData{get;set;}
    // public List<CommitmentFundsForGrantIdDataWrapper> lstCommitmentFundsForGrantIdDataWrapper{get;set;}
    public boolean opFlg{get;set;}
    public boolean ipFlg{get;set;}
    
    public boolean showPopup {get;set;}
    public Fund_Commitment__c objFormFundCommitment{get;set;}
    public String Start_FY{get;set;}
    
    
    
     
     public FundCommitmentsForAwardCntrl2(ApexPages.StandardController p_controller){
       this.stdcontroller= p_controller;
       
      // stdcontroller.addFields(new List<String>{'name'});
       
       this.objAward= (Award__c )stdController.getrecord();
       strAwardId=objAward.name;
       System.debug('***objAward***'+objAward);
      
      // lstCommitmentFundsForGrantIdDataWrapper=new List<CommitmentFundsForGrantIdDataWrapper>();
      opFlg=true;
      ipFlg=false;
      
      showPopup = false;
    }
    
    
    public PageReference openPopup()
    {   System.debug('****openPopup****');
        showPopup = true;
        objFormFundCommitment=new Fund_Commitment__c ();
        return null;
    }
    
    public PageReference Cancel()
    {
        System.debug('****Cancel****');
        showPopup = false;
        System.debug('***Start_FY***'+Start_FY);
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
        HttpResponse resp;
        String json;
        
            DemoHandShakingMuleSoft objDemo= new DemoHandShakingMuleSoft();
            try{
               resp= objDemo.makeACall(strAwardId);
               System.debug('***resp***'+resp);
               // the service is returning a line feed so parse it out
               json = resp.getBody().replace('\n', '');
               System.debug('***resp***'+resp );
               System.debug('***json***'+json );
              
               objDeserializedJson= new ParseJSONUtil.CommitmentFundsForGrantIdJSON();
                 
               ParseJSONUtil objParseJSONUtil= new ParseJSONUtil();
               objDeserializedJson=objParseJSONUtil.parseCommitmentFundsForGrantId(json);
               System.debug('***objDeserializedJson in invokeFcLines***'+objDeserializedJson);
               lstCommitmentFundsForGrantIdData = objDeserializedJson.lstData;
               System.debug('***lstCommitmentFundsForGrantIdData '+lstCommitmentFundsForGrantIdData );
               //copyData();
               copyJSONDataToFundCommitmentStruct();
                     
            }catch(System.CalloutException ce) {
                  System.debug('Callout error: '+ ce);
                  ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,ce.getMessage()));
                  //System.debug(resp.toString());
            }
            catch(Exception exc){
                System.debug('***exc***'+exc.getMessage());
            }
       
    }
    
   public void copyJSONDataToFundCommitmentStruct(){
           
            System.debug('***lstCommitmentFundsForGrantIdData '+lstCommitmentFundsForGrantIdData );
            lstFundCommitment =new List<Fund_Commitment__c>();
            Fund_Commitment__c objFundCommitment;
            for(ParseJSONUtil.CommitmentFundsForGrantIdData itrCommitmentFundsForGrantIdData   :lstCommitmentFundsForGrantIdData ){
                System.debug('***itrCommitmentFundsForGrantIdData***'+itrCommitmentFundsForGrantIdData  );  
                objFundCommitment=new Fund_Commitment__c();
                //objFundCommitment.Award__c=objAward.id;//itrCommitmentFundsForGrantIdData.DOC_NUM;
                objFundCommitment.Start_FY__c=itrCommitmentFundsForGrantIdData.FISCAL_YR_1_NBR;
                objFundCommitment.Ending_FY__c =itrCommitmentFundsForGrantIdData.FISCAL_YR_2_NBR;
                objFundCommitment.Fund__c=itrCommitmentFundsForGrantIdData.FUND_CD;
                objFundCommitment.Grant_Location__c=itrCommitmentFundsForGrantIdData.GRNT_LOCATION_NBR;
                objFundCommitment.Object_Class__c=itrCommitmentFundsForGrantIdData.OBJ_CLASS_CD;
                objFundCommitment.Program__c=itrCommitmentFundsForGrantIdData.PGM_MGR_CD;//PROG_ID;
                objFundCommitment.Purpose__c=itrCommitmentFundsForGrantIdData.PURPOSE_CD;
                objFundCommitment.Current_Amount__c=(itrCommitmentFundsForGrantIdData!=null && itrCommitmentFundsForGrantIdData.LINE_COMMITTED_AMT!=null)? Decimal.Valueof(itrCommitmentFundsForGrantIdData.LINE_COMMITTED_AMT):0;
                lstFundCommitment.add(objFundCommitment);
            }
             System.debug('***lstFundCommitment***'+lstFundCommitment);   
     
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
       for( Fund_Commitment__c itrObjFund_Commitment  :lstFundCommitment){
            
            Double chng=(itrObjFund_Commitment!=null && itrObjFund_Commitment.Change__c!=null)? Double.valueof(itrObjFund_Commitment.Change__c) : 0;
           // Decimal chng=(objCommitmentFundsForGrantIdData!=null && objCommitmentFundsForGrantIdData.Change!=null)? Decimal.valueof(objCommitmentFundsForGrantIdData.Change) : 0;
           /* if(itrObjFund_Commitment  !=null && itrObjFund_Commitment.Change__c!=null){
                chng= double.valueof(itrObjFund_Commitment.Change__c) ;
            }
            else{
               chng=0; 
            }*/
          
           Double total_amt=Double.valueof(itrObjFund_Commitment.Current_Amount__c)+chng;
           if (concatfromSecItr==true) {
                strBuildData+='~';
            }
            
            strBuildData+=line_num+'~';
            strBuildData+=total_amt+'~';
            strBuildData+='01'+'~';
            strBuildData+=itrObjFund_Commitment.Start_FY__c+'~';
            
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
            
            strBuildData+='07/01/2014'+'~';
            strBuildData+='06/30/2015'+'~';
            
            strBuildData+='~~';
            concatfromSecItr=true;   
            line_num++;  
       }
       
        String strBody ='{ "grnt_id":"'+ strAwardId +'",';
        strBody +=strBuildData +'",';
        String strFormAction='"formAction":"AMEND",';
        strBody +=strFormAction;
        String strAmendJustificationTxt='"amendjustificationTxt": "Testing Mule Trasfer"'; 
        strBody +=strAmendJustificationTxt+'       }' ;
       
        System.debug('***strBody***'+strBody );
        invokeFundCommitment(strBody );

   }
   
   public void invokeFundCommitment(String strBody){
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
    
    


}