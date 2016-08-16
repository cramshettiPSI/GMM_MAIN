public with sharing class Stages1 {

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
    
    
    public Stages1(ApexPages.StandardController stdController) {
    
        MyAllowAdd = true;
        MyAllowEdit = true;
        MyAllowDelete = true;
        MyBlockTitle = 'Stages for this NOFO Group';
        MyObj = 'Stages__c';
        MyRecId = stdController.getId();  // fill in your record Id here
        MyRelationField = 'NOFA_Group__c';
        MyFieldList = new list<String> {'Id','Roles__c','Start_Date__c','End_Date__c','Type__c','Name'};
        MyLabelOverrideFieldList = new list<String> { 'Id'};
        MyLabelOverrideTextList = new list<String> { 'Stages ID'};
        MyDefaultValueFieldList = new list<String> {};
        MyDefaultValueTextList = new list<String> {};
    }
}