Global  class DemoHandShakingMuleSoft {

   // HttpRequest req;
  //  HttpResponse resp;
    
    public DemoHandShakingMuleSoft(){
        System.debug('***DemoHandShakingMuleSoft');
    
    }
    
    // call the  service
         public HttpResponse makeACall(String strGrantId){

            String json;
        HttpRequest     req = new HttpRequest();
        HttpResponse     resp = new HttpResponse();
             Http http = new Http();
         // set the method
             req.setMethod('POST');
             // generate the url for the request
            
              //007
              //15SR400737
             //  String url='https://cncs-api-dev.cloudhub.io/momentum?gmmId='+strAppId ;
            //  String url='https://cncs-api.cloudhub.io/momentum/fcLines?gmmId='+strAppId ;
               String url='https://cncs-api.cloudhub.io/momentum/fcLines';
            
            //String strinfranet_acct_num='16587589';
             
             System.debug('***url***'+url );
             // add the endpoint to the request 
             req.setEndpoint(url);
            // req.setBody('infranet_acct_num='+EncodingUtil.urlEncode(strinfranet_acct_num, 'UTF-8'));
             
             req.setTimeout(2*60*1000);
             String userName='mule';
             String passWord='mul3!';
             Blob headerValue=Blob.valueOf(userName+':' +password);
             String authorizationHeader ='Basic '+ EncodingUtil.base64Encode(headerValue);
             req.setHeader('Authorization',authorizationHeader);
             //req.setHeader('Content-Type', 'text/plain;charset=UTF-8');

             req.setHeader('Content-Type','application/json');
             
            
             //req.setClientCertificateName('certname';)
             // create the response object
             
            // String strBody = '{  "grant_id":"14SR178827" }';
             String  strBody =composeBodyForFCLines(strGrantId);
             System.debug('***strBody ***'+strBody );
             req.setBody(strBody );
             
             try{
              resp = http.send(req);
             // the service is returning a line feed so parse it out
             json = resp.getBody().replace('\n', '');
             System.debug('***resp***'+resp );
             System.debug('***json***'+json );
             
             
             ParseJSONUtil.CommitmentFundsForGrantIdJSON objDeserializedJson= new ParseJSONUtil.CommitmentFundsForGrantIdJSON();
             
             ParseJSONUtil objParseJSONUtil= new ParseJSONUtil();
             objDeserializedJson=objParseJSONUtil.parseCommitmentFundsForGrantId(json);
             System.debug('***objDeserializedJson***'+objDeserializedJson);
             
            /// processUpsertDeserializedData(objDeserializedJson,objAccount);
             
             
             }
             catch(System.CalloutException e) {
                    System.debug('Callout error: '+ e);
                    System.debug(resp.toString());
             }
             catch(Exception exc){
                System.debug('***exc***'+exc );
             }
             return resp;
         }
         
         
         public HttpResponse makeCallFundCommitmentSave(String strGrantId,String strBody){

            String json;
             HttpRequest req = new HttpRequest();
             HttpResponse resp = new HttpResponse();
             Http http = new Http();
         // set the method
             req.setMethod('PUT');
             // generate the url for the request
            
           
               String url='https://cncs-api.cloudhub.io/momentum/fundcommitment';
            
           
             
             System.debug('***url***'+url );
             // add the endpoint to the request 
             req.setEndpoint(url);
            
             
             req.setTimeout(2*60*1000);
             String userName='mule';
             String passWord='mul3!';
             Blob headerValue=Blob.valueOf(userName+':' +password);
             String authorizationHeader ='Basic '+ EncodingUtil.base64Encode(headerValue);
             req.setHeader('Authorization',authorizationHeader);
             //req.setHeader('Content-Type', 'text/plain;charset=UTF-8');

             req.setHeader('Content-Type','application/json');
                        
             // create the response object
             
          /*   String strbody = '{ "grnt_id": "14SR178827",';
             strbody +='         "buildData":"1~95000~01~2014~~OPE1~P~P74~22207~4101~OPO~~07/01/2014~06/30/2015~~~~2~68750~01~2015~~OPE1~P~P74~22207~4101~OPO~~07/01/2014~03/31/2016~~~~3~-7000~01~2015~~OPE1~P~P74~22207~4101~OPO~~07/01/2014~03/31/2016~~~",';
             strbody +='         "formAction":"AMEND",';
             strbody +='         "amendjustificationTxt": "Geetha Testing Mule Trasfer"';
             strbody +='       }'; */
             req.setBody(strbody);
             
             try{
              resp = http.send(req);
             // the service is returning a line feed so parse it out
             json = resp.getBody().replace('\n', '');
             System.debug('***resp***'+resp );
             System.debug('***json***'+json );
             
             
            ///// ParseJSONUtil.CommitmentFundsForGrantIdJSON objDeserializedJson= new ParseJSONUtil.CommitmentFundsForGrantIdJSON();
             
            ///// ParseJSONUtil objParseJSONUtil= new ParseJSONUtil();
           /////  objDeserializedJson=objParseJSONUtil.parseCommitmentFundsForGrantId(json);
           /////  System.debug('***objDeserializedJson***'+objDeserializedJson);
             
            /// processUpsertDeserializedData(objDeserializedJson,objAccount);
             
             
             }
             catch(System.CalloutException e) {
                    System.debug('Callout error: '+ e);
                    System.debug(resp.toString());
             }
             catch(Exception exc){
                System.debug('***exc***'+exc );
             }
             return resp;
         }
         
         public String composeBodyForFCLines(String strGrantId){
         
         //'{  "grant_id":"14SR178827" }'
          String strBody ='{ "grant_id":"'+ strGrantId +'" }';
          return strBody;
       
         }
         
         public String composeBodyForFundCommitment(String p_strGrantId){
          String strBody ='';
          
         /* Fund_Commitment__c objFundCommitment =[SELECT id,name,Award__c,Beginning_FY__c,Change__c, Current_Amount__c,Ending_FY__c,Fund__c,Grant_Location__c,
                                                          New_Total__c,Object_Class__c,Program__c,Purpose__c,Start_FY__c
                                                 FROM  Fund_Commitment__c Where ];        
          */
          
          List<Award__c> lstAward = [SELECT id,name, 
                                      (SELECT id,name,Award__c,Beginning_FY__c,Change__c, Current_Amount__c,Ending_FY__c,Fund__c,Grant_Location__c,
                                                          New_Total__c,Object_Class__c,Program__c,Purpose__c,Start_FY__c 
                                       FROM Fund_Commitment__r limit 1 ) 
                               FROM    Award__c  
                               WHERE name= :p_strGrantId ];
                               
           String strGrantId='';
           String strBuildData='"buildData":';
           String strFormAction='"formAction":"AMEND",';
           String strAmendJustificationTxt='"amendjustificationTxt": "Testing Mule Trasfer"'; 
           
                              
          // decimal LINE_COMMITTED_AMT;
          // deciaml CHANGE_AMT;
           decimal total_amt; 
           integer line_num=1;                   
           for(Award__c itrAward :lstAward){
               Fund_Commitment__c itrFundCommitment =itrAward.Fund_Commitment__r ;
               total_amt=itrFundCommitment.Current_Amount__c+itrFundCommitment.Change__c;
              
              // itrFundCommitment.Beginning_FY__c;
              //itrFundCommitment.Ending_FY__c;
              //itrFundCommitment.Fund__c
              //itrFundCommitment.Purpose__c-first char
              //itrFundCommitment.Purpose__c
            //  Grant_Location__c
             //   Object_Class__c
            //        Program__c
             //       ~~
            //        Start_FY__c
           //             Ending_FY__c
           //             ~
           //             NULL
           //             NULL
            //            NULL
               
            strBuildData+=line_num+'~';
            strBuildData+=total_amt+'~';
            strBuildData+='01'+'~';
            strBuildData+=itrFundCommitment.Beginning_FY__c+'~';
            strBuildData+=itrFundCommitment.Ending_FY__c+'~';
            strBuildData+=itrFundCommitment.Fund__c+'~';
            strBuildData+=itrFundCommitment.Purpose__c+'~';//-first char
            strBuildData+=itrFundCommitment.Purpose__c+'~';
            strBuildData+=itrFundCommitment.Grant_Location__c+'~';
            strBuildData+=itrFundCommitment.Object_Class__c+'~';
            strBuildData+=itrFundCommitment.Program__c+'~';
            strBuildData+='~';
            strBuildData+=itrFundCommitment.Start_FY__c+'~';
            strBuildData+=itrFundCommitment.Ending_FY__c+'~';
            strBuildData+='~'+NULL+'~'+NULL+'~'+NULL;
             
           }                         
           strBuildData+=',';                        
          
          
          
          
          return strBody;
       
         }
         
         public HttpResponse calltoObligationDataFor_mech_supp_cd(String strsupp_mech_cd){
            strsupp_mech_cd='12SRSFL022';
            String json;
            HttpRequest     req = new HttpRequest();
            HttpResponse     resp = new HttpResponse();
            Http http = new Http();
            // set the method
            req.setMethod('POST');
            
            String url='https://cncs-api.cloudhub.io/momentum/oblData';
            System.debug('***url***'+url );
             // add the endpoint to the request 
             req.setEndpoint(url);
             req.setTimeout(2*60*1000);
             String userName='mule';
             String passWord='mul3!';
             Blob headerValue=Blob.valueOf(userName+':' +password);
             String authorizationHeader ='Basic '+ EncodingUtil.base64Encode(headerValue);
             req.setHeader('Authorization',authorizationHeader);
             req.setHeader('Content-Type','application/json');
             // create the response object
             
             // String strBody = '{  "grant_id":"14SR178827" }';
             String  strBody =composeBodyForObligationData(strsupp_mech_cd);
             System.debug('***strBody ***'+strBody );
             req.setBody(strBody );
             
             try{
              resp = http.send(req);
             // the service is returning a line feed so parse it out
             json = resp.getBody().replace('\n', '');
             System.debug('***resp***'+resp );
             System.debug('***json***'+json );
 
 /*            ParseJSONUtil.CommitmentFundsForGrantIdJSON objDeserializedJson= new ParseJSONUtil.CommitmentFundsForGrantIdJSON();
             
             ParseJSONUtil objParseJSONUtil= new ParseJSONUtil();
             objDeserializedJson=objParseJSONUtil.parseCommitmentFundsForGrantId(json);
             System.debug('***objDeserializedJson***'+objDeserializedJson);
      */       
            /// processUpsertDeserializedData(objDeserializedJson,objAccount);
             
             
             }
             catch(System.CalloutException e) {
                    System.debug('Callout error: '+ e);
                    System.debug(resp.toString());
             }
             catch(Exception exc){
                System.debug('***exc***'+exc );
             }
             return resp;
         }
         
         public String composeBodyForObligationData(String strsupp_mech_cd){
        
          String strBody ='{ "supp_mech_cd":'+'"'+ strsupp_mech_cd+'" }';
          return strBody;
       
         }
         

}