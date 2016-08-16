trigger addressDoctor on Project__c (before update) {
if(Project_WebseviceCallouts.isFutureUpdateOnProject == false){
for(Project__c p:trigger.new)
{
Project__c oldproject=trigger.oldmap.get(p.id);

if(oldproject.State__c!=p.State__c)
Project_WebseviceCallouts.ProjectCallOutFuture(p.id);
}

}

}