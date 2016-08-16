Trigger FFRUpdateTrigger On Award_Reporting__c (before insert)
{

list<Award_Reporting__c> arList = [select id,Federal_Share_of_expenditures__c,Fed_Share_of_expenditures_This_Period__c ,Recipient_share_of_expenditures__c,Recipient_share_of_exp_This_Period__c from
                                      Award_Reporting__c order by createddate desc limit 1];
 Id FFRRecordTypeId = Schema.SObjectType.Award_Reporting__c.getRecordTypeInfosByName().get('Federal Financial Reports').getRecordTypeId();                                     
        for(Award_Reporting__c ar:trigger.new)
        {
        if(ar.recordtypeid == FFRRecordTypeId )
        {
        if(arlist.size()>0)
        {
        if(!arList.isEmpty()|| arList!=null)
        
        ar.Federal_Share_of_expenditures__c = arList[0].Fed_Share_of_expenditures_This_Period__c;
        ar.Recipient_share_of_expenditures__c = arList[0].Recipient_share_of_exp_This_Period__c;
        }
        }
        }


}