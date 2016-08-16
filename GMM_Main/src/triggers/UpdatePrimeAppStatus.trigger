trigger UpdatePrimeAppStatus on Award__c (after update) {
  
    if(trigger.isAfter && trigger.isupdate){
        Id primeAwardRTId= Schema.SObjectType.Award__c.getRecordTypeInfosByName().get('Prime Award').getRecordTypeId();
        list<Id> PrimeAppIdList = new list<id>();
        for(Award__c Aw : trigger.new){
          if(Aw.Grant_Status__c == 'Awarded' && aw.recordTypeId == primeAwardRTId){
           PrimeAppIdList.add(Aw.Prime_Application__c); 
          }
        }

         list<Prime_Application__c> PAS = [SELECT id,CNCS_Status__c,Competitive_or_Formula__c from Prime_Application__c WHERE id in: PrimeAppIdList];
           
         for(Prime_Application__c PA : PAS){
          if(PA.Competitive_or_Formula__c == 'Formula'){              
                PA.CNCS_Status__c = 'Awarded';
          }
         }
         update PAS;
    }
}