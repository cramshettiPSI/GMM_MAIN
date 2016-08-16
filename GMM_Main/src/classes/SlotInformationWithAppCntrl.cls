public class SlotInformationWithAppCntrl{

    public ApexPages.StandardController stdcontroller;
    public Application3__c app{get;set;}
    public List<Slot__c> lstSlot{get;set;}
    
    public SlotInformationWithAppCntrl(){
          System.debug('***SlotInformationWithApp constructor***');
    
    }
    
    public SlotInformationWithAppCntrl(ApexPages.StandardController p_controller){
    try{
      this.stdcontroller= p_controller;
      this.app= (Application3__c )stdController.getrecord();
      System.debug('***appid***'+app.id);
      String strAppId='';
      strAppId=(app!=null )? app.id:'';
      readSlotInformation(strAppId);
      }
      catch(Exception exc){
            System.debug('***error in SlotInformationWithAppCntrl constructor***'+exc.getMessage());
      }   
      
    }
    
    
    
    public void readSlotInformation(String p_strAppId){
         System.debug('***p_strAppId***'+p_strAppId);
         if(p_strAppId!=null && p_strAppId!=''){
            lstSlot =[SELECT ID,NAME,Slot_Type__c,Award__c,Prime_Application__c,ApplicationId__c,   Application__c,Budget_Application__c,Requested_w_Allowance__c,Requested_w_o_Allowance__c,
                             Recommended_w_Allowance__c,Recommended_w_o_Allowance__c,
                             Aggregate_Recommendation_w_Allowance__c,Aggregate_Recommendation_w_o_Allowance__c,Enrollment_Start_Date__c,Enrollment_End_Date__c 
                      FROM SLOT__c  Where   Application__c= :p_strAppId];  //Where ApplicationId__c= :p_strAppId
         }         
         System.debug('*** lstSlot ***'+lstSlot );    
   
    }
    
    public PageReference updateSlotRecs(){
        try{
           System.debug('*** lstSlot ***'+lstSlot );
           if(lstSlot !=null && lstSlot.size()>0){
             Update lstSlot ;
           }
        }
        catch(Exception exc){
            System.debug('***lstSlot ***'+exc );
             //System.debug('***excMsg***' +exc.getMesssage());
        
        }
        return null;
    
    }
    
    public void processBdgLnRecsForUpdate(){
    List<cb3__BudgetLine__c> lstBdgLin = new List<cb3__BudgetLine__c>();
        
      /* for(SLOT__c   itrSlot :lstSlot ){
         itrSlot.  
       
       }*/
    
    }
  

}