@istest
public class  NotifyGranteeAdmintest
{
static testMethod void testmethod1()
{
account acc = new account();
acc .Name = 'Test';
acc .Legal_Name__c = 'Test Org'; 
acc .Name_d_b_a__c = 'Test';
acc .Organization_Type__c ='State Government' ;
acc .Phone__c = '98232123123';
acc .Address_1__c = 'abcd123';
acc .City__c= 'abcd';
acc .States__c = 'nj';
acc .Zip1__c = '97643';

// acc.account = 'xyz';
insert acc;

contact con = new contact ();
con .Salutation = 'Mr'; 
con .FirstName = 'Test';
con .LastName ='State Government' ;
con .Primary_Phone__c= '98232123123';
con .Is_this_a_Mobile_Number__c = 'No';
con .Emails__c= 'ash@email.com';
con .Re_Enter_Email__c = 'ash@email.com';
//con .contact = 'xyz12';
insert con;

account acc2 = new account();
acc2 .Name = 'Test';
acc2 .Legal_Name__c = 'Sowmya Test Org'; 
acc2 .Name_d_b_a__c = 'Test';
acc2 .Organization_Type__c ='State Government' ;
acc2 .Phone__c = '98232123123';
acc2 .Address_1__c = 'abcd123';
acc2 .City__c= 'abcd';
acc2 .States__c = 'nj';
acc2 .Zip1__c = '97643';

// acc.account = 'xyz';
insert acc2;

contact con1 = new contact ();
con1 .Salutation = 'Mr'; 
con1 .FirstName = 'Teste';
con1 .LastName ='State Governmente' ;
con1 .Primary_Phone__c= '98232123123';
con1 .Is_this_a_Mobile_Number__c = 'No';
con1 .Emails__c= 'asha@email.com';
con1 .Re_Enter_Email__c = 'asha@email.com';
//con .contact = 'xyz12';
insert con1;

list<contact> mycon = new list<contact>();
mycon.add(con);
mycon.add(con1);

map<id,contact> mymap = new map<id,contact>();

mymap.put(con.id,con);

NotifyGranteeAdmin nf = new NotifyGranteeAdmin ();

nf.notifyEmailGranteeAdmin(mycon,mymap );



}
}