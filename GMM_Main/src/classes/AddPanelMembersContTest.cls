@isTest
private class AddPanelMembersContTest {
	public static AddPanelMembersCont ext;
    static testMethod void myUnitTest() {
       Nofa_Group__c ng = Utilityclass.createNofaGroup();
       insert ng;
       
       Contact c = UtilityClass.createContact();
       insert c;
       
       Reviewer_Pool__c	rp = UtilityClass.createReviewerPool();
       rp.NOFA_Group__c = ng.Id;
       rp.Expert_Reviewer_Name__c = c.Id;
       insert rp;
       
       Stages__c stage = UtilityClass.createStage();
       stage.NOFA_Group__c = ng.Id;
       insert stage;
       
       Paneling__c panel = UtilityClass.createPanel();
       panel.Stage_Number__c = stage.Id;
       insert panel;       
       
       
       PageReference pref = Page.AddPanelMembers; 
       test.setCurrentPage(pref);      
       pref.getParameters().put('Id',panel.Id);
       ext = new AddPanelMembersCont();
       Apexpages.currentPage().getParameters().put('area','CNCS');
       Apexpages.currentPage().getParameters().put('residence','VA');
       Apexpages.currentPage().getParameters().put('education','Less Than High School');
       Apexpages.currentPage().getParameters().put('status',' ');
       Apexpages.currentPage().getParameters().put('rating','0');
       Apexpages.currentPage().getParameters().put('Experience','2');
       //ext.wrappedContacts.add(new contactWrapper(c));
       ext.getContacts();
       ext.runSearch();              
       ext.savePanelMembers();
       ext.cancel();
        
    }
}