public class CNCS_AuthorizeHttp{
    String consumerKey;
    String consumerSecret;
    String uName;
    String uPassword;
    Boolean isSandbox;
    String uri;
    
    String accessToken;
    
    public class MyException extends Exception {}
    
    public CNCS_AuthorizeHttp(){
    
    
    }
    
    public CNCS_AuthorizeHttp(String consumerKey, String consumerSecret, String uName, String uPassword, Boolean isSandbox){
        this.consumerKey = consumerKey;
        this.consumerSecret = consumerSecret;
        this.uName = uName;
        this.uPassword = uPassword;
        this.isSandbox = isSandbox;
    }
    
    public HttpResponse wsConnectAndSend(String uri,String uName,String uPassword,String strHttpMethod,String strContentType,String strReqBody,Boolean oAuthorizeRequest){
    
        if (Limits.getCallouts() == Limits.getLimitCallouts())
            throw new MyException('[HTTP-00] Callout limit: ' + Limits.getCallouts() + ' reached. No more callouts permitted.');
        
        if (String.isEmpty(uri)){
            throw new MyException('Empty URL');
        }

       /// if (url.substring(0, 1).equals('/')){
       ///     url= URL.getSalesforceBaseUrl().toExternalForm()+ url;
       /// }
       
        System.debug('endPointuri->'+uri+'+uName->'+uName+'uPassword->'+uPassword+'strHttpMethod->'+strHttpMethod+'strContentType->'+strContentType+'strReqBody->'+strReqBody);

        Http http = new Http();
        HttpRequest     hRqst = new HttpRequest();
        HttpResponse    hResp = new HttpResponse();
        
        if (oAuthorizeRequest){
            authorizeRequest(hRqst);
        }
        
        Blob headerValue=Blob.valueOf(uName+':' +uPassword);
        String authorizationHeader ='Basic '+ EncodingUtil.base64Encode(headerValue);
        hRqst.setHeader('Authorization',authorizationHeader);
        hRqst.setHeader('Content-Type',strContentType);

        hRqst.setEndpoint(uri);             // caller provides, this will be a REST resource
        hRqst.setMethod(strHttpMethod);     // caller provides
        hRqst.setTimeout(2*60*1000); 
        
        hRqst.setBody(strReqBody );
        
        try{
            hResp = http.send(hRqst);
            System.debug('***hResp***'+hResp.toString());
            System.debug('***hResp.Status***'+hResp.getStatus()+'****'+'***hResp.StatusCode***'+hResp.getStatusCode());
           /* if(hResp!=null && hResp.getStatusCode()!=200){
                 throw new CNCS_ObjectUtility.CustomException('Status-->'+hResp.getStatus()+' StatusCode-->'+hResp.getStatusCode());
            }*/
        }catch(System.CalloutException e) {
                    System.debug('Callout error: '+ e);
                    System.debug(hResp.toString());
        }
        catch(CNCS_ObjectUtility.CustomException custExc) {
                  System.debug('Custom Exception '+ custExc);
                  ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,custExc.getMessage()));
         }
        catch(Exception exc){
                System.debug('***exc***'+exc );
        }
        String json = hResp.getBody().replace('\n', '');
        System.debug('***json***'+json );
        return hResp;
    }
    
    private void authorizeRequest(HttpRequest request){
    
        if (this.accessToken != null){
            request.setHeader('Authorization','Bearer ' + this.accessToken);
            return;
        }
    
        String uri          = 'https://' + (isSandbox ? 'test' : 'login') + '.salesforce.com/services/oauth2/token';
        String clientId     = EncodingUtil.urlEncode(consumerKey,'UTF-8');
        String clientSecret = EncodingUtil.urlEncode(consumerSecret,'UTF-8');
        String username     = EncodingUtil.urlEncode(uName,'UTF-8');
        String password     = EncodingUtil.urlEncode(uPassword,'UTF-8');
 
        String body =   'grant_type=password&client_id=' + clientId + 
                        '&client_secret=' + clientSecret +
                        '&username=' + username + 
                        '&password=' + password; 
                        
        HttpResponse hRes; 
       /// hRes= this.send(uri, 'POST', body, false);
        
        if (hRes.getStatusCode() != 200) 
            throw new MyException('OAuth 2.0 access token request error. Verify username, password, consumer key, consumer secret, StatusCode=' +
                                                 hRes.getStatusCode() + ' statusMsg=' + hRes.getStatus());
         
 
        Map<String,String> res = (Map<String,String>) JSON.deserialize(hRes.getBody(),Map<String,String>.class);
  
        this.accessToken = res.get('access_token');  
        request.setHeader('Authorization','Bearer ' + this.accessToken);
  
        /*
        this.accessToken        = res.get('access_token');      // remember these for subsequent calls
        this.sfdcInstanceUrl    = res.get('instance_url');
        */
    }

}