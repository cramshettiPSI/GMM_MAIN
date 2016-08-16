global class Project_WebseviceCallouts
  {
    public static boolean isFutureUpdateOnProject = false; 
      @future (callout=true)
      public static void ProjectCallOutFuture(String str){
       //     Project_WebseviceCallouts.doCallOutNowForProject(addr,test);
       Project_WebseviceCallouts.doCallOutNowForProject(str);
      }
       
   //   public static void doCallOutNowForProject(String address, String test)
   public static void doCallOutNowForProject(String a)
        { 
             /*
             Calling webservice method        
             */   
            

// public static void calldoctor(String address, String test)
Project__c pr=[Select name,Response_Address_Doctor__c from Project__c where id=:a limit 1];

AddressdoctorComWebservice5 tes = new AddressdoctorComWebservice5();
AddressdoctorComWebservice5.AddressValidationSoap testsoap = new AddressdoctorComWebservice5.AddressValidationSoap();
AddressdoctorComWebservice5.Parameters parameters = new AddressdoctorComWebservice5.Parameters();
parameters.ProcessMode='BATCH';
AddressdoctorComWebservice5.ArrayOfAddress addresses = new AddressdoctorComWebservice5.ArrayOfAddress();
AddressdoctorComWebservice5.Address address1 = new AddressdoctorComWebservice5.Address();
addresses.address = new List<AddressdoctorComWebservice5.Address>();
AddressdoctorComWebservice5.ArrayOfString testArray = new AddressdoctorComWebservice5.ArrayOfString();
testArray.string_x = new List<String>();
testArray.string_x.add('Test');
address1.Organization = testArray;
testArray.string_x.clear();
testArray.string_x.add('Test@gmail.com');
address1.Email = testArray;
testArray.string_x.clear();
testArray.string_x.add('Virgina');
address1.Province= testArray;
testArray.string_x.clear();
testArray.string_x.add('USA');
address1.Country= testArray;
testArray.string_x.clear();
testArray.string_x.add('45');
address1.HouseNumber= testArray;
testArray.string_x.clear();
testArray.string_x.add('3201');
address1.PostalCode= testArray;
addresses.Address.add(address1);
AddressdoctorComWebservice5.ArrayOfEnrichment enrichments = new AddressdoctorComWebservice5.ArrayOfEnrichment();
AddressdoctorComWebservice5.ServiceParameters ServiceParam = new AddressdoctorComWebservice5.ServiceParameters();
ServiceParam.JobToken='b89be474-318c-4da3-87c2-f15b2e43c2cb';
parameters.ServiceParameters = ServiceParam;
//AddressdoctorComWebservice5.Response res = testsoap.Process('160781','Strike1',parameters,addresses,enrichments);
AddressdoctorComWebservice5.Response res = testsoap.Process('160906','3y1sadgA',parameters,addresses,enrichments);
System.debug('****%%%%%%%%'+res);
System.debug('Prashant$$$$$$$'+res.statuscode+'$$$$'+res.StatusMessage+'^^^^^^^'+res.JobToken);
pr.Response_Address_Doctor__c=res.StatusMessage;
System.debug('Prshant$$$$$$$&&&&&&'+pr.id+'*******'+pr.Response_Address_Doctor__c);
 isFutureUpdateOnProject = true; 
Update pr;
}
             
             
             
             
             
        }