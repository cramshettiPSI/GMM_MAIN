@isTest
public class AddReviewerPoolConttest {
 
 static testmethod void testcontrollertest(){
        
  List<Contact> Contactslist = new List<Contact>{};
        Schema.DescribeSObjectResult cfrSchema = Schema.SObjectType.Contact; 
  Map<String,Schema.RecordTypeInfo> ContactRecordTypeInfo = cfrSchema.getRecordTypeInfosByName(); 
  Id rtId = ContactRecordTypeInfo.get('Expert Reviewer').getRecordTypeId();
  contact con = new contact();
  con.lastname ='test';
  con.firstname ='First';
  con.email = 'abctest@gmail.com';
  
  con.Area_of_Expertise__c = 'Education';
  con.Expertise__c = 'Computer literacy';
  con.Years_of_Experience__c = 5;
  con.Highest__c = 'Some College';
  con.Performance_Rating__c = 5;
  con.State_of_Residence__c = 'AA';
  con.Status__c ='Accepted';

    con.recordtypeid= rtId;
  
  
  contact con1 = new contact();
  con1.lastname ='test';
  con1.firstname ='First';
  con1.email = 'abctest@gmail.com';
  
  con1.Area_of_Expertise__c = 'Education';
  con1.Expertise__c = 'Computer literacy';
  con1.Years_of_Experience__c = 5;
  con1.Highest__c = 'some college';
  con1.Performance_Rating__c = 0;
  con1.State_of_Residence__c = 'AA';
  con1.Status__c ='Accepted';

    con1.recordtypeid= rtId;
  
    Contactslist.add(con);
    Contactslist.add(con1);
  
        Insert Contactslist;
        AddReviewerPoolCont arpc = new AddReviewerPoolCont();
        arpc.con = con;
        NOFA_Group__c na = new NOFA_Group__c();
        na.Review_Type__c = 'Staff';
        
        insert na;
       
        Reviewer_Pool__c Rp = new Reviewer_Pool__c();
        Rp.NOFA_Group__c  = na.id;
        Rp.Expert_Reviewer_Name__c =con.id;
        Rp.status__C='Available';
        insert Rp;
        
        AddReviewerPoolCont.contactWrapper wrap = new AddReviewerPoolCont.contactWrapper(con);
        wrap.isSelected = true;
        arpc.selectedStates = 'A,b,c';
        
        arpc.personid ='abc12345';
        arpc.selectedareaofExpertise ='a,b,c,d';
        arpc.selectedexpertise ='a,b,c,d';
        arpc.runSearch();
        arpc.getcontacts();
        arpc.savePanelMembers();
        arpc.cancel();  
        list<SelectOption> teststates = arpc.stateslist;
        list<SelectOption> testexpts  = arpc.expertiselist;
        list<SelectOption> testares  = arpc.areaofexpertiselist; 
   }
}