public with sharing class PrimeApplicationExtension 
{
    private ApexPages.StandardController sController;
    public PrimeApplicationExtension(ApexPages.StandardController controller) 
    {
        sController=controller;
    }
    public PageReference SaveAndNew()
    {
        try
        {
            sController.save();
            Schema.DescribeSObjectResult describeResult = sController.getRecord().getSObjectType().getDescribe();  
            PageReference pr=new PageReference('/apex/PrimeApplication');
            pr.setRedirect(true);
            return pr;
        }
        catch(Exception e) 
        {   
            ApexPages.addMessages(e);  
            return null;  
        }  
    }
    
}