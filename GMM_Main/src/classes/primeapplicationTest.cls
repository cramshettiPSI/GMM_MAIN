@istest
public class primeapplicationTest{

    Private Static testmethod void Testprimeapplication(){    
    Prime_Application__c primeApp = new Prime_Application__c();
        Pagereference pref = Page.PrimeApplicationDetail;
        test.setCurrentPage(pref);
        Prime_Application__c testapp = UtilityClass.createPrimeApplication();
    Insert testapp;
        
        ApexPages.currentPage().getParameters().put('id',testapp.id);
        ApexPages.StandardController stdcon = new ApexPages.StandardController(testapp);
        PrimeApplicationExt obj_PrimeApplicationExt  = new PrimeApplicationExt(stdcon);
        obj_PrimeApplicationExt.apply();
        obj_PrimeApplicationExt.report();
        obj_PrimeApplicationExt.ApprovedforAward();
         obj_PrimeApplicationExt.FormulaNOFAchange();
         obj_PrimeApplicationExt.submitsubApps();
         obj_PrimeApplicationExt.ContPrimeApp();
         obj_PrimeApplicationExt.RecAwardsMethod();
         obj_PrimeApplicationExt.Amend();
        
        }
   }