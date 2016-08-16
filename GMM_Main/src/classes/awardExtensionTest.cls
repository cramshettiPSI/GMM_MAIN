@istest

public class awardExtensionTest{

    Private Static testmethod void TestAward(){  
     Application3__c App = UtilityClass.createApplication();
     insert App;
    
   
     Award__c testawd = new Award__c();
   // Award__c objAwd = new Award__c();
        Pagereference pref = Page.AwardDetailPage;
        test.setCurrentPage(pref);
      //  Award__c testawd = UtilityClass.createAward();
         testawd.Application_ID__c = App.Id;
    Insert testawd;
        
        ApexPages.currentPage().getParameters().put('id',testawd.id);
        AwardExtension ext =new AwardExtension();
        ApexPages.StandardController stdcon = new ApexPages.StandardController(testawd);
        AwardExtension obj_awardExtension  = new AwardExtension(stdcon);
       
         obj_awardExtension.initMethod();
        // obj_awardExtension.AwardApp();
         obj_awardExtension.CertifiyApplicationbyPO();
          obj_awardExtension.ApproveGrantpreviouslycertifiedbyPO();
          obj_awardExtension.ApproveGrantpreviouslycertifiedbyPO();
          //obj_awardExtension.CertifyApplicationCommitted();
          obj_awardExtension.sendtopo();
          obj_awardExtension.sendtospo();
          obj_awardExtension.sendtoGO();
          obj_awardExtension.sendtoSGO();
          obj_awardExtension.CertifytoSGO();
          obj_awardExtension.commitfromSGO();
          obj_awardExtension.Obligatepgmtypenull();
         obj_awardExtension.CertifiyApplicationbyPO1();
          obj_awardExtension.sendtoXO();
          obj_awardExtension.Withdraw();
          obj_awardExtension.CSHRtoXO();
          obj_awardExtension.reject();
          obj_awardExtension.ReturntoRework();
          obj_awardExtension.returntoXO();
          obj_awardExtension.ApproveAgreementbyXO();
          obj_awardExtension.esign();
          obj_awardExtension.esignature();
          obj_awardExtension.moveWithoutCommitting();
          obj_awardExtension.esignaturebySPO();
          obj_awardExtension.AwardnonCS();
          obj_awardExtension.MovetoAward();
          obj_awardExtension.eSignaturebySGO();
          obj_awardExtension.SignAgreementtoXO();
          obj_awardExtension.confirmsign();
          obj_awardExtension.reload();
          obj_awardExtension.Amend();
         
        /* testawd.Grant_Status__c='Awaiting SGO Approval';
         update testawd;
         obj_awardExtension.CertifyApplicationCommitted();*/
                  
          }
    
    Private Static testmethod void TestAward1(){    
     Award__c objAwd = new Award__c();
     Pagereference pref = Page.AwardDetailPage;
     test.setCurrentPage(pref);
     
     Award__c testawd = UtilityClass.createAward();
    testawd.Grant_Status__c='Awaiting SGO Approval';
    testawd.Committed__c=true;
     Insert testawd;
        
        ApexPages.currentPage().getParameters().put('id',testawd.id);
        ApexPages.StandardController stdcon = new ApexPages.StandardController(testawd);
        AwardExtension obj_awardExtension  = new AwardExtension(stdcon);     
      obj_awardExtension.CertifyApplicationCommitted();
      } 
          
       
       
      
   Private Static testmethod void TestAward3(){    
    // Award__c objAwd = new Award__c();
     Pagereference pref = Page.AwardDetailPage;
     test.setCurrentPage(pref);
      Application3__c App = UtilityClass.createApplication();
   
        insert App;
        
               
        
        Award__c Award = new Award__c();
        //Award.Application_ID__c = App.Id;
        Award.NOFA_Name__c = app.NOFA_RFP__c;       
        Award.Name = 'Test Award';
        //Award.Master_Award__c = 
        //Award.Prime_Application__c = 
        Award.Organization__c = app.Organization__c;
        Award.Grant_Status__c = 'Awaiting PO Certification';
        Award.Grant__c = 'Test127262';
        //Award.Number_of_Child_Awards__c = 1;
        Award.Amendment__c=0;
        Award.RecordTypeId = Schema.SObjectType.Award__c.getRecordTypeInfosByName().get('App Award').getRecordTypeId();
     
    // Award__c testawd = UtilityClass.createAward();
     //testawd.Grant_Status__c='Awaiting SGO Approval';
     //testawd.Committed__c=true;
    // testawd.Application_ID__c=null;
     Insert Award;
        
        ApexPages.currentPage().getParameters().put('id',Award.id);
        ApexPages.StandardController stdcon = new ApexPages.StandardController(Award);
        AwardExtension obj_awardExtension  = new AwardExtension(stdcon);    
        //obj_awardExtension.app_Clonedfrom_List = new List<Application3__c>{App};
      obj_awardExtension.Amend();
     
      }  
   
   Private Static testmethod void TestAward4(){    
        
        Pagereference pref = Page.AwardDetailPage;
        test.setCurrentPage(pref);
        Award__c testawd = UtilityClass.createAward();
        Insert testawd;
        Award__c objAwd = new Award__c();
        objAwd=[select id, Grant_Status__c from Award__c where id=:testAwd.id];
        system.debug('@@@prash'+objAwd);
        objAwd.Grant_Status__c='Obligated';
        objAwd.Sponsor_e_Signature__c=true;
        objAwd.Committed__c=true;
        update objAwd;
        
     /*   ApexPages.currentPage().getParameters().put('id',testawd.id);
         
        AwardExtension ext =new AwardExtension();
        ApexPages.StandardController stdcon = new ApexPages.StandardController(testawd);
        AwardExtension obj_awardExtension  = new AwardExtension(stdcon);
        obj_awardExtension.AwardApp();
        
        objAwd=[select id, Grant_Status__c from Award__c where id=:testAwd.id];
        system.debug('@@@prash'+objAwd);
        objAwd.Grant_Status__c='Awarded';
        objAwd.Sponsor_e_Signature__c=true;
        update objAwd;*/
        Apexpages.currentPage().getParameters().put('id',objAwd.Id);
        ApexPages.StandardController stdcon = new ApexPages.StandardController(objAwd);
        AwardExtension obj_awardExtension  = new AwardExtension(stdcon);
        obj_awardExtension.AwardApp();
        obj_awardExtension.CertifyApplicationCommitted();
       // obj_awardExtension.sendtoGO();
        objAwd.Grant_Status__c='Awaiting GO Certification';
        Apexpages.currentPage().getParameters().put('id',objAwd.Id);
      //  obj_awardExtension.sendtoSGO();
       
        obj_awardExtension.CertifytoSGO();
        obj_awardExtension.Withdraw();
       // obj_awardExtension.esign();
      //  objAwd=[select id, Grant_Status__c from Award__c where id=:objAwd.id];
        
        objAwd.Grant_Status__c='Awaiting GO Certification';
        update objAwd;
        Apexpages.currentPage().getParameters().put('id',objAwd.Id);
        stdcon = new ApexPages.StandardController(objAwd);
        AwardExtension obj_awardExtension1  = new AwardExtension(stdcon);
        obj_awardExtension1.sendtoSGO();
        obj_awardExtension1.Obligatepgmtypenull();
         //Awaiting GO Certification
         
        objAwd.Grant_Status__c='Awaitinifg PO Certification';
        update objAwd;
        Apexpages.currentPage().getParameters().put('id',objAwd.Id);
        stdcon = new ApexPages.StandardController(objAwd);
        AwardExtension obj_awardExtension2  = new AwardExtension(stdcon);
     //  obj_awardExtension2.esign();
       obj_awardExtension2.reject();
       //obj_awardExtension2.ReturntoRework();
        //obj_awardExtension2.esign();
        
        objAwd.Grant_Status__c='Awaiting PO Certification';
        update objAwd;
        Apexpages.currentPage().getParameters().put('id',objAwd.Id);
        stdcon = new ApexPages.StandardController(objAwd);
        AwardExtension obj_awardExtension3  = new AwardExtension(stdcon);
        obj_awardExtension3.ReturntoRework();
        obj_awardExtension3.returntoXO();
        
         }
         
        Private Static testmethod void TestAward5(){     
        Pagereference pref = Page.AwardDetailPage;
        test.setCurrentPage(pref);
        Award__c testawd = UtilityClass.createAward();
        Insert testawd;
        Award__c objAwd = new Award__c();
        objAwd=[select id, Grant_Status__c from Award__c where id=:testAwd.id];
        system.debug('@@@prash'+objAwd);
         
        objAwd.Grant_Status__c='Awaiting SGO Approval';
        update objAwd;
        Apexpages.currentPage().getParameters().put('id',objAwd.Id);
       ApexPages.StandardController stdcon = new ApexPages.StandardController(objAwd);
        AwardExtension obj_awardExtension4  = new AwardExtension(stdcon);
       obj_awardExtension4.returntoXO(); 
      // obj_awardExtension4.MovetoAward();
        obj_awardExtension4.moveWithoutCommitting();
       
                
       /*objAwd.Grant_Status__c='Awaiting XO CSHR Approval';
        update objAwd;
        Apexpages.currentPage().getParameters().put('id',objAwd.Id);
        stdcon = new ApexPages.StandardController(objAwd);
        AwardExtension obj_awardExtension3  = new AwardExtension(stdcon);*/
        
        
                         
        objAwd.Grant_Status__c='Awaiting SPO Award';
        update objAwd;
        Apexpages.currentPage().getParameters().put('id',objAwd.Id);
        stdcon = new ApexPages.StandardController(objAwd);
        AwardExtension obj_awardExtension5  = new AwardExtension(stdcon);
        obj_awardExtension5.AwardnonCS();
        //obj_awardExtension5.MovetoAward();
      
      
        objAwd.Grant_Status__c='Awaiting SGO Approval';
        update objAwd;
        Apexpages.currentPage().getParameters().put('id',objAwd.Id);
        stdcon = new ApexPages.StandardController(objAwd);
        AwardExtension obj_awardExtension6  = new AwardExtension(stdcon);
        obj_awardExtension6.MovetoAward();
        obj_awardExtension6.sendtoGO();
         
         
        objAwd.Grant_Status__c='Awaiting SGO Approval';
        update objAwd;
        Apexpages.currentPage().getParameters().put('id',objAwd.Id);
        stdcon = new ApexPages.StandardController(objAwd);
        AwardExtension obj_awardExtension7  = new AwardExtension(stdcon);
        obj_awardExtension7.sendtoGO(); 
       
        
        objAwd.Grant_Status__c='Awaiting PO Certification';
        update objAwd;
        Apexpages.currentPage().getParameters().put('id',objAwd.Id);
        stdcon = new ApexPages.StandardController(objAwd);
        AwardExtension obj_awardExtension8  = new AwardExtension(stdcon);
        obj_awardExtension8.esign();
       // obj_awardExtension8.reject();
       
        objAwd.Grant_Status__c='Awaiting SPO Approval';
        objAwd.Sponsor_e_Signature__c=true;
        update objAwd;
        Apexpages.currentPage().getParameters().put('id',objAwd.Id);
        stdcon = new ApexPages.StandardController(objAwd);
        AwardExtension obj_awardExtension9  = new AwardExtension(stdcon);
        obj_awardExtension9.esignaturebySPO(); 
        
        }
        
        Private Static testmethod void CreateAwardfromAwardReporting(){  
        Application3__c App = UtilityClass.createApplication();
        insert App;
         
         Id Nofaid = [Select name,NOFA_RFP__r.id from Application3__c where id=: App.id].NOFA_RFP__r.id ;
         System.debug('NOFA_Id1'+Nofaid);
         Action_Reports__c actionreport =new Action_Reports__c();
         actionreport.NOFA_ID__c=Nofaid;
         insert actionreport;
         
          Id AppAwardRecordTypeId = Schema.SObjectType.Award__c.getRecordTypeInfosByName().get('App Award').getRecordTypeId();
        
         List<Award__c> award_List = new List<Award__c>();
        
        Award__c testawd = new Award__c();
   
         testawd.Application_ID__c = App.Id;
         award_List.add(testawd);
       //  Insert testawd;
         
         Award__c testawd1 = new Award__c();
   
         testawd1.Application_ID__c = App.Id;
         testawd1.recordtypeId = AppAwardRecordTypeId;
         award_List.add(testawd1);
       //  Insert testawd;
        
        Insert award_List;
        
        Pagereference pref = Page.AwardDetailPage;
        test.setCurrentPage(pref);
        
        ApexPages.currentPage().getParameters().put('id',testawd.id);
        AwardExtension ext =new AwardExtension();
        ApexPages.StandardController stdcon = new ApexPages.StandardController(testawd);
        AwardExtension obj_awardExtension  = new AwardExtension(stdcon);
        
    Award__c awd =  [Select Application_ID__r.NOFA_RFP__r.id from Award__c where id=:testawd.id];
      System.debug('Award_Info^^^'+awd.Application_ID__r.NOFA_RFP__r.id);
    
         
       }
       
        }