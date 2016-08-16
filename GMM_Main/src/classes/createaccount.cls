public class createaccount {
      
    Public String Address{get;set;}
    Public String AddressSelected{get;set;}
    Public List<SelectOption> options{get;set;}
    Public Account pro{get;set;}
    Public Account Account{get;set;}
    Public Account acct{get;set;}
    public boolean displayPopup {get; set;} 
    Public Map<String,AddressdoctorComWebservice5.ResultData> MapOfAddress;
    public string userId = ApexPages.currentPage().getParameters().get('uid');
    public Map<String,String> mpSuggestedAddresses=new map<String,String>();
    public String strProcessStatusMsg{get;set;}

    
    //public Account Org;
    /*public Account account{
    get {
            if (account == null)
                account = new Account();
            return account;
            
        }
        set;
    }*/
    String OrgEin{get;set;}
    //apexpages.standardController sController;
   /*public createaccount(ApexPages.StandardController stdController) {
        sController = stdController;
        this.Org = (Account)stdController.getRecord();
    }*/
    public createaccount(){
         system.Debug('userId-------'+userId);
         MapOfAddress=new Map<String,AddressdoctorComWebservice5.ResultData>();
         
         Account = new Account();
         String strURL=System.URL.getSalesforceBaseUrl().toExternalForm();
         System.debug('Prashant@@@@@@@%%%%^^^^^^'+strURL+'^^^^^^^^^^'+Account+'@@@@@@@@'+acct);
    }
        
    //Addressdoctor method start here
    Public Void retrieveAddress(){
        try{
        
        AddressdoctorComWebservice5 tes = new AddressdoctorComWebservice5();
        AddressdoctorComWebservice5.AddressValidationSoap testsoap = new AddressdoctorComWebservice5.AddressValidationSoap();
        AddressdoctorComWebservice5.Parameters parameters = new AddressdoctorComWebservice5.Parameters();
        parameters.ProcessMode='INTERACTIVE';
        AddressdoctorComWebservice5.ValidationParameters valParams = new AddressdoctorComWebservice5.ValidationParameters();
        valParams.PreferredLanguage = 'ENGLISH';
        valParams.FormatDelimiter = 'COMMA';
        valParams.MatchingAlternatives = 'ALL';
        valParams.GlobalPreferredDescriptor='LONG';
        valParams.GeoCodingType='NONE';
        parameters.ValidationParameters=valParams;
        AddressdoctorComWebservice5.ArrayOfAddress addresses = new AddressdoctorComWebservice5.ArrayOfAddress();
        AddressdoctorComWebservice5.Address addr = new AddressdoctorComWebservice5.Address();
        addresses.Address = new List<AddressdoctorComWebservice5.Address>();
        //AddressdoctorComWebservice5.FormattedAddress formatAddress = new AddressdoctorComWebservice5.FormattedAddress();
        //AddressdoctorComWebservice5.ArrayOfString  testArray1 = new AddressdoctorComWebservice5.ArrayOfString();
        AddressdoctorComWebservice5.ArrayOfString  arrayHouseNumber = new AddressdoctorComWebservice5.ArrayOfString();
        arrayHouseNumber.string_x=new List<String>{'2320'};
        addr.HouseNumber=arrayHouseNumber;
        //AddressdoctorComWebservice5.ArrayOfString  testArray2 = new AddressdoctorComWebservice5.ArrayOfString();
        AddressdoctorComWebservice5.ArrayOfString  arrayStreet = new AddressdoctorComWebservice5.ArrayOfString();
        arrayStreet.string_x=new List<String>{'Dulles Station Blvd'};
        addr.Street=arrayStreet;
        //AddressdoctorComWebservice5.ArrayOfString  testArray3 = new AddressdoctorComWebservice5.ArrayOfString();
        AddressdoctorComWebservice5.ArrayOfString  arrayLocality = new AddressdoctorComWebservice5.ArrayOfString();
        arrayLocality.string_x=new List<String>{'Herndon'};
        addr.Locality=arrayLocality;
        
        ///
        AddressdoctorComWebservice5.ArrayOfString  orgNumber= new AddressdoctorComWebservice5.ArrayOfString();
        orgNumber.string_x=new List<String>{};
        addr.Organization=orgNumber;
        
        AddressdoctorComWebservice5.ArrayOfString  arrayDepartment= new AddressdoctorComWebservice5.ArrayOfString();
        arrayDepartment.string_x=new List<String>{};
        addr.Department=arrayDepartment;
        
        AddressdoctorComWebservice5.ArrayOfString  arrayContact= new AddressdoctorComWebservice5.ArrayOfString();
        arrayContact.string_x=new List<String>{};
        addr.Contact=arrayContact;
        
        AddressdoctorComWebservice5.ArrayOfString  arrayEmail= new AddressdoctorComWebservice5.ArrayOfString();
        arrayEmail.string_x=new List<String>{};
        addr.Email=arrayEmail;
        
        AddressdoctorComWebservice5.ArrayOfString  arrayBuilding= new AddressdoctorComWebservice5.ArrayOfString();
        arrayBuilding.string_x=new List<String>{};
        addr.Building=arrayBuilding;
        
        AddressdoctorComWebservice5.ArrayOfString  arraySubBuilding= new AddressdoctorComWebservice5.ArrayOfString();
        arraySubBuilding.string_x=new List<String>{};
        addr.SubBuilding=arraySubBuilding;
        
        AddressdoctorComWebservice5.ArrayOfString  arrayDeliveryService= new AddressdoctorComWebservice5.ArrayOfString();
        arrayDeliveryService.string_x=new List<String>{};
        addr.DeliveryService=arrayDeliveryService;
        
        AddressdoctorComWebservice5.ArrayOfString  arrayPreferredLocality= new AddressdoctorComWebservice5.ArrayOfString();
        arrayPreferredLocality.string_x=new List<String>{};
        addr.PreferredLocality=arrayPreferredLocality;
        
        AddressdoctorComWebservice5.ArrayOfString  arrayResidue= new AddressdoctorComWebservice5.ArrayOfString();
        arrayResidue.string_x=new List<String>{};
        addr.Residue=arrayResidue;
        
        AddressdoctorComWebservice5.ArrayOfString  arrayRecipientLines= new AddressdoctorComWebservice5.ArrayOfString();
        arrayRecipientLines.string_x=new List<String>{};
        addr.RecipientLines=arrayRecipientLines;
        
        AddressdoctorComWebservice5.ArrayOfString  arrayDeliveryAddressLines= new AddressdoctorComWebservice5.ArrayOfString();
        arrayDeliveryAddressLines.string_x=new List<String>{};
        addr.DeliveryAddressLines=arrayDeliveryAddressLines;
        
        AddressdoctorComWebservice5.ArrayOfString  arrayCountrySpecificLocalityLine= new AddressdoctorComWebservice5.ArrayOfString();
        arrayCountrySpecificLocalityLine.string_x=new List<String>{};
        addr.CountrySpecificLocalityLine=arrayCountrySpecificLocalityLine;
        
        
        //AddressdoctorComWebservice5.ArrayOfString  testArray4 = new AddressdoctorComWebservice5.ArrayOfString();
        AddressdoctorComWebservice5.ArrayOfString  arrayProvince = new AddressdoctorComWebservice5.ArrayOfString();
        arrayProvince.string_x=new List<String>{'Virginia'};
        addr.Province=arrayProvince;
        //AddressdoctorComWebservice5.ArrayOfString  testArray5 = new AddressdoctorComWebservice5.ArrayOfString();
        AddressdoctorComWebservice5.ArrayOfString  arrayZip = new AddressdoctorComWebservice5.ArrayOfString();
        arrayZip.string_x=new List<String>{'20171'};
        addr.PostalCode=arrayZip;
        //AddressdoctorComWebservice5.ArrayOfString  testArray6 = new AddressdoctorComWebservice5.ArrayOfString();
        AddressdoctorComWebservice5.ArrayOfString  arrayCountry = new AddressdoctorComWebservice5.ArrayOfString();
        arrayCountry.string_x=new List<String>{'United States'};
        addr.Country=arrayCountry ;
        System.debug('Test Postal Code.......Executed');
      
        //if(addr!=null){
        addresses.Address.add(addr);
        //}else{
        System.debug('Test Addresses Array....Null Ref'+addr);
        //}
        AddressdoctorComWebservice5.ArrayOfEnrichment enrichments = new AddressdoctorComWebservice5.ArrayOfEnrichment();
        //AddressdoctorComWebservice5.Enrichment enrich = new AddressdoctorComWebservice5.Enrichment();
       // enrich.Type_x = 'GEOCODING';
        AddressdoctorComWebservice5.ServiceParameters ServiceParam = new AddressdoctorComWebservice5.ServiceParameters();
        //ServiceParam.JobToken='b89be474-318c-4da3-87c2-f15b2e43c2cb';
        parameters.ServiceParameters = ServiceParam;
        //enrichments.Enrichment=enrich;
        AddressdoctorComWebservice5.Response res = testsoap.Process('161683','Infa123',parameters,addresses,enrichments);
        System.debug('Sravan AddressDoc Test..............%%%%%%%%%' +res);  
        AddressdoctorComWebservice5.ResultData[] ResData=res.results.result[0].ResultDataSet.ResultData; // Added
        //AddressdoctorComWebservice5.Enrichment[] EnrichmentData=res.results.result[0].Enrichments.Enrichment; // Added
        //System.debug('#######EnrichmentDebug'+EnrichmentData);
        //System.debug('#######EnrichmentDebug'+res.results.result[0]);
        System.debug('#######ResultSet'+res.results.result.size());
        System.debug('#######ArrayOfResultSet'+res.results.result[0].ResultDataSet.ResultData.size()+'@@@@@@'+ResData.size());
        System.debug('#######ArrayOfResultSet_ResultNumber'+res.results.result[0].ResultDataSet.ResultData[0].ResultNumber);
        options = new List<SelectOption>();
        for(AddressdoctorComWebservice5.ResultData rd : ResData)
        {
        //System.debug('#######ArrayOfResultSet_ResultNumber_iterate'+rd.address.Organization.string_x+'@@'+rd.address.Department.string_x+'@@'+rd.address.Contact.string_x+'@@'+rd.address.Building.string_x+'@@'+rd.address.SubBuilding.string_x+'@@'+rd.address.Street.string_x+'@@'+rd.address.HouseNumber.string_x+'@@'+rd.address.DeliveryService.string_x+'@@'+rd.address.Locality.string_x+'@@'+rd.address.AddressComplete);
        //System.debug('#######ArrayOfResultSet_ResultNumber_iterate_Fields'+rd.address.PreferredLocality.string_x+'@@'+rd.address.PostalCode.string_x+'@@'+rd.address.Province.string_x+'@@'+rd.address.Country.string_x+'@@'+rd.address.Residue.string_x+'@@'+rd.address.RecipientLines.string_x+'@@'+rd.address.DeliveryAddressLines.string_x+'@@'+rd.address.CountrySpecificLocalityLine.string_x+'@@'+rd.address.FormattedAddress.string_x);
        System.debug('#######ArrayOfResultSet_ResultNumber_iterate'+rd.address.FormattedAddress.string_x);
        options.add(new SelectOption(rd.address.AddressComplete,rd.address.AddressComplete)); 
        System.debug('AddressComplete Value ....... @@@@@@@@@@@@' +rd.address.AddressComplete);
        MapOfAddress.put(rd.address.AddressComplete,rd);
        
        } 
       
        }
       
        catch(exception e){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Exception.....'+e.getMessage()));
        }                     
    }
    
    
    Public Void GetAddresses()
    {


         /*
             Calling webservice method        
         */   
            

        // pro=[Select name,Address_1__c,Address_2__c, States__c,Zip1__c from Account where id=:a limit 1];
        //System.debug('######Project ID'+pro.id);
        AddressdoctorComWebservice5 tes = new AddressdoctorComWebservice5();
        AddressdoctorComWebservice5.AddressValidationSoap testsoap = new AddressdoctorComWebservice5.AddressValidationSoap();
        AddressdoctorComWebservice5.Parameters parameters = new AddressdoctorComWebservice5.Parameters();
        parameters.ProcessMode='INTERACTIVE';
        AddressdoctorComWebservice5.ValidationParameters valParams = new AddressdoctorComWebservice5.ValidationParameters();
        valParams.FormatDelimiter='COMMA';
        valParams.MatchingAlternatives='ALL';
        valParams.PreferredLanguage='ENGLISH';
        valParams.GeoCodingType='NONE';
        AddressdoctorComWebservice5.ArrayOfAddress addresses = new AddressdoctorComWebservice5.ArrayOfAddress();
        AddressdoctorComWebservice5.Address address1 = new AddressdoctorComWebservice5.Address();
        addresses.address = new List<AddressdoctorComWebservice5.Address>();
        AddressdoctorComWebservice5.ArrayOfString testArray = new AddressdoctorComWebservice5.ArrayOfString();
        testArray.string_x = new List<String>{'ABC'};
    
        AddressdoctorComWebservice5.ArrayOfString  testArray1 = new AddressdoctorComWebservice5.ArrayOfString();
        
        //testArray1.string_x = new List<String>{'Test@gmail.com'};
        //address1.Email = testArray1; 
        
        System.debug('Prashant^^^^^^^^^^'+Account.States__c+'########'+Account.Address_1__c);
        
        AddressdoctorComWebservice5.ArrayOfString  testArray2 = new AddressdoctorComWebservice5.ArrayOfString();
        testArray2.string_x=new List<String>{Account.States__c};
        address1.Province= testArray2; 
        
        AddressdoctorComWebservice5.ArrayOfString  testArray3 = new AddressdoctorComWebservice5.ArrayOfString();
        testArray3.string_x=new List<String>{'United States'};
        address1.Country= testArray3; 
        
        AddressdoctorComWebservice5.ArrayOfString  testArray4 = new AddressdoctorComWebservice5.ArrayOfString();
        testArray4.string_x=new List<String>{Account.Address_1__c};
        address1.HouseNumber= testArray4; 
        
        AddressdoctorComWebservice5.ArrayOfString  testArray5 = new AddressdoctorComWebservice5.ArrayOfString();
        testArray5.string_x=new List<String>{Account.Address_2__c};
        address1.Street= testArray5; 
        
        AddressdoctorComWebservice5.ArrayOfString  testArray6 = new AddressdoctorComWebservice5.ArrayOfString();
        testArray6.string_x=new List<String>{Account.Zip1__c};
        address1.PostalCode= testArray6; 
        
        addresses.Address.add(address1);
        //System.debug('ValidateAddress'+address1.Organization+'@@@@@'+address1.Country+'%%%%'+address1.PostalCode);
        AddressdoctorComWebservice5.ArrayOfEnrichment enrichments = new AddressdoctorComWebservice5.ArrayOfEnrichment();
        AddressdoctorComWebservice5.ServiceParameters ServiceParam = new AddressdoctorComWebservice5.ServiceParameters();
        //ServiceParam.JobToken='b89be474-318c-4da3-87c2-f15b2e43c2cb';
        parameters.ServiceParameters = ServiceParam;
        
       
        
        AddressdoctorComWebservice5.Response res = testsoap.Process('161683','Infa123',parameters,addresses,enrichments);
        System.debug('Prashant$$$$$$$^^^^^'+res.statuscode+'$$$$'+res.StatusMessage);
        AddressdoctorComWebservice5.ResultData[] ResData=res.results.result[0].ResultDataSet.ResultData; // Added
        //AddressdoctorComWebservice5.Enrichment[] EnrichmentData=res.results.result[0].Enrichments.Enrichment; // Added
        //System.debug('#######EnrichmentDebug'+EnrichmentData);
        //System.debug('#######EnrichmentDebug'+res.results.result[0]);
        System.debug('#######ResultSet'+res.results.result.size());
        System.debug('#######ArrayOfResultSet'+res.results.result[0].ResultDataSet.ResultData.size()+'@@@@@@'+ResData.size());
        System.debug('#######ArrayOfResultSet_ResultNumber'+res.results.result[0].ResultDataSet.ResultData[0].ResultNumber);
        options = new List<SelectOption>();
        For(AddressdoctorComWebservice5.ResultData rd : ResData)
        {
        //System.debug('#######ArrayOfResultSet_ResultNumber_iterate'+rd.address.Organization.string_x+'@@'+rd.address.Department.string_x+'@@'+rd.address.Contact.string_x+'@@'+rd.address.Building.string_x+'@@'+rd.address.SubBuilding.string_x+'@@'+rd.address.Street.string_x+'@@'+rd.address.HouseNumber.string_x+'@@'+rd.address.DeliveryService.string_x+'@@'+rd.address.Locality.string_x+'@@'+rd.address.AddressComplete);
        //System.debug('#######ArrayOfResultSet_ResultNumber_iterate_Fields'+rd.address.PreferredLocality.string_x+'@@'+rd.address.PostalCode.string_x+'@@'+rd.address.Province.string_x+'@@'+rd.address.Country.string_x+'@@'+rd.address.Residue.string_x+'@@'+rd.address.RecipientLines.string_x+'@@'+rd.address.DeliveryAddressLines.string_x+'@@'+rd.address.CountrySpecificLocalityLine.string_x+'@@'+rd.address.FormattedAddress.string_x);
        System.debug('#######ArrayOfResultSet_ResultNumber_iterate'+rd.address.FormattedAddress.string_x);
        options.add(new SelectOption(rd.address.AddressComplete,rd.address.AddressComplete)); 
        System.debug('AddressComplete Value ....... @@@@@@@@@@@@' +rd.address.AddressComplete);
        MapOfAddress.put(rd.address.AddressComplete,rd);
        }
       

    }
    
    
    /* unsued method
     Public Void addressDoctorRequest(){
                 AddressRequest objAddressRequest = new AddressRequest();
                 //assign data
                 objAddressRequest.houseNumber = new List<String>{'123'};
                 System.debug('House Number Value ....... @@@@@@@@@@@@' +objAddressRequest.houseNumber);
                 objAddressRequest.street = new List<String>{Account.Address_1__c};
                 System.debug('Street Value ....... @@@@@@@@@@@@' +objAddressRequest.street);
                 objAddressRequest.province = new List<String>{Account.States__c};
                 System.debug('Province Value ....... @@@@@@@@@@@@' +objAddressRequest.province);
                 objAddressRequest.postalCode = new List<String>{Account.Zip1__c};
                 System.debug('Postal code Value ....... @@@@@@@@@@@@' +objAddressRequest.postalCode);
                 objAddressRequest.country = new List<String>{'United States'};
                 System.debug('Country Value ....... @@@@@@@@@@@@' +objAddressRequest.country);
                
                 CNCS_WebServiceGateWay objCNCS_WebServiceGateWay=new CNCS_WebServiceGateWay('ADDRESSDOCTOR');
                 objCNCS_WebServiceGateWay.connectToAddressDoctor(objAddressRequest);
                
     
     }
     */
     
     public AddressRequest  prepareRequestForAddressDoctor(){
     
         AddressRequest objAddressRequest = new AddressRequest();
         String  strSplittedAddress;
         //assign data
         if(Account!=null && Account.Address_1__c!=''){
            //String  strSplittedAddress1='2520  dulles station blvd';
            strSplittedAddress=Account.Address_1__c;
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
         objAddressRequest.locality= new List<String>{Account.City__c};
         System.debug('City Value ....... @@@@@@@@@@@@' +objAddressRequest.locality);
         objAddressRequest.province = new List<String>{Account.States__c};
         System.debug('Province Value ....... @@@@@@@@@@@@' +objAddressRequest.province);
         objAddressRequest.postalCode = new List<String>{Account.Zip1__c};
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
             if(Address!=null){
                 System.debug('###mpSuggestedAddresses###'+mpSuggestedAddresses+'###Address###'+Address);
                 String strSelectedAddress=mpSuggestedAddresses.get(Address);
                 List<String> lstAddressSubFields=strSelectedAddress.split('~');
                 System.debug('###lstAddressSubFields###'+lstAddressSubFields);
                 If(lstAddressSubFields!=null && lstAddressSubFields.size()>0){
                    displayPopup = false;
                    Account.Address_1__c=lstAddressSubFields[0].subString(1,lstAddressSubFields[0].length()-1);
                    Account.City__c=lstAddressSubFields[1].subString(1,lstAddressSubFields[1].length()-1);
                    string tempStates=lstAddressSubFields[2].split(',')[0];
                    Account.States__c=tempStates.subString(1,tempStates.length());
                    String tempZip=lstAddressSubFields[3].split('-')[0];
                    Account.Zip1__c=tempZip.subString(1,tempZip.length());
                    return createuser();
                    pagereference pr =new pagereference('/apex/granteeportal/Createorganization');
                    return pr;
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

    public PageReference Submit() {
        PageReference PR;
        
        try{
        If(Address!=null){
        AddressdoctorComWebservice5 tes = new AddressdoctorComWebservice5();
        AddressdoctorComWebservice5.AddressValidationSoap testsoap = new AddressdoctorComWebservice5.AddressValidationSoap();
        AddressdoctorComWebservice5.Parameters parameters = new AddressdoctorComWebservice5.Parameters();
        parameters.ProcessMode='INTERACTIVE';
        AddressdoctorComWebservice5.ArrayOfAddress addresses2 = new AddressdoctorComWebservice5.ArrayOfAddress();
        AddressdoctorComWebservice5.Address address3 = new AddressdoctorComWebservice5.Address();
        addresses2.address = new List<AddressdoctorComWebservice5.Address>();
        address3.AddressComplete=Address;
        addresses2.Address.add(address3);
        AddressdoctorComWebservice5.ArrayOfEnrichment enrichments2 = new AddressdoctorComWebservice5.ArrayOfEnrichment();
        AddressdoctorComWebservice5.Enrichment enrichment3 = new AddressdoctorComWebservice5.Enrichment();
        enrichments2.enrichment = new List<AddressdoctorComWebservice5.Enrichment>();
        enrichment3.type_x='GEOCODING';
        enrichments2.enrichment.add(enrichment3);
        AddressdoctorComWebservice5.Response res1 = testsoap.Process('161683','Infa123',parameters,addresses2,enrichments2);
        System.debug('Prashant$$$$$$$^^^^^'+res1.statuscode+'$$$$'+res1.StatusMessage);
        AddressdoctorComWebservice5.Enrichment[] EnrichmentData=res1.results.result[0].Enrichments.Enrichment; // Added
        System.debug('#######EnrichmentDebug'+EnrichmentData);
        System.debug('Payload:'+EnrichmentData[0].PayloadXml);
        if(EnrichmentData[0].PayloadXml != NULL)
        {
        Dom.Document doc = new Dom.Document();
        doc.load(EnrichmentData[0].payloadxml);
        Dom.XMLNode ordDtls = doc.getRootElement();
        String LATITUDE= ordDtls.getChildElement('LATITUDE', null).getText();
        String LONGITUDE = ordDtls.getChildElement('LONGITUDE', null).getText();
        System.debug('OrderDtlID: ' + LATITUDE);
        System.debug('OrderDtlID: ' + LONGITUDE);
        Account.longitude__c= Longitude;
        Account.latitude__c= LATITUDE;
        }
        String Postalcode=MapOfAddress.get(Address).address.PostalCode.string_x[0];
        List<String> strlist=Address.split(';');
        system.debug('Address$'+ strlist);
        If(strlist.size()>0){
        displayPopup = false;
        Account.Address_1__c=strlist[0];
        Account.States__c=MapOfAddress.get(Address).address.Province.string_x[0];
        Account.City__c=MapOfAddress.get(Address).address.Locality.string_x[0];
        Account.Zip1__c=Postalcode;
        
        return createuser();
            //}
        
        //Insert Account;
        //PR = new PageReference('/'+Account.id);
        //PR = new PageReference('/apex/CommunitiesSelfRegConfirm');
        }
        }
        else{
        ApexPages.Message msg = new Apexpages.Message(ApexPages.Severity.Warning,'Please select one option to update' );
        ApexPages.addmessage(msg);
        }
        //return PR;
        return null;//added
        }
        
        catch(Exception e){
        System.debug('Exception Message'+e.getMessage());
        }
        
        return null;
    }
    
    Public PageReference Save(){
        PageReference PR;
     
        try{
          //Insert Account;
          //PR = new PageReference('/'+Account.id);
          //PR = new PageReference('/apex/CommunitiesSelfRegConfirm');
          //return PR;
          return null;//added
        } 
        catch(Exception e){
           System.debug('Exception Message'+e.getMessage());
        }
    
        return null;
    }    
    
    Public PageReference PageRedirect(){
        //List<account> acco=[Select id,Phone1__c,Legal_Name__c,Organization_Type__c,Address_1__c,City__c,States__c,Zip1__c,Phone__c from account];
        //if(acco.size()>0)
        //System.debug('Exception Mess33333age'+acco.size());
        displayPopup = true;
        invokeAddressDoctor();
        //GetAddresses();
        ///retrieveAddress();
        
        return null;
        
        //PageReference pageref = new PageReference('/apex/newValidateAddress');
        //return pageref;
         
        return null;
     }  


    public pagereference closePopup() {        
        displayPopup = false;    
        pagereference pr;
        pr = createuser();
        return pr;
    }
         
    public void showPopup() {        
        displayPopup = true;    
    }
    
    public void unshowPopup(){
        displayPopup = false;
    }
      
    public In_direct__c indirectcost{get;set;}
        
    public void create(){
        pagereference pr =null;
        try{
            system.Debug(LoggingLevel.Info,+account.Ein__c);
            
            // Removed Unique Identifier check for EIN per bug #3746
            //if(lstOrg!=null && lstOrg.size()>0){
            //if(lstOrg!=null && !lstOrg.isEmpty()){
               //ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Error: The Organization you are trying to create already exists'));
           // }else{
           if(account.EIN__c == null || account.EIN__c ==''){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Please enter a value for EIN number'));
           }
           pageredirect();
         // addressDoctorRequest();
               }
        catch(exception e)
        {  
            system.debug('e = '+e);  
           String msg = e.getMessage();  
           if(msg.contains('You can select only')){
               //ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'You can select only three values from the Organization Type list'));
           }else{ 
               ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,''+e.getMessage()));
           }
        }
     //   return pr;
    
    }

    
    public pagereference Cancelrecord(){
       pagereference pr  =new pagereference('/apex/Login_Page'); 
       return pr;
    
    }
    
    public pagereference createuser()
    {
                List<Account> lstOrg =[Select id,Ein__c from Account where Ein__c =:account.Ein__c];
                system.Debug('account-------'+account);
                system.Debug('userId-------'+userId);
                Profile  prof = [Select id, Name from Profile where Name = 'System Administrator' limit 1];
                User newUser = [Select id, Name from User where ProfileId =: prof.Id ORDER BY FirstName ASC Limit 1];
                account.ownerId = newUser.Id;
                //account.ownerId = '005t0000000M0WW';
                account.Created_from_Portal__c = true;
                insert account;
                Contact newContact =[Select id,AccountId,RecordtypeId,FirstName,LastName,Email,CommunityAuto__c from Contact where Id =:userId limit 1];
                newContact.AccountId = account.Id;
                //Added Code by Sravan on 12/19/2015 - Start
                newContact.RecordTypeId = Schema.SObjectType.Contact.getRecordTypeInfosByName().get('Grantee Admin').getRecordTypeId();
                newContact.Status__c = 'Accepted';
                //Added Code by Sravan on 12/19/2015 - End
                update newContact;
                
                //Added Code by Sravan on 12/19/2015 - Start
                User u = new User(ProfileId = ApexPages.currentPage().getParameters().get('profile'));
                u.Username = ApexPages.currentPage().getParameters().get('uname');
                u.Email = newContact.Email;
                u.FirstName = newContact.FirstName;
                u.LastName = newContact.LastName;
                u.Contactid=newContact.Id;
                u.CommunityNickname = newContact.FirstName+''+newContact.LastName+''+newContact.CommunityAuto__c;
                u.Alias = (newContact.FirstName+''+newContact.LastName).substring(0,1);
                u.EmailEncodingKey = 'ISO-8859-1';
                u.LanguageLocaleKey = 'en_US';
                u.LocaleSidKey = 'en_US';
                u.TimeZoneSidKey = 'America/New_York';
                insert u;
                
     
                pagereference pr =new pagereference('/apex/CommunitiesSelfRegConfirm');
                return pr;
    }
}