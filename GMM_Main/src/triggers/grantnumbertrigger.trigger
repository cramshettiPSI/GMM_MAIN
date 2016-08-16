trigger grantnumbertrigger on Grant_Close_Out__c (before insert)
{

set<id> masterid = new set<id>();
map<id,list<award__C>> masterandawardmap = new map<id,list<award__C>>();
for(Grant_Close_Out__c gco : trigger.new)
{
masterid.add(gco.Master_Award__c);
}

list<award__C> allawards = [select id,name,createddate,Master_Award__r.id from award__c where Master_Award__r.id in : masterid];

for(award__C  ac : allawards )
if(masterandawardmap.containsKey(ac.Master_Award__r.id)) {
        List<Award__c> awardlist = masterandawardmap.get(ac.Master_Award__r.id);
        awardlist.add(ac);
        masterandawardmap.put(ac.Master_Award__r.id, awardlist);
    } else {
        masterandawardmap.put(ac.Master_Award__r.id, new List<Award__c> {ac});
    }
for(Grant_Close_Out__c grantcloseout : trigger.new)
{

//for(award__C a : masterandawardmap.get(grantcloseout.Master_Award__c)
//{

//}
list<award__C> acc = masterandawardmap.get(grantcloseout.Master_Award__c);
integer i=0;
integer j=1;
integer size = acc.size();
award__c aclatest = new award__c();

for(integer k=1;k<=acc.size();k++)
{
if(j<size )
{
if(acc[i].createddate > acc[j].createddate)
{
 aclatest  = acc[i];
i++;
J++;
}
else
{
aclatest  = acc[j];
i++;
J++;
}
}
}
grantcloseout.test_grant_number__c = aclatest.name;
}
}