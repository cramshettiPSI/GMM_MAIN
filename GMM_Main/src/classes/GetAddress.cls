public class GetAddress
{
    
    Public List<SelectOption> options{get;set;}
    Public Map<String,AddressdoctorComWebservice5.ResultData> MapOfAddress;
    public boolean displayPopup {get; set;} 
    Public String Address{get;set;}
    list<project__c> project;
    String type;
    Public String StreetAddress1{get;set;}
    Public String StreetAddress2{get;set;}
    Public String State{get;set;}
    Public String City{get;set;}
    Public String Zip{get;set;}
    Public GetAddress()
    {

    type=Apexpages.currentPage().getParameters().get('ID');
    MapOfAddress=new Map<String,AddressdoctorComWebservice5.ResultData>();
        project = [SELECT Street_Address_1__c, Street_Address_2__c, City__c, State__c, Zip__c FROM project__c WHERE id=:type];
        if(project != NULL && project.size()>0)
        {
         StreetAddress1=project[0].Street_Address_1__c;
         StreetAddress2=project[0].Street_Address_2__c;
          State=project[0].State__c;
     City=project[0].City__c;
     Zip=project[0].Zip__c ;
        }
        
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
        testArray2.string_x=new List<String>{State};
            address1.Province= testArray2; 
        
      //  AddressdoctorComWebservice5.ArrayOfString  testArray10 = new AddressdoctorComWebservice5.ArrayOfString();
      //  testArray10.string_x=new List<String>{City};
       //     address1.City= testArray10; 
        
        AddressdoctorComWebservice5.ArrayOfString  testArray3 = new AddressdoctorComWebservice5.ArrayOfString();
        testArray3.string_x=new List<String>{'United States'};
            address1.Country= testArray3; 
        
        AddressdoctorComWebservice5.ArrayOfString  testArray4 = new AddressdoctorComWebservice5.ArrayOfString();
        testArray4.string_x=new List<String>{StreetAddress1};
            //testArray4.string_x=new List<String>{'Landover Street'};
            address1.HouseNumber= testArray4; 
        
        AddressdoctorComWebservice5.ArrayOfString  testArray5 = new AddressdoctorComWebservice5.ArrayOfString();
        testArray5.string_x=new List<String>{StreetAddress2};
            address1.Street= testArray5; 
        
        AddressdoctorComWebservice5.ArrayOfString  testArray6 = new AddressdoctorComWebservice5.ArrayOfString();
        testArray6.string_x=new List<String>{Zip};
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
         //   System.debug('#######ArrayOfResultSet_ResultNumber_iterate'+rd.address.FormattedAddress.string_x);
         //   System.debug('Testing'+rd.address.Province.string_x[0]);
          //  System.debug('Testing5'+rd.address.Locality.string_x[0]);
            options.add(new SelectOption(rd.address.AddressComplete,rd.address.AddressComplete)); 
            MapOfAddress.put(rd.address.AddressComplete,rd);
        }
        
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
               //     locationInput.longitude__c= Longitude;
                //    locationInput.latitude__c= LATITUDE;
                }
                
                String Postalcode=MapOfAddress.get(Address).address.PostalCode.string_x[0];
                List<String> strlist=Address.split(';');
                system.debug('Address$'+ strlist);
                If(strlist.size()>0){
                    displayPopup = false;
                    
                   
                        project[0].Street_Address_1__c=strlist[0];
                        project[0].State__c=MapOfAddress.get(Address).address.Province.string_x[0];
                        project[0].City__c=MapOfAddress.get(Address).address.Locality.string_x[0];
                        project[0].Zip__c=PostalCode;
                        update project[0];
                        PR = new PageReference('/' + type);
                        //PR.setredirect(true);
                        return PR;
                    
                }
            }
            else{
                ApexPages.Message msg = new Apexpages.Message(ApexPages.Severity.Warning,'Please select one option to update' );
                ApexPages.addmessage(msg);
            }
            return null;//added
        }
        
        catch(Exception e){
            System.debug('Exception Message'+e.getMessage());
        }
        displayPopup = false;
        return PR;
    }

public pagereference Cancel()
{
PageReference PR = new PageReference('/' + type);
                       
 return PR;
}

}