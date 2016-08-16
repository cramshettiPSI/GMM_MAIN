public with sharing class projectaddrresdocotrext {

    public string USERNAME='160781 ';
    public string PASSWORD='Strike1';
    public Project__c pro {get; set;}
    public List<AddressdoctorComWebservice5.Address> responseAddresses{get;set;}
    public projectaddrresdocotrext(ApexPages.StandardController controller) {

       pro=(Project__c)controller.getRecord();
       responseAddresses=new List<AddressdoctorComWebservice5.Address>();
       doCallout();

    }
    
    public PageReference doCallout()
    {
           
            AddressdoctorComWebservice5.ArrayOfString Street=new AddressdoctorComWebservice5.ArrayOfString();
            Street.string_x=new string[]{pro.Street_Address_1__c};
            AddressdoctorComWebservice5.ArrayOfString PostalCode=new AddressdoctorComWebservice5.ArrayOfString();
            PostalCode.string_x=new string[]{string.valueof(pro.Zip__c)};
             AddressdoctorComWebservice5.ArrayOfString Province=new AddressdoctorComWebservice5.ArrayOfString();
            Province.string_x=new string[]{pro.State__c};
            AddressdoctorComWebservice5.ArrayOfString Country=new AddressdoctorComWebservice5.ArrayOfString();
            Country.string_x=new string[]{pro.country__c};
            
            AddressdoctorComWebservice5.AddressValidationSoap    doctorCall=new AddressdoctorComWebservice5.AddressValidationSoap();
            
            
            AddressdoctorComWebservice5.Parameters parameters=new AddressdoctorComWebservice5.Parameters();
            parameters.ProcessMode='BATCH';
            AddressdoctorComWebservice5.Address[] Add_resses=new AddressdoctorComWebservice5.Address[1];
            AddressdoctorComWebservice5.Address Addres=new AddressdoctorComWebservice5.Address();
            Addres.Street=Street;
            Addres.PostalCode=PostalCode;
            Addres.Province=Province;
            Addres.Country=Country;
              
                
            Add_resses[0]=Addres;
            
            AddressdoctorComWebservice5.ArrayOfAddress  arrayofAddress=new AddressdoctorComWebservice5.ArrayOfAddress ();
            arrayofAddress.Address=Add_resses;
            
            AddressdoctorComWebservice5.ArrayOfAddress addresses=arrayofAddress;
             
            AddressdoctorComWebservice5.ArrayOfEnrichment enrichments;
            
            AddressdoctorComWebservice5.Response response=new AddressdoctorComWebservice5.Response();
            response=doctorCall.Process(USERNAME,PASSWORD,parameters,addresses,enrichments);
            
            system.debug('response=================>'+response.statusCode);
            
            AddressdoctorComWebservice5.Result[]  results=response.Results.Result;
            for(AddressdoctorComWebservice5.Result result:response.Results.Result)
            {
                for(AddressdoctorComWebservice5.ResultData  resultAd:result.ResultDataSet.ResultData)
                {
                
                    system.debug('result is===='+result);
                    AddressdoctorComWebservice5.Address Address=resultAd.Address;
                    responseAddresses.add(resultAd.Address);
                    system.debug('=@@@='+address.street.string_x);
                    system.debug('=@@@='+address.province.string_x);
                    //system.debug('=@@@='+address.Locality.string_x);
                    system.debug('=@@@='+address.PostalCode.string_x);
                   system.debug('=@@@='+address.Country.string_x);
                    //+'===='+address.Street.string_x+'===='+address.Country.string_x+'====='+address.Province.string_x+'====='+address.DeliveryAddressLines.string_x);
                }
            }
            
            return null;
    
    
    
    }

}