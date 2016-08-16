public with sharing class CopyHeldFormulaApps {
    
    public String competetiveid;
    public string nofaId;
    //public string selectedPrimeAppId{get;set;}
    public List<cPrimeApplication> primeAppList {get; set;}
    
    public CopyHeldFormulaApps(ApexPages.StandardController controller){
        competetiveid=ApexPages.currentPage().getParameters().get('id');
        nofaId = ApexPages.currentPage().getParameters().get('nofaId');
    }
    
    public list<cPrimeApplication> getprimeAppsFormula(){
        if(primeAppList==null){
            primeAppList = new list<cPrimeApplication>();
            for(Prime_Application__c p: [Select Id,Name,Prime_Application_Id_w_link__c,NOFO_RFP__c,Project_Name__c,CNCS_Status__c,Competitive_or_Formula__c,NOFO_Name__c from Prime_Application__c 
                                                                                    where Competitive_or_Formula__c = 'Formula' and NOFO_RFP__c = :nofaId]){
                primeAppList.add(new cPrimeApplication(p));
            }                       
        }
        return primeAppList;        
    } 
    
    public PageReference copy(){ 
        List<Prime_Application__c> selectedPrimeApp = new List<Prime_Application__c>();
        for(cPrimeApplication cPc: getprimeAppsFormula()) {
            if(cPc.selected == true) {
                selectedPrimeApp.add(cPc.pc);
            }
        }
        if(selectedPrimeApp.size()>1){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.error,'Please Select only one Prime Application'));
            return null;
        }else if(selectedPrimeApp.size()==1){
            list<Application3__c> subApps = new list<Application3__c>([Select Id, Name, Application_ID__c From Application3__c where Prime_Application__c = :competetiveid and (Grantee_Status__c = 'Held for Formula' or Status__c = 'Held for Formula')]);
            if(subApps.size()>0){
                for(Application3__c a: subApps){
                    a.Prime_Application__c = selectedPrimeApp[0].Id;
                    //a.Status__c = 'In Progress';
                    //a.Grantee_Status__c  = 'In Progress';
                }
                update subApps;
            }
            PageReference pg = new PageReference('/apex/PrimeApplicationDetail?id='+selectedPrimeApp[0].Id);
            pg.setRedirect(true);
            return pg;
        }else if(selectedPrimeApp.size()==0){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.error,'Please Select one Prime Application'));
            return null;
        }
        
        return null;
        
    }
    
    public PageReference cancel(){
        PageReference pg = new PageReference('/apex/PrimeApplicationDetail?id='+competetiveid);
        pg.setRedirect(true);
        return pg;
    }
    
    public class cPrimeApplication {
        public Prime_Application__c pc {get; set;}
        public Boolean selected {get; set;}

        public cPrimeApplication(Prime_Application__c p) {
            pc = p;
            selected = false;
        }

    }
    

}