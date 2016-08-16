@isTest
Public Class SyncField2_TEST
{
    static testmethod void SyncField2_TEST1()
    {
        Profile p = [SELECT Id FROM Profile WHERE Name='System Administrator'];


        User u = new User();
        u.Alias = 'email'; 
        u.Email='email@email.com';
        u.EmailEncodingKey='UTF-8';
        u.LastName='Testing'; 
        u.LanguageLocaleKey='en_US'; 
        u.LocaleSidKey='en_US';
        u.ProfileId = p.Id;
        u.TimeZoneSidKey='America/Los_Angeles';
        u.UserName='email@testcoverage.com';
        insert u;
        
        Contact con = new Contact();
        con.Salutation='Mr.';
        con.FirstName = 'Test';
        con.LastName = 'Contact';
        con.Primary_Phone__c = '3837373772';
        con.Is_this_a_Mobile_Number__c = 'No';
        con.Email = 'test@gmail.com';
        con.Re_Enter_Email__c = 'test@gmail.com';
        con.Mailing_Street_Address_1__c = 'test street';
        con.Mailing_State__c = 'test state';
        con.Mailing_City__c = 'test city';
        con.State_of_Residence__c = 'DC';
        con.How_did_you_hear_about_CNCS_Reviews__c = 'google';
        con.Highest__c = 'Test';    
        con.Area_of_Expertise__c = 'CNCS';
        insert con;
        
        System.runAs(u){        
        Paneling__c pan = new Paneling__c();
        pan.Response__c = 'qwer';
        pan.Panel_Coordinator__c = con.id;
        
        
        insert pan;
        
        
        Expert_Review_Panel__c erp = new Expert_Review_Panel__c();
        erp.Status__c= 'Completed';
        //erp.Profile__c = 'Expert Reviewer';
        erp.Staff_Reviewer__c = u.id;
        erp.Panel__c = pan.Id;
       
        
    
        insert erp;
        
        
    }
    }
}