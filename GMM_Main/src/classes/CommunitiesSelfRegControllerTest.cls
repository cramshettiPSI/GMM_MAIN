/**
 * An apex page controller that supports self registration of users in communities that allow self registration
 */
@isTest(seealldata=true)
 private class CommunitiesSelfRegControllerTest {
    
    static testMethod void CommunitiesSelfRegControllerTest() {
        
        Pagereference pref = Page.CommunitiesCustomSelfRegPage;
        test.setCurrentPage(pref);
        
        CommunitiesSelfRegController controller = new CommunitiesSelfRegController();
        //ApexPages.currentPage().getParameters().put('')
        controller.firstName = 'FirstName';
        controller.lastName = 'LastName';
        controller.email = 'test@force.com';
        controller.communityNickname = 'test';        
        // registerUser will always return null when the page isn't accessed as a guest user    
        controller.registerUser();
              
        controller.password = 'abcd1234';
        controller.confirmPassword = 'abcd123';
        
        controller.registerUser(); 
        controller.Cancel();
         
    }    
    
    static testMethod void CommunitiesSelfRegController1Test() {
        Pagereference pref = Page.CommunitiesCustomSelfRegPage1;
        test.setCurrentPage(pref);
        
        CommunitiesSelfRegController1 controller = new CommunitiesSelfRegController1();
        //ApexPages.currentPage().getParameters().put('')
        controller.contact.firstName = 'FirstName';
        controller.contact.lastName = 'LastName';
        controller.contact.email = 'test@force.com';
        controller.contact.Re_Enter_Email__c = 'test@force.com';   
        controller.contact.Mailing_Street_Address_2__c = '1212 New York Ave. ';
        controller.contact.Mailing_City__c = 'DC';
        controller.contact.Mailing_State__c = 'DC';
        controller.contact.Mailing_Zip_Code__c = '20170';                  
        controller.contact.Re_Enter_Password__c = 'abcd1234';
        controller.contact.New_Password__c = 'abcd1234';
        controller.Address = 'landover st, alexandria,va,22305';    
        controller.contact.Primary_Phone__c= '6346466664'; 
        //controller.Submit();
        controller.registerUser();
        //controller.PageRedirect();
        
           
        
       // Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        Test.setMock(WebServiceMock.class, new AddressDoctorWebServiceMock());
        controller.GetAddresses();
       
       
        controller.Submit();
        controller.Cancel();   
        
       // controller.closePopup();
    }
        static testMethod void CommunitiesSelfRegController1Test1() {
        Pagereference pref = Page.CommunitiesCustomSelfRegPage1;
        test.setCurrentPage(pref);
        
        CommunitiesSelfRegController1 controller = new CommunitiesSelfRegController1();
        //ApexPages.currentPage().getParameters().put('')
        controller.contact.firstName = 'FirstName';
        controller.contact.lastName = 'LastName';
        controller.contact.email = 'test@force.com';
        controller.contact.Re_Enter_Email__c = 'test@force.com';   
        controller.contact.Mailing_Street_Address_2__c = '1212 New York Ave. ';
        controller.contact.Mailing_City__c = 'DC';
        controller.contact.Mailing_State__c = 'DC';
        controller.contact.Mailing_Zip_Code__c = '20170';                  
        controller.contact.Re_Enter_Password__c = 'abcd1234';
        controller.contact.New_Password__c = 'abcd1234';
        controller.Address = 'landover st, alexandria,va,22305';    
        controller.contact.Primary_Phone__c= '6346466664'; 

        
       // controller.closePopup();
    }
}