public with sharing class CldBdgPrmAppMultiSelectCntrl{

    public ApexPages.StandardController stdcontroller;
    public SelectOption[] selectedBdgFrms { get; set; }
    public SelectOption[] allBdgFrms { get; set; }
    public String message { get; set; }
   
    public List<cb3__Budget_Settings__c> lstBudgetForm{get;set;}
      
    public Prime_Application__c prmApplication{get;set;}
    
    public Boolean showBdgFrm{get;set;} 
    
    public string selBudgetForm{get;set;}
    public NOFA__c nofa{get;set;}
    public String nofaId;
    
    public CldBdgPrmAppMultiSelectCntrl(){
      selectedBdgFrms = new List<SelectOption>();
    
    }
    
    public void readBudgetFormData(){
        selectedBdgFrms = new List<SelectOption>();
        lstBudgetForm= [SELECT id,name,cb3__Title__c FROM cb3__Budget_Settings__c ORDER BY cb3__Title__c];
         allBdgFrms= new List<SelectOption>();
        for (cb3__Budget_Settings__c objBudgetForm : lstBudgetForm) {
        if(objBudgetForm.cb3__Title__c!=null)
            allBdgFrms.add(new SelectOption(objBudgetForm.id ,objBudgetForm.cb3__Title__c));
        }
        
    }
    
     public CldBdgPrmAppMultiSelectCntrl(ApexPages.StandardController p_controller){
        selectedBdgFrms = new List<SelectOption>();
      this.stdcontroller= p_controller;
      this.prmApplication= (Prime_Application__c )stdController.getrecord();
      prmApplication=[select id,name,NOFO_RFP__c,Prime_Application_Configured_BudgetForms__c FROM Prime_Application__c where id= :prmApplication.id];
      if(prmApplication.NOFO_RFP__c!=null){
          nofaId=prmApplication.NOFO_RFP__c;
      //readBudgetFormData();
          retrieveSelectedBudgetFormData();
      }
    }
    
    public List<selectOption> getBudgetFormOptions(){
        List<SelectOption> budgetFormOptions = new List<SelectOption>(); 
        System.debug('***lstBudgetForm***'+lstBudgetForm);
        try{
            showBdgFrm=(lstBudgetForm==null) ? true:false;  
            if(lstBudgetForm!=null){
                for(cb3__Budget_Settings__c objBudgetForm : lstBudgetForm) {
                    if(objBudgetForm.cb3__Title__c!=null){
                        budgetFormOptions.add(new SelectOption(objBudgetForm.id ,objBudgetForm.cb3__Title__c ));                  
                    }
                }
           }
        }catch(Exception exc){  
                System.debug('error-getBudgetFormOptions'+ exc.getmessage()); 
       } 
        return budgetFormOptions;
    }
    
    public void retrieveSelectedBudgetFormData(){
    allBdgFrms= new List<SelectOption>();
      if(nofaId!=null && nofaId!=''){
          list<nofa__c> nofas =  new list<nofa__c>([select id,ConfiguredBudgetForms__c FROM NOFA__c WHERE id = :nofaId]);
          System.debug('***nofa***'+nofa);
          if(nofas!=null && nofas.size()>0){
              String strBdgFrmsid=nofas[0].ConfiguredBudgetForms__c ;
              List<String> lstBdgFrmIds=new List<String>();
              if(strBdgFrmsid!=null){
                  lstBdgFrmIds =strBdgFrmsid.split(',');
                   System.debug('***lstBdgFrmIds ***'+lstBdgFrmIds );
      
                  lstBudgetForm= [SELECT id,name,cb3__Title__c FROM cb3__Budget_Settings__c where id in :lstBdgFrmIds ORDER BY cb3__Title__c  ]; 
                   System.debug('***lstBudgetForm***'+lstBudgetForm);
                   for (cb3__Budget_Settings__c objBudgetForm : lstBudgetForm) {
                        if(objBudgetForm.cb3__Title__c!=null)
                            allBdgFrms.add(new SelectOption(objBudgetForm.id ,objBudgetForm.cb3__Title__c));
                        } 
                  }
          
          }
     }
        
    }
     public PageReference save() {
        message = 'Selected Budget Forms';
        String bdgFrmIds='';
        
        Boolean first = true;
        for ( SelectOption so : selectedBdgFrms ) {
            if (!first) {
                message += ', ';
                bdgFrmIds+=',';
            }
            message += so.getLabel() + ' (' + so.getValue() + ')';
            bdgFrmIds+=  so.getValue();
            first = false;
        }
        
  
        prmApplication.Prime_Application_Configured_BudgetForms__c =  bdgFrmIds;
        
        try{
            update prmApplication;
        }
        catch(Exception exc){
           System.debug('CldBdgPrmAppMultiSelectCntrl -Exception *** '+ exc);
        }
       
          //List<Database.SaveResult> resultList  = Database.update(listToUpsert, false);
          return null;       
    }
    
    
    
    




}