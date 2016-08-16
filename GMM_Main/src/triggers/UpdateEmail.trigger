Trigger UpdateEmail On Award_Reporting__c (before insert,before update)
{
    Set<ID> ids=new Set<ID>();
    for(Award_Reporting__c ar:trigger.new)
    {
        ids.add(ar.id);
    }
    List<Award_Reporting__c > arList=[SELECT ID,Award__r.pos__r.email FROM Award_Reporting__c WHERE ID IN:ids];
    for(Award_Reporting__c ar:arList)
    {
        if(ar.Award__r.pos__r.email!=NULL)
            ar.PO_Email__c=ar.Award__r.pos__r.email;      //new email field 
    }
}