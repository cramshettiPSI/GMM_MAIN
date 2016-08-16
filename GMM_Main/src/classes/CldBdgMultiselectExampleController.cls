public with sharing class CldBdgMultiselectExampleController {

    public ApexPages.StandardController stdcontroller;
    public SelectOption[] selectedContacts { get; set; }
    public SelectOption[] allContacts { get; set; }
    
    public String message { get; set; }
    
     public List<cb3__Budget_Settings__c> lstBudgetForm{get;set;}
     public NOFA__c nofa{get;set;}
     
     public Integer budgetApplicationLimit{get;set;}
    
    public CldBDgMultiselectExampleController() {
        selectedContacts = new List<SelectOption>();
        
      /*  List<Contact> contacts = [SELECT Name, Id FROM Contact];    
        allContacts = new List<SelectOption>();
        for ( Contact c : contacts ) {
            allContacts.add(new SelectOption(c.Id, c.Name));
        }
        */
        //readBudgetFormData();
     
    }
    
    public void readBudgetFormData(){
        selectedContacts = new List<SelectOption>();
        lstBudgetForm= [SELECT id,name,cb3__Title__c FROM cb3__Budget_Settings__c ORDER BY cb3__Title__c];
         allContacts = new List<SelectOption>();
        for (cb3__Budget_Settings__c objBudgetForm : lstBudgetForm) {
        if(objBudgetForm.cb3__Title__c!=null)
            allContacts.add(new SelectOption(objBudgetForm.id ,objBudgetForm.cb3__Title__c));
        }
        
    }

    public CldBDgMultiselectExampleController (ApexPages.StandardController p_controller){
        selectedContacts = new List<SelectOption>();
      this.stdcontroller= p_controller;
      this.nofa= (NOFA__c)stdController.getrecord();
      readBudgetFormData();
    }

    public PageReference save() {
        message = 'Selected Budget Forms';
        String bdgFrmIds='';
        
        Boolean first = true;
        for ( SelectOption so : selectedContacts ) {
            if (!first) {
                message += ', ';
                bdgFrmIds+=',';
            }
            message += so.getLabel() + ' (' + so.getValue() + ')';
            bdgFrmIds+=  so.getValue();
            first = false;
        }
        
        nofa.ConfiguredBudgetForms__c  =bdgFrmIds;
       // nofa.Budget_Application_Limit__c=budgetApplicationLimit;
        System.debug('***bdgFrmIds***'+bdgFrmIds);
        try{
            update nofa;
            
          //List<Database.SaveResult> resultList  = Database.update(listToUpsert, false);
        }
        catch(Exception exc){
           System.debug('Exception *** '+ exc);
           ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,exc.getMessage()));
        }
         
        
        return null;       
    }
}