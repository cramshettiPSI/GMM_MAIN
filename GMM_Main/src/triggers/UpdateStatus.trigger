trigger UpdateStatus on Award__c(before insert,before update)
{
    if(trigger.isInsert && trigger.isBefore && trigger.isUpdate)
    {
        Set<ID> mAwardIds=new Set<ID>();
        for(Award__c a:Trigger.new)
        {
            mAwardIds.add(a.Master_Award__c);
         //   a.Grant_Status__c='Being Closed';
        }
        List<Master_Award__c> mAward=new List<Master_Award__c>();
        List<Grant_Close_Out__c> closeOut=new List<Grant_Close_Out__c>();
        closeOut=[SELECT ID,Status__c FROM Grant_Close_Out__c WHERE Master_Award__c IN:mAwardIds];
        System.debug('Close OUts:'+closeOut);
        for(Award__c a:Trigger.new)
        {
            for(Grant_Close_Out__c g:closeOut)
            {
                if(a.Master_Award__c==g.Master_Award__c && g.status__c=='In Progress')
                {
                       // a.Grant_Status__c.equalsIgnoreCase('Being Closed');
                        a.Grant_Status__c='Being Closed';
                }
            }
        }
    }
}