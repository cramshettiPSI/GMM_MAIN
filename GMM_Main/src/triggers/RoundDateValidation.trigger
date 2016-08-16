trigger RoundDateValidation on Round__c (after insert,after update) 
{
    Map<ID,Round__c> fpchildslist = new Map<ID,Round__c>([SELECT ID,Round_Start_Date__c,Transition_End_Round_Date__c,class__r.id FROM Round__c WHERE ID IN:trigger.new]);
    List<Id> idList=new List<Id>();
    for(Round__c r:fpchildslist.values())
    {
        idList.add(r.class__r.id);
    }
    List<class__c> plist=new List<class__c>(); 
    System.debug('idList1:'+idList);
    Map<ID,class__c> roundMap=new Map<ID,class__c>([SELECT ID,(SELECT ID,Round_Start_Date__c,Transition_End_Round_Date__c FROM rounds__r) FROM class__c WHERE Id IN:idList]);
    System.debug('roundMap:'+roundMap.keySet());
    for(Round__c r:trigger.new)
    {
        System.debug('FPCID:'+r.Id);
        ID pid=fpchildslist.get(r.id).class__r.id;
        if(roundMap.containsKey(pid))
        {
            System.debug('roundMap1:'+roundMap.keySet());
            List<Round__c> fchilds=new List<Round__c>();
            fchilds=roundMap.get(pid).rounds__r;
            System.debug('fchilds:'+fchilds);
            for(Round__c f:fchilds)
            {
            if(r.id!=f.id && ((
                    (r.Round_Start_Date__c >= f.Round_Start_Date__c && r.Round_Start_Date__c <= f.Transition_End_Round_Date__c)||
                    (r.Transition_End_Round_Date__c >= f.Round_Start_Date__c && r.Transition_End_Round_Date__c <= f.Transition_End_Round_Date__c)) 
                    || ((f.Round_Start_Date__c >= r.Round_Start_Date__c && f.Round_Start_Date__c <= r.Transition_End_Round_Date__c)||
                    (f.Transition_End_Round_Date__c >= r.Round_Start_Date__c && f.Transition_End_Round_Date__c <= r.Transition_End_Round_Date__c))))
                {
                   r.addError('Round should not overlap with existing rounds');
                }
               
               
            }
            
        }
    }
}