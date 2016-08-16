trigger userpermissonassign  on contact(after update)
{
if(trigger.isupdate && trigger.isafter)
{
Map<string,contact> contactemails = new map<string,contact>();
set<string> emailset = new set<string>();
for(contact c : trigger.new)
{
contactemails.put(c.email,c);
emailset.add(c.email);
}
list<user> userret = [select id,name,ContactId,email from user where email in:emailset];

for(user u : userret)
{

contact c = contactemails.get(u.email);
if(trigger.oldmap.get(c.id).Validation_of_Reports__c != contactemails.get(u.email).Validation_of_Reports__c || trigger.oldmap.get(c.id).Summer_of_Service_Grantee__c != contactemails.get(u.email).Summer_of_Service_Grantee__c|| trigger.oldmap.get(c.id).Vista_Sponsor_Verification__c != contactemails.get(u.email).Vista_Sponsor_Verification__c|| trigger.oldmap.get(c.id).Grantee__c != contactemails.get(u.email).Grantee__c || trigger.oldmap.get(c.id).Grantee_W_O_budget__c != contactemails.get(u.email).Grantee_W_O_budget__c || trigger.oldmap.get(c.id).Grantee_Recruitment__c != contactemails.get(u.email).Grantee_Recruitment__c || trigger.oldmap.get(c.id).VISTA_Grantee_Member_Management__c != contactemails.get(u.email).VISTA_Grantee_Member_Management__c || trigger.oldmap.get(c.id).Grantee_Travel_Profile__c != contactemails.get(u.email).Grantee_Travel_Profile__c || trigger.oldmap.get(c.id).State_and_National_Grantee_Member_Manage__c != contactemails.get(u.email).State_and_National_Grantee_Member_Manage__c|| trigger.oldmap.get(c.id).View_Costshare_Invoices__c != contactemails.get(u.email).View_Costshare_Invoices__c || trigger.oldmap.get(c.id).Grantee_With_Budget__c != contactemails.get(u.email).Grantee_With_Budget__c)
{

Assignpermissiontouser.Assignpermission2(u.ContactId,u.id);


}
}





}
}