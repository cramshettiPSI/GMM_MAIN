@isTest
public class RoundDateValidationTest
{
    static testmethod void method1()
    {
        Program_Name__c p=new Program_Name__c();
        p.Name='test';
        p.Start_Date__c=Date.Today();
        insert p;
        
        Region__c re=new Region__c();
        re.Region_Number__c=1;
        re.Region_Assigned_States_Territories__c='GA,FL';
        re.Campus_City__c='Alexandria';
        re.Campus_State__c='VA';
        re.Region_Start_Date__c=Date.Today()+3;
        re.Program__c=p.id;
        insert re;
        
        class__c c=new class__c();
        c.Region__c =re.id;
        insert c;
        
        Round__c r=new Round__c();
        r.Round_Start_Date__c=Date.Today()+5;
        r.Transition_End_Round_Date__c=Date.Today()+10;
        r.class__c=c.id;
        insert r;
        
        Round__c r1=new Round__c();
        r1.Round_Start_Date__c=Date.Today()+11;
        r1.Transition_End_Round_Date__c=Date.Today()+13;
        r1.class__c=c.id;
        insert r1;
        
        Round__c r2=new Round__c();
        r2.Round_Start_Date__c=Date.Today()+14;
        r2.Transition_End_Round_Date__c=Date.Today()+15;
        r2.class__c=c.id;
        insert r2;
    }
}