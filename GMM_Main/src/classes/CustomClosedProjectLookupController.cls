/**
To display projects in a lookup which are not closed. Page CustomClosedProjectLookup
**/
public with sharing class CustomClosedProjectLookupController {

  public Project__c project {get;set;} // new account to create
  public List<Project__c> results{get;set;} // search results
  public string searchString{get;set;} // search keyword

  public CustomClosedProjectLookupController() {
    project = new Project__c();
    // get the current search string
    searchString = System.currentPageReference().getParameters().get('lksrch');
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
  private List<Project__c> performSearch(string searchString) {

    String soql = 'select  Name from Project__c';
    if(searchString != '' && searchString != null){
        soql +=  ' where Name LIKE \'%' + searchString +'%\'';
        soql += ' AND Status__c != \'Closed\'';
    }else{
        soql +=  ' where Status__C != \'Closed\'';
    }
    soql = soql + ' limit 25';
    System.debug(soql);
    return database.query(soql); 

  }

  // save the new account record
  public PageReference saveProject() {
    insert project;
    project = new Project__c();
    return null;
  }

  // used by the visualforce page to send the link to the right dom element
  public string getFormTag() {
    return System.currentPageReference().getParameters().get('frm');
  }

  // used by the visualforce page to send the link to the right dom element for the text box
  public string getTextBox() {
    return System.currentPageReference().getParameters().get('txt');
  }

}