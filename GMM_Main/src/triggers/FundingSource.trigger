trigger FundingSource on Funding_Source__c (after update) {
    set<Id> nofaIds = new set<Id>();
    if(trigger.isUpdate && trigger.isAfter){
        for(Funding_Source__c f: trigger.new){
            if(f.NOFA__c!=null){
                nofaIds.add(f.NOFA__c);
            }
        }
        if(nofaIds.size()>0){
            list<NOFA__c> nofas = new list<NOFA__c>([Select Status__c, Id,Name from NOFA__c where id in :nofaIds and status__c = 'Finalized']);
            for(NOFA__c n:nofas){
                n.Status__c = 'Setup In Progress';
                n.NOFA_Active_Inactive__c = false;
            }
            if(nofas.size()>0){
                update nofas;
            }
        }
    }
}