public class GrantCloseOutForFinancialCloseOutCntrl{
      
      public ApexPages.StandardController stdcontroller;
      public Grant_Close_Out__c objGrantCloseOut{get;set;}
      public String strGrantId{get;set;}
      
      public GrantCloseOutForFinancialCloseOutCntrl(ApexPages.StandardController p_controller){
           this.stdcontroller= p_controller;
           stdcontroller.addFields(new List<String>{'name','Grant__c','Grant_Number__c'});
           this.objGrantCloseOut= (Grant_Close_Out__c )stdController.getrecord();
           // strGrantId=objGrantCloseOut.Grant__c;
           //strGrantId='18ND143084';//objGrantCloseOut.Grant_Number__c;
           strGrantId=objGrantCloseOut.Grant_Number__c;
           System.debug('***objGrantCloseOut***'+objGrantCloseOut);
           System.debug('***strGrantId***'+strGrantId);
       }
       
       public PageReference validationsAndWSInvocations(){
           Boolean updateFlag =validateReconcilationAmts();
            System.debug('***updateFlag in validationsAndWSInvocations ***'+updateFlag );
           if(updateFlag ){
               invokeMomCloseOutWithGrantId();
           }
           return null;
       
       }
       
       public Boolean  validateReconcilationAmts(){
        Boolean updateFlag=false;
    
        List<Grant_Close_Out__c> lstGrantCloseout =[SELECT Id,Name,Advanced_Momentum__c,Disbursed_Momentum_SF_425__c,Total_Federal_Expenditure_Final_FFR_SF__c 
                                                    FROM Grant_Close_Out__c 
                                                    WHERE Id= :objGrantCloseOut.id Limit 1];
                                                    
                                                    
                                                    
        Grant_Close_Out__c objGrant_Close_Out=new Grant_Close_Out__c();
        if(lstGrantCloseout!=null && lstGrantCloseout.size()>0){
        
            objGrant_Close_Out=lstGrantCloseout[0];
            if(objGrant_Close_Out!=null && objGrant_Close_Out.Advanced_Momentum__c!=objGrant_Close_Out.Disbursed_Momentum_SF_425__c){
                    if( objGrant_Close_Out.Advanced_Momentum__c!=objGrant_Close_Out.Total_Federal_Expenditure_Final_FFR_SF__c){
                        
                        ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Reconciliation amounts do not match. Financial Closeout cannot be performed at this time'));
                    
                    }
            }else{
                    objGrant_Close_Out.Financial_Closeout_Date__c=Date.Today();
                    objGrant_Close_Out.Date_Funds_Deobligated__c=Date.Today();
                    objGrant_Close_Out.Status__c='Financial Closeout Complete';
                    updateFlag=true;
            
            }
            if(updateFlag){
                 try{
                   // Update objGrant_Close_Out;
                 
                 }
                 catch(DmlException dmlExc){
                    System.debug('***validateReconcilationAmts dmlExc***'+dmlExc.getMessage());
                 
                 }
                 catch(Exception exc){
                    System.debug('***validateReconcilationAmts exc***'+exc.getMessage());
                 }
            
            }
        }
        
        return updateFlag ;
    }   
       
       
         public void invokeMomCloseOutWithGrantId(){
         
         
                
                HttpResponse hResp;
                String json='';
                                    
                String strWSname='MOMcloseout';
                String  endPointuri='';
                String  uName='';
                String  upassword='';
                String  httpMethodName='';
                String  contenttype='';
                CNCS_AuthorizeHttp objCNCS_AuthorizeHttp=new CNCS_AuthorizeHttp();
                
                //PageReference returnPage;// = new PageReference(ApexPages.currentPage().getParameters().get('retURL')); 
                //PageReference returnPage= new Pagereference('a0M?'+);  
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
                    String strBody=composeBodyForMomCloseOutWithGrantId();
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
                    ParseJSONUtil.MomCloseOutForgrnt_idJSON    objMomCloseOutForgrnt_idJSON= new ParseJSONUtil.MomCloseOutForgrnt_idJSON();
                    objMomCloseOutForgrnt_idJSON= objParseJSONUtil.parseMomCloseOutForgrnt_idJSON(json);
                    System.debug('***objMomCloseOutForgrnt_idJSON'+objMomCloseOutForgrnt_idJSON);
                    List<ParseJSONUtil.MomCloseOutForgrnt_id> lstMomCloseOutForgrnt_id=objMomCloseOutForgrnt_idJSON.lstData;
                    System.debug('***lstMomCloseOutForgrnt_id'+lstMomCloseOutForgrnt_id);
                    updateStatusForMomCloseOut(lstMomCloseOutForgrnt_id);                    
                   // returnPage = new PageReference(ApexPages.currentPage().getParameters().get('retURL'));  
                    
                  
                }catch(CalloutException exc){
                    System.debug('***exc***'+exc);
                    System.debug('***exc.getMessage()***'+exc.getMessage());
                    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,exc.getMessage()));
                }
                catch(CNCS_ObjectUtility.CustomException custExc) {
                  System.debug('Custom Exception '+ custExc);
                  ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,custExc.getMessage()));
                }
                catch(Exception exc){
                    System.debug('***exc***'+exc);
                    System.debug('***exc.getMessage()***'+exc.getMessage());
                    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,exc.getMessage()));
                }
                //return returnPage ;
     }

     public String composeBodyForMomCloseOutWithGrantId(){
       //strGrantId='15SF171363';
       String strBody ='{ "grnt_id":'+'"'+ strGrantId+'" }';
       return strBody;
     }
     
     public void updateStatusForMomCloseOut(List<ParseJSONUtil.MomCloseOutForgrnt_id> lstMomCloseOutForgrnt_id){
         Boolean goAheadFlag=false;
         System.debug('***updateStatusForMomCloseOut***');
         try{
            if(lstMomCloseOutForgrnt_id!=null && lstMomCloseOutForgrnt_id.size() >0){
                String RESULT_TXT =lstMomCloseOutForgrnt_id[0].RESULT_TXT;
                    if(RESULT_TXT !=null && RESULT_TXT !='' && RESULT_TXT.equalsignoreCase('0~')){   //'~Ok')
                         goAheadFlag=true;
                    }else{
                          goAheadFlag=false;
                          throw new CNCS_ObjectUtility.CustomException('Exception -> '+ RESULT_TXT +' .'); 
                    } 
             }
             if(goAheadFlag){
                 //update stat
                 objGrantCloseOut.Status__c='Financial Closeout Complete';
                 
                 ///
                 objGrantCloseOut.Financial_Closeout_Date__c=Date.Today();
                 objGrantCloseOut.Date_Funds_Deobligated__c=Date.Today();
                 objGrantCloseOut.Status__c='Financial Closeout Complete';
                 update objGrantCloseOut;
                 ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO,'Financial Closeout Complete'));
                ///
             }
             
                    /* Grant_Close_Out__c updObjGrant_Close_Out;
                     updObjGrant_Close_Out.id=
                     updObjGrant_Close_Out*/
            }
            catch(DMLException exc){
                System.debug('***exc***'+exc);
                System.debug('***exc.getMessage()***'+exc.getMessage());
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,exc.getMessage()));
            }
            catch(CNCS_ObjectUtility.CustomException  custExc) {
                 // throw new CNCS_ObjectUtility.CustomException(custExc.getmessage());
                  System.debug('Custom Exception '+ custExc);
                  ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,custExc.getMessage()));
            }
            catch(Exception exc){
                System.debug('***exc***'+exc);
                System.debug('***exc.getMessage()***'+exc.getMessage());
                
           }
        }
        
        
      public PageReference returnToDetailView(){
          String strGrantId=ApexPages.currentPage().getParameters().get('id');
          
         // PageReference returnPage= new Pagereference('id?'+); 
          PageReference returnPage= new Pagereference('/'); 
          
         // returnPage.getParameters().put('id',strGrantId);
          Schema.DescribeSObjectResult result = Grant_Close_Out__c.SObjectType.getDescribe();
         

        /* PageReference pageRef = redirectToList();//new PageReference('/' + result.getKeyPrefix() + '/o');
          return pageRef;*/
           //  return returnPage;
           
           //SObject record; // can be of any type
           PageReference view = new ApexPages.standardController(objGrantCloseOut).view();
           return view;
      
      }
      
      public PageReference redirectToList() { 
          Schema.DescribeSObjectResult result = Grant_Close_Out__c.SObjectType.getDescribe(); 
          PageReference pageRef = new PageReference('/' + result.getKeyPrefix()); 
          pageRef.setRedirect(true); 
          return pageRef; 
}
        
     }