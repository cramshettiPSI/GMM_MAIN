trigger UpdateOrgObj on NOFA__c   (after update) {
        
        List<Account> oppList = new List<Account>();
        // Create a set of related opps
        set <id> ids = new set <id>();
        for (NOFA__c   newSet : Trigger.new)
        ids.add(newSet.Organizations__c);

        // Add child? checkbox to map
        map <id,Account > childMap = new map<id,Account >();
        for (Account o:[select id,ActiveAmericorpsOrSeniorCorpsAward__c from Account where id in :ids])
        childMap.put(o.id, o);
   
     for (NOFA__c   newBonus : Trigger.new) {
           
            Account o = childMap.get(newBonus.Organizations__c);
           /* if(newBonus.Require_Active_Grant__c == true)
            {
            
            }*/
            if(newBonus.Require_Active_Grant__c == true &&  o.ActiveAmericorpsOrSeniorCorpsAward__c == false )
            {
            newBonus.addError('Validation failed.');
            return;
            
            }
           oppList.add(o);
   }
      // you are missing below lines
      if(oppList.size()>0)
       {
       update oppList;
      }
}