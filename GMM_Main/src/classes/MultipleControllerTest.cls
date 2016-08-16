@isTest
private class MultipleControllerTest {

    static testMethod void rlControllerTest() {
        
        Application3__c app = UtilityClass.createApplication();
        insert app;
        
        RLController cont = new RLController();
        cont.aFields = 'Name,Organization__c,Status__c,Grantee_Status__c,Submitted_On__c';
        cont.aObjType = 'Application3__c';
        cont.arecId = app.NOFA_RFP__c;
        cont.arecordType = 'Application';
        cont.arelationfield = 'Nofa_Rfp__c';
        
        List<SelectOption> options = cont.options;
        //cont.ColumnWrapList;
        cont.getobjList();
        cont.edit();
        cont.LoadObjectList(app.NOFA_RFP__c, cont.aObjType, cont.arecordType, cont.aFields, cont.arelationfield);
        cont.run();
        String tmpStr = cont.aFields;
        String[] aFieldsList= tmpStr.split(',');
        //cont.LoadColumnList(cont.aobjType, aFieldsList);
       // cont.getrecordTypeId(cont.aobjType, cont.arecordType);
        
    }
    
    static testMethod void multiselectComponentControllerTest() {
        Application3__c app = UtilityClass.createApplication();
        app.Natural_and_Other_Disasters__c = 'test 1;test 2';
        insert app;
        
        MultiSelectComponentController cont = new MultiSelectComponentController(); 
        cont.fieldName = 'Natural_and_Other_Disasters__c';
                
        ApexPages.StandardController controller = new ApexPages.StandardController(app);
        cont.appEdit = new ApplicationEditpageExt(controller);                       
        cont.appEdit.applicationInput = app;
        
        /*ApexPages.StandardController controller2 = new ApexPages.StandardController(app);
        cont.cPaperEdit = new ConceptpapereditExt(controller2);                             
        cont.cPaperEdit.applicationInput = app;*/
        
        list<selectOption> options = cont.options;
        cont.selected = new list<string>{'Test 1'};
        cont.deselected = new list<string>{'Test 2'};
        cont.selecting();        
        list<selectOption> options2 = cont.selectedOptions;
        cont.deselecting();
        cont.assignOptions(options, cont.fieldName);    
        
        
    }
    
    static testMethod void customLookupControllerTest() {        
        NOFA_Group__c nfgrp = UtilityClass.createNofaGroup();
        insert nfgrp;
        
        Stages__c stage = UtilityClass.createStage();
        stage.NOFA_Group__c = nfgrp.Id;
        insert stage;
        
        Paneling__c panel = UtilityClass.createPanel();
        panel.Stage_Number__c = stage.Id;
        insert panel;
        
        Application3__c app = UtilityClass.createApplication();
        insert app;
        
        NOFA_Member__c nofaMember = new NOFA_Member__c();
        nofaMember.NOFA_Group__c = nfgrp.Id;
        nofaMember.NOFA__c = app.NOFA_RFP__c;
        insert nofaMember;
        
        Apexpages.currentPage().getParameters().put('lksrch','test');
        Apexpages.currentPage().getParameters().put('parentId',panel.Id);
        CustomLookupController cont = new CustomLookupController();
        cont.search();        
        
    }
    
    static testMethod void customLookupControllerTest2(){
                
        NOFA_Group__c nfgrp = UtilityClass.createNofaGroup();
        nfgrp.Review_of__c = 'Concept papers';
        insert nfgrp;
        
        Stages__c stage = UtilityClass.createStage();
        stage.NOFA_Group__c = nfgrp.Id;
        insert stage;
        
        Paneling__c panel = UtilityClass.createPanel();
        panel.Stage_Number__c = stage.Id;
        insert panel;
        
        Application3__c app = UtilityClass.createConceptPaper();
        insert app;
        
        NOFA_Member__c nofaMember = new NOFA_Member__c();
        nofaMember.NOFA_Group__c = nfgrp.Id;
        nofaMember.NOFA__c = app.NOFA_RFP__c;
        insert nofaMember;
        
        Apexpages.currentPage().getParameters().put('lksrch','test');
        Apexpages.currentPage().getParameters().put('parentId',panel.Id);
        CustomLookupController cont = new CustomLookupController();
        cont.search();
        
    }
    
    
}