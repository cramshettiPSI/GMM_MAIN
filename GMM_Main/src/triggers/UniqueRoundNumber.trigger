trigger UniqueRoundNumber on Round__c (before insert, before update) {

	if(trigger.isbefore){
		set<id> parentids = new set<id>();
		for(Round__c  rou : trigger.new)
		{
			parentids.add(Rou.Class__c);
		}
		map<id,list<Round__c>> parentmap = new map<id,list<Round__c>>();
		for(Round__c r : [select id,class__c,Round_Number__c from round__c where class__c in: parentids ])
		{
			if(parentmap.containskey(r.class__c))
			{
				list<round__c> dlist = parentmap.get(r.class__c);
				dlist.add(r);
				parentmap.put(r.class__c,dlist);
			}
			else
			{
				parentmap.put(r.class__C,new list<round__c>{r});
			}
		}
		system.debug('!!!!!!'+parentmap);
		for(Round__c roun : trigger.new)
		{
			if(parentmap.get(roun.class__c) != null)
			{
				for(Round__c existingrounds : parentmap.get(roun.class__c))
				{
					if(roun.Id != existingrounds.Id && roun.Round_Number__c == existingrounds.Round_Number__c)
					{
						roun.adderror('Record with round number already exists');
					}
				}
			}
		}
	}
}