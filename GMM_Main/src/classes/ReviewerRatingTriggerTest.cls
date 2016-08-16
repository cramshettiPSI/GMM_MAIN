@isTest
public class ReviewerRatingTriggerTest
{
    static testmethod void method1()
    {
        Contact c=new Contact(lastname='Test');            //Insert Contact here
        insert c;
        History__c h=new History__c(Job_Description__c='Test',User_Account__c=c.id);    //Insert History Records
        History__c h1=new History__c(Job_Description__c='Test',User_Account__c=c.id);
        
        List<Reviewer_Rating__c> revList=new List<Reviewer_Rating__c>();
        Reviewer_Rating__c r=new Reviewer_Rating__c(Role__c = 'Panel Co-Ordinator',Performance_Rating__c=20,Reviewer_Name__c=c.id);
        revList.add(r);
        Reviewer_Rating__c r1=new Reviewer_Rating__c(Role__c = 'Panel Co-Ordinator',Performance_Rating__c=20,Reviewer_Name__c=c.id);
        revList.add(r1);
        Reviewer_Rating__c r2=new Reviewer_Rating__c(Role__c = 'Expert Reviewer',Performance_Rating__c=20,Reviewer_Name__c=c.id);
        revList.add(r2);
        Reviewer_Rating__c r3=new Reviewer_Rating__c(Role__c = 'Expert Reviewer',Performance_Rating__c=20,Reviewer_Name__c=c.id);
        revList.add(r3);
        
        insert revList;
        
        Reviewer_Rating__c r5=new Reviewer_Rating__c(Role__c = 'Panel Co-Ordinator',Performance_Rating__c=20,Reviewer_Name__c=c.id);
        insert r5;
        Reviewer_Rating__c r6=new Reviewer_Rating__c(Role__c = 'Expert Reviewer',Performance_Rating__c=20,Reviewer_Name__c=c.id);
        insert r6;
    }
}