Public class FundSourceLookUpCntrl{

    public Award__c objAward{get;set;} 
    public List<Funding_Source__c> lstFundingSource{get;set;}
    
    public PageReference retrieveFundSourceRecs(){
        String strAwardId=ApexPages.currentPage().getParameters().get('idfield');
        System.debug('***strAwardId***'+strAwardId);
        if(strAwardId!=null){
            objAward= [Select id,Application_ID__r.NOFA_RFP__c from Award__c where id=:strAwardId];
            System.debug('objAward'+objAward);
            if(objAward!=null && objAward.Application_ID__r.NOFA_RFP__c!=null){
                lstFundingSource=[Select id,name,Object_code__r.name,Grant_location_number__c,Funds_Remaining__c from Funding_Source__c where NOFA__c=:objAward.Application_ID__r.NOFA_RFP__c];
                System.debug('lstFundingSource'+lstFundingSource);
            }
        }
        return null;
    }
 
}