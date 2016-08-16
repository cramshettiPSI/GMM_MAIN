public with sharing class CldBdgMultiSelectBdgFrmsInNofaCntrl {

    public ApexPages.StandardController stdcontroller;
    public SelectOption[] selectOptsSelectedBdgFrms { get; set; } 
    public SelectOption[] selectOptsAvailableBdgFrms{ get; set; } 
    
    public String message { get; set; }
    
     public List<cb3__Budget_Settings__c> lstBudgetForm{get;set;}
     public Map<Id,String> mpBdgFrmIdToTitle{get;set;}
     public NOFA__c nofa{get;set;}
     public Set<String> setConfiguredNofaIds{get;set;}
     public Set<String> setAvailableBudgetForms{get;set;}
     public Set<String> setSelectedBudgetForms{get;set;}
     
     public Integer budgetApplicationLimit{get;set;}
    
     public CldBdgMultiSelectBdgFrmsInNofaCntrl() {
        selectOptsSelectedBdgFrms = new List<SelectOption>();
        //readBudgetFormData();
     }
    
     public CldBdgMultiSelectBdgFrmsInNofaCntrl (ApexPages.StandardController p_controller){
        selectOptsSelectedBdgFrms = new List<SelectOption>();
        this.stdcontroller= p_controller;
        stdcontroller.addFields(new List<String>{'name','ConfiguredBudgetForms__c','Budget_Application_Limit__c','Status__c'});
        this.nofa= (NOFA__c)stdController.getrecord();
        System.debug('***nofa***'+nofa);
        readBudgetFormData();
    }
    
    public void readBudgetFormData(){
        selectOptsSelectedBdgFrms = new List<SelectOption>();
        lstBudgetForm= [SELECT id,name,cb3__Title__c FROM cb3__Budget_Settings__c ORDER BY cb3__Title__c];
        mpBdgFrmIdToTitle =new Map<Id,String>();
        
        for(cb3__Budget_Settings__c itrBdgFrm :lstBudgetForm){
            mpBdgFrmIdToTitle.put(itrBdgFrm.id,itrBdgFrm.cb3__Title__c);
        }
        
        exludeConfiguredBdgFrms(lstBudgetForm);
        
        selectOptsAvailableBdgFrms = new List<SelectOption>();
        String strBdgFrmTitle='';
        
        for (String itrStr : setAvailableBudgetForms) {
            if(mpBdgFrmIdToTitle!=null && mpBdgFrmIdToTitle.containsKey(itrStr)){
                strBdgFrmTitle=mpBdgFrmIdToTitle.get(itrStr);
                if(strBdgFrmTitle!=null && strBdgFrmTitle!='')
                    selectOptsAvailableBdgFrms.add(new SelectOption(itrStr ,strBdgFrmTitle));
            }
        }
        System.debug('***selectOptsAvailableBdgFrms***'+selectOptsAvailableBdgFrms);
        
        for (String itrStr : setSelectedBudgetForms) {
            if(mpBdgFrmIdToTitle!=null && mpBdgFrmIdToTitle.containsKey(itrStr)){
                strBdgFrmTitle=mpBdgFrmIdToTitle.get(itrStr);
                if(strBdgFrmTitle!=null && strBdgFrmTitle!='')
                    selectOptsSelectedBdgFrms.add(new SelectOption(itrStr ,strBdgFrmTitle));
            }
        }
        System.debug('***selectOptsAvailableBdgFrms***'+selectOptsAvailableBdgFrms);
        
    }
    
    public void exludeConfiguredBdgFrms(List<cb3__Budget_Settings__c> p_lstBudgetForm){
        String tmpSelectedNofaIds=nofa.ConfiguredBudgetForms__c;
        setConfiguredNofaIds=new Set<String>();
        setAvailableBudgetForms=new Set<String>();
        setSelectedBudgetForms=new Set<String>();
        
        if(nofa.ConfiguredBudgetForms__c!=null && nofa.ConfiguredBudgetForms__c!=''){
            for(String strKey : nofa.ConfiguredBudgetForms__c.split(',')){
                setConfiguredNofaIds.add(strKey);
            }
            for (cb3__Budget_Settings__c itrBudgetForm : p_lstBudgetForm) {
                if(!setConfiguredNofaIds.contains(itrBudgetForm.id) ){
                    setAvailableBudgetForms.add(itrBudgetForm.id);
                }else{
                    setSelectedBudgetForms.add(itrBudgetForm.id);
                }            
            }
        }else{
                for (cb3__Budget_Settings__c itrBudgetForm : p_lstBudgetForm) {
                        setAvailableBudgetForms.add(itrBudgetForm.id);
                }
        }
    }
    

    public PageReference save() {
        message = 'Selected Budget Forms';
        String bdgFrmIds='';
        Boolean first = true;
        
        for ( SelectOption so : selectOptsSelectedBdgFrms ) {
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
        	system.debug('nofa status = '+nofa.status__c);
        	if(nofa.Status__c=='Review in Progress'){
        		ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Budget forms cannot be edited when Nofa is in Review in Progress'));
        		return null;
        	}else if(nofa.Status__c=='Finalized'){
        		nofa.NOFA_Active_Inactive__c = false;
        		nofa.Status__c='Setup in Progress';
            	update nofa;
        	}else{
        		update nofa;
        	}
            
            
          //List<Database.SaveResult> resultList  = Database.update(listToUpsert, false);
        }
        catch(Exception exc){
           System.debug('Exception *** '+ exc);
           ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,exc.getMessage()));
        }
         return null;       
    }
}