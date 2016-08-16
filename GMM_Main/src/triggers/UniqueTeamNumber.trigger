trigger UniqueTeamNumber  on Team__c (before insert, before update) {

if(trigger.isbefore)
{
set<id> parentids = new set<id>();
for(Team__c  team : trigger.new)
{
parentids.add(team.Unit__c);
}
map<id,list<Team__c>> parentmap = new map<id,list<Team__c>>();
for(Team__c r : [select id,Unit__c,Team_Number__c from Team__c where Unit__c in: parentids ])
{
if(parentmap.containskey(r.Unit__c))
{
list<Team__c> dlist = parentmap.get(r.Unit__c);
dlist.add(r);
parentmap.put(r.Unit__c,dlist);
}
else
{
parentmap.put(r.Unit__c,new list<Team__c>{r});
}
}
system.debug('!!!!!!'+parentmap);
for(Team__c tea : trigger.new)
{
if(parentmap.get(tea.Unit__c) != null)
{
for(Team__c existingrounds : parentmap.get(tea.Unit__c))
{
if(tea.id!=existingrounds.id && tea.Team_Number__c == existingrounds.Team_Number__c)
{
tea.adderror('Record with same team number already exists');
}
}
}
}
}
}