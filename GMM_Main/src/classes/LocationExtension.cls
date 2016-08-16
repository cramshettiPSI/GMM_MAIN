public class LocationExtension {
 

    Public Location__c locationInput{get;set;}    
    public String id;
    public String Locationid;
    // public String Id;
    Public String nofaid;
    public PageReference Redirect;
    public PageReference RedirectNew;
    public Application3__c Application {get;set;}
    public NOFA__c Nofa{get;set;}
    public String queryString {get;set;}
    private ApexPages.StandardController scontroller;
    Public List<SelectOption> options{get;set;}
    Public Map<String,AddressdoctorComWebservice5.ResultData> MapOfAddress;
    public boolean displayPopup {get; set;} 
    Public String Address{get;set;}
    public Map<String,String> mpSuggestedAddresses=new map<String,String>();
    /* String StreetAddress1;
    String StreetAddress2;
    String State;
    String City;
    String Zip;
    */
    
    
    public LocationExtension getThis(){
        return this;
    }
    
    public LocationExtension (ApexPages.StandardController controller) 
    {      
            MapOfAddress=new Map<String,AddressdoctorComWebservice5.ResultData>();
            displayPopup = false;
                  
            sController = controller;
            locationInput= new Location__c();
            System.debug('State_####'+locationInput.State__c);
            Locationid=Apexpages.currentPage().getParameters().get('Locationid');  
            // nofaid=Apexpages.currentPage().getParameters().get('nofaid');  
            id=Apexpages.currentPage().getParameters().get('applicationid');    
           
            If(id!=null && id!='')
               /* locationInput=[select Application__r.NOFA_RFP__r.Volunteer_Information__c,Application__c,Beds_Provided__c,Capacity_Building__c,City__c,Description_of_Accessibility__c,Disaster_Services__c,
               Distance_to_Location_of_Service__c,Economic_Opportunities__c,Education__c,Environmental_Stewardship__c,Healthy_Futures__c,Is_this_a_K_12_school__c,Kitchen__c,Laundry__c,Location_EIN__c,Location_Type__c,Lodging_Arrival_Date__c,
               Lodging_Category__c,Lodging_Departure_Date__c,Lodging_Description__c,Lodging_Type__c,NOFA1__c,NOFA__c,Number_of_Unduplicated_Volunteers__c,Number_of_Volunteers__c,Other_Capacity_Building__c,Other_Disaster_Services__c,
               Other_Economic_Opportunities__c,Other_Education__c,Other_Environmental_Stewardship__c,Other_Healthy_Futures__c,Other_Veterans_Military_Families__c,Projected_End_Date__c,Projected_Start_Date__c,Refrigerator_Microwave__c,Shower__c,
               Site_Type__c,State__c,Station_Type__c,Street_Address_1__c,Street_Address_2__c,Summer_Associates__c,Supervisor_Email__c,Supervisor_Name__c,Supervisor_Organization__c,Supervisor_Phone_Number__c,Supervisor_Phone_Number_Extension__c,
               Undisclosed_Location__c,Veterans_Military_Families__c,Veterans_Served__c,Zip__c from Location__c where id=:Locationid];  */                  
  
           If(id!=null && id!='')
                Application=[Select Id,Name,NOFA_RFP__c,NOFA_RFP__r.Volunteer_Information__c, Nofa_RFP__r.School_Information__c, NOFA_RFP__r.Focus_Area_and_Objectives_Location__c,Nofa_RFP__r.Standard_Information__c,
                             NOFA_RFP__r.EIN_Information__c,Nofa_RFP__r.Site_Date_Information__c,NOFA_RFP__r.Site_Type__c,Nofa_RFP__r.Site_Type_and_Summer_Associates__c,NOFA_RFP__r.Additional_Operating_Site_Information__c,
                             Nofa_RFP__r.Lodging_Information__c,Application_Signed__c,Authorized_Representative__c,Certifications_Clicked__c,Assurances_Clicked__c from Application3__c where id=:id]; 

           locationInput.Application__c =id;
           //system.debug('$$$ '+ id+ '###'+ locationInput.Application__c + '&&&' +Application.id);
           //system.debug('@@@PRASHANT'+id+'$$$'+Application.id);

           //PageReference thisPage = ApexPages.currentPage();

           // List<String> url = thisPage.getUrl().split('\\?');

           // queryString = url[1];
   
        
            /*     StreetAddress1= locationinput.Street_Address_1__c;
            StreetAddress2= locationinput.Street_Address_2__c;
            City= locationinput.City__c;
            State= locationinput.State__c;
            Zip= locationinput.Zip__c; */
        
    }
  
  
  
    public pagereference save1(){
  
    // PageReference Redirect;
        try{
            if(Validate()) {           
                 // return null; 
                    If(id!=null && id!='')
                    {
                        //PageRedirect();
                        if(Application.Application_Signed__c){
                            Application.Application_Signed__c = false;
                            Application.Authorized_Representative__c = null;
                            Application.Certifications_Clicked__c = false;
                            Application.Assurances_Clicked__c = false;
                        }
                        update Application;
                          
                        insert locationInput;
                        Redirect = new PageReference('/apex/LocationDetailPage?id='+locationInput.id);
                        return Redirect;
                    }
                 // insert locationInput;
                 // Redirect = new PageReference('/apex/LocationDetailPage?id='+locationInput.id);
                 system.debug('@#@#'+locationInput.id);
            }  
            // return Redirect;
         }
         Catch(DMLException e){
             ApexPages.addMessages(e);
             System.debug('@@@@@@@@!!!!!'+e.getmessage());
         }
         return null;
    }
  
    public boolean savennew=false;
    // Save and New button
    public Pagereference saveandnew(){       
        //save1();        
        savennew=true;
        try{
            if(Validate()){
                PageRedirect();
                //NewRedirect();
                savennew=true;
            }
            return null;      
        }catch(System.DMLException e) {
            ApexPages.addMessages(e);
            return null;
        }
    } 
    
    public boolean Validate()
    {
        if((locationInput.Location_Type__c == null)){
            locationInput.Location_Type__c.addError('Enter Location Type');
            return false;
        }
      
        if(((locationInput.Location_Type__c == 'Operating Site') || ((locationInput.Location_Type__c == 'Member Lodging')) || (locationInput.Location_Type__c == 'Inclement Weather Site')|| (locationInput.Location_Type__c == 'Service Location')) && ((locationInput.Supervisor_Email__c == null)))
        {
            locationInput.Supervisor_Email__c.addError('Enter Supervisor Email');
            return false;
        }
        if(((locationInput.Location_Type__c == 'Operating Site') || (locationInput.Location_Type__c == 'Member Lodging') || (locationInput.Location_Type__c == 'Inclement Weather Site')|| (locationInput.Location_Type__c == 'Service Location')) && ((locationInput.Supervisor_Name__c == null)))
        {
            locationInput.Supervisor_Name__c.addError('Enter Supervisor Name');
            return false;
        }
        if(((locationInput.Location_Type__c == 'Operating Site') || (locationInput.Location_Type__c == 'Member Lodging') || (locationInput.Location_Type__c == 'Inclement Weather Site')|| (locationInput.Location_Type__c == 'Service Location')) && ((locationInput.Supervisor_Phone_Number__c == null)))
        {
            locationInput.Supervisor_Phone_Number__c.addError('Enter Supervisor Phone Number');
            return false;
        }
        if(((locationInput.Location_Type__c == 'Operating Site') || (locationInput.Location_Type__c == 'Member Lodging') || (locationInput.Location_Type__c == 'Inclement Weather Site')|| (locationInput.Location_Type__c == 'Service Location')) && ((locationInput.Undisclosed_Location__c == null)))
        {
             locationInput.Undisclosed_Location__c.addError('Enter undisclosed Location');
             return false;
        }
        if(((locationInput.Location_Type__c == 'Operating Site') || (locationInput.Location_Type__c == 'Member Lodging')|| (locationInput.Location_Type__c == 'Inclement Weather Site') ||((locationInput.Location_Type__c == 'Service Location') && (locationInput.Is_this_a_K_12_school__c == 'No')))&& ((locationInput.Name == null)))
        {
             locationInput.Name.addError('Enter Location Name');
             return false;
        }
        if(((locationInput.Location_Type__c == 'Operating Site') || (locationInput.Location_Type__c == 'Member Lodging')|| (locationInput.Location_Type__c == 'Inclement Weather Site')  ||((locationInput.Location_Type__c == 'Service Location') && (locationInput.Is_this_a_K_12_school__c == 'No') )) && ((locationInput.Street_Address_1__c == null)))
        {
             locationInput.Street_Address_1__c.addError('Enter Street Address 1');
             return false;
        }
        if(((locationInput.Location_Type__c == 'Operating Site') || (locationInput.Location_Type__c == 'Member Lodging')|| (locationInput.Location_Type__c == 'Inclement Weather Site') ||((locationInput.Location_Type__c == 'Service Location') && (locationInput.Is_this_a_K_12_school__c == 'No') )) && ((locationInput.City__c == null)))
        {
             locationInput.City__c.addError('Enter City');
             return false;
        }
        if(((locationInput.Location_Type__c == 'Operating Site') || (locationInput.Location_Type__c == 'Member Lodging')|| (locationInput.Location_Type__c == 'Inclement Weather Site') ||((locationInput.Location_Type__c == 'Service Location') && (locationInput.Is_this_a_K_12_school__c == 'No') )) && ((locationInput.State__c == null)))
        {
             locationInput.State__c.addError('Enter State');
             return false;
        } 
        if(((locationInput.Location_Type__c == 'Operating Site') || (locationInput.Location_Type__c == 'Member Lodging')|| (locationInput.Location_Type__c == 'Inclement Weather Site') ||((locationInput.Location_Type__c == 'Service Location') && (locationInput.Is_this_a_K_12_school__c == 'No') )) && ((locationInput.Zip__c == null)))
        {
             locationInput.Zip__c.addError('Enter Zip');
             return false;
        } 
        if((Application.NOFA_RFP__r.Site_Date_Information__c == true ) && ((locationInput.Location_Type__c == 'Member Lodging') || (locationInput.Location_Type__c == 'Inclement Weather Site') || (locationInput.Location_Type__c == 'Service Location')) && ((locationInput.Projected_Start_Date__c == null)))
        {
             locationInput.Projected_Start_Date__c.addError('Enter Projected Start Date');
             return false;
        } 
        if((Application.NOFA_RFP__r.Site_Date_Information__c == true ) && ((locationInput.Location_Type__c == 'Member Lodging') || (locationInput.Location_Type__c == 'Inclement Weather Site') || (locationInput.Location_Type__c == 'Service Location')) && (locationInput.Projected_End_Date__c == null))
        {
             locationInput.Projected_End_Date__c.addError('Enter Projected End Date'); 
             return false;
        }
        if((Application.NOFA_RFP__r.Site_Type_and_Summer_Associates__c == true ) && ((locationInput.Location_Type__c == 'Service Location')) && (locationInput.Site_Type__c == null))
        {
             locationInput.Site_Type__c.addError('Enter Site type');
             return false;
        } 
        if((Application.NOFA_RFP__r.Lodging_Information__c == true ) && ((locationInput.Location_Type__c == 'Member Lodging')) && (locationInput.Lodging_Type__c == null))
        {
             locationInput.Lodging_Type__c.addError('Enter Lodging type');
             return false;
        }
        if((Application.NOFA_RFP__r.Lodging_Information__c == true ) && ((locationInput.Location_Type__c == 'Member Lodging')) && (locationInput.Lodging_Category__c == null))
        {
             locationInput.Lodging_Category__c.addError('Enter Lodging Category');
             return false;
        }
        if((Application.NOFA_RFP__r.Lodging_Information__c == true ) && ((locationInput.Location_Type__c == 'Member Lodging')) && (locationInput.Lodging_Description__c == null))
        {
             locationInput.Lodging_Description__c.addError('Enter Lodging Description');
             return false;
        }
        if((Application.NOFA_RFP__r.Lodging_Information__c == true ) && ((locationInput.Location_Type__c == 'Member Lodging')) && (locationInput.Distance_to_Location_of_Service__c == null))
        {
             locationInput.Distance_to_Location_of_Service__c.addError('Enter Distance to location of service');
             return false;
        }
        if((Application.NOFA_RFP__r.Lodging_Information__c == true ) && ((locationInput.Location_Type__c == 'Member Lodging')) && (locationInput.Lodging_Departure_Date__c == null))
        {
             locationInput.Lodging_Departure_Date__c.addError('Enter Lodging Departure Date');
             return false;
        }
        if((Application.NOFA_RFP__r.Lodging_Information__c == true ) && ((locationInput.Location_Type__c == 'Member Lodging')) && (locationInput.Lodging_Arrival_Date__c == null))
        {
             locationInput.Lodging_Arrival_Date__c.addError('Enter Lodging Arrival Date');
             return false;
        }
        if((Application.NOFA_RFP__r.Site_Type__c == true ) && ((locationInput.Location_Type__c == 'Service Location')) && (locationInput.Station_Type__c == null))
        {
             locationInput.Station_Type__c.addError('Enter Station Type');
             return false;
        }

        if(Application.NOFA_RFP__r.Focus_Area_and_Objectives_Location__c == true && locationInput.Location_Type__c != 'Member Lodging' )    
        {
                if(locationInput.Education__c == null && locationInput.Veterans_Military_Families__c == null && locationInput.Disaster_Services__c == null && 
                    locationInput.Environmental_Stewardship__c == null && locationInput.Healthy_Futures__c == null && locationInput.Capacity_Building__c == null  && 
                    locationInput.Economic_Opportunities__c == null)    
                {
    
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error, 'Please enter atleast 1 Focus Area'));
                    return false;
                } 
        } 




        if(((locationInput.Is_this_a_K_12_school__c == 'Yes') && (locationInput.NCES_ID__c == null)) || ((locationInput.Accessible_for_people_with_disablities__c == true) && (locationInput.Description_of_Accessibility__c == null)))
        {
          locationInput.NCES_IDs__c.addError('Enter NCES ID');
          locationInput.NCES_IDs__c.addError('Enter Description of Accesibility');
       /* locationInput.Name.addError('Enter Name');
          locationInput.Location_Type__c.addError('Enter Location Type');
          locationInput.Supervisor_Name__c.addError('Enter Supervisor Name');
          locationInput.Supervisor_Email__c.addError('Enter Supervisor Email');
          locationInput.Supervisor_Phone_Number__c.addError('Enter Supervisor Phone Number');
          locationInput.Undisclosed_Location__c.addError('Enter Undisclosed Location');
          locationInput.Street_Address_1__c.addError('Enter Street Address 1');
          locationInput.City__c.addError('Enter City');
          locationInput.State__c.addError('Enter State');
          locationInput.Zip__c.addError('Enter Zip');
          locationInput.Projected_Start_Date__c.addError('Enter Projected Start Date');
          locationInput.Projected_End_Date__c.addError('Enter Projected End Date');          
          locationInput.Description_of_Accessibility__c.addError('Enter Description of Accessibility');
          locationInput.Site_Type__c.addError('Enter Site Type');
          locationInput.Station_Type__c.addError('Enter Station Type');
          locationInput.Lodging_Type__c.addError('Enter Lodging Type');
          locationInput.Lodging_Category__c.addError('Enter Lodging Category');
          locationInput.Lodging_Description__c.addError('Enter Lodging Description');
          locationInput.Lodging_Arrival_Date__c.addError('Enter Lodging Arrival Date');
          locationInput.Lodging_Departure_Date__c.addError('Enter Lodging Departure Date');
          locationInput.Distance_to_Location_of_Service__c.addError('Enter Distance to Location of Service');  */
          return false;
        }
                       
        return true;
    }
  
    /* public PageReference populateOtherFields()
    {
        Location__c l = [Select NCES_IDs__c, Private_School_Name__c, School_State__c from Location__c where School_ID_NCES__c=: locationInput.NCES_ID__c];
        LocSchool = l.Private_School_Name__c;
        LocState = l.School_State__c;
        return null;

    }*/

    public PageReference PageRedirect(){
        //displayPopup = true;
        //GetAddresses();
        if(locationInput.Is_this_a_K_12_school__c == 'No' || locationInput.Location_Type__c != 'Service Location'){
            displayPopup = true;
            invokeAddressDoctor();
            return null;
            }
            else{
                insert locationInput;
                //sController.save();
                PageReference Redirect = new PageReference('/apex/LocationDetailPage?id='+locationInput.id);
                return Redirect;    
            }
           
    }
    
    
    public AddressRequest  prepareRequestForAddressDoctor(){
     
         AddressRequest objAddressRequest = new AddressRequest();
         String  strSplittedAddress1;
         //assign data
         if(locationInput!=null && locationInput.Street_Address_1__c!=''){
            //String  strSplittedAddress1='2520  dulles station blvd';
            strSplittedAddress1=locationInput.Street_Address_1__c;
            String []str; 
            integer spaceIndex= strSplittedAddress1.indexof(' ');
            System.debug('spaceindex'+spaceIndex);
            String strHno=strSplittedAddress1.subString(0,spaceIndex);
            System.debug('strHno'+strHno);
            String strStreet=strSplittedAddress1.subString(spaceIndex+1,strSplittedAddress1.length());
            System.debug('strStreet'+strStreet);
            objAddressRequest.houseNumber = new List<String>{strHno};
            objAddressRequest.street = new List<String>{strStreet};
            
         }
         else{
           // Apexpages.addMessage('Please provide Address details');
                
            return null;
            }
          
         
        // objAddressRequest.houseNumber = new List<String>{'123'};
         //System.debug('House Number Value ....... @@@@@@@@@@@@' +objAddressRequest.houseNumber);
        // objAddressRequest.street = new List<String>{Account.Address_1__c};
        // System.debug('Street Value ....... @@@@@@@@@@@@' +objAddressRequest.street);
        objAddressRequest.locality= new List<String>{LocationInput.City__c};
         System.debug('City Value ....... @@@@@@@@@@@@' +objAddressRequest.locality);
         objAddressRequest.province = new List<String>{locationInput.State__c};
         System.debug('Province Value ....... @@@@@@@@@@@@' +objAddressRequest.province);
         objAddressRequest.postalCode = new List<String>{locationInput.Zip__c};
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
             
             //for adding the suggested address from AddressDoctor into RadioButtons
             mpSuggestedAddresses=new map<String,String>();
             options = new List<SelectOption>();
             string strProcessStatusMsg='';
             string strMailabilityScoreMsg='';
             for(AddressDoctorResponse.Result itrObjAddressDoctorResponseResult    : objAddressDoctorResponse.lstResult){
                if(itrObjAddressDoctorResponseResult.processStatus!=null && itrObjAddressDoctorResponseResult.processStatus!=''){
                    strProcessStatusMsg=AddressDoctorResponse.evaluateProcessStatus(itrObjAddressDoctorResponseResult.processStatus);
                }
                if(itrObjAddressDoctorResponseResult.mailabilityScore!=null && itrObjAddressDoctorResponseResult.mailabilityScore!=''){
                    strMailabilityScoreMsg=AddressDoctorResponse.evaluateMailabilityScore(itrObjAddressDoctorResponseResult.mailabilityScore);
                }
                //System.debug('#######itrObjAddressDoctorResponseResult.formattedAddress'+itrObjAddressDoctorResponseResult.formattedAddress);
                options.add(new SelectOption(itrObjAddressDoctorResponseResult.addressComplete,itrObjAddressDoctorResponseResult.addressComplete)); 
                ///String strConcatenatedAddressWithTilde=itrObjAddressDoctorResponseResult.houseNumber+' '+itrObjAddressDoctorResponseResult.street+'~';
                String strConcatenatedAddressWithTilde=itrObjAddressDoctorResponseResult.street+'~';
                strConcatenatedAddressWithTilde+=itrObjAddressDoctorResponseResult.locality+'~';
                strConcatenatedAddressWithTilde+=itrObjAddressDoctorResponseResult.province+'~';
                strConcatenatedAddressWithTilde+=itrObjAddressDoctorResponseResult.postalCode;
                mpSuggestedAddresses.put(itrObjAddressDoctorResponseResult.addressComplete,strConcatenatedAddressWithTilde);
              } 
          }
         //add callout exception
         catch(NullPointerException nullPtrExc){
             System.debug('*** invokeAddressDoctor NullPointerException ***'+nullPtrExc);
         }
         catch(Exception exc){
             System.debug('*** invokeAddressDoctor Exception ***'+exc);
         }
     }
     
     public PageReference addressSelection(){
         try{
             if(Address!=null){
                 System.debug('###mpSuggestedAddresses###'+mpSuggestedAddresses+'###Address###'+Address);
                 String strSelectedAddress=mpSuggestedAddresses.get(Address);
                 List<String> lstAddressSubFields=strSelectedAddress.split('~');
                 System.debug('###lstAddressSubFields###'+lstAddressSubFields);
                 If(lstAddressSubFields.size()>0){
                    displayPopup = false;
                    locationInput.Street_Address_1__c=lstAddressSubFields[0].subString(1,lstAddressSubFields[0].length()-1);
                    locationInput.City__c=lstAddressSubFields[1].subString(1,lstAddressSubFields[1].length()-1);
                    string tempStates=lstAddressSubFields[2].split(',')[0];
                    locationInput.State__c=tempStates.subString(1,tempStates.length());
                    String tempZip=lstAddressSubFields[3].split('-')[0];
                    locationInput.Zip__c=tempZip.subString(1,tempZip.length()); 
                    //sController.save(); 
                    insert locationInput;
                    Redirect = new PageReference('/apex/LocationDetailPage?id='+locationInput.id);
                    return Redirect;
                    //locationInput.Zip__c=lstAddressSubFields[3].subString(1,lstAddressSubFields[3].length()-1);
                    //return createuser();
                   // pagereference pr =new pagereference('/apex/granteeportal/Createorganization');
                    //return null;
                 }
            }
            else{
                ApexPages.Message msg = new Apexpages.Message(ApexPages.Severity.Warning,'Please select one option to update' );
                ApexPages.addmessage(msg);
            }
                
         
         
         }
         catch(Exception exc){
         
         
         }
         return null; 
     } 
        
    public Void GetAddresses()
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
        testArray2.string_x=new List<String>{locationInput.State__c};
        address1.Province= testArray2; 
        
        //  AddressdoctorComWebservice5.ArrayOfString  testArray10 = new AddressdoctorComWebservice5.ArrayOfString();
        //  testArray10.string_x=new List<String>{locationInput.City__c};
        //     address1.City= testArray10; 
        
        AddressdoctorComWebservice5.ArrayOfString  testArray3 = new AddressdoctorComWebservice5.ArrayOfString();
        testArray3.string_x=new List<String>{'United States'};
        address1.Country= testArray3; 
        
        AddressdoctorComWebservice5.ArrayOfString  testArray4 = new AddressdoctorComWebservice5.ArrayOfString();
        testArray4.string_x=new List<String>{locationInput.Street_Address_1__c};
        //testArray4.string_x=new List<String>{'Landover Street'};
        address1.HouseNumber= testArray4; 
        
        AddressdoctorComWebservice5.ArrayOfString  testArray5 = new AddressdoctorComWebservice5.ArrayOfString();
        testArray5.string_x=new List<String>{locationInput.Street_Address_2__c};
        address1.Street= testArray5; 
        
        AddressdoctorComWebservice5.ArrayOfString  testArray6 = new AddressdoctorComWebservice5.ArrayOfString();
        testArray6.string_x=new List<String>{locationInput.Zip__c};
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
           // System.debug('#######ArrayOfResultSet_ResultNumber_iterate'+rd.address.FormattedAddress.string_x);
            options.add(new SelectOption(rd.address.AddressComplete,rd.address.AddressComplete)); 
           
            MapOfAddress.put(rd.address.AddressComplete,rd);
        }
        
    }
    
     public void unshowPopup(){
        displayPopup = false;
     }
    
    public PageReference closePopup()
    {        
         displayPopup = false;    
         if(savennew)
         {
            insert locationInput;
            sController.save();
            
            Schema.DescribeSObjectResult describeResult = sController.getRecord().getSObjectType().getDescribe();        
         
            PageReference pr = new PageReference('/apex' + '/LocationCreationPage?' + queryString);
      
            pr.setRedirect(true);
            return pr;  

         }
         else
         {
            //insert locationInput;
            sController.save();
            PageReference Redirect = new PageReference('/apex/LocationDetailPage?id='+locationInput.id);
            return Redirect;
         }
    }
    
    public PageReference Submit() {
    
        PageReference redirect;       
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
                    //     locationInput.longitude__c= Longitude;
                    //     locationInput.latitude__c= LATITUDE;
                }
                String Postalcode=MapOfAddress.get(Address).address.PostalCode.string_x[0];
                List<String> strlist=Address.split(';');
                system.debug('Address$'+ strlist);
                If(strlist.size()>0){
                    displayPopup = false;                     
                    locationInput.Street_Address_1__c=strlist[0];
                    locationInput.State__c=MapOfAddress.get(Address).address.Province.string_x[0];
                    locationInput.City__c=MapOfAddress.get(Address).address.Locality.string_x[0];
                    locationInput.Zip__c=PostalCode;
                   
                    system.debug('Testing66');               
                    if(savennew)
                    {
                    
                        insert locationInput;
                        sController.save();
                        
                        Schema.DescribeSObjectResult describeResult = sController.getRecord().getSObjectType().getDescribe();        
                     
                        PageReference pr = new PageReference('/apex' + '/LocationCreationPage?' + queryString);
                  
                        pr.setRedirect(true);
                        return pr;  

                    }
                    else
                    {
                        system.debug('Testing67');
                        insert locationInput;
                        Redirect = new PageReference('/apex/LocationDetailPage?id='+locationInput.id);
                        Redirect.setRedirect(true);
                        return Redirect;
                    }
                    
                        
                    
                    //Insert Account;
                    //PR = new PageReference('/'+Account.id);
                    
                }
            }
            else{
                ApexPages.Message msg = new Apexpages.Message(ApexPages.Severity.Warning,'Please select one option to update' );
                ApexPages.addmessage(msg);
                return null;
            }
            //return PR;
            
       }        
       catch(Exception e){
            System.debug('Exception Message'+e.getMessage());
       } 
       displayPopup = false;
       return redirect;
    }
    
}