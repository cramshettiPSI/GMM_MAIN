@isTest
Public Class paymentAmountUpdate_TEST
{
    static testmethod void paymentAmountUpdateTestmethod1()
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
        
         User u1 = new User(alias = 'kbra', email='kbrazi@salesforce.com',
                            emailencodingkey='UTF-8', lastname='Testing', languagelocalekey='fr',
                            localesidkey='fr_FR_EURO', profileid = p.Id, country='France',
                            timezonesidkey='Europe/Paris', username='abc@salesforce.com',
                            IsActive = true);
    insert u1; 
        
        System.runAs(u){

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

        NOFA_Group__c ng =  new NOFA_Group__c();
        ng.Name__c = 'qwe';
        ng.Review_of__c = 'Application';
        ng.Review_Type__c = 'Staff';
        ng.Status__c = 'Pending';
        insert ng;
        
        Stages__c st = new Stages__c();
        st.NOFA_Group__c = ng.Id;
        st.Type__c = 'Internal';
        st.Status__c = 'In Progress';
      //  st.Start_Date__c = Today();
        //st.End_Date__c = Today()+10;
        st.Stage_Number__c = '1';
        Insert st;  
        Paneling__c pan = new Paneling__c();
        pan.Panel_Coordinator__c = con.id;
        pan.Staff_Liaison__c = con.id;
       // pan.Staff_Liasion1__c = u.Id;
        pan.Stage_Number__c = st.Id;
        insert pan;


        Panel_Member__c pm = new Panel_Member__c();
        pm.Active__c = true;
        pm.COI_Conflict__c= false;
        pm.Role__c = 'New Reviewer';
        pm.Status__c = 'Active';
        pm.Payment_Amount__c =123;
        pm.Staff_Member__c = u1.id;
        pm.Panel__c =  pan.id;

        Test.startTest();
        insert pm;
        pm.Status__c = 'in Active';
        update pm;
        
        Test.StopTest();
        
        
    }
    }
}