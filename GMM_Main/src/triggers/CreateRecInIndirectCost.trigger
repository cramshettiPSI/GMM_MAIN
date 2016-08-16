trigger CreateRecInIndirectCost on Account (after insert) { 
 List <In_direct__c> ImpToInsert = new List <In_direct__c> ();

 for (Account A : Trigger.new) 
 {
 In_direct__c rec = new In_direct__c();
       rec.Organization_Name__c= A.id;
       rec.Do_you_have_an_Indirect_Cost_Rate__c = A.Do_you_have_anIndirect_Cost_Rate__c;
        rec.Rate_Type__c=A.Rate_Type__c;
        rec.State__c =A.State__c;
        rec.Effective_From__c=A.Effective_From__c;
        rec.Effective_To__c=A.Effective_To__c;
        rec.Issuing_Agency__c=A.Issuing_Agency__c;
       rec.Descriptions__c=A.Descriptions__c;
        rec.Extended__c=A.Extended__c;
        rec.Rate_Status__c=A.Rate_Status__c;
        rec.Rate_Percent__c=A.R_Percent__c;
       rec.Rate_Base__c=A.Rate_Base__c;
       rec.Treatment_of_FringeBenefits__c=A.Treatment_of_FringeBenefits__c ; 
        ImpToInsert.add(rec);
 }
   insert ImpToInsert;
/*database.saveResult[] sr = database.insert(impToInsert,false);  

 for(integer x=0;x<sr.size();x++)
 {
    if(sr[x].isSuccess() == false)
      system.debug(logginglevel.error,sr[x].getErrors()[0].getMessage());
 }*/
}