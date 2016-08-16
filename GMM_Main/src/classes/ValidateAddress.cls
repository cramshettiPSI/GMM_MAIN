Public class ValidateAddress{

String Address;
Public String AddressSelected{get;set;}
Public List<SelectOption> options{get;set;}
Public Project__c pro{get;set;}
Public List<AddressData> AddressDataList {get{return AddressDataList;}set;}

Public ValidateAddress(ApexPages.StandardController stdController){
      Project__c proj = (Project__c)stdController.getRecord();
      AddressDataList = new List<AddressData>();
      String strURL=System.URL.getSalesforceBaseUrl().toExternalForm();
      System.debug('Prashant@@@@@@@%%%%^^^^^^'+strURL);
      GetAddresses(proj.id);
}




Private Void GetAddresses(String a)
{


     /*
             Calling webservice method        
             */   
            

 pro=[Select name,Response_Address_Doctor__c,Street_Address_1__c,Street_Address_2__c, State__c,Zip__c,Country__c from Project__c where id=:a limit 1];
System.debug('######Project ID'+pro.id);
AddressdoctorComWebservice5 tes = new AddressdoctorComWebservice5();
AddressdoctorComWebservice5.AddressValidationSoap testsoap = new AddressdoctorComWebservice5.AddressValidationSoap();
AddressdoctorComWebservice5.Parameters parameters = new AddressdoctorComWebservice5.Parameters();
parameters.ProcessMode='INTERACTIVE';
AddressdoctorComWebservice5.ArrayOfAddress addresses = new AddressdoctorComWebservice5.ArrayOfAddress();
AddressdoctorComWebservice5.Address address1 = new AddressdoctorComWebservice5.Address();
addresses.address = new List<AddressdoctorComWebservice5.Address>();
AddressdoctorComWebservice5.ArrayOfString testArray = new AddressdoctorComWebservice5.ArrayOfString();
testArray.string_x = new List<String>{'ABC'};
//address1.Organization = testArray;
address1.RecordId= a;

AddressdoctorComWebservice5.ArrayOfString  testArray1 = new AddressdoctorComWebservice5.ArrayOfString();

//testArray1.string_x = new List<String>{'Test@gmail.com'};
//address1.Email = testArray1; 

AddressdoctorComWebservice5.ArrayOfString  testArray2 = new AddressdoctorComWebservice5.ArrayOfString();
testArray2.string_x=new List<String>{pro.State__c};
address1.Province= testArray2; 

AddressdoctorComWebservice5.ArrayOfString  testArray3 = new AddressdoctorComWebservice5.ArrayOfString();
testArray3.string_x=new List<String>{'United States'};
address1.Country= testArray3; 

AddressdoctorComWebservice5.ArrayOfString  testArray4 = new AddressdoctorComWebservice5.ArrayOfString();
testArray4.string_x=new List<String>{pro.Street_Address_1__c};
address1.HouseNumber= testArray4; 

AddressdoctorComWebservice5.ArrayOfString  testArray5 = new AddressdoctorComWebservice5.ArrayOfString();
testArray5.string_x=new List<String>{pro.Street_Address_2__c};
address1.Street= testArray5; 

AddressdoctorComWebservice5.ArrayOfString  testArray6 = new AddressdoctorComWebservice5.ArrayOfString();
testArray6.string_x=new List<String>{pro.Zip__c};
address1.PostalCode= testArray6;

addresses.Address.add(address1);
//System.debug('ValidateAddress'+address1.Organization+'@@@@@'+address1.Country+'%%%%'+address1.PostalCode);
AddressdoctorComWebservice5.ArrayOfEnrichment enrichments = new AddressdoctorComWebservice5.ArrayOfEnrichment();
AddressdoctorComWebservice5.ServiceParameters ServiceParam = new AddressdoctorComWebservice5.ServiceParameters();
//ServiceParam.JobToken='b89be474-318c-4da3-87c2-f15b2e43c2cb';
parameters.ServiceParameters = ServiceParam;

AddressdoctorComWebservice5.Response res = testsoap.Process('160968','oGm5%8kK',parameters,addresses,enrichments);
System.debug('Prashant$$$$$$$^^^^^'+res.statuscode+'$$$$'+res.StatusMessage);
AddressdoctorComWebservice5.ResultData[] ResData=res.results.result[0].ResultDataSet.ResultData; // Added

System.debug('#######ResultSet'+res.results.result.size());
System.debug('#######ArrayOfResultSet'+res.results.result[0].ResultDataSet.ResultData.size()+'@@@@@@'+ResData.size());
System.debug('#######ArrayOfResultSet_ResultNumber'+res.results.result[0].ResultDataSet.ResultData[0].ResultNumber);
options = new List<SelectOption>();
For(AddressdoctorComWebservice5.ResultData rd : ResData)
{
//System.debug('#######ArrayOfResultSet_ResultNumber_iterate'+rd.address.Organization.string_x+'@@'+rd.address.Department.string_x+'@@'+rd.address.Contact.string_x+'@@'+rd.address.Building.string_x+'@@'+rd.address.SubBuilding.string_x+'@@'+rd.address.Street.string_x+'@@'+rd.address.HouseNumber.string_x+'@@'+rd.address.DeliveryService.string_x+'@@'+rd.address.Locality.string_x+'@@'+rd.address.AddressComplete);
//System.debug('#######ArrayOfResultSet_ResultNumber_iterate_Fields'+rd.address.PreferredLocality.string_x+'@@'+rd.address.PostalCode.string_x+'@@'+rd.address.Province.string_x+'@@'+rd.address.Country.string_x+'@@'+rd.address.Residue.string_x+'@@'+rd.address.RecipientLines.string_x+'@@'+rd.address.DeliveryAddressLines.string_x+'@@'+rd.address.CountrySpecificLocalityLine.string_x+'@@'+rd.address.FormattedAddress.string_x);
System.debug('#######ArrayOfResultSet_ResultNumber_iterate'+rd.address.FormattedAddress.string_x);
AddressData ad = new AddressData();
ad.Vaddress=rd.address.AddressComplete;
AddressDataList.add(ad);
options.add(new SelectOption(ad.Vaddress,ad.Vaddress)); 

}

System.debug('****%%%%%%%%'+res);
System.debug('Prashant$$$$$$$'+res.statuscode+'$$$$'+res.StatusMessage+'^^^^^^^'+res.JobToken);
pro.Response_Address_Doctor__c=res.StatusMessage;
 
//Update acc;
}

public PageReference Submit() {
//PageReference p = new PageReference('javascript&colon;window.opener.history.go(0);self.close();');
//p.setRedirect(true);

If(Address!=null){
List<String> strlist=Address.split(';');
If(strlist.size()>0){
pro.Street_Address_1__c=strlist[0];
Update pro;
}
}
else{

ApexPages.Message msg = new Apexpages.Message(ApexPages.Severity.Warning,'Please select one option to update' );
ApexPages.addmessage(msg);
}

        return null;
    }

Public String getAddress(){
return Address;
}

Public void setAddress(String Address){
this.Address=Address;
}

public with sharing class AddressData{

Public String Vaddress{get;set;}
}

//public void setAddressSelected(String AddressSelected) { this.AddressSelected= AddressSelected; }

}