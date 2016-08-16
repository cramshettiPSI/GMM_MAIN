trigger permissonassign  on User (after update)
{
/*
if(trigger.isupdate && trigger.isafter)
{
list<user> updatedusers = new list<user>();
set<id> myuserset = new set<id>();
for(user u1 : trigger.old)
{
myuserset.add(u1.id);
}
for(user u : [select id,name,with_budget__c,W_O_budget__c,contactid from user where id in:myuserset])
{
if(u.with_budget__c  == true)
{
 Assignpermissiontouser.Assignpermissionwithbudget(u.ContactId,u.id);
}
if(u.W_O_budget__c  == true)
{
Assignpermissiontouser.Assignpermissionwithoutbudget(u.ContactId,u.id);
}
if(u.with_budget__c   == true && u.W_O_budget__c  == true)
{
Assignpermissiontouser.Assignpermissionboth(u.ContactId,u.id);
}

}

}
*/
}