public with sharing class CommunitiesSelfRegController1 {
    
    
    
    
    
    public Contact contact {
        get {
            if (contact == null)
                contact = new Contact();
            return contact;
        }
        set;
    }
    
    public String firstName {get; set;}
    public String lastName {get; set;}
    public String email {get; set;}
    public String password {get; set {password = value == null ? value : value.trim(); } }
    public String confirmPassword {get; set { confirmPassword = value == null ? value : value.trim(); } }
    public String communityNickname {get; set { communityNickname = value == null ? value : value.trim(); } }
    Public List<SelectOption> options{get;set;}
    Public Map<String,AddressdoctorComWebservice5.ResultData> MapOfAddress;
    public boolean displayPopup {get; set;} 
    Public String Address{get;set;}
    public string userId = ApexPages.currentPage().getParameters().get('uid');
    
    public CommunitiesSelfRegController1 () {
        MapOfAddress=new Map<String,AddressdoctorComWebservice5.ResultData>();
        displayPopup = false;
        
    }
    
    private boolean isValidPassword() {
        return password == confirmPassword;
    }
    public pagereference Cancel(){
        pagereference pr  =new pagereference('/apex/CommunitiesLogin'); 
        return pr;
    }
    
    
    public PageReference registerUser() 
    {
        //PageReference Redirect;
        
        try
        {
            if(contact.Email!=contact.Re_Enter_Email__c)
            {           
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Info,'Email and Re-Enter Email address should be same.'));
                return null;
            }
            else if(contact.New_Password__c!=contact.Re_Enter_Password__c)
            {           
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Info,'Password and Re-Enter Password should be same.'));
                return null;
            }
            else
            {
                
                system.Debug('========enter registeruser');
                
                if (!isValidPassword()) 
                {
                    ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.ERROR, Label.site.passwords_dont_match);
                    ApexPages.addMessage(msg);
                    //   return null;
                    
                }
                //closePopup();
                
                // displayPopup = false;  
        system.Debug('contact======='+contact);
        //String profileId = '00er0000000LrAvAAK'; // To be filled in by customer.
        //Contact c = [Select Id, RecordtypeId from Contact where Id =:Apexpages.currentPage().getParameters().get('id')];
        Profile prof = [Select Id, Name from Profile where Name = 'Expert Reviewers'];
        String profileId = prof.Id;//'00er0000000Ls4p';//'00er0000000Ls1u';//'00er0000000Ls1u';//'00er0000000LrB0'; // To be filled in by customer.
        String roleEnum = 'Expertreviewers'; // To be filled in by customer.
        Account accName = [Select Id, Name from Account where Name = 'Expert Reviewers account'];
        String accountId = accName.Id; //'001r0000004y5an';//'001r0000004xqjR';//'001r0000004acZP';  // To be filled in by customer.
        //Id RecordTypeId = Schema.SObjectType.Contact.getRecordTypeInfosByName().get('Grantee Admin').getRecordTypeId();
        //Contact.SSN__c = '12345';
        
        contact.Accountid = accountId;
        //   If(userId!=null && userId!=''){
        
        insert contact; 
        system.Debug('============contact======'+contact);
        
        String userName = email;
        
        User u = new User(ProfileId = profileId);
        String urlVal = Apexpages.currentPage().getUrl();
        If(urlVal.contains('CommunitiesCustomSelfRegPage1?')){
            u.Username = contact.email+'.expertreviewer';
        }
        else {
            u.Username = contact.email;
        }
        system.Debug('============Username======'+u.Username);
        u.Email = contact.email;
        system.Debug('============Email======'+u.Email);
        u.FirstName = contact.FirstName;
        u.LastName = contact.LastName;
        u.Contactid=contact.Id;
        system.Debug('============Contactid======'+u.Contactid);
        DateTime currentTime = System.now(); Long timeInMili = currentTime.getTime()/1000; 
        u.CommunityNickname = contact.FirstName+''+contact.LastName +timeInMili;//communityNickname;
        // system.Debug('============portaluser======'+Site.createPortalUser(u, accountId, password));
        String userId = Site.createPortalUser(u, accountId, password);
        contact.OwnerId =  userId;
        //   Contact NewContact = [select Id, OwnerId from Contact where Id = :contact.Id limit 1 ];
        // NewContact.OwnerId = '005r0000000I84I';
        //update NewContact;
        
        system.Debug('============userId ======'+userId );
        System.debug('============Username======'+Username);
        if (userId != null) { 
            if (password != null && password.length() > 1) {
                return Site.login(username,password, null);
            }
            else {
                PageReference page = System.Page.communitiesSelfRegConfirm1;
                page.setRedirect(true);
                return page;
            }
        }
                
                return null;
                
                
            }   
            
        }
        
        
        catch(exception ex)
        {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'error====='+ ex));
        }
        return null;
    }
  /*  Public void PageRedirect(){
       // displayPopup = true;
        //GetAddresses();
        closePopup();
     
        //return null;
        
    }  */
    Public Void GetAddresses()
    {
        
        AddressdoctorComWebservice5 tes = new AddressdoctorComWebservice5();
        AddressdoctorComWebservice5.AddressValidationSoap testsoap = new AddressdoctorComWebservice5.AddressValidationSoap();
        AddressdoctorComWebservice5.Parameters parameters = new AddressdoctorComWebservice5.Parameters();
        parameters.ProcessMode='INTERACTIVE';
        AddressdoctorComWebservice5.ArrayOfAddress addresses = new AddressdoctorComWebservice5.ArrayOfAddress();
        AddressdoctorComWebservice5.Address address1 = new AddressdoctorComWebservice5.Address();
        addresses.address = new List<AddressdoctorComWebservice5.Address>();
        AddressdoctorComWebservice5.ArrayOfString testArray = new AddressdoctorComWebservice5.ArrayOfString();
        testArray.string_x = new List<String>{'ABC'};
            
            AddressdoctorComWebservice5.ArrayOfString  testArray1 = new AddressdoctorComWebservice5.ArrayOfString();
        
        AddressdoctorComWebservice5.ArrayOfString  testArray2 = new AddressdoctorComWebservice5.ArrayOfString();
        testArray2.string_x=new List<String>{Contact.Mailing_State__c};
            address1.Province= testArray2; 
        
        AddressdoctorComWebservice5.ArrayOfString  testArray3 = new AddressdoctorComWebservice5.ArrayOfString();
        testArray3.string_x=new List<String>{'United States'};
            address1.Country= testArray3; 
        
        AddressdoctorComWebservice5.ArrayOfString  testArray4 = new AddressdoctorComWebservice5.ArrayOfString();
        testArray4.string_x=new List<String>{Contact.Mailing_Street_Address_1__c};
            //testArray4.string_x=new List<String>{'Landover Street'};
            address1.HouseNumber= testArray4; 
        
        AddressdoctorComWebservice5.ArrayOfString  testArray5 = new AddressdoctorComWebservice5.ArrayOfString();
        testArray5.string_x=new List<String>{Contact.Mailing_Street_Address_2__c};
            address1.Street= testArray5; 
        
        AddressdoctorComWebservice5.ArrayOfString  testArray6 = new AddressdoctorComWebservice5.ArrayOfString();
        testArray6.string_x=new List<String>{Contact.Mailing_Zip_Code__c};
            //testArray6.string_x=new List<String>{'22305'};
            address1.PostalCode= testArray6; 
        
        addresses.Address.add(address1);
        
        AddressdoctorComWebservice5.ArrayOfEnrichment enrichments = new AddressdoctorComWebservice5.ArrayOfEnrichment();
        AddressdoctorComWebservice5.ServiceParameters ServiceParam = new AddressdoctorComWebservice5.ServiceParameters();
        
        parameters.ServiceParameters = ServiceParam;
        
        AddressdoctorComWebservice5.Response res = testsoap.Process('161683','Infa123',parameters,addresses,enrichments);
        
        AddressdoctorComWebservice5.ResultData[] ResData=res.results.result[0].ResultDataSet.ResultData; // Added
        System.debug('#######ResultSet'+res.results.result.size());
        System.debug('#######ArrayOfResultSet'+res.results.result[0].ResultDataSet.ResultData.size()+'@@@@@@'+ResData.size());
        System.debug('#######ArrayOfResultSet_ResultNumber'+res.results.result[0].ResultDataSet.ResultData[0].ResultNumber);
        options = new List<SelectOption>();
        For(AddressdoctorComWebservice5.ResultData rd : ResData)
        {
            //System.debug('#######ArrayOfResultSet_ResultNumber_iterate'+rd.address.Organization.string_x+'@@'+rd.address.Department.string_x+'@@'+rd.address.Contact.string_x+'@@'+rd.address.Building.string_x+'@@'+rd.address.SubBuilding.string_x+'@@'+rd.address.Street.string_x+'@@'+rd.address.HouseNumber.string_x+'@@'+rd.address.DeliveryService.string_x+'@@'+rd.address.Locality.string_x+'@@'+rd.address.AddressComplete);
            //System.debug('#######ArrayOfResultSet_ResultNumber_iterate_Fields'+rd.address.PreferredLocality.string_x+'@@'+rd.address.PostalCode.string_x+'@@'+rd.address.Province.string_x+'@@'+rd.address.Country.string_x+'@@'+rd.address.Residue.string_x+'@@'+rd.address.RecipientLines.string_x+'@@'+rd.address.DeliveryAddressLines.string_x+'@@'+rd.address.CountrySpecificLocalityLine.string_x+'@@'+rd.address.FormattedAddress.string_x);
            //System.debug('#######ArrayOfResultSet_ResultNumber_iterate'+rd.address.FormattedAddress.string_x);
            if(rd.address.AddressComplete != null)
            {
                options.add(new SelectOption(rd.address.AddressComplete,rd.address.AddressComplete)); 
                
                MapOfAddress.put(rd.address.AddressComplete,rd);
            }
        }
        
    }
    
    /*public pagereference closePopup()
    {  
        
       
       return null;
    }*/
    
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
                    Contact.longitude__c= Longitude;
                    Contact.latitude__c= LATITUDE;
                }
                String Postalcode=MapOfAddress.get(Address).address.PostalCode.string_x[0];
                List<String> strlist=Address.split(';');
                system.debug('Address$'+ strlist);
                If(strlist.size()>0){
                    displayPopup = false;
                    Contact.Mailing_Street_Address_1__c=strlist[0];
                    Contact.Mailing_State__c=MapOfAddress.get(Address).address.Province.string_x[0];
                    Contact.Mailing_City__c=MapOfAddress.get(Address).address.Locality.string_x[0];
                    Contact.Mailing_Zip_Code__c=Postalcode;
                    //Insert Account;
                    //PR = new PageReference('/'+Account.id);
                    //PR = new PageReference('/apex/CommunitiesSelfRegConfirm');
                    system.Debug('contact======='+contact);
                    //String profileId = '00er0000000LrAvAAK'; // To be filled in by customer.
                    //Contact c = [Select Id, RecordtypeId from Contact where Id =:Apexpages.currentPage().getParameters().get('id')];
                    Profile prof = [Select Id, Name from Profile where Name = 'Expert Reviewers'];
                    String profileId = prof.Id;//'00er0000000Ls4p';//'00er0000000Ls1u';//'00er0000000Ls1u';//'00er0000000LrB0'; // To be filled in by customer.
                    String roleEnum = 'Expertreviewers'; // To be filled in by customer.
                    Account accName = [Select Id, Name from Account where Name = 'Expert Reviewers account'];
                    String accountId = accName.Id; //'001r0000004y5an';//'001r0000004xqjR';//'001r0000004acZP';  // To be filled in by customer.
                    //Id RecordTypeId = Schema.SObjectType.Contact.getRecordTypeInfosByName().get('Grantee Admin').getRecordTypeId();
                    //Contact.SSN__c = '12345';
                    
                    contact.Accountid = accountId;
                    //   If(userId!=null && userId!=''){
                    
                    insert contact; 
                    system.Debug('============contact======'+contact);
                    
                    String userName = email;
                    
                    User u = new User(ProfileId = profileId);
                    String urlVal = Apexpages.currentPage().getUrl();
                    If(urlVal.contains('CommunitiesCustomSelfRegPage1?')){
                        u.Username = contact.email+'.expertreviewer';
                    }
                    else {
                        u.Username = contact.email;
                    }
                    system.Debug('============Username======'+u.Username);
                    u.Email = contact.email;
                    system.Debug('============Email======'+u.Email);
                    u.FirstName = contact.FirstName;
                    u.LastName = contact.LastName;
                    u.Contactid=contact.Id;
                    system.Debug('============Contactid======'+u.Contactid);
                    DateTime currentTime = System.now(); Long timeInMili = currentTime.getTime()/1000; 
                    u.CommunityNickname = contact.FirstName+''+contact.LastName +timeInMili;//communityNickname;
                    // system.Debug('============portaluser======'+Site.createPortalUser(u, accountId, password));
                    String userId = Site.createPortalUser(u, accountId, password);
                    contact.OwnerId =  userId;
                    //   Contact NewContact = [select Id, OwnerId from Contact where Id = :contact.Id limit 1 ];
                    // NewContact.OwnerId = '005r0000000I84I';
                    //update NewContact;
                    
                    system.Debug('============userId ======'+userId );
                    System.debug('============Username======'+Username);
                    if (userId != null) { 
                        if (password != null && password.length() > 1) {
                            return Site.login(username,password, null);
                        }
                        else {
                            /*PageReference page = System.Page.communitiesSelfRegConfirm1;
                            page.setRedirect(true);
                            return page;*/
                            return new Pagereference('/apex/CommunitiesSelfRegConfirm1');
                        }
                    }
                }
            }
            else{
                ApexPages.Message msg = new Apexpages.Message(ApexPages.Severity.Warning,'Please select one option to update' );
                ApexPages.addmessage(msg);
                return null;
            }
            //return PR;
            //added
        }
        
        catch(Exception e){
            System.debug('Exception Message'+e.getMessage());
            return null;
        }
        // displayPopup = false;
        return null;
    }
    
   //public pagereference Confirm(){    
        //return new Pagereference('/apex/CommunitiesSelfRegConfirm');
    //} 
    
}