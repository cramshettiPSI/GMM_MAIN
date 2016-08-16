public with sharing class PanelApplicationInLineEditing{

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
    
    
    public PanelApplicationInLineEditing(ApexPages.StandardController stdController) {
    
        MyAllowAdd = true;
        MyAllowEdit = true;
        MyAllowDelete = true;
        MyBlockTitle = 'Add Applications to the Panel';
        MyObj = 'Panel_Application__c';
        MyRecId = stdController.getId();  // fill in your record Id here
        MyRelationField = 'Paneling__c';
        MyFieldList = new list<String> {'Application__c','Application__r.Name'};
    }
}