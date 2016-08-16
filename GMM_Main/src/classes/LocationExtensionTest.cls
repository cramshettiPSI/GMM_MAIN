@istest
public class LocationExtensionTest{
    private Static testmethod void LocationExtensionTest(){    
        Location__c objLocation = new Location__c();
         Pagereference pref = Page.LocationCreationPage;
        test.setCurrentPage(pref);
         Location__c testLoc = UtilityClass.createLocation();
      Insert testLoc;       
               
          /*Application3__c testapp = UtilityClass.createApplication();
             Insert testapp; */ 
                
        ApexPages.currentPage().getParameters().put('applicationid',testLoc.Application__c);
        ApexPages.StandardController Loc = new ApexPages.StandardController(objLocation);
        LocationExtension objLocationExtension  = new LocationExtension(Loc);
        
        objLocationExtension.Save1();
        objLocationExtension.saveandnew();
    }
   static testMethod void CommunitiesSelfRegController1Test() {

   
          
         LocationExtension objLocationExtension  = new LocationExtension(null);
        Location__c Loc1= new Location__c();
        Loc1.Street_Address_1__c='landover st';
        Loc1.Street_Address_2__c='landover s';
        Loc1.Zip__c='22305';
        Loc1.State__c='va';
        objLocationExtension.locationInput= Loc1;
        objLocationExtension.address='landover st, alexandria,va,22305';
        
       // Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        Test.setMock(WebServiceMock.class, new AddressDoctorWebServiceMock());
        objLocationExtension.GetAddresses();
       
       
        objLocationExtension.Submit();
         
     
     
    }
    static testMethod void CommunitiesSelfRegController1Test1() {

   
          
         LocationExtension objLocationExtension  = new LocationExtension(null);
        Location__c Loc1= new Location__c();
        Loc1.Street_Address_1__c='landover st';
        Loc1.Street_Address_2__c='landover s';
        Loc1.Zip__c='22305';
        Loc1.State__c='va';
        objLocationExtension.locationInput= Loc1;
        objLocationExtension.address='landover st, alexandria,va,22305';
        
  
        
        objLocationExtension.closePopup();
       
    }
}