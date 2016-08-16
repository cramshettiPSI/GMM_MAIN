trigger UpdateChildFields on NOFA__c (before insert, before update,After Update) {
    
    List<Id> nofaIds =new List<Id>();
    
        for (NOFA__c obj: trigger.new){
     nofaIds.add(obj.id);
            }
            
   Map<Id,NOFA__c> nofaMap = new Map<Id,NOFA__c>([select id,Program_Name__c,CNCS_Corporate_Program__c,CNCS_Corporate_Program__r.CNCS_Corporate_Program_Name__r.name from NOFA__c where id in: nofaIds]);
       
    if((trigger.isBefore && trigger.isInsert) || (trigger.isBefore && trigger.isUpdate)){
        
        for (NOFA__c obj: trigger.new){
            if (obj.Parent_NOFA__c != null)
                obj.Allow_planning_grants_for_this_NOFA__c = obj.Parent_NOFA__r.Allow_planning_grants_for_this_NOFA__c;
        }
        
        
        for(NOFA__c n: trigger.new){
            
            if(nofaMap.size() > 0 && nofaMap.get(n.id).CNCS_Corporate_Program__r.CNCS_Corporate_Program_Name__r.name!=null)
                n.Program_Name__c = nofaMap.get(n.id).CNCS_Corporate_Program__r.CNCS_Corporate_Program_Name__r.name;
            if(n.Required__c !=null && n.Organization_Docs__c != null )
            {
                String required =  n.Required__c;
                String orgDocs = n.Organization_Docs__c;
                system.debug('required = '+required);
                system.debug('org Docs = '+orgDocs);
                
                if(required.contains(orgDocs))
                    n.addError('Same Type cannot be in both fields: Required and Oranization Docs');
            }   
            
        }
    }  
    
    if(trigger.isAfter && trigger.isUpdate){
        
        List<NOFA__c> nofaToUpdate = new List<NOFA__c>();
        List<NOFA__c> nofaList = new List<NOFA__c>();
        
        for(NOFA__c n: trigger.new){
            NOFA__c oldNofa =  trigger.oldmap.get(n.id);
            if( oldNofa.CNCS_Corporate_Program__c != n.CNCS_Corporate_Program__c)
                nofaList.add(n);
        }
        
        for(NOFA__c nof : [Select id,Program_Name__c,CNCS_Corporate_Program__c,CNCS_Corporate_Program__r.CNCS_Corporate_Program_Name__r.name from NOFA__c where id IN: nofaList] )
        {
         nofaToUpdate.add(nof);
            if(nofaMap.size() > 0 && nofaMap.get(nof.id).CNCS_Corporate_Program__r.CNCS_Corporate_Program_Name__r.name!=null)
                nof.Program_Name__c = nofaMap.get(nof.id).CNCS_Corporate_Program__r.CNCS_Corporate_Program_Name__r.name;
        }
        
        if(nofaToUpdate.size()>0)
            Update nofaToUpdate;
    }
}