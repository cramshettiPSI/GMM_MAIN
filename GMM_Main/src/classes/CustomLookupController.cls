public with sharing class CustomLookupController {
    
  public Application3__c app{get;set;} // new account to create
  public List<Application3__c> results{get;set;} // search results
  public string searchString{get;set;} // search keyword
  public Id parentId{get;set;}
  static public string sObjType;
  
  public CustomLookupController() {
    Application3__c app = new Application3__c ();
    // get the current search string
    searchString = System.currentPageReference().getParameters().get('lksrch');
    parentId = System.currentPageReference().getParameters().get('parentId');
    system.debug('ParentId = '+parentId);    
    runSearch();  
  }
   
  // performs the keyword search
  public PageReference search() {
    runSearch();
    return null;
  }
  
  // prepare the query and issue the search command
  private void runSearch() {
    // TODO prepare query string for complex serarches & prevent injections
    results = performSearch(searchString);               
  } 
  
  // run the search and return the records found. 
  private List<Application3__c> performSearch(string searchString) {
    
    String soql = 'select id, name '; 
    String soql1 = 'select id, name '; 
    string t1='\'';
  string t2= '\'';
  Id recTypeId = Schema.SObjectType.Application3__c.getRecordTypeInfosByName().get('Application').getRecordTypeId();
  Id recTypeId1 = Schema.SObjectType.Application3__c.getRecordTypeInfosByName().get('Concept Paper').getRecordTypeId();
  set<String> statusofApp = new Set<String>{'Submitted','Submitted to CNCS'};
  // soql1 = soql1 + ', Nofa_RFP__c, Organization__c, Grantee_Status__c, Status__c, Submitted_By__c from Application3__c where Status__c = '+t1+statusofApp+t2+' and recordTypeId1 = '+t1+recTypeId+t2;

  
    soql = soql + ', Nofa_RFP__c, Organization__c, Grantee_Status__c, Status__c, Submitted_By__c from Application3__c where (Grantee_Status__c in :statusofApp or status__c in :statusofApp) ';      
  
    if(parentId != null){
      sObjType = parentId.getsObjectType().getDescribe().getName();
      system.debug('ParentId in search = '+parentId);
      
      system.debug('got here = '+sObjType);
      /*if(sObjType == 'Nofa_Group__c'){        
          NOFA_Group__c parent = [Select Id,Fiscal_yr__c from  NOFA_Group__c where Id = :parentId];          
          soql = soql + ', NOFA_name__c,Concept_Paper_Due_Date__c,Applications_due_date__c,Fiscal_Yr__c from NOFA__c ';
          if(parent.Fiscal_Yr__c != null && parent.Fiscal_yr__c != '')
              soql = soql + ' where Fiscal_Yr__c = '+t1+parent.Fiscal_yr__c+t2;
      }*/
      if(sObjType == 'Paneling__c'){        
        
        set<Id> nofaIds = new set<Id>();
        Paneling__c parent = [Select Id, Name, Stage_Number__r.NOFA_Group__r.Id from Paneling__c where Id = :parentId];
        if(parent!=null && parent.Stage_Number__r.Nofa_Group__r.Id!=null)
        {
          NOFA_Group__c nfGrp = [Select n.Name, n.Id,Review_of__c, (Select Id, NOFA__c From NOFA_Member__r) From NOFA_Group__c n where Id = :parent.Stage_Number__r.Nofa_Group__r.Id];
          if(nfgrp != null && nfGrp.NOFA_Member__r != null)
                {
                    for(NOFA_Member__c nm: nfGrp.NOFA_Member__r)
                        {
                            nofaIds.add(nm.Nofa__c);
                        }
                }           
             system.debug('size = '+nofaIds.size());
             if(nofaIds.size()>0)
                {
                    if(nfGrp.Review_of__c == 'Applications')
                    { 
            
                        system.debug('soql = '+soql);
                        soql = soql +  ' and NOFA_RFP__c in : nofaIds and recordTypeId = '+t1+recTypeId+t2;
          //  soql1 = soql1 +  ' and NOFA_RFP__c in : nofaIds';
           
                            if(searchString != '' && searchString != null)
                                {
                                    soql = soql +  ' and name LIKE \'%' + searchString +'%\'';
                                }
                            }
                        else if(nfGrp.Review_of__c == 'Concept papers')
                            {   
                                soql = soql +  ' and NOFA_RFP__c in : nofaIds and recordTypeId = '+t1+recTypeId1+t2;                                                                
                                if(searchString != '' && searchString != null)
                                    {
                                        
                                        soql = soql +  ' and name LIKE \'%' + searchString +'%\'';
                                    }
                            } 
                }else if(nofaIds.size()==0){
            if(searchString != '' && searchString != null)
                {
                soql = soql +  ' and name LIKE \'%' + searchString +'%\'';
               }
          }
        }
      }        
    }
    if(parentId == null && (searchString != '' && searchString != null)){
      soql = soql +  ' name LIKE \'%' + searchString +'%\'';
    }
    soql = soql + ' limit 25';
    system.debug('soql = '+soql);
    System.debug(soql);
    return database.query(soql); 

  }
  
  /*// save the new account record
  public PageReference saveAccount() {
    insert account;
    // reset the account
    account = new Account();
    return null;
  }*/
  
  // used by the visualforce page to send the link to the right dom element
  public string getFormTag() {
    return System.currentPageReference().getParameters().get('frm');
  }
    
  // used by the visualforce page to send the link to the right dom element for the text box
  public string getTextBox() {
    return System.currentPageReference().getParameters().get('txt');
  }
 
}