public with sharing class MultiPicklistComponentController {
    public LocationExtension Locationcreate{get;set;}
    public LocationEditExt LocationEdit{get;set;}
    public string fieldName{get;set;}
    public string fieldLabel{get;set;}   
    public list<String>  selected{get;set;}
    public list<String>  deselected{get;set;}
    public set<String> selectedSet = new set<String>();
    public set<String> deselectedSet = new set<String>();
   // public ComponentData cData {get;set;}
    //public list<SelectOption> chosenOptions{get;set;}
   
  
    public MultiPicklistComponentController(){
      
    
    } 
    public list<selectOption> options {            
        set;
        get{
            options = new list<SelectOption>();              
            Schema.SObjectType t = Schema.getGlobalDescribe().get('Location__c'); 
            Schema.DescribeSObjectResult r = t.getDescribe();
            system.debug('fieldName = '+fieldName);
            Schema.DescribeFieldResult optionFieldDescription = r.fields.getMap().get(fieldName).getDescribe();  
            fieldLabel = optionFieldDescription.getLabel();
            system.debug('label ='+fieldLabel);
        
            options.add(new Selectoption('Available','Available',true)); 
            if(deselectedSet.size()==0){
                for(Schema.PicklistEntry pleOptions : optionFieldDescription.getPicklistValues()){ 
                    deselectedSet.add(pleOptions.getLabel());  
                }                             
                //options.add(new SelectOption(pleOptions.getvalue(),pleOptions.getLabel()));                                                      
            }      
            system.debug('deselectedSet = '+deselectedSet);
            if(Locationcreate!=null || LocationEdit!=null){
                String fieldValue;
                if(Locationcreate!=null && LocationEdit!=null )
                    fieldValue = (String)Locationcreate.locationInput.get(fieldName);
                    if(LocationEdit!=null && LocationEdit!=null )
                    fieldValue = (String)LocationEdit.locationInput.get(fieldName);
                
                if(fieldValue != null && fieldValue != ''){
                     list<String> values = fieldValue.split(';');
                     for(String s: values){
                        for(string ns : deselectedSet){
                            if(s==ns){
                                deselectedSet.remove(ns);
                            }
                        }
                     }                       
                     for(string ns : deselectedSet){                            
                        options.add(new SelectOption(ns,ns));                           
                     }                   
                }
                else{            
                    for(string s : deselectedSet){
                        options.add(new SelectOption(s,s));
                    }
                }
            }            
            else{            
                for(string s : deselectedSet){
                    options.add(new SelectOption(s,s));
                }
            }           
                                  
            return options;
            }
     }
     
     public list<selectOption> selectedOptions{
         set;
         get{
            
            selectedOptions = new list<SelectOption>(); 
            selectedOptions.add(new Selectoption('Chosen','Chosen',true));
            if(Locationcreate!=null || LocationEdit!=null){
                String fieldValue;
                if(Locationcreate!=null && LocationEdit!=null)
                    fieldValue = (String)Locationcreate.locationInput.get(fieldName);     
                    if(LocationEdit!=null && LocationEdit!=null)
                    fieldValue = (String)LocationEdit.locationInput.get(fieldName);             
                if(fieldValue != null && fieldValue != ''){
                     list<String> values = fieldValue.split(';');
                     for(String s: values){
                        selectedSet.add(s);
                     }              
                } 
            }
            system.debug('selected set = '+selectedSet);
             if(selectedSet!=null){
                 for(String toSelect: selectedSet) {
                     selectedOptions.add(new SelectOption(toSelect,toSelect,false));
                 }
             }
            
             return selectedOptions;
         }
                  
     }      
    
   
    public void selecting() {   
       selected.clear();
       system.debug('deselected = '+deselected);
       system.debug('selected = '+selected);
       for(String s: deselected){
            deselectedSet.remove(s);            
            selectedSet.add(s);
        } 
       // system.debug('chosen list = '+mainController.chosenlist);
       system.debug('selected options after selecting = '+selectedOptions);
       assignOptions(selectedOptions,fieldName);      
       
        
     
    }
    
    public void assignOptions(list<selectOption> options,string fieldName){
        //ahandle.chosenList = options;
        list<String> values = new list<string>();
        for(selectOption option:options){
            if(option.getValue()!='Chosen')
                values.add(option.getValue());
        }
        String combinedString = ' ';
        for(String s: values){
           if(combinedString == ' '){
               combinedString=s + ';' ;
           }else{
               combinedString+= s + ';' ;
           }
       }            
       if(Locationcreate!=null){
            Locationcreate.locationInput.put(fieldName,combinedString); 
       }
       
       if(LocationEdit!=null){
            LocationEdit.locationInput.put(fieldName,combinedString); 
       }
       
    }
 
    public void deselecting() { 
        deselected.clear();
        system.debug('deselected when unselected = '+deselectedSet);
        system.debug('selected when unselected = '+selectedSet);
        system.debug('selected in deselect function = '+selected);
        for(String s: selected){
            selectedSet.remove(s);
            deselectedSet.add(s);
        }
        list<selectOption> options = new list<selectOption>(); 
        for(String toSelect: selectedSet) {
            options.add(new SelectOption(toSelect,toSelect,false));
        }
        assignOptions(options,fieldName);
       
        //assignOptions()

    }
}