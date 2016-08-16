/******
Triger to count the number of Award(either amended/regular)
Since we have limitation to use master-detial relationship we are going for trigger
Created By:Krishna
Created Date: 1/29/2016
Last Modifeid BY:Prashant
******/

trigger UpdateCountonMA on Award__c (After Insert,After Update,After Delete) {
   
   Set<Id> MA_IDs = new Set<Id>();
   
   if(Trigger.isDelete) {
     for(Award__c Aw:Trigger.Old) {
      
        MA_IDs.add(Aw.Master_Award__c);   
       }   
     }
   
   if(Trigger.isInsert || Trigger.isUpdate ) {
   for(Award__c Aw:Trigger.new) {
      
        MA_IDs.add(Aw.Master_Award__c);   
         }  
    }
    List<Master_Award__c> MA_List = [select id,Number_of_Child_Awards__c,(Select id from Award__r) from Master_Award__c where id IN :MA_IDs];
    for(Master_Award__c ma : MA_List){
   ma.Number_of_Child_Awards__c = ma.Award__r.size();
   }
  
  If(!MA_List.isEmpty()) 
   update MA_List;

}