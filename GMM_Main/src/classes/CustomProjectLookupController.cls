public class CustomProjectLookupController {
public Account account {get;set;} // new account to create
  public List<Project__c> results{get;set;} // search results
  public string searchString{get;set;} // search keyword

  public CustomProjectLookupController() {
    account = new Account();
    // get the current search string
    searchString = System.currentPageReference().getParameters().get('lksearch');
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
  User u = [Select Id,Name,AccountId from User where Id = :userInfo.getuserId()];
  Profile p = [Select Id,Name from Profile where Name = 'System Administrator'];
  List<Project__c> projects;
  if(UserInfo.getProfileId()!=p.Id){
  	  if(searchString != '' && searchString != null){
  	  	projects=[SELECT ID,Name,Organization__c,Project_Title__c FROM Project__c WHERE Organization__c = :u.AccountId and Name = :searchString/*CorporateProgram__r.id=:searchString OR CorporateProgram__r.id=NULL*/];  	  	 
  	  }else{
      	projects=[SELECT ID,Name,Organization__c,Project_Title__c FROM Project__c WHERE Organization__c = :u.AccountId /*CorporateProgram__r.id=:searchString OR CorporateProgram__r.id=NULL*/];
  	  }
  }else{
      projects=[SELECT ID,Name,Organization__c,Project_Title__c FROM Project__c WHERE CorporateProgram__r.id=:searchString OR CorporateProgram__r.id=NULL];
    }
    return projects; 

  

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