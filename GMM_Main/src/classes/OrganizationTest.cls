@isTest
private class OrganizationTest {

    static testMethod void myUnitTest() {
    	
    	Contact con = UtilityClass.createContact();
    	insert con;
    	
    	
        Pagereference pref = Page.CreateOrganization;
	    test.setCurrentPage(pref);
	    ApexPages.currentPage().getParameters().put('uid',con.Id);
	    
	    Test.startTest();
	    createaccount cont = new createaccount();  
	    cont.Account.Name = 'test account';
	    cont.Account.EIN__c = '123526152';
	    cont.Account.DUNS__c = '293838381';
	    cont.Account.Legal_Name__c = 'Test Account';
	    cont.Account.Name_d_b_a__c = 'test acc';
	    cont.Account.Organization_Type__c = 'Type 1;Type 2';
	    cont.Account.O__c = 'Type 3;Type 4';
	    cont.Account.Address_1__c= 'test st';
	    cont.Account.Address_2__c = 'test ct';
	    cont.Account.City__c = 'test city';
	    cont.Account.States__c = 'test state';
	    cont.Account.Zip1__c = '33321';
	    cont.Account.Phone__c = '4432212343';
	    cont.Account.Email__c = 'test@c.com';
	    cont.create();
	    //cont.PageRedirect();
	    cont.Cancelrecord();
	    //cont.GetAddresses();
	    cont.Save();
	    cont.Submit();
	    Test.stopTest();
	    
    }
}