@istest
public class  FFRUpdateTriggertest
{

 static testMethod void testmethod1()
{
 Award__c testawd = UtilityClass.createAward();

 Insert testawd;
 
 Award_Reporting__c ar = new Award_Reporting__c();
 
 id FFRRecordTypeId = Schema.SObjectType.Award_Reporting__c.getRecordTypeInfosByName().get('Federal Financial Reports').getRecordTypeId();                                     
 ar.RecordTypeid = FFRRecordTypeId;
 insert ar;
 
 Award_Reporting__c awardrep = new Award_Reporting__c();
 
 id FFRRecordTypeId1 = Schema.SObjectType.Award_Reporting__c.getRecordTypeInfosByName().get('Federal Financial Reports').getRecordTypeId();                                     
 awardrep.RecordTypeid = FFRRecordTypeId1;
 insert awardrep;
 
 }
 }