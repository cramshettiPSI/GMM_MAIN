@isTest
private class AddAttachmentsContTest {
    public static AddAttachmentsController ext;
    public static AddAttachmentsController ext2;
    
    static testMethod void myUnitTest() {
       
        Utilityclass.insertFieldIds();
        Pagereference pref = Page.AddAttachments;
        test.setCurrentPage(pref);
        Monitoring_Activity__c ma = UtilityClass.createMonitoringActivity();
        insert ma;
        Apexpages.currentPage().getParameters().put('CF00Nr0000000Oh4V_lkid',ma.Id);
        
        ApexPages.StandardController controller = new ApexPages.StandardController(new Attachment__c());
        ext = new AddAttachmentsController(controller);
        //ext.Options();
        ext.fileName = 'test';
        ext.fileBody = Blob.valueOf('test');
        list<selectOption> soptions; 
        soptions = ext.Options;
        ext.processUpload();
        ext.back();      
        
        Account a = UtilityClass.createOrganization();
        insert a;
        Apexpages.currentPage().getParameters().put('CF00Nr0000000OGTx_lkid',a.Id);   
        
        ApexPages.StandardController controller2 = new ApexPages.StandardController(new Attachment__c());
        ext2 = new AddAttachmentsController(controller2);
        //ext.Options();
        ext2.fileName = 'test';
        ext2.fileBody = Blob.valueOf('test');
        list<selectOption> soptions2; 
        soptions2 = ext2.Options;
        ext2.processUpload();
        //ext2.back();       
    }
    
    static testMethod void myUnitTest2() {
        Utilityclass.insertFieldIds();
        Contact c = UtilityClass.createContact();
        insert c;
        Apexpages.currentPage().getParameters().put('CF00Nr0000000OR9y_lkid',c.Id);   
        
        ApexPages.StandardController controller = new ApexPages.StandardController(new Attachment__c());
        ext = new AddAttachmentsController(controller);
        //ext.Options();
        ext.fileName = 'test';
        ext.fileBody = Blob.valueOf('test');
        list<selectOption> soptions; 
        soptions = ext.Options;
        ext.processUpload();
        
        
        Nofa_Group__c ng = Utilityclass.createNofaGroup();
        insert ng;
        Stages__c stage = UtilityClass.createStage();
        stage.NOFA_Group__c = ng.Id;
        insert stage;
        
        Apexpages.currentPage().getParameters().put('CF00Nr0000000OD8D_lkid',stage.Id);   
        
        ApexPages.StandardController controller2 = new ApexPages.StandardController(new Attachment__c());
        ext2 = new AddAttachmentsController(controller2);
        //ext.Options();
        ext2.fileName = 'test';
        ext2.fileBody = Blob.valueOf('test');
        list<selectOption> soptions2; 
        soptions2 = ext.Options;
        ext2.processUpload();
        ext2.back();
        
        
        
    }
    
    static testMethod void myUnitTest3() {
        Utilityclass.insertFieldIds();
        NOFA__c nofa = UtilityClass.createNofa();
        insert nofa;
        
        Apexpages.currentPage().getParameters().put('CF00Nr0000000OB3z_lkid',nofa.Id);
        
        ApexPages.StandardController controller = new ApexPages.StandardController(new Attachment__c());
        ext = new AddAttachmentsController(controller);
        //ext.Options();
        ext.fileName = 'test';
        ext.fileBody = Blob.valueOf('test');
        list<selectOption> soptions; 
        soptions = ext.Options;
        ext.processUpload();
        
        
        
    }
    
    static testMethod void myUnitTest4(){
        Utilityclass.insertFieldIds();
        Application3__c app = UtilityClass.createApplication();
        insert app;
        
        Apexpages.currentPage().getParameters().put('CF00Nr0000000OB8Q_lkid',app.Id);
        
        ApexPages.StandardController controller = new ApexPages.StandardController(new Attachment__c());
        ext = new AddAttachmentsController(controller);
        //ext.Options();
        ext.fileName = 'test';
        ext.fileBody = Blob.valueOf('test');
        list<selectOption> soptions; 
        soptions = ext.Options;
        ext.processUpload();       
        
    }
    
    static testMethod void myUnitTest5(){
        Utilityclass.insertFieldIds();
        Award__c aw = UtilityClass.createAward();
        insert aw;
        
        Apexpages.currentPage().getParameters().put('CF00Nr0000000OHGB_lkid',aw.Id);
        
        ApexPages.StandardController controller = new ApexPages.StandardController(new Attachment__c());
        ext = new AddAttachmentsController(controller);
        //ext.Options();
        ext.fileName = 'test';
        ext.fileBody = Blob.valueOf('test');
        list<selectOption> soptions; 
        soptions = ext.Options;
        ext.processUpload();       
        
    }
}