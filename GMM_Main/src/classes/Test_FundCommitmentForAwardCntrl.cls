@isTest
private class Test_FundCommitmentForAwardCntrl{

    static testMethod void testMethod1(){
    
        PageReference pageRef = Page.FundCommitmentForAwardVF;
        Test.setCurrentPageReference(pageRef);
        Award__c objAward =UtilityClass.createAward();
        insert objAward ;
        ApexPages.StandardController sc = new ApexPages.standardController(objAward );
        FundCommitmentForAwardCntrl objExtCntrl = new FundCommitmentForAwardCntrl(sc);
        System.assertEquals(objExtCntrl.objAward, objAward );
    }    




}