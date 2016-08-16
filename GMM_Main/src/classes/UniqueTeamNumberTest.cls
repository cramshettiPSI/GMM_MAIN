@isTest
private class UniqueTeamNumberTest 
{

    static testMethod void method1()
    {
    Unit__c u = new unit__c();
    u.Unit_Name__c = 'testname';
    u.Effective_Date__c = system.today();
    insert u;
     
    team__c t = new team__c();
   // t.TeamName__c = 'testname 2';   
    t.Unit__c = u.id;
    t.Team_Number__c = '2';
    t.Effective_Date__c = system.today();
    insert t;
    
     team__c t1 = new team__c();
   // t1.TeamName__c = 'testname 1';  
    t1.Unit__c = u.id;
    t1.Team_Number__c = '1';
    t1.Effective_Date__c = system.today();
    
    try
    {

    insert t1;
   
    }
    catch(exception e)
    {
    
    }
   
    }
    }