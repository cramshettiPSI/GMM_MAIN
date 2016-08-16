trigger PickListCheck on Honorarium_Information__c (before insert)
{  
 List<Honorarium_Information__c> pickList = [Select NOFA_Group__c,position__c from Honorarium_Information__c ];  
 for (Honorarium_Information__c newList : Trigger.new)
 {      
    for(Honorarium_Information__c sa: pickList)
    {         
          if(sa.NOFA_Group__c == newList.NOFA_Group__c && sa.position__c == newList.position__c)         
          {              
              newList.position__c.addError('Pick List Value is already Selected');        
          }     
    } 
 } 
}