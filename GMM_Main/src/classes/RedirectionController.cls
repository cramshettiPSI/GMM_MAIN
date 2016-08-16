public class RedirectionController
{
 Public Id caseId;
 public string contactID{get;set;}
 public string userID{get;set;}  
 public Id Cid {get;set;}
 private ApexPages.StandardController ctrl;
    public RedirectionController(ApexPages.StandardController controller) {
        Contact con= new Contact();        
        Cid = controller.getId();
        ctrl = controller;
        RedirectPage();
    }

public RedirectionController()
{

}

public PageReference RedirectPage()
{
User U = [Select ID, ContactID,Profile.Name FROM User where ID = :UserInfo.getuserID()];
userID = U.ID;
contactID = U.contactID;

contact cont= [select id,name,Organization_Name__c,recordType.Name from contact where id=:Cid];  
PageReference PgRef ;  
//if(cont.Organization_Name__c=='PSI' || cont.Organization_Name__c=='State Commission Portal' || cont.Organization_Name__c=='Serve Ohio-- Ohio Commission on Service and Volunteerism' )
if((cont.recordType.Name=='Expert Reviewer' && contactID == cont.id )|| u.Profile.Name=='System Administrator' || u.Profile.Name=='GO' )
{
PgRef = new PageReference('/apex/ExpertReviewerDetail?id='+Cid);
}

else 
{
if(cont.recordType.Name=='Expert Reviewer')
{
 ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Insufficient Privilages for this User'));
}
/*PgRef = new pageReference('/003/e?retURL=%2F003%2Fo&ent=Contact');//('/003/e?retURL=%2F003%2Fo&p3&ent=Contact&nooverride=1');
PgRef.getParameters().put('nooverride','1');
*/
//Contact theCase = (Contact) ctrl.getRecord();
  //caseId = (Id) ctrl.getRecord().get('id');
  else{
  pgref = new pageReference('/'+Cid +'?nooverride=1');
}
}
return PgRef;
}

}