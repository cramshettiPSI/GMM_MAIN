@isTest
private class UniqueRoundNumbertest 
{

    static testMethod void method1()
    {
    Program_Name__c p = new Program_Name__c();
    p.Start_Date__c = system.today()-99;
    p.name = 'test';
 
    insert p; 
    
    Region__c re = new Region__c();
    re.Region_Number__c = 3;
    re.Region_Assigned_States_Territories__c = 'AE';
    re.Campus_City__c = 'asd';
    re.Campus_State__c= 'AK';
    re.Region_Start_Date__c = system.today()-100;
    re.Region_End_Date__c = system.today()+15;
    re.Program__c= p.id;
    insert re;

   
    Class__c c = new Class__c();
    c.Class_Number__c = '3';
    c.Team_Leader_Arrival__c = system.today()-20;
    c.Corps_Member_Arrival__c = system.today()-10;
    c.Member_Induction__c = system.today()+20;
    c.Graduation__c = system.today()+30;
    c.Team_Leader_Departure__c = system.today()+40;
    c.Slots__c = 3;
    c.Region__c =re.id;
        
    insert c;
     
    Round__c r = new Round__c();
    r.Class__c = c.id;   
    r.Round_Number__c = '4';
    r.Round_Start_Date__c = system.today()+21;
    r.Round_End_Date__c = system.today()+22;
    r.Transition_Start_Round_Dates__c = system.today()+23;
    r.Transition_End_Round_Date__c = system.today()+24;

    insert r;
    
    Round__c r1 = new Round__c();
    r1.Class__c = c.id;   
    r1.Round_Number__c = '2';
    r1.Round_Start_Date__c = system.today()+25;
    r1.Round_End_Date__c = system.today()+26;
    r1.Transition_Start_Round_Dates__c = system.today()+27;
    r1.Transition_End_Round_Date__c = system.today()+28;

    insert r1;
    
    try
    {

    insert r;
   
    }
    catch(exception e)
    {
    
    }
   
    }
    }