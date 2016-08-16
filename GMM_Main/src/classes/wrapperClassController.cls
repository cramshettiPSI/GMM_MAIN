public class wrapperClassController {

    public wrapperClassController(ContactSearchController controller) {

    }


    public String Expertises { get; set; }

    public String Status2 { get; set; }

    public String getState1() {
        return null;
    }  

 public String con { get; set; }
    public String contacts { get; set; }

    public String Expertise { get; set; }

    public String Status1 { get; set; }

    public String State { get; set; }

    
private String soql {get;set;}
  // the collection of contacts to display
  public List<Contact> contact1 {get;set;}

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
      contact1 = Database.query(soql + ' order by ' + sortField + ' ' + sortDir + ' limit 20');
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

    soql = 'select State_of_Residence__c, Status__c, Performance_rating__c, Area_of_expertise__c from contact where First_Name__c != null';
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

    

   

    //Our collection of the class/wrapper objects cContact
    public List<cContact> contactList {get; set;}
    //This method uses a simple SOQL query to return a List of Contacts
    public List<cContact> getContact() {
        if(contactList == null) {
            contactList = new List<cContact>();
            for(Contact c: [select Name, State_of_Residence__c, Status__c, Performance_Rating__c, Area_of_Expertise__c from Contact ]) {
                // As each contact is processed we create a new cContact object and add it to the contactList
                contactList.add(new cContact(c));
            }
        }
        return contactList;
    }
    public PageReference processSelected() {
                //We create a new list of Contacts that we be populated only with Contacts if they are selected
        List<Contact> selectedContact = new List<Contact>();
        //We will cycle through our list of cContacts and will check to see if the selected property is set to true, if it is we add the Contact to the selectedContacts list
        for(cContact cCon: getContact()) {
            if(cCon.selected == true) {
                selectedContact.add(cCon.con);
            }
        }
        // Now we have our list of selected contacts and can perform any type of logic we want, sending emails, updating a field on the Contact, etc
        System.debug('These are the selected Contacts...');
        for(Contact con: selectedContact) {
            system.debug(con);
        }
        contactList=null; // we need this line if we performed a write operation  because getContacts gets a fresh list now
        return null;
    }
    // This is our wrapper/container class. A container class is a class, a data structure, or an abstract data type whose instances are collections of other objects. In this example a wrapper class contains both the standard salesforce object Contact and a Boolean value
    public class cContact {
        public Contact con {get; set;}
        public Boolean selected {get; set;}
        //This is the contructor method. When we create a new cContact object we pass a Contact that is set to the con property. We also set the selected value to false
        public cContact(Contact c) {
            con = c;
            selected = False;
        }
    }
    
}