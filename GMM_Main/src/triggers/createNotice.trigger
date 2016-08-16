trigger createNotice on Opportunity (after update) {

integer i = 0;

List<Notice__c> notices = new List<Notice__c>();
List<Appendix_I__c> appenddices = new List<Appendix_I__c>();

  for (Opportunity opp : Trigger.new) {
    // Access the "old" record by its ID in Trigger.oldMap
    Opportunity oldOpp = Trigger.oldMap.get(opp.Id);

    // Trigger.new records are the "new" versions!
    String oldState = oldOpp.StageName;
    String newState = opp.StageName;
    
    // Run this code if the opportunity stage changes
    if (oldState != newState) {
        

        //Here we create 3 notices, you will want to dynamically create the correct number of parent object based on reviewers
        Notice__c notice1 = new Notice__c ();
       notices.add(notice1); 
       Notice__c notice2 = new Notice__c ();
       notices.add(notice2); 
       Notice__c notice3 = new Notice__c ();
       notices.add(notice3); 
       //now do an insert - though hopefully you would have more error checking than this!
       insert notices;
       
       
       //Now loop through the parent object
       for(Notice__c a : notices){
       
            //For each parent, create 2 children
            Appendix_I__c appendix1 = new Appendix_I__c();
            //since you have done your insert, you already have the SFDC ID
            appendix1.Notice_ID__c = a.Id;
            appenddices.add(appendix1);
            //Repeat for the second one
            Appendix_I__c appendix2 = new Appendix_I__c();
            appendix2.Notice_ID__c = a.Id;
            appenddices.add(appendix2);         
        }
        
        //Now insert the child record
        insert appenddices;
    }
  }
}