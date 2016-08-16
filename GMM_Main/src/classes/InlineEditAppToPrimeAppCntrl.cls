public class InlineEditAppToPrimeAppCntrl{
    
    public ApexPages.StandardController stdcontroller;
    public Prime_Application__c objPrimApp{get;set;}
    public Application3__c objApp{get;set;}
    public List<Application3__c> lstApp{get;set;}
    //public Boolean errValidationErorExplode{get;set;}

    public InlineEditAppToPrimeAppCntrl(){
    }
    
    public InlineEditAppToPrimeAppCntrl(ApexPages.StandardController p_controller){
    try{  
          //errValidationErorExplode=false;
          lstApp= new List<Application3__c>();
          this.stdcontroller= p_controller;
          this.objPrimApp= (Prime_Application__c)stdController.getrecord();
          readAppData();
      }
      catch(Exception exc){
           System.debug('*** Exception***InlineEditAppToPrimeAppCntrl Constructor***'+exc.getMessage()); 
      }
    }

    public void readAppData(){
        lstApp= new List<Application3__c>();
        Prime_Application__c objPrimAppTemp=new Prime_Application__c();
        try{
            objPrimAppTemp =[SELECT id, (select id,name,Rank__c,Assessment_of_Quality_Indicators__c,Organizational_Capability__c,Executive_Summary__c,
                                                Ranking_Justification__c,Status__c  
                                         from Applications__r) 
                             FROM Prime_Application__c where id = :objPrimApp.id ];
                             
            for(Application3__c objAppTemp : objPrimAppTemp.Applications__r)         {
                if(objAppTemp.Status__c!=null && (objAppTemp.Status__c.equalsIgnoreCase('Recommended to CNCS') || objAppTemp.Status__c.equalsIgnoreCase('Submitted to CNCS') 
                                                          || objAppTemp.Status__c.equalsIgnoreCase('Submitted Late to CNCS') || objAppTemp.Status__c.equalsIgnoreCase('Review In Progress')
                                                          || objAppTemp.Status__c.equalsIgnoreCase('Returned for Rework') || objAppTemp.Status__c.equalsIgnoreCase('Accepted')
                                                          || objAppTemp.Status__c.equalsIgnoreCase('Awarded'))){ 
                    lstApp.add(objAppTemp );
                }
            }
        }
        catch(Exception exc){
           System.debug('*** Exception***InlineEditAppToPrimeAppCntrl->method -readAppData() ***'+exc.getMessage()); 
        }
        
        System.debug('***lstApp***'+lstApp);
    }
    
    public PageReference SaveInlineChanges(){
       // system.debug(attended);
        system.debug(lstApp);
        try{
   
        // update attended;
         update lstApp;
         }
         catch(DMLException dmlExc){
           //errValidationErorExplode=true;
           System.debug('***DMLException***InlineEditAppToPrimeAppCntrl->method -SaveInlineChanges() ***'+dmlExc.getMessage());
         }
         catch(Exception exc){
             System.debug('*** Exception***InlineEditAppToPrimeAppCntrl->method -SaveInlineChanges() ***'+exc.getMessage());
         }
   
    //return ApexPages.CurrentPage();
    return null;
    }
    
    
}