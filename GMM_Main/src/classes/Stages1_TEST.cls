@isTest
Public Class Stages1_TEST
{
    static testmethod void NofaMember ()
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
        Test.StartTest();
        System.runAs(u){        

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

        
        ApexPages.StandardController sc = new ApexPages.StandardController(st);
        Stages1   cpa = new Stages1  (sc);
        StagesPanelling  cpb = new StagesPanelling (sc);
     
        Test.StopTest();
        
        
    }
    }
}