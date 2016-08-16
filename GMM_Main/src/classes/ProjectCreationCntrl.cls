public class ProjectCreationCntrl{
    private ApexPages.StandardController std;
    Public String Address{get;set;}
    //public String ProjectId;
    public Project__c projectInput{get;set;}
    Public List<SelectOption> options{get;set;}
    public boolean displayPopup {get; set;}
    public Map<String,String> mpSuggestedAddresses=new map<String,String>();
    public String strProcessStatusMsg{get;set;}
    
    
    public ProjectCreationCntrl(ApexPages.StandardController stdCtrl){
         std=stdCtrl;
         projectInput= new Project__c();
            
            //ProjectId=Apexpages.currentPage().getParameters().get('id'); 
    }
    
   /* public Project__c projectNewRecord(){
        projectInput = new Project__c();
        return projectInput;
    }*/
    
    public Project__c projectInfo(){
        return (Project__c) std.getRecord();
    }
    
    public AddressRequest  prepareRequestForAddressDoctor(){
     
         AddressRequest objAddressRequest = new AddressRequest();
         String  strSplittedAddress;
         //assign data
         if(projectInput!=null && projectInput.Street_Address_1__c!=''){
            //String  strSplittedAddress1='2520  dulles station blvd';
            strSplittedAddress=projectInput.Street_Address_1__c;
            String []str; 
            if(strSplittedAddress.contains(' ')){
                integer spaceIndex= strSplittedAddress.indexof(' ');
                System.debug('spaceindex'+spaceIndex);
                String strHno=strSplittedAddress.subString(0,spaceIndex);
                System.debug('strHno'+strHno);
                String strStreet=strSplittedAddress.subString(spaceIndex+1,strSplittedAddress.length());
                System.debug('strStreet'+strStreet);
                objAddressRequest.houseNumber = new List<String>{strHno};
                objAddressRequest.street = new List<String>{strStreet};
            }
            else{
                  ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Please provide House Number along with Street'));
                  
            }
         }
         else{
           // Apexpages.addMessage('Please provide Address details');
            return null;
            }
        // objAddressRequest.houseNumber = new List<String>{'123'};
         //System.debug('House Number Value ....... @@@@@@@@@@@@' +objAddressRequest.houseNumber);
        // objAddressRequest.street = new List<String>{Account.Address_1__c};
        // System.debug('Street Value ....... @@@@@@@@@@@@' +objAddressRequest.street);
         objAddressRequest.locality= new List<String>{projectInput.City__c};
         System.debug('City Value ....... @@@@@@@@@@@@' +objAddressRequest.locality);
         objAddressRequest.province = new List<String>{projectInput.State__c};
         System.debug('Province Value ....... @@@@@@@@@@@@' +objAddressRequest.province);
         objAddressRequest.postalCode = new List<String>{projectInput.Zip__c};
         System.debug('Postal code Value ....... @@@@@@@@@@@@' +objAddressRequest.postalCode);
         objAddressRequest.country = new List<String>{'United States'};
         System.debug('Country Value ....... @@@@@@@@@@@@' +objAddressRequest.country);
         return objAddressRequest;
         
     }
     
     public void invokeAddressDoctor(){
         try{
             AddressRequest objAddressRequest = prepareRequestForAddressDoctor();
             System.debug('***objAddressRequest ***'+objAddressRequest );
             CNCS_WebServiceGateWay objCNCS_WebServiceGateWay=new CNCS_WebServiceGateWay('ADDRESSDOCTOR');
             AddressDoctorWSStub.Response objAddressDoctorWSStubResponse=objCNCS_WebServiceGateWay.connectToAddressDoctor(objAddressRequest);
             System.debug('***objAddressDoctorWSStubResponse***'+objAddressDoctorWSStubResponse);
             AddressDoctorResponse  objAddressDoctorResponse =AddressDoctorResponse.parseAddressDoctorWSStubResponse(objAddressDoctorWSStubResponse);
             System.debug('*** in method invokeAddressDoctor===>objAddressDoctorResponse ***'+objAddressDoctorResponse );
             
             fillNewSuggestedAddress(objAddressDoctorResponse);
          }
         //add callout exception
         catch(NullPointerException nullPtrExc){
             System.debug('*** invokeAddressDoctor NullPointerException ***'+nullPtrExc);
         }
         catch(Exception exc){
             System.debug('*** invokeAddressDoctor Exception ***'+exc);
         }
     }
     
     public void fillNewSuggestedAddress(AddressDoctorResponse  objAddressDoctorResponse){
         //for adding the suggested address from AddressDoctor into RadioButtons
             mpSuggestedAddresses=new map<String,String>();
             options = new List<SelectOption>();
         for(AddressDoctorResponse.Result itrObjAddressDoctorResponseResult    : objAddressDoctorResponse.lstResult){
                if(itrObjAddressDoctorResponseResult.processStatus!=null && itrObjAddressDoctorResponseResult.processStatus!=''){
                    strProcessStatusMsg=AddressDoctorResponse.evaluateProcessStatus(itrObjAddressDoctorResponseResult.processStatus);
                }
                /*if(itrObjAddressDoctorResponseResult.mailabilityScore!=null && itrObjAddressDoctorResponseResult.mailabilityScore!=''){
                    strMailabilityScoreMsg=AddressDoctorResponse.evaluateMailabilityScore(itrObjAddressDoctorResponseResult.mailabilityScore);
                }*/
                //System.debug('#######itrObjAddressDoctorResponseResult.formattedAddress'+itrObjAddressDoctorResponseResult.formattedAddress);
               // options.add(new SelectOption(itrObjAddressDoctorResponseResult.addressComplete,itrObjAddressDoctorResponseResult.addressComplete+ '*** Mailability '+  strMailabilityScoreMsg)); 
                options.add(new SelectOption(itrObjAddressDoctorResponseResult.addressComplete,itrObjAddressDoctorResponseResult.addressComplete)); 
                ///String strConcatenatedAddressWithTilde=itrObjAddressDoctorResponseResult.houseNumber+' '+itrObjAddressDoctorResponseResult.street+'~';
                String strConcatenatedAddressWithTilde=itrObjAddressDoctorResponseResult.street+'~';
                strConcatenatedAddressWithTilde+=itrObjAddressDoctorResponseResult.locality+'~';
                strConcatenatedAddressWithTilde+=itrObjAddressDoctorResponseResult.province+'~';
                strConcatenatedAddressWithTilde+=itrObjAddressDoctorResponseResult.postalCode;
                mpSuggestedAddresses.put(itrObjAddressDoctorResponseResult.addressComplete,strConcatenatedAddressWithTilde);
              } 
     }
     
     public PageReference addressSelection(){
         try{
            System.debug('what is the address.......' +Address);
             if(Address!=null){
                         System.debug('###mpSuggestedAddresses###'+mpSuggestedAddresses+'###Address###'+Address);
                         String strSelectedAddress=mpSuggestedAddresses.get(Address);
                         List<String> lstAddressSubFields=strSelectedAddress.split('~');
                         System.debug('###lstAddressSubFields###'+lstAddressSubFields);
                         If(lstAddressSubFields!=null && lstAddressSubFields.size()>0){
                            displayPopup = false;
                            projectInput.Street_Address_1__c=lstAddressSubFields[0].subString(1,lstAddressSubFields[0].length()-1);
                            projectInput.City__c=lstAddressSubFields[1].subString(1,lstAddressSubFields[1].length()-1);
                            string tempStates=lstAddressSubFields[2].split(',')[0];
                            projectInput.State__c=tempStates.subString(1,tempStates.length());
                            String tempZip=lstAddressSubFields[3].split('-')[0];
                            projectInput.Zip__c=tempZip.subString(1,tempZip.length());
                            //projectInput.Zip__c=lstAddressSubFields[3].subString(1,lstAddressSubFields[3].length()-1);
                            //std.save();
                            system.debug('Project Input............@@@@@' +projectInfo().id);
                            insert projectInput;
                            system.debug('After Insert.......'+projectInput);
                            pagereference pr =new pagereference('/'+projectInput.id);
                            pr.setRedirect(true);
                            return pr;
                            //return null;
                     }
                 }              
                else{
                    ApexPages.Message msg = new Apexpages.Message(ApexPages.Severity.Warning,'Please select one option to update' );
                    ApexPages.addmessage(msg);
                } 
             }
             catch(NullPointerException npExc){
             System.debug('***NullPointerException in Method addressSelection***'+npExc.getMessage());    
         }
         catch(Exception exc){
             System.debug('***Exception in Method addressSelection***'+exc.getMessage());
        }
         return null;  
         
     } 
     
     Public PageReference PageRedirect(){
         displayPopup = true;
         invokeAddressDoctor();
         //pagereference pr =new pagereference('/'+projectInput.id);
         //return pr;
         return null;
     
     }
     
     public pagereference closePopup(){        
        displayPopup = false;
         std.save();
          pagereference pr =new pagereference('/'+projectInput.id);
          return pr;    
        //pagereference pr;
        //pr = createuser();
        //return null;
     }
         
     public void showPopup(){        
        displayPopup = true;    
     }
    
     public void unshowPopup(){
        displayPopup = false;
     }


}