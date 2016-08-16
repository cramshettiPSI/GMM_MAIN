public class LocationEditExt {
    
    public Location__c locationInput{get;set;}
    private ApexPages.StandardController scontroller;
    public String id;
    public String LocationId;
    Public List<SelectOption> options{get;set;}
    public Application3__c Application {get;set;}
    public NOFA__c Nofa{get;set;}
    Public String Address{get;set;}
    public String queryString {get;set;}
    public boolean displayPopup {get; set;} 
    public boolean savennew=false;
    public PageReference Redirect;
    public Map<String,String> mpSuggestedAddresses=new map<String,String>();
    
    public boolean loc1{get;set;}
    
    public LocationEditExt getThis(){
            return this;
        }
    
    public LocationEditExt (ApexPages.StandardController controller) 
    {  
            locationInput= new Location__c();
            scontroller = controller;
            Locationid=Apexpages.currentPage().getParameters().get('id');          
            system.debug('#####locbef###'+id);
            system.debug('#####locbeforeid###'+Locationid);
    
               
            If(Locationid!=null)
               locationInput=[select Id,Name,RecordType.Name,Application__r.NOFA_RFP__r.Lodging_Information__c ,Application__r.NOFA_RFP__r.Site_Type__c,Application__r.NOFA_RFP__r.Site_Date_Information__c,Application__r.NOFA_RFP__r.Focus_Area_and_Objectives_location__c,Application__r.NOFA_RFP__r.EIN_Information__c,Application__r.NOFA_RFP__r.Volunteer_Information__c,Application__r.NOFA_RFP__r.Standard_Information__c,Application__r.NOFA_RFP__r.School_Information__c ,Application__c,School_Name__c ,Accessible_for_people_with_disablities__c,NCES_ID__c,School_City__c,School_Zip__c ,School_Street_Address_2__c ,School_State__c ,School_Street_Address_1__c ,School_ID_NCES__c ,Economic_Opportunities__c,Healthy_Futures__c,Capacity_Building__c,Beds_Provided__c,City__c,Environmental_Stewardship__c,Description_of_Accessibility__c,Distance_to_Location_of_Service__c,Education__c,
               Is_this_a_K_12_school__c,Kitchen__c,Laundry__c,Location_EIN__c,Application__r.NOFA_RFP__r.Site_Type_and_Summer_Associates__c,Location_Type__c,Lodging_Arrival_Date__c,Lodging_Category__c,Lodging_Departure_Date__c,
               Lodging_Description__c,Lodging_Type__c,NOFA1__c,NOFA__c,Number_of_Unduplicated_Volunteers__c,Number_of_Volunteers__c,Other_Capacity_Building__c,
               Other_Disaster_Services__c,Disaster_Services__c,Other_Economic_Opportunities__c,Other_Education__c,Other_Environmental_Stewardship__c,Other_Healthy_Futures__c,
               Other_Veterans_Military_Families__c,Projected_End_Date__c,Projected_Start_Date__c,Refrigerator_Microwave__c,Shower__c,Site_Type__c,State__c,
               Station_Type__c,Street_Address_1__c,Street_Address_2__c,Summer_Associates__c,Supervisor_Email__c,Supervisor_Name__c,Supervisor_Organization__c,
               Supervisor_Phone_Number__c,Supervisor_Phone_Number_Extension__c,Undisclosed_Location__c,Veterans_Military_Families__c,Veterans_Served__c,
               Zip__c  from Location__c where id=:Locationid];                    
            if(locationInput!=null){
                system.debug('got here '+id);
                id = locationInput.Application__c;
                system.debug('got here 2 '+id);
            }   
      
            If(id!=null && id!='')
                Application=[Select Id,Name,NOFA_RFP__c,NOFA_RFP__r.Volunteer_Information__c,Nofa_RFP__r.School_Information__c,NOFA_RFP__r.Focus_Area_and_Objectives_Location__c,Nofa_RFP__r.Standard_Information__c,
                NOFA_RFP__r.EIN_Information__c,Nofa_RFP__r.Site_Date_Information__c,NOFA_RFP__r.Site_Type__c,Nofa_RFP__r.Site_Type_and_Summer_Associates__c,NOFA_RFP__r.Additional_Operating_Site_Information__c,
                Nofa_RFP__r.Lodging_Information__c,Application_Signed__c,Authorized_Representative__c,Certifications_Clicked__c,Assurances_Clicked__c from Application3__c where id=:id]; 
            system.debug('#####locatiobeforesave###'+id);
    
      
    
    }
       
    public void locationrendering()
    {
        if(Application.NOFA_RFP__r.Volunteer_Information__c && locationInput.Location_Type__c == 'Service Location')
        {
            loc1 = true;
        }
        else
        {
            loc1 = false;
        }
    }
    
    public PageReference PageRedirect(){
        //displayPopup = true;
        //GetAddresses();
        if(locationInput.Is_this_a_K_12_school__c == 'No' || locationInput.Location_Type__c != 'Service Location'){
            displayPopup = true;
            invokeAddressDoctor();
            return null;
            }
            else{
                scontroller.save();
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
         objAddressRequest.locality= new List<String>{locationInput.City__c};
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
                    scontroller.save();
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
       
       
    public PageReference Save(){   
        PageReference Redirect;   
        try
        {
            if(Validate()){
        
                If(Locationid!=null )
                {
                    if(Application.Application_Signed__c){
                        Application.Application_Signed__c = false;
                        Application.Authorized_Representative__c = null;
                        Application.Certifications_Clicked__c = false;
                        Application.Assurances_Clicked__c = false;
                    }                
                    update Application; 
                    update locationInput;
         
                    Redirect = new PageReference('/apex/LocationDetailPage?id='+Locationid);
                    system.debug('#####locationInput###'+locationInput);
    
                    //  Redirect.setRedirect(true);
         
                    return Redirect;
                }
            }
        }catch(System.DMLException e) {
            ApexPages.addMessages(e);
            return null;
        }
        return null;
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
            scontroller.save();
            PageReference Redirect = new PageReference('/apex/LocationDetailPage?id='+locationInput.id);
            return Redirect;
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
        if((locationInput.Application__r.NOFA_RFP__r.Site_Date_Information__c == true ) && ((locationInput.Location_Type__c == 'Member Lodging') || (locationInput.Location_Type__c == 'Inclement Weather Site') || (locationInput.Location_Type__c == 'Service Location')) && ((locationInput.Projected_Start_Date__c == null)))
        {
             locationInput.Projected_Start_Date__c.addError('Enter Projected Start Date');
              return false;
        } 
        if((locationInput.Application__r.NOFA_RFP__r.Site_Date_Information__c == true ) && ((locationInput.Location_Type__c == 'Member Lodging') || (locationInput.Location_Type__c == 'Inclement Weather Site') || (locationInput.Location_Type__c == 'Service Location')) && (locationInput.Projected_End_Date__c == null))
        {
             locationInput.Projected_End_Date__c.addError('Enter Projected End Date'); 
             return false;
        }
        if((locationInput.Application__r.NOFA_RFP__r.Site_Type_and_Summer_Associates__c == true ) && ((locationInput.Location_Type__c == 'Service Location')) && (locationInput.Site_Type__c == null))
        {
             locationInput.Site_Type__c.addError('Enter Site type');
              return false;
        } 
        if((locationInput.Application__r.NOFA_RFP__r.Lodging_Information__c == true ) && ((locationInput.Location_Type__c == 'Member Lodging')) && (locationInput.Lodging_Type__c == null))
        {
             locationInput.Lodging_Type__c.addError('Enter Lodging type');
              return false;
        }
        if((locationInput.Application__r.NOFA_RFP__r.Lodging_Information__c == true ) && ((locationInput.Location_Type__c == 'Member Lodging')) && (locationInput.Lodging_Category__c == null))
        {
             locationInput.Lodging_Category__c.addError('Enter Lodging Category');
              return false;
        }
        if((locationInput.Application__r.NOFA_RFP__r.Lodging_Information__c == true ) && ((locationInput.Location_Type__c == 'Member Lodging')) && (locationInput.Lodging_Description__c == null))
        {
             locationInput.Lodging_Description__c.addError('Enter Lodging Description');
              return false;
        }
        if((locationInput.Application__r.NOFA_RFP__r.Lodging_Information__c == true ) && ((locationInput.Location_Type__c == 'Member Lodging')) && (locationInput.Distance_to_Location_of_Service__c == null))
        {
             locationInput.Distance_to_Location_of_Service__c.addError('Enter Distance to location of service');
             return false;
        
        }
        if((locationInput.Application__r.NOFA_RFP__r.Lodging_Information__c == true ) && ((locationInput.Location_Type__c == 'Member Lodging')) && (locationInput.Lodging_Departure_Date__c == null))
        {
             locationInput.Lodging_Departure_Date__c.addError('Enter Lodging Departure Date');
             return false;
        
        }
        if((locationInput.Application__r.NOFA_RFP__r.Lodging_Information__c == true ) && ((locationInput.Location_Type__c == 'Member Lodging')) && (locationInput.Lodging_Arrival_Date__c == null))
        {
             locationInput.Lodging_Arrival_Date__c.addError('Enter Lodging Arrival Date');
             return false;
        
        }
        if((locationInput.Application__r.NOFA_RFP__r.Site_Type__c == true ) && ((locationInput.Location_Type__c == 'Service Location')) && (locationInput.Station_Type__c == null))
        {
             locationInput.Station_Type__c.addError('Enter Station Type');
             return false;
        }
        return true;
    }
    
}