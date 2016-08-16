@isTest
private class ExpertReviewerTest {
    public static ContactCreateController8 ext;
    public static ExpertReviewEdit editext;
    public static accountRecordTypeSelection_Controller rtSelectExt; 
    public static ExpertReviewRedirect redirectExt;
    static testMethod void expertReviewDetailTest() {
        
        Pagereference pref = Page.ExpertReviewerDetail;
        test.setCurrentPage(pref);
        
        Account a = UtilityClass.createOrganization();
        insert a;
        
        Contact c = utilityClass.createContact();
        c.AccountId = a.Id;
        insert c;
        
        list<History__c> eduH = utilityClass.createEducationHistory();
        for(History__c h:eduH){
            h.User_Account__c = c.Id;
        }
        insert eduH;
        
        list<History__c> empH = UtilityClass.createEmploymenthistory();
        for(History__c eh:empH){
            eH.User_Account__c = c.Id;
        }
        insert empH;
        
        Apexpages.currentPage().getParameters().put('id',c.Id);
        
        ApexPages.StandardController controller = new ApexPages.StandardController(new Contact());
        ext = new ContactCreateController8(controller);
        ext.Acceptbtn();
        ext.editbtn();
        ext.rejectbtn();
        ext.SubmitBtn();
        ext.Applybtn();
        ext.pendingbtn();        
        
    }
    
    static testMethod void expertReviewEditTest() {
        Pagereference pref = Page.ExpertReviewEdit;
        test.setCurrentPage(pref);
        
        Account a = UtilityClass.createOrganization();
        insert a;
        
        Contact c = utilityClass.createContact();
        c.AccountId = a.Id;
        system.debug('conatct = '+c);
        insert c;        
        
        list<History__c> eduH = utilityClass.createEducationHistory();
        for(History__c h:eduH){
            h.User_Account__c = c.Id;
        }
        insert eduH;
        
        list<History__c> empH = UtilityClass.createEmploymenthistory();
        for(History__c eh:empH){
            eH.User_Account__c = c.Id;
        }
        insert empH;
        
        
        Apexpages.currentPage().getParameters().put('id',c.Id);
        
        ApexPages.StandardController controller = new ApexPages.StandardController(new Contact());
        editext = new ExpertReviewEdit(controller);        
        //editext.delEmpRow2();
        //editext.delRow2();
        editext.edubool = true;
        editext.empbool = true;
        editext.fileName = 'test attachment';
        editext.fileBody = Blob.valueOf('testing attachment');
        editext.save_upsert();
        editext.SaveAsDraft();
        editext.AddEmpRow2();
        editext.AddRow2();
        
        editext.edubool = false;
        editext.empbool = false;
        editext.fileName = 'test attachment';
        editext.fileBody = Blob.valueOf('testing attachment');
        editext.save_upsert();
        editext.SaveAsDraft();
        
        editext.con = new Contact();       
        editext.con.Salutation='Mr.';
        editext.save_upsert();
        
        editext.con = new Contact();
        editext.con.Salutation='Mr.';
        editext.con.FirstName = 'Test';             
        editext.save_upsert();
        
        editext.con = new Contact();
        editext.con.Salutation='Mr.';
        editext.con.FirstName = 'Test';
        editext.con.LastName = 'Contact';        
        editext.save_upsert();
        
        editext.con = new Contact();
        editext.con.Salutation='Mr.';
        editext.con.FirstName = 'Test';
        editext.con.LastName = 'Contact';
        editext.con.Primary_Phone__c = '3837373772';
        editext.save_upsert();        
        
        editext.con = new Contact();
        editext.con.Salutation='Mr.';
        editext.con.FirstName = 'Test';
        editext.con.LastName = 'Contact';
        editext.con.Primary_Phone__c = '3837373772';
        editext.con.Is_this_a_Mobile_Number__c = 'No';
        editext.save_upsert();         
        
        editext.con = new Contact();
        editext.con.Salutation='Mr.';
        editext.con.FirstName = 'Test';
        editext.con.LastName = 'Contact';
        editext.con.Primary_Phone__c = '3837373772';
        editext.con.Is_this_a_Mobile_Number__c = 'No';
        editext.con.Email = 'test@gmail.com';
        editext.save_upsert();
        
        editext.con = new Contact();
        editext.con.Salutation='Mr.';
        editext.con.FirstName = 'Test';
        editext.con.LastName = 'Contact';
        editext.con.Primary_Phone__c = '3837373772';
        editext.con.Is_this_a_Mobile_Number__c = 'No';
        editext.con.Email = 'test@gmail.com';
        editext.con.Re_Enter_Email__c = 'test@gmail.com';
        editext.save_upsert();
        
        editext.con = new Contact();
        editext.con.Salutation='Mr.';
        editext.con.FirstName = 'Test';
        editext.con.LastName = 'Contact';
        editext.con.Primary_Phone__c = '3837373772';
        editext.con.Is_this_a_Mobile_Number__c = 'No';
        editext.con.Email = 'test@gmail.com';
        editext.con.Re_Enter_Email__c = 'test@gmail.com';
        editext.con.Mailing_Street_Address_1__c = 'test street';
        editext.save_upsert();
        
        editext.con = new Contact();
        editext.con.Salutation='Mr.';
        editext.con.FirstName = 'Test';
        editext.con.LastName = 'Contact';
        editext.con.Primary_Phone__c = '3837373772';
        editext.con.Is_this_a_Mobile_Number__c = 'No';
        editext.con.Email = 'test@gmail.com';
        editext.con.Re_Enter_Email__c = 'test@gmail.com';
        editext.con.Mailing_Street_Address_1__c = 'test street';
        editext.con.Mailing_State__c = 'test state';
        editext.save_upsert();
        
        editext.con = new Contact();
        editext.con.Salutation='Mr.';
        editext.con.FirstName = 'Test';
        editext.con.LastName = 'Contact';
        editext.con.Primary_Phone__c = '3837373772';
        editext.con.Is_this_a_Mobile_Number__c = 'No';
        editext.con.Email = 'test@gmail.com';
        editext.con.Re_Enter_Email__c = 'test@gmail.com';
        editext.con.Mailing_Street_Address_1__c = 'test street';
        editext.con.Mailing_State__c = 'test state';
        editext.con.Mailing_City__c = 'test city';
        editext.save_upsert();
        
        editext.con = new Contact();
        editext.con.Salutation='Mr.';
        editext.con.FirstName = 'Test';
        editext.con.LastName = 'Contact';
        editext.con.Primary_Phone__c = '3837373772';
        editext.con.Is_this_a_Mobile_Number__c = 'No';
        editext.con.Email = 'test@gmail.com';
        editext.con.Re_Enter_Email__c = 'test@gmail.com';
        editext.con.Mailing_Street_Address_1__c = 'test street';
        editext.con.Mailing_State__c = 'test state';
        editext.con.Mailing_City__c = 'test city';
        editext.con.State_of_Residence__c = 'DC';
        editext.save_upsert();
        
        editext.con = new Contact();
        editext.con.Salutation='Mr.';
        editext.con.FirstName = 'Test';
        editext.con.LastName = 'Contact';
        editext.con.Primary_Phone__c = '3837373772';
        editext.con.Is_this_a_Mobile_Number__c = 'No';
        editext.con.Email = 'test@gmail.com';
        editext.con.Re_Enter_Email__c = 'test@gmail.com';
        editext.con.Mailing_Street_Address_1__c = 'test street';
        editext.con.Mailing_State__c = 'test state';
        editext.con.Mailing_City__c = 'test city';
        editext.con.State_of_Residence__c = 'DC';
        editext.con.How_did_you_hear_about_CNCS_Reviews__c = 'google';
        editext.save_upsert();      
        
        editext.con = new Contact();
        editext.con.Salutation='Mr.';
        editext.con.FirstName = 'Test';
        editext.con.LastName = 'Contact';
        editext.con.FirstName = 'Test';
        editext.con.LastName = 'Contact';
        editext.con.Primary_Phone__c = '3837373772';
        editext.con.Is_this_a_Mobile_Number__c = 'No';
        editext.con.Email = 'test@gmail.com';
        editext.con.Re_Enter_Email__c = 'test@gmail.com';
        editext.con.Mailing_Street_Address_1__c = 'test street';
        editext.con.Mailing_State__c = 'test state';
        editext.con.Mailing_City__c = 'test city';
        editext.con.State_of_Residence__c = 'DC';
        editext.con.How_did_you_hear_about_CNCS_Reviews__c = 'google';
        editext.con.Highest__c = 'Test';        
        editext.save_upsert();
            
        editext.con = new Contact();
        editext.con.Salutation='Mr.';
        editext.con.FirstName = 'Test';
        editext.con.LastName = 'Contact';
        editext.con.Primary_Phone__c = '3837373772';
        editext.con.Is_this_a_Mobile_Number__c = 'No';
        editext.con.Email = 'test@gmail.com';
        editext.con.Re_Enter_Email__c = 'test@gmail.com';
        editext.con.Mailing_Street_Address_1__c = 'test street';
        editext.con.Mailing_State__c = 'test state';
        editext.con.Mailing_City__c = 'test city';
        editext.con.State_of_Residence__c = 'DC';
        editext.con.How_did_you_hear_about_CNCS_Reviews__c = 'google';
        editext.con.Highest__c = 'Test';        
        editext.con.Area_of_Expertise__c = 'CNCS';
        editext.save_upsert();
        
        editext.con = new Contact();
        editext.con.Salutation='Mr.';
        editext.con.Primary_Phone__c = '3837373772';
        editext.con.Is_this_a_Mobile_Number__c = 'No';
        editext.con.Email = 'test@gmail.com';
        editext.con.Re_Enter_Email__c = 'test@gmail.com';
        editext.con.Mailing_Street_Address_1__c = 'test street';
        editext.con.Mailing_State__c = 'test state';
        editext.con.Mailing_City__c = 'test city';
        editext.con.State_of_Residence__c = 'DC';
        editext.con.How_did_you_hear_about_CNCS_Reviews__c = 'google';
        editext.con.Highest__c = 'Test';        
        editext.con.FirstName = 'Test';
        editext.con.LastName = 'Contact';
        editext.con.Area_of_Expertise__c = 'CNCS';
        editext.con.State_of_Residence__c = 'VA';
        editext.save_upsert();
        
        editext.con = new Contact();
        editext.con.Salutation='Mr.';
        editext.con.Primary_Phone__c = '3837373772';
        editext.con.Is_this_a_Mobile_Number__c = 'No';
        editext.con.Email = 'test@gmail.com';
        editext.con.Re_Enter_Email__c = 'test@gmail.com';
        editext.con.Mailing_Street_Address_1__c = 'test street';
        editext.con.Mailing_State__c = 'test state';
        editext.con.Mailing_City__c = 'test city';
        editext.con.State_of_Residence__c = 'DC';
        editext.con.How_did_you_hear_about_CNCS_Reviews__c = 'google';
        editext.con.Highest__c = 'Test';        
        editext.con.FirstName = 'Test';
        editext.con.LastName = 'Contact';
        editext.con.Area_of_Expertise__c = 'CNCS';
        editext.con.State_of_Residence__c = 'VA';
        editext.save_upsert();      
        
        editext.con = new Contact();
        editext.con.Salutation='Mr.';
        editext.con.Primary_Phone__c = '3837373772';
        editext.con.Is_this_a_Mobile_Number__c = 'No';
        editext.con.Email = 'test@gmail.com';
        editext.con.Re_Enter_Email__c = 'test@gmail.com';
        editext.con.Mailing_Street_Address_1__c = 'test street';
        editext.con.Mailing_State__c = 'test state';
        editext.con.Mailing_City__c = 'test city';
        editext.con.State_of_Residence__c = 'DC';
        editext.con.How_did_you_hear_about_CNCS_Reviews__c = 'google';
        editext.con.Highest__c = 'Test';        
        editext.con.FirstName = 'Test';
        editext.con.LastName = 'Contact';
        editext.con.Area_of_Expertise__c = 'CNCS';
        editext.con.State_of_Residence__c = 'VA';
        editext.history = new History__c();
        editext.save_upsert();
        
        editext.con = new Contact();
        editext.con.Salutation='Mr.';
        editext.con.Primary_Phone__c = '3837373772';
        editext.con.Is_this_a_Mobile_Number__c = 'No';
        editext.con.Email = 'test@gmail.com';
        editext.con.Re_Enter_Email__c = 'test@gmail.com';
        editext.con.Mailing_Street_Address_1__c = 'test street';
        editext.con.Mailing_State__c = 'test state';
        editext.con.Mailing_City__c = 'test city';
        editext.con.State_of_Residence__c = 'DC';
        editext.con.How_did_you_hear_about_CNCS_Reviews__c = 'google';
        editext.con.Highest__c = 'Test';        
        editext.con.FirstName = 'Test';
        editext.con.LastName = 'Contact';
        editext.con.Area_of_Expertise__c = 'CNCS';
        editext.con.State_of_Residence__c = 'VA';
        editext.history = new History__c();
        editext.history.Organization_Type1__c = 'test';
        editext.save_upsert();
        
        editext.con = new Contact();
        editext.con.Salutation='Mr.';
        editext.con.Primary_Phone__c = '3837373772';
        editext.con.Is_this_a_Mobile_Number__c = 'No';
        editext.con.Email = 'test@gmail.com';
        editext.con.Re_Enter_Email__c = 'test@gmail.com';
        editext.con.Mailing_Street_Address_1__c = 'test street';
        editext.con.Mailing_State__c = 'test state';
        editext.con.Mailing_City__c = 'test city';
        editext.con.State_of_Residence__c = 'DC';
        editext.con.How_did_you_hear_about_CNCS_Reviews__c = 'google';
        editext.con.Highest__c = 'Test';        
        editext.con.FirstName = 'Test';
        editext.con.LastName = 'Contact';
        editext.con.Area_of_Expertise__c = 'CNCS';
        editext.con.State_of_Residence__c = 'VA';
        editext.history = new History__c();
        editext.history.Organization_Type1__c = 'test';
        editext.history.Areas_of_Study_Degree_Details__c = 'test';
        editext.save_upsert();
        
        editext.con = new Contact();
        editext.con.Salutation='Mr.';
        editext.con.Primary_Phone__c = '3837373772';
        editext.con.Is_this_a_Mobile_Number__c = 'No';
        editext.con.Email = 'test@gmail.com';
        editext.con.Re_Enter_Email__c = 'test@gmail.com';
        editext.con.Mailing_Street_Address_1__c = 'test street';
        editext.con.Mailing_State__c = 'test state';
        editext.con.Mailing_City__c = 'test city';
        editext.con.State_of_Residence__c = 'DC';
        editext.con.How_did_you_hear_about_CNCS_Reviews__c = 'google';
        editext.con.Highest__c = 'Test';        
        editext.con.FirstName = 'Test';
        editext.con.LastName = 'Contact';
        editext.con.Area_of_Expertise__c = 'CNCS';
        editext.con.State_of_Residence__c = 'VA';
        editext.history = new History__c();
        editext.history.Organization_Type1__c = 'test';
        editext.history.Areas_of_Study_Degree_Details__c = 'test';
        editext.history2 = new History__c();
        editext.save_upsert();
        
        editext.con = new Contact();
        editext.con.Salutation='Mr.';
        editext.con.Primary_Phone__c = '3837373772';
        editext.con.Is_this_a_Mobile_Number__c = 'No';
        editext.con.Email = 'test@gmail.com';
        editext.con.Re_Enter_Email__c = 'test@gmail.com';
        editext.con.Mailing_Street_Address_1__c = 'test street';
        editext.con.Mailing_State__c = 'test state';
        editext.con.Mailing_City__c = 'test city';
        editext.con.State_of_Residence__c = 'DC';
        editext.con.How_did_you_hear_about_CNCS_Reviews__c = 'google';
        editext.con.Highest__c = 'Test';        
        editext.con.FirstName = 'Test';
        editext.con.LastName = 'Contact';
        editext.con.Area_of_Expertise__c = 'CNCS';
        editext.con.State_of_Residence__c = 'VA';
        editext.history = new History__c();
        editext.history.Organization_Type1__c = 'test';
        editext.history.Areas_of_Study_Degree_Details__c = 'test';
        editext.history = new History__c();
        editext.history.Organization_Type1__c = 'test';
        editext.history.Areas_of_Study_Degree_Details__c = 'test';
        editext.history2 = new History__c();
        editext.history2.Employer__c = 'test employer';
        editext.save_upsert();
        
        editext.con = new Contact();
        editext.con.Salutation='Mr.';
        editext.con.Primary_Phone__c = '3837373772';
        editext.con.Is_this_a_Mobile_Number__c = 'No';
        editext.con.Email = 'test@gmail.com';
        editext.con.Re_Enter_Email__c = 'test@gmail.com';
        editext.con.Mailing_Street_Address_1__c = 'test street';
        editext.con.Mailing_State__c = 'test state';
        editext.con.Mailing_City__c = 'test city';
        editext.con.State_of_Residence__c = 'DC';
        editext.con.How_did_you_hear_about_CNCS_Reviews__c = 'google';
        editext.con.Highest__c = 'Test';        
        editext.con.FirstName = 'Test';
        editext.con.LastName = 'Contact';
        editext.con.Area_of_Expertise__c = 'CNCS';
        editext.con.State_of_Residence__c = 'VA';
        editext.history = new History__c();
        editext.history.Organization_Type1__c = 'test';
        editext.history.Areas_of_Study_Degree_Details__c = 'test';
        editext.history = new History__c();
        editext.history.Organization_Type1__c = 'test';
        editext.history.Areas_of_Study_Degree_Details__c = 'test';
        editext.history2 = new History__c();
        editext.history2.Employer__c = 'test employer';
        editext.history2.Organization_Type__c = 'Test organization';
        editext.save_upsert();
        
        editext.con = new Contact();
        editext.con.Salutation='Mr.';
        editext.con.Primary_Phone__c = '3837373772';
        editext.con.Is_this_a_Mobile_Number__c = 'No';
        editext.con.Email = 'test@gmail.com';
        editext.con.Re_Enter_Email__c = 'test@gmail.com';
        editext.con.Mailing_Street_Address_1__c = 'test street';
        editext.con.Mailing_State__c = 'test state';
        editext.con.Mailing_City__c = 'test city';
        editext.con.State_of_Residence__c = 'DC';
        editext.con.How_did_you_hear_about_CNCS_Reviews__c = 'google';
        editext.con.Highest__c = 'Test';        
        editext.con.FirstName = 'Test';
        editext.con.LastName = 'Contact';
        editext.con.Area_of_Expertise__c = 'CNCS';
        editext.con.State_of_Residence__c = 'VA';
        editext.history = new History__c();
        editext.history.Organization_Type1__c = 'test';
        editext.history.Areas_of_Study_Degree_Details__c = 'test';
        editext.history = new History__c();
        editext.history.Organization_Type1__c = 'test';
        editext.history.Areas_of_Study_Degree_Details__c = 'test';
        editext.history2 = new History__c();
        editext.history2.Employer__c = 'test employer';
        editext.history2.Organization_Type__c = 'Test organization';
        editext.history2.Area_of_Expertise__c = 'Test expertise';
        editext.save_upsert();
        
        editext.con = new Contact();
        editext.con.Salutation='Mr.';
        editext.con.Primary_Phone__c = '3837373772';
        editext.con.Is_this_a_Mobile_Number__c = 'No';
        editext.con.Email = 'test@gmail.com';
        editext.con.Re_Enter_Email__c = 'test@gmail.com';
        editext.con.Mailing_Street_Address_1__c = 'test street';
        editext.con.Mailing_State__c = 'test state';
        editext.con.Mailing_City__c = 'test city';
        editext.con.State_of_Residence__c = 'DC';
        editext.con.How_did_you_hear_about_CNCS_Reviews__c = 'google';
        editext.con.Highest__c = 'Test';        
        editext.con.FirstName = 'Test';
        editext.con.LastName = 'Contact';
        editext.con.Area_of_Expertise__c = 'CNCS';
        editext.con.State_of_Residence__c = 'VA';
        editext.history = new History__c();
        editext.history.Organization_Type1__c = 'test';
        editext.history.Areas_of_Study_Degree_Details__c = 'test';
        editext.history = new History__c();
        editext.history.Organization_Type1__c = 'test';
        editext.history.Areas_of_Study_Degree_Details__c = 'test';
        editext.history2 = new History__c();
        editext.history2.Employer__c = 'test employer';
        editext.history2.Organization_Type__c = 'Test organization';
        editext.history2.Area_of_Expertise__c = 'Test expertise';
        editext.save_upsert();
        
        editext.con = new Contact();
        editext.con.Salutation='Mr.';
        editext.con.Primary_Phone__c = '3837373772';
        editext.con.Is_this_a_Mobile_Number__c = 'No';
        editext.con.Email = 'test@gmail.com';
        editext.con.Re_Enter_Email__c = 'test@gmail.com';
        editext.con.Mailing_Street_Address_1__c = 'test street';
        editext.con.Mailing_State__c = 'test state';
        editext.con.Mailing_City__c = 'test city';
        editext.con.State_of_Residence__c = 'DC';
        editext.con.How_did_you_hear_about_CNCS_Reviews__c = 'google';
        editext.con.Highest__c = 'Test';        
        editext.con.FirstName = 'Test';
        editext.con.LastName = 'Contact';
        editext.con.Area_of_Expertise__c = 'CNCS';
        editext.con.State_of_Residence__c = 'VA';
        editext.history = new History__c();
        editext.history.Organization_Type1__c = 'test';
        editext.history.Areas_of_Study_Degree_Details__c = 'test';
        editext.history = new History__c();
        editext.history.Organization_Type1__c = 'test';
        editext.history.Areas_of_Study_Degree_Details__c = 'test';
        editext.history2 = new History__c();
        editext.history2.Employer__c = 'test employer';
        editext.history2.Organization_Type__c = 'Test organization';
        editext.history2.Area_of_Expertise__c = 'Test expertise';
        editext.history2.Experience_Type__c = 'Professional';
        editext.save_upsert();   
        
        editext.con = new Contact();
        editext.con.Salutation='Mr.';
        editext.con.Primary_Phone__c = '3837373772';
        editext.con.Is_this_a_Mobile_Number__c = 'No';
        editext.con.Email = 'test@gmail.com';
        editext.con.Re_Enter_Email__c = 'test@gmail.com';
        editext.con.Mailing_Street_Address_1__c = 'test street';
        editext.con.Mailing_State__c = 'test state';
        editext.con.Mailing_City__c = 'test city';
        editext.con.State_of_Residence__c = 'DC';
        editext.con.How_did_you_hear_about_CNCS_Reviews__c = 'google';
        editext.con.Highest__c = 'Test';        
        editext.con.FirstName = 'Test';
        editext.con.LastName = 'Contact';
        editext.con.Area_of_Expertise__c = 'CNCS';
        editext.con.State_of_Residence__c = 'VA';
        editext.history = new History__c();
        editext.history.Organization_Type1__c = 'test';
        editext.history.Areas_of_Study_Degree_Details__c = 'test';
        editext.history = new History__c();
        editext.history.Organization_Type1__c = 'test';
        editext.history.Areas_of_Study_Degree_Details__c = 'test';
        editext.history2 = new History__c();
        editext.history2.Employer__c = 'test employer';
        editext.history2.Organization_Type__c = 'Test organization';
        editext.history2.Area_of_Expertise__c = 'Test expertise';
        editext.history2.Experience_Type__c = 'Professional';
        editext.history2.Expertise__c = 'Test expertise';
        editext.save_upsert();
        
        editext.con = new Contact();
        editext.con.Salutation='Mr.';
        editext.con.Primary_Phone__c = '3837373772';
        editext.con.Is_this_a_Mobile_Number__c = 'No';
        editext.con.Email = 'test@gmail.com';
        editext.con.Re_Enter_Email__c = 'test@gmail.com';
        editext.con.Mailing_Street_Address_1__c = 'test street';
        editext.con.Mailing_State__c = 'test state';
        editext.con.Mailing_City__c = 'test city';
        editext.con.State_of_Residence__c = 'DC';
        editext.con.How_did_you_hear_about_CNCS_Reviews__c = 'google';
        editext.con.Highest__c = 'Test';        
        editext.con.FirstName = 'Test';
        editext.con.LastName = 'Contact';
        editext.con.Area_of_Expertise__c = 'CNCS';
        editext.con.State_of_Residence__c = 'VA';
        editext.history = new History__c();
        editext.history.Organization_Type1__c = 'test';
        editext.history.Areas_of_Study_Degree_Details__c = 'test';
        editext.history = new History__c();
        editext.history.Organization_Type1__c = 'test';
        editext.history.Areas_of_Study_Degree_Details__c = 'test';
        editext.history2 = new History__c();
        editext.history2.Employer__c = 'test employer';
        editext.history2.Organization_Type__c = 'Test organization';
        editext.history2.Area_of_Expertise__c = 'Test expertise';
        editext.history2.Experience_Type__c = 'Professional';
        editext.history2.Expertise__c = 'Test expertise';
        editext.history2.Job_Description__c = 'test description';
        editext.save_upsert();
        
        
        editext.con = new Contact();
        editext.con.Salutation='Mr.';
        editext.con.Primary_Phone__c = '3837373772';
        editext.con.Is_this_a_Mobile_Number__c = 'No';
        editext.con.Email = 'test@gmail.com';
        editext.con.Re_Enter_Email__c = 'test@gmail.com';
        editext.con.Mailing_Street_Address_1__c = 'test street';
        editext.con.Mailing_State__c = 'test state';
        editext.con.Mailing_City__c = 'test city';
        editext.con.State_of_Residence__c = 'DC';
        editext.con.How_did_you_hear_about_CNCS_Reviews__c = 'google';
        editext.con.Highest__c = 'Test';        
        editext.con.FirstName = 'Test';
        editext.con.LastName = 'Contact';
        editext.con.Area_of_Expertise__c = 'CNCS';
        editext.con.State_of_Residence__c = 'VA';
        editext.history = new History__c();
        editext.history.Organization_Type1__c = 'test';
        editext.history.Areas_of_Study_Degree_Details__c = 'test';
        editext.history = new History__c();
        editext.history.Organization_Type1__c = 'test';
        editext.history.Areas_of_Study_Degree_Details__c = 'test';
        editext.history2 = new History__c();
        editext.history2.Employer__c = 'test employer';
        editext.history2.Organization_Type__c = 'Test organization';
        editext.history2.Area_of_Expertise__c = 'Test expertise';
        editext.history2.Experience_Type__c = 'Professional';
        editext.history2.Expertise__c = 'Test expertise';
        editext.history2.Job_Description__c = 'test description';
        editext.history2.empFrom__c = Date.newInstance(1965,2,18);
        editext.save_upsert();
        
        editext.con = new Contact();
        editext.con.Salutation='Mr.';
        editext.con.Primary_Phone__c = '3837373772';
        editext.con.Is_this_a_Mobile_Number__c = 'No';
        editext.con.Email = 'test@gmail.com';
        editext.con.Re_Enter_Email__c = 'test@gmail.com';
        editext.con.Mailing_Street_Address_1__c = 'test street';
        editext.con.Mailing_State__c = 'test state';
        editext.con.Mailing_City__c = 'test city';
        editext.con.State_of_Residence__c = 'DC';
        editext.con.How_did_you_hear_about_CNCS_Reviews__c = 'google';
        editext.con.Highest__c = 'Test';        
        editext.con.FirstName = 'Test';
        editext.con.LastName = 'Contact';
        editext.con.Area_of_Expertise__c = 'CNCS';
        editext.con.State_of_Residence__c = 'VA';
        editext.history = new History__c();
        editext.history.Organization_Type1__c = 'test';
        editext.history.Areas_of_Study_Degree_Details__c = 'test';
        editext.history = new History__c();
        editext.history.Organization_Type1__c = 'test';
        editext.history.Areas_of_Study_Degree_Details__c = 'test';
        editext.history2 = new History__c();
        editext.history2.Employer__c = 'test employer';
        editext.history2.Organization_Type__c = 'Test organization';
        editext.history2.Area_of_Expertise__c = 'Test expertise';
        editext.history2.Experience_Type__c = 'Professional';
        editext.history2.Expertise__c = 'Test expertise';
        editext.history2.Job_Description__c = 'test description';
        editext.history2.empFrom__c = Date.newInstance(1965,2,18);
        editext.history2.empTo__c = date.newInstance(1970,2,18);
        editext.history2.Years_of_Experience__c = 5;
        editext.save_upsert();         
        apexpages.currentpage().getparameters().put('index','0');        
        editext.delEmpRow2();
        editext.delRow2();
      
    }
    
    static testMethod void expertReviewRedirectTest() {
        Pagereference pref = Page.ExpertReviewerDetail;
        test.setCurrentPage(pref);
        
        Account a = UtilityClass.createOrganization();
        insert a;
        
        Contact c = utilityClass.createContact();
        c.AccountId = a.Id;
        insert c;
        
        User u = utilityclass.createUser('Expert Reviewers');
        u.ContactId = c.Id;
        //insert u;
        
        System.runAs(u){
             //ApexPages.StandardController controller = new ApexPages.StandardController(new Contact());
             redirectExt = new ExpertReviewRedirect();
             redirectExt.PageRedirect();
        }
        
        
    }
    
    static testMethod void contactRecordTypeSelectTest(){
        
        Pagereference pref = Page.SelectRecordType;
        test.setCurrentPage(pref);
        
        Account a = UtilityClass.createOrganization();
        insert a;
        
        Contact c = utilityClass.createContact();
        c.AccountId = a.Id;
        insert c;
        
        Apexpages.currentPage().getParameters().put('id',c.Id);
        
        ApexPages.StandardController controller = new ApexPages.StandardController(new Contact());
        rtSelectExt = new accountRecordTypeSelection_Controller(controller);
        rtSelectExt.selectedRtType = Schema.SObjectType.Contact.getRecordTypeInfosByName().get('Expert Reviewer').getRecordTypeId();
        rtSelectExt.continueWtSelection();
        
        rtSelectExt.selectedRtType = Schema.SObjectType.Contact.getRecordTypeInfosByName().get('Grantee').getRecordTypeId();
        rtSelectExt.continueWtSelection();
    }
}