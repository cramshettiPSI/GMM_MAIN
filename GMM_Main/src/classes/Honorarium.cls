public with sharing class Honorarium {

    public Boolean MyAllowAdd {get; set;}
    public Boolean MyAllowEdit {get; set;}
    public Boolean MyAllowDelete {get; set;}
    public String MyObj {get; set;}
    public String MyRecId {get; set;}
    public String MyRelationField {get; set;}
    public list<String> MyFieldList {get; set;}
    public list<String> MyLabelOverrideFieldList {get; set;}
    public list<String> MyLabelOverrideTextList {get; set;}
    public list<String> MyDefaultValueFieldList {get; set;}
    public list<String> MyDefaultValueTextList {get; set;}
    public String MyBlockTitle {get; set;}
    
    
    public Honorarium(ApexPages.StandardController stdController) {
    
        MyAllowAdd = true;
        MyAllowEdit = true;
        MyAllowDelete = true;
        MyBlockTitle = 'Honorarium Information for this NOFO Group';
        MyObj = 'Honorarium_Information__c';
        MyRecId = stdController.getId();  // fill in your record Id here
        MyRelationField = 'NOFA_Group__c';
        MyFieldList = new list<String> {'Payment_Amount__c','Position__c'};
       /* MyLabelOverrideFieldList = new list<String> { 'Position__c'};
        MyLabelOverrideTextList = new list<String> {'Position__c'};
        MyDefaultValueFieldList = new list<String> {'Position__c'};
        MyDefaultValueTextList = new list<String> {'<default value>'};
   */
    }
}