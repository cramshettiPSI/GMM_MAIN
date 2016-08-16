@isTest
public class RedirectionControllertest {
 
 static testmethod void testcontrollertest(){
        
  List<Contact> Contactslist = new List<Contact>{};
        Schema.DescribeSObjectResult cfrSchema = Schema.SObjectType.Contact; 
  Map<String,Schema.RecordTypeInfo> ContactRecordTypeInfo = cfrSchema.getRecordTypeInfosByName(); 
  Id rtId = ContactRecordTypeInfo.get('Expert Reviewer').getRecordTypeId();
  contact con = new contact();
  con.lastname ='test';
  con.firstname ='First';
  con.email = 'abctest@gmail.com';
  //con.phone = 98995822552;
    con.recordtypeid= rtId;
  
  contact con1 = new contact();
  con1.lastname ='test';
  con1.firstname ='First';
  con1.email = 'abctest1@gmail.com';
  //con1.phone = 98995822552;
  
  Contactslist.add(con);
  Contactslist.add(con1);
        Insert Contactslist;
        ApexPages.StandardController sc = new ApexPages.StandardController(con);
        
        RedirectionController testconPlan = new RedirectionController(sc);
        RedirectionController conPlan = new RedirectionController();
        PageReference pageRef = Page.RedirectionPage;
        string id = con.id;
        //test.setCurrentpage(pageRef);
       // pageRef.getParameters().put('id', String.valueOf(testconPlan.Id));
        //ApexPages.currentPage().getParameters().put(id, testconPlan.Id);  
        //Test.setCurrentPage(pageRef);
    
        ApexPages.StandardController sc1 = new ApexPages.StandardController(con1);
        RedirectionController testconPlan1 = new RedirectionController(sc1);
        
        testconPlan.RedirectPage();
         testconPlan1.RedirectPage();

      }
}