public with sharing class ContactSearchController {

    public ContactSearchController(wrapperClassController controller) {

    }


    public String getC() {
        return null;
    }


  // the soql without the order and limit
  private String soql {get;set;}
  // the collection of contacts to display
  public List<Contact> contacts {get;set;}

  // the current sort direction. defaults to asc
  public String sortDir {
    get  { if (sortDir == null) {  sortDir = 'asc'; } return sortDir;  }
    set;
  }

  // the current field to sort by. defaults to last name
  public String sortField {
    get  { if (sortField == null) {sortField = 'lastName'; } return sortField;  }
    set;
  }

  // format the soql for display on the visualforce page
  public String debugSoql {
    get { return soql + ' order by ' + sortField + ' ' + sortDir + ' limit 20'; }
    set;
  }

  // init the controller and display some sample data when the page loads
  public ContactSearchController() {
    soql = 'select State_of_Residence__c, Status__c, Performance_rating__c, Area_of_expertise__c from contact where Name != null';
    runQuery();
  }

  // toggles the sorting of query from asc<-->desc
  public void toggleSort() {
    // simply toggle the direction
    sortDir = sortDir.equals('asc') ? 'desc' : 'asc';
    // run the query again
    runQuery();
  }

  // runs the actual query
  public void runQuery() {

    try {
      contacts = Database.query(soql + ' order by ' + sortField + ' ' + sortDir + ' limit 20');
    } catch (Exception e) {
      ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Ooops!'));
    }

  }

  // runs the search with parameters passed via Javascript
  public PageReference runSearch() {

    String State = Apexpages.currentPage().getParameters().get('State_of_Residence__c');
    String Status1 = Apexpages.currentPage().getParameters().get('Status__c');
    String Rating = Apexpages.currentPage().getParameters().get('Performance_rating__c');
    String Expertise= Apexpages.currentPage().getParameters().get('Area_of_expertise__c');

    soql = 'select State_of_Residence__c, Status__c, Performance_rating__c, Area_of_expertise__c from contact where Name != null';
    if (!State.equals(''))
      soql += ' and State_of_Residence__c includes ("+State +")';
    if (!Status1 .equals(''))
      soql += ' and Status__c includes ("+Status1+")';
    if (!Rating .equals(''))
      soql +=  'and Performance_rating__c LIKE "+String.escapeSingleQuotes(Rating )+" "%" ';  
    if (!Expertise.equals(''))
      soql += ' and Area_of_expertise__c includes ("+Expertise+")';

    // run the query again
    runQuery();

    return null;
  }

  // use apex describe to build the picklist values
  public List<String> Expertises {
    get {
      if (Expertises == null) {

        Expertises = new List<String>();
        Schema.DescribeFieldResult field = Contact.Area_of_expertise__c.getDescribe();

        for (Schema.PicklistEntry f : field.getPicklistValues())
          Expertises .add(f.getLabel());

      }
      return Expertises ;          
    }
    set;
  }

    public List<String> State1 {
    get {
      if (State1  == null) {

        State1 = new List<String>();
        Schema.DescribeFieldResult field = Contact.State_of_Residence__c.getDescribe();

        for (Schema.PicklistEntry f : field.getPicklistValues())
          State1 .add(f.getLabel());

      }
      return State1 ;          
    }
    set;
  }
  public List<String> Status2{
    get {
      if (Status2== null) {

        State1 = new List<String>();
        Schema.DescribeFieldResult field = Contact.Status__c.getDescribe();

        for (Schema.PicklistEntry f : field.getPicklistValues())
          Status2.add(f.getLabel());

      }
      return Status2;          
    }
    set;
  }
}