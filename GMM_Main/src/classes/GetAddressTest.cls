@isTest
public class GetAddressTest {
static testMethod void CommunitiesSelfRegController1Test() {

         Test.setMock(WebServiceMock.class, new AddressDoctorWebServiceMock());
         GetAddress objLocationExtension  = new GetAddress();
        
        objLocationExtension.StreetAddress1='landover st';
        objLocationExtension.StreetAddress2='landover s';
        objLocationExtension.Zip='22305';
        objLocationExtension.City='alexiandria';
        objLocationExtension.State='va';
        objLocationExtension.address='landover st, alexandria,va,22305';
        
       // Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
       
       
       
       
        objLocationExtension.Submit();
         
     
     
    }
}