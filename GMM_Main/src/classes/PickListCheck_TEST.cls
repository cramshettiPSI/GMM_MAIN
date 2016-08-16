@isTest
Public Class PickListCheck_TEST
{
    static testmethod void PickListCheck1()
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

        System.runAs(u){        
        NOFA_Group__c ng = new NOFA_Group__c();
        ng.Status__c = 'Pending';       
        ng.Review_Type__c= 'Staff';
        ng.Review_of__c= 'Application';
        ng.Name__c ='tets';
        insert ng;
        
        
        Honorarium_Information__c hi = new Honorarium_Information__c();
        hi.Position__c ='Panel Coordinator';
        hi.Payment_Amount__c =123;
        hi.NOFA_Group__c = ng.Id;        
        insert hi;
        
        
    }
    }
    static testmethod void PickListCheck2()
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
        
        System.runAs(u){        
        NOFA_Group__c ng = new NOFA_Group__c();
        ng.Status__c = 'Pending';       
        ng.Review_Type__c= 'Staff';
        ng.Review_of__c= 'Application';
        ng.Name__c ='tets';
        insert ng;
        
        Honorarium_Information__c hi = new Honorarium_Information__c();
        hi.Position__c ='Panel Coordinator';
        hi.Payment_Amount__c =123;
        hi.NOFA_Group__c = ng.Id;    
        insert hi;
        //hi.Position__c ='New Reviewer';
      //  hi.Position__c ='Panel Coordinator';
        ///update hi;
        
    }
    }
}