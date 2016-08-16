public class Assignpermissiontouser
 {

 @future
public static void Assignpermission2(string contactid, string us)
 {
 list<PermissionSetAssignment> psetass = [select id from  PermissionSetAssignment where AssigneeId =: us AND PermissionSetId IN (SELECT Id 
                                                      FROM PermissionSet
                                                     WHERE IsOwnedByProfile =false)];
   
   if(psetass.size() > 0)
       delete psetass ;

  contact c = [select id,Summer_of_Service_Grantee__c,State_and_National_Grantee_Member_Manage__c,Grantee__c,Grantee_W_O_budget__c,Grantee_Recruitment__c,Grantee_With_Budget__c,Grantee_Travel_Profile__c,VISTA_Grantee_Member_Management__c,Validation_of_Reports__c,Vista_Sponsor_Verification__c,View_Costshare_Invoices__c from contact where id =: contactid];
 
   user u =[select id,name from user where id=:us];
   permissionset p = [select id,name from PermissionSet where name =: 'Grantee'];
   permissionset p1 = [select id,name from PermissionSet where name =: 'Grantee_W_O_budget'];
   permissionset p2 = [select id,name from PermissionSet where name =: 'Grantee_Recruitment'];
   permissionset p3 = [select id,name from PermissionSet where name =: 'Grantee_Travel_Profile'];
   permissionset p4 = [select id,name from PermissionSet where name =: 'State_and_National_Grantee_Member_Management'];
   permissionset p5 = [select id,name from PermissionSet where name =: 'Summer_of_Service_Grantee'];
   permissionset p6 = [select id,name from PermissionSet where name =: 'Validation_of_Reports'];
   permissionset p7 = [select id,name from PermissionSet where name =: 'View_Costshare_Invoices'];
   permissionset p8 = [select id,name from PermissionSet where name =: 'VISTA_Grantee_Member_Management'];
   permissionset p9 = [select id,name from PermissionSet where name =: 'Vista_Sponsor_Verification'];
   permissionset p10 = [select id,name from PermissionSet where name =: 'CBTest'];
 
   
    if(c.Summer_of_Service_Grantee__c == true)
    {
        PermissionSetAssignment psa = new PermissionSetAssignment();
                psa.PermissionSetId = p5.id;
                psa.AssigneeId = u.Id;
                insert psa; 
    }
     if(c.State_and_National_Grantee_Member_Manage__c == true)
    {
        PermissionSetAssignment psa1 = new PermissionSetAssignment();
                psa1.PermissionSetId = p4.id;
                psa1.AssigneeId = u.Id;
                insert psa1; 
    }

 if(c.Grantee__c == true)
    {
        PermissionSetAssignment psa2 = new PermissionSetAssignment();
                psa2.PermissionSetId = p.id;
                psa2.AssigneeId = u.Id;
                insert psa2; 
    }

 if(c.Grantee_W_O_budget__c == true)
    {
        PermissionSetAssignment psa3 = new PermissionSetAssignment();
                psa3.PermissionSetId = p1.id;
                psa3.AssigneeId = u.Id;
                insert psa3; 
    }

 if(c.Grantee_Recruitment__c == true)
    {
        PermissionSetAssignment psa4= new PermissionSetAssignment();
                psa4.PermissionSetId = p2.id;
                psa4.AssigneeId = u.Id;
                insert psa4; 
    }

 if(c.Grantee_Travel_Profile__c == true)
    {
        PermissionSetAssignment psa5 = new PermissionSetAssignment();
                psa5.PermissionSetId = p3.id;
                psa5.AssigneeId = u.Id;
                insert psa5; 
    }

 if(c.VISTA_Grantee_Member_Management__c == true)
    {
        PermissionSetAssignment psa6 = new PermissionSetAssignment();
                psa6.PermissionSetId = p8.id;
                psa6.AssigneeId = u.Id;
                insert psa6; 
    }


    if(c.Validation_of_Reports__c == true)
    {
       PermissionSetAssignment psa7 = new PermissionSetAssignment();
                psa7.PermissionSetId = p6.id;
                psa7.AssigneeId = u.Id;
                insert psa7; 
    }
    if(c.Vista_Sponsor_Verification__c == true)
    {
       PermissionSetAssignment psa8 = new PermissionSetAssignment();
                psa8.PermissionSetId = p9.id;
                psa8.AssigneeId = u.Id;
                insert psa8; 
    }
    if(c.View_Costshare_Invoices__c == true)
    {
       PermissionSetAssignment psa9 = new PermissionSetAssignment();
                psa9.PermissionSetId = p7.id;
                psa9.AssigneeId = u.Id;
                insert psa9; 
    }
    
    if(c.Grantee_With_Budget__c == true)
    {
       PermissionSetAssignment psa10 = new PermissionSetAssignment();
                psa10.PermissionSetId = p10.id;
                psa10.AssigneeId = u.Id;
                insert psa10; 
    }
  }
}