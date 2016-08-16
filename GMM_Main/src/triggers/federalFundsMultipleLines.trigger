trigger federalFundsMultipleLines On Source_Of_Federal_Funds__c (before insert)
       {
       	list<id> AwardRepIds = new list<id>();
       	for(Source_Of_Federal_Funds__c sfr : Trigger.new){
       		AWardRepIds.add(sfr.Award_Reporting__c);
       	}
        list<Award_Reporting__c > listAwardReportingFields = new list<Award_Reporting__c >([select id, State_and_National_specific_box__c from Award_Reporting__c where id=: AWardRepIds]);
        
        if(listAwardReportingFields!=null && !listAwardReportingFields.isEmpty()){
        for(Source_Of_Federal_Funds__c sff :trigger.new)
          {
             for(Award_Reporting__c ar: listAwardReportingFields)
               {
                 if(ar.State_and_National_specific_box__c == 'No'||ar.State_and_National_specific_box__c == null)
                     	{
                     		sff.addError('User Cannot Insert');
                     	}
             	}

			}
        }
}