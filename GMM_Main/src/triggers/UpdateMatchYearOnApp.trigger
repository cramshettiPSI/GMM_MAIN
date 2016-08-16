trigger UpdateMatchYearOnApp on Project__c (after insert, after update) {
    list<Id> projIDs = new list<Id>();
    list<Application3__c> apptoUpdate = new list<Application3__c>();
    list<Project__c> projList;
    for(Project__c p:Trigger.new){
        projIDs.add(p.Id);
    }
    if(projIDs != null && !projIDs.IsEmpty()){
        projList = new list<Project__c>([Select Id,Name,Match_Year__c,(Select Id,Name,Match_Year__c from Application__r) from Project__c where ID IN:projIDs]);
    }
    if(projList!=null&& !projList.isEmpty()){
    for(Project__c pr:projList){
        if(pr.Application__r!=null && !pr.Application__r.isEmpty()){
        for(Application3__c a:pr.Application__r){
            if(a.Match_Year__c != pr.Match_Year__c){
            a.Match_Year__c = pr.Match_Year__c;
            apptoUpdate.add(a);
            }
        }
    }
  }
    update apptoUpdate;
  }
}