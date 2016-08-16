@isTest
private class ConceptPaperTest {
	
	public static ConceptpapereditExt ext;
	public static NOFAtoConceptPaperUIExt nofaTocpExt;
	public static NotificationEditpageExt notificationEditExt;
	public static NOFAtoNotificationUIExt nofaToNotificationExt;
	
    static testMethod void conceptPaperEditTest() {
    	Application3__c conceptPaper = UtilityClass.createConceptPaper();
    	insert conceptPaper;
    	
    	Apexpages.currentPage().getParameters().put('id',conceptPaper.Id);
        
        ApexPages.StandardController controller = new ApexPages.StandardController(conceptPaper);
        ext = new ConceptpapereditExt(controller);
        
        Pagereference pref = Page.ConceptPaperEdit;
	    test.setCurrentPage(pref);
        ext.getThis();
        ext.reopen1();
        ext.SaveAsDraft();
        ext.Validate();    	
    	
        
    }
    
    static testMethod void nofaToConceptPaperTest() {
        Application3__c conceptPaper = UtilityClass.createConceptPaper();
    	insert conceptPaper;
    	
    	NOFA__c nofa = [Select Id,Name from NOFA__c where id = :conceptPaper.NOFA_RFP__c];
    	
    	Apexpages.currentPage().getParameters().put('id',conceptPaper.NOFA_RFP__c);
        Apexpages.currentPage().getParameters().put('projectid',conceptPaper.Project__c);
        //Apexpages.currentPage().getParameters().put('primeApplicationId',app.Prime_Application__c);
        
        ApexPages.StandardController controller = new ApexPages.StandardController(nofa);
        nofaTocpExt = new NOFAtoConceptPaperUIExt(controller);
        
        Pagereference pref = Page.NOFAtoConceptPaperUI;
	    test.setCurrentPage(pref);
	    
	    //nofaTocpExt.createProject();
	    nofaTocpExt.getThis();
	    nofaTocpExt.SaveAsDraft();
	    //nofaTocpExt.save1();
	    nofaTocpExt.Validate();
	    
    }
    
    static testMethod void notificationEditTest(){

    	Application3__c intentToApply = UtilityClass.createNotification();
    	insert intentToApply;
    	
    	Apexpages.currentPage().getParameters().put('id',intentToApply.Id);
        
        ApexPages.StandardController controller = new ApexPages.StandardController(intentToApply);
        notificationEditExt = new NotificationEditpageExt(controller);
        
        Pagereference pref = Page.NotificationEditPage;
	    test.setCurrentPage(pref);
	    
	    notificationEditExt.edit();
	    notificationEditExt.save();
	    
	    
    }
    
     static testMethod void nofaToNotificationTest() {
        Application3__c intentToApply = UtilityClass.createNotification();
    	insert intentToApply;
    	
    	NOFA__c nofa = [Select Id,Name from NOFA__c where id = :intentToApply.NOFA_RFP__c];
    	
    	Apexpages.currentPage().getParameters().put('id',intentToApply.NOFA_RFP__c);
        Apexpages.currentPage().getParameters().put('projectid',intentToApply.Project__c);
        //Apexpages.currentPage().getParameters().put('primeApplicationId',app.Prime_Application__c);
        
        ApexPages.StandardController controller = new ApexPages.StandardController(nofa);
        nofaToNotificationExt = new NOFAtoNotificationUIExt(controller);
        
        Pagereference pref = Page.NotificationofIntenttoApply;
	    test.setCurrentPage(pref);
	    
	    //nofaToNotificationExt.save();
	    nofaToNotificationExt.SaveAsDraft();
	    
     }
}