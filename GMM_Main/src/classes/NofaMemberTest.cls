public with sharing class NofaMemberTest{

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
    
    
    public NofaMemberTest(ApexPages.StandardController stdController) {
    
        MyAllowAdd = true;
        MyAllowEdit = true;
        MyAllowDelete = true;
        MyBlockTitle = 'NOFOs for the NOFO Group';
        MyObj = 'NOFA_Member__c';
        MyRecId = stdController.getId();  // fill in your record Id here
        MyRelationField = 'NOFA_Group__c';
        MyFieldList = new list<String> {'NOFA__c','NOFA__r.Name','NOFA_name__c'};
       // MyLabelOverrideFieldList = new list<String> {'NOFA__c'};
       // MyLabelOverrideTextList = new list<String> {'NOFA__c'};
       // MyDefaultValueFieldList = new list<String> {'NOFA__c'};
       // MyDefaultValueTextList = new list<String> {'NOFA__c'};
    }
}