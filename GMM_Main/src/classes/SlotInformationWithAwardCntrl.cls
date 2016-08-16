public class SlotInformationWithAwardCntrl{

    public ApexPages.StandardController stdController;
    public Award__c award{get;set;}
    public List<Slot__c> lstSlot{get;set;}
    
    public SlotInformationWithAwardCntrl(){
          System.debug('***SlotInformationWithAwardCntrl constructor***');
    
    }
     
    public SlotInformationWithAwardCntrl(ApexPages.StandardController p_controller){
    try{
      this.stdController= p_controller;
      this.award= (Award__c )stdController.getrecord();
      System.debug('***award***'+award.id);
      String strAwardId='';
      strAwardId=(award!=null )? award.id:'';
      String strAppId=(award!=null )? award.Application_ID__c:'';
      readSlotInformation(strAwardId,strAppId);
      }
      catch(Exception exc){
                 System.debug('***error in SlotInformationWithAwardCntrl constructor***'+exc.getMessage());
      }   
   }
     
    public void readSlotInformation(String p_StrAwardId,String p_StrAppId){
         System.debug('***p_StrAwardId***'+p_StrAwardId+'***p_StrAppId***'+p_StrAppId);
         if((p_StrAwardId!=null && p_StrAwardId!='')||(p_StrAppId!=null && p_StrAppId!='')){
              lstSlot =[SELECT ID,NAME,Slot_Type__c,Award__c,Prime_Application__c,ApplicationId__c,Budget_Application__c,Requested_w_Allowance__c,Requested_w_o_Allowance__c,
                               Recommended_w_Allowance__c,Recommended_w_o_Allowance__c,Aggregate_Recommendation_w_Allowance__c,Aggregate_Recommendation_w_o_Allowance__c,
                               Enrollment_Start_Date__c,Enrollment_End_Date__c,Approved_With_Allowance__c,Approved_WithOut_Allowance__c 
                        FROM SLOT__c  Where Award__c= :p_StrAwardId or Application__c= :p_StrAppId];
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
        catch(DMLException dmlExc){
            System.debug('***DMLException -lstSlot ***'+dmlExc);
        }
        catch(Exception exc){
            System.debug('***lstSlot ***'+exc );
             //System.debug('***excMsg***' +exc.getMesssage());
        }
        return null;
    }
}