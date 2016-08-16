public class CNCSCorporateProgramRecortType
{

    public CNCSCorporateProgramRecortType(ApexPages.StandardController controller) {

    }

 Public CNCS_Corporate_Program__c cncscorp {get;set;}
public Id Cid {get;set;}
public string rec {get;set;}
public string keyPrefix {get;set;}
    public CNCSCorporateProgramRecortType() {
       CNCS_Corporate_Program__c cncscorp = new CNCS_Corporate_Program__c(); 
     
 //cncscorp = (CNCS_Corporate_Program__c)controller.getRecord();       
       }
       public pagereference RedirectPage(){
       PageReference PgRef ;  
       rec = [select id,DeveloperName from RecordType where sobjecttype='CNCS_Corporate_Program__c' and name = 'Program'].id;
   
   Schema.DescribeSObjectResult r = CNCS_Corporate_Program__c.sObjectType.getDescribe();
String keyPrefix = r.getKeyPrefix();
System.debug('@@@@@@@'+keyPrefix);

pgref = new pageReference('/'+keyPrefix+'/e'+'?nooverride=1');
   return PgRef;
   
    }


}