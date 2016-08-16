public class CNCS_WebServiceGateWay{

      String uName;
      String uPassword;
      String strWebserviceToAddressDoctor='ADDRESSDOCTOR';
      
      public class MyException extends Exception {}

      public CNCS_WebServiceGateWay(){
             
      }
      
      public CNCS_WebServiceGateWay(String strWSConnectionName){
         try{
              if(strWSConnectionName.equalsIgnoreCase(strWebserviceToAddressDoctor)){
                 CNCS_Credentials__c objCNCSCredentials = CNCS_Credentials__c.getInstance(strWebserviceToAddressDoctor);
                 this.uName = objCNCSCredentials.userName__c;
                 this.uPassword=objCNCSCredentials.passWord__c;
              }
         }
         catch(CNCS_ObjectUtility.CustomException custExc) {
              System.debug('Custom Exception '+ custExc);
              ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,custExc.getMessage()));
         }
         catch(Exception exc){
            System.debug('***exc***'+exc.getMessage());
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,exc.getMessage()));
         }     
          
      }
      
      public AddressDoctorWSStub.Response connectToAddressDoctor(AddressRequest objAddressRequest){
          AddressDoctorWSStub.Response objResponse;
      try{
      
           if (Limits.getCallouts() == Limits.getLimitCallouts()){
             throw new MyException('[HTTP-00] Callout limit: ' + Limits.getCallouts() + ' reached. No more callouts permitted.');
           }
           AddressDoctorWSStub objAddressDoctorWSStub =new AddressDoctorWSStub();
           AddressDoctorWSStub.AddressValidationSoap objAddressValidationSoap = new AddressDoctorWSStub.AddressValidationSoap();
           AddressDoctorWSStub.Parameters objParameters = new AddressDoctorWSStub.Parameters();
           objParameters.ProcessMode='INTERACTIVE';
           
           //setting validation Parameters 
           AddressDoctorWSStub.ValidationParameters objValidationParameters  = new AddressDoctorWSStub.ValidationParameters();
           objValidationParameters.PreferredLanguage = 'ENGLISH';
           objValidationParameters.FormatDelimiter = 'COMMA';
           objValidationParameters.MatchingAlternatives = 'ALL';
           objValidationParameters.GlobalPreferredDescriptor='LONG';
           objValidationParameters.GeoCodingType='NONE';
           objValidationParameters.StreetWithNumber=true;
           objValidationParameters.FormatWithCountry=true;
           objValidationParameters.ElementAbbreviation=true;
           objValidationParameters.StandardizeInvalidAddresses=true;
           objValidationParameters.FlexibleRangeExpansion=true;
           objValidationParameters.MatchingExtendedArchive=true;
           objValidationParameters.GlobalMaxLength=1000;
           objValidationParameters.MaxResultCount=10;
           objValidationParameters.FormatMaxLines=18;
           objValidationParameters.StandardizeInvalidAddresses=true;
           objParameters.ValidationParameters=objValidationParameters;
           
           AddressDoctorWSStub.ArrayOfAddress objArrOfAddresses = new AddressDoctorWSStub.ArrayOfAddress();
           AddressDoctorWSStub.Address objAddr = new AddressDoctorWSStub.Address();
           objArrOfAddresses.Address = new List<AddressDoctorWSStub.Address>();
           AddressDoctorWSStub.ArrayOfString  arrayHouseNumber = new AddressDoctorWSStub.ArrayOfString();
           arrayHouseNumber.string_x=objAddressRequest.houseNumber;
           objAddr.HouseNumber=arrayHouseNumber;
           
           AddressDoctorWSStub.ArrayOfString  arrayStreet = new AddressDoctorWSStub.ArrayOfString();
           arrayStreet.string_x=objAddressRequest.street;
           objAddr.Street=arrayStreet;
           
           AddressDoctorWSStub.ArrayOfString  arrayLocality = new AddressDoctorWSStub.ArrayOfString();
           arrayLocality.string_x=objAddressRequest.locality;
           objAddr.Locality=arrayLocality;
           
           AddressDoctorWSStub.ArrayOfString  arrayProvince = new AddressDoctorWSStub.ArrayOfString();
           arrayProvince.string_x=objAddressRequest.province;
           objAddr.Province=arrayProvince;
           
           AddressDoctorWSStub.ArrayOfString  arrayZip = new AddressDoctorWSStub.ArrayOfString();
           arrayZip.string_x=objAddressRequest.postalCode;
           objAddr.PostalCode=arrayZip;
           
           AddressDoctorWSStub.ArrayOfString  arrayCountry = new AddressDoctorWSStub.ArrayOfString();
           arrayCountry.string_x=objAddressRequest.country;
           objAddr.Country=arrayCountry ;
           
           objArrOfAddresses.Address.add(objAddr);
           
           AddressDoctorWSStub.ArrayOfEnrichment objArrayOfEnrichment = new AddressDoctorWSStub.ArrayOfEnrichment();
           AddressDoctorWSStub.Enrichment objEnrichment  = new AddressDoctorWSStub.Enrichment();
           objEnrichment.Type_x = 'GEOCODING';
           objEnrichment.PayloadXml='1';
           System.debug('alpha');
            
           AddressDoctorWSStub.ServiceParameters objServiceParameters = new AddressDoctorWSStub.ServiceParameters();
           System.debug('beta');
           
           objParameters.ServiceParameters = objServiceParameters ;
           System.debug('gama');
           
           objResponse = objAddressValidationSoap.Process(uName,uPassword,objParameters ,objArrOfAddresses ,objArrayOfEnrichment );
           System.debug('objResponse ..............%%%%%%%%%' +objResponse );  
        }
        catch(System.CalloutException e) {
                    System.debug('Callout error: '+ e);
                    
        }
        catch(CNCS_ObjectUtility.CustomException custExc) {
                  System.debug('Custom Exception '+ custExc);
                  ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,custExc.getMessage()));
        }
        catch(MyException myExc){
                System.debug('***myExc***'+myExc);
        }
        catch(Exception exc){
                System.debug('***exc***'+exc );
        }
        return objResponse ;
      
      }
      


}