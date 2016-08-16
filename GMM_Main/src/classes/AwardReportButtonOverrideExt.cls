public class AwardReportButtonOverrideExt {


   public string Profileid{get;set;}
    public string userID{get;set;}
  public boolean check{get;set;}
      
  
    public AwardReportButtonOverrideExt(ApexPages.StandardController stdCtrl)
    {
    check= false;
     
     Profile p = [Select Name from Profile where ID =: userinfo.getProfileid()];
   
     String pname = p.name;
     
     if(pname == 'Applicant' || pname == 'Grantee Admin' ) {
     check= true;

      
     }
}

public pagereference redirect()
{
if(!check)
{
 PageReference acctPage = new pagereference('/a1l/e?retURL=%2Fa1l%2Fo&nooverride=1');
        acctPage.setRedirect(true);

        return acctPage;
        }
        else
       {
       PageReference acctPage = new pagereference('/apex/NewButtonOverrideonAwardReporting');
        acctPage.setRedirect(true);

        return null;
       } 
}
    }