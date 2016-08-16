trigger CreateCNCSCorporateProgram on CNCS_Corporate_Program__c  (after insert, after update,after delete) 
{
Set<Product2> parents = new Set<Product2>();
    Set<Id> setOppId=new Set<Id>();
    map<id,id> mapDelete = new map<id,id>();
    Set<Id> setOppDelete=new Set<Id>();
    map<Id,Id> childRtToparentRT = new map<Id,Id>();
    set<String> programCodes = new set<String>();
    set<String> corpprogramCodes = new set<String>();
    set<String> childprogramCodes = new set<String>();
    map<String,Product2> parentProg = new map<String,Product2>(); 
    set<Id> set1 = new set<Id>();
    set<Id> set2 = new set<Id>();   
    map<String,Id> ProgramProducts = new map<String,Id>();
    map<Id,String> newMap = new map<Id,String>();  
    static public Map<String, Schema.RecordTypeInfo> parentRT = 
                                            Schema.SObjectType.Product2.getRecordTypeInfosByName();
    static public Map<String, Schema.RecordTypeInfo> childRT = 
                                            Schema.SObjectType.CNCS_Corporate_Program__c.getRecordTypeInfosByName();
    for(String pRT: parentRT.keyset()){
        for(String cRT: childRT.keyset()){          
            if(pRT == cRT){             
                childRTtoParentRT.put(childRT.get(cRT).getRecordTypeId(),parentRT.get(pRT).getRecordTypeId());
            }
        }
    } 
    
    system.debug('childRTtoParentRT= '+childRTtoParentRT);      
    if(trigger.isAfter && (trigger.isInsert || trigger.isUpdate))
    {
        for (CNCS_Corporate_Program__c child : trigger.new) {
            //if(child.name!= null && child.name!= '' && (child.RecordTypeId == '012r00000004J91' || child.RecordTypeId == '012r00000004J8r' || child.RecordTypeId == '012r00000004J8w')) {
                
            if(child.name!= null && child.name!= '' && (childRTtoParentRT.containsKey(child.RecordTypeId))) {
            system.debug('got here in if cond');
                
                if(child.Code_CNCS__c!=null && child.Code_CNCS__c != '' )               
                    programCodes.add(child.Code_CNCS__c);
                if(child.Code_Corporate__c!=null && child.Code_Corporate__c != '')
                    corpprogramCodes.add(child.Code_Corporate__c);
                if(child.Code_Child__c!=null && child.Code_Child__c != '')
                    childprogramCodes.add(child.Code_Child__c);
                if(child.CNCS_Program_Name__c!=null){
                    set1.add(child.CNCS_Program_Name__c);
                }
                if(child.CNCS_Child_Program_Name__c!=null){
                    set2.add(child.CNCS_Child_Program_Name__c);
                }                   
            }
        }
        list<Product2> parentsProd = new list<Product2>();      
        if(programCodes!=null && programcodes.size()>0){
            //system.debug('got here 1');
            parentsProd = [Select p.Title__c, p.Street_Address_Line_2__c, p.Street_Address_Line_1__c, p.Start_Date__c, p.Short_Code__c, p.RecordTypeId, p.Name, p.Id, p.Family, p.End_Date__c, 
                    p.Director_ID__c, p.Corporate_Program_ID__c, p.Code_Corporate__c, p.Code_Child__c, p.Code_CNCS__c, p.CNCS_Program_Name__c, p.CNCS_Program_Name_1__c, p.CNCS_Program_Code__c,
                    p.CNCS_Corporate_Program_Name__c, p.CNCS_Corporate_Program_Name_1__c,p.CNCS_Corporate_Program_Code__c From Product2 p where Code_CNCS__c in :programCodes];
                    
        }
        if(corpprogramCodes!=null && corpprogramCodes.size()>0){
            //system.debug('got here 2');
             parentsProd = [Select p.Title__c, p.Street_Address_Line_2__c, p.Street_Address_Line_1__c, p.Start_Date__c, p.Short_Code__c, p.RecordTypeId, p.Name, p.Id, p.Family, p.End_Date__c, 
                    p.Director_ID__c, p.Corporate_Program_ID__c, p.Code_Corporate__c, p.Code_Child__c, p.Code_CNCS__c, p.CNCS_Program_Name__c, p.CNCS_Program_Name_1__c, p.CNCS_Program_Code__c,
                    p.CNCS_Corporate_Program_Name__c, p.CNCS_Corporate_Program_Name_1__c, p.CNCS_Corporate_Program_Code__c From Product2 p where Code_Corporate__c in :corpprogramCodes];
                    
        }
        if(childprogramCodes!=null && childprogramCodes.size()>0){
            //system.debug('got here 3');
             parentsProd = [Select p.Title__c, p.Street_Address_Line_2__c, p.Street_Address_Line_1__c, p.Start_Date__c, p.Short_Code__c, p.RecordTypeId, p.Name, p.Id, p.Family, p.End_Date__c, 
                    p.Director_ID__c, p.Corporate_Program_ID__c, p.Code_Corporate__c, p.Code_Child__c, p.Code_CNCS__c, p.CNCS_Program_Name__c, p.CNCS_Program_Name_1__c, p.CNCS_Program_Code__c,
                    p.CNCS_Corporate_Program_Name__c, p.CNCS_Corporate_Program_Name_1__c, p.CNCS_Corporate_Program_Code__c From Product2 p where Code_Child__c in :childprogramCodes];
        }            
        list<CNCS_Corporate_Program__c> lcorpProgram = new list<CNCS_Corporate_Program__c>();
        set<String> cnames = new set<String>();
        lcorpProgram = [Select Id,Name from CNCS_Corporate_Program__c where Id in :set1 or Id in :set2];
        for(CNCS_Corporate_Program__c cp: lcorpProgram ){
            cNames.add(cp.Name);
            newMap.put(cp.Id,cp.Name);
        }
        list<Product2> lscorpProgram = new list<Product2>([select Id,Name from Product2 where Name in :cNames]);
        for(Product2 p: lscorpProgram){
            ProgramProducts.put(p.Name,p.Id);
        }
        
        
        //system.debug('parentsProd = '+parentsProd);
        for(Product2 p: parentsProd){
            system.debug(p.Code_CNCS__c);
            system.debug(p.Code_Corporate__c);
            system.debug(p.Code_Child__c);
            if(p.Code_CNCS__c!=null)
                parentProg.put(p.Code_CNCS__c,p);
            if(p.Code_Corporate__c!=null)
                parentProg.put(p.Code_Corporate__c,p);
            if(p.Code_Child__c!=null)
                parentProg.put(p.Code_Child__c,p);      
        }           
        //system.debug('parentProg = '+parentProg);
        for (CNCS_Corporate_Program__c child : trigger.new) {
            if(child.name!= null && child.name!= '' &&  childRTtoParentRT.containsKey(child.RecordTypeId)) {                       
                if(parentProg.get(child.Code_CNCS__c)==null && parentProg.get(child.Code_Corporate__c)==null && parentProg.get(child.Code_Child__c)==null){
                    /*system.debug('got here 4');
                    system.debug('1'+parentProg.get(child.Code_CNCS__c));
                    system.debug('2'+parentProg.get(child.Code_Corporate__c));
                    system.debug('3'+parentProg.get(child.Code_Child__c));*/                    
                    parents.add(new Product2(
                        /*Id = child.Corporate_Programs__c,*/
                        Code_CNCS__c= child.Code_CNCS__c,
                        Code_Corporate__c=child.Code_Corporate__c,
                        Code_Child__c=child.Code_Child__c,
                        Description__c=child.Description__c,
                        Short_Code__c=child.Short_Code__c,
                        End_Date__c=child.End_Date__c,
                        Start_Date__c=child.Start_Date__c,
                       Street_Address_Line_1__c =child.Street_Address_Line1__c,
                        Street_Address_Line_2__c=child.Street_Address_Line_2__c,
                        CNCS_Program_Name_1__c = ProgramProducts.get(newMap.get(child.CNCS_Program_Name__c)),
                        CNCS_Child_Program_Name__c = ProgramProducts.get(newMap.get(child.CNCS_Child_Program_Name__c)),
                        Name=child.Name,
                        Corporate_Program_Id__c =child.Id,
                        RecordTypeId = childRTtoParentRT.get(child.RecordTypeId)
                        )
                        );
                }else{
                    Product2 tmpProd;
                    if(parentProg.get(child.Code_CNCS__c)!=null){
                        tmpProd = parentProg.get(child.Code_CNCS__c);
                    }else if(parentProg.get(child.Code_Corporate__c)!=null){
                        tmpProd = parentProg.get(child.Code_Corporate__c);
                    }else if(parentProg.get(child.Code_Child__c)!=null){
                        tmpProd = parentProg.get(child.Code_Child__c);
                    }
                    tmpProd.Code_CNCS__c= child.Code_CNCS__c;
                    tmpProd.Code_Corporate__c=child.Code_Corporate__c;
                    tmpProd.Code_Child__c=child.Code_Child__c;
                    tmpProd.Description__c=child.Description__c;
                    tmpProd.End_Date__c=child.End_Date__c;
                    tmpProd.Start_Date__c=child.Start_Date__c;
                    tmpProd.Street_Address_Line_1__c =child.Street_Address_Line1__c;
                    tmpProd.Street_Address_Line_2__c=child.Street_Address_Line_2__c;                    
                    tmpProd.Corporate_Program_Id__c =child.Id; 
                    tmpProd.Short_Code__c=child.Short_Code__c; 
                    parents.add(tmpProd);               
                }
            }
       }

    if(!parents.isEmpty()){
        List<Product2> toUpdate = new List<Product2>();
        toUpdate.addAll(parents);
        upsert toUpdate;
    }
    } 
    if(Trigger.isDelete)
        {
            for(CNCS_Corporate_Program__c ada:Trigger.old)
            {
            mapDelete.put(ada.Corporate_Programs__c,ada.id);
            setOppId.add(ada.Corporate_Programs__c);
            setOppDelete.add(ada.id);
            }
            
            delete [SELECT Id, Name,Corporate_Program_Id__c FROM Product2 where Corporate_Program_Id__c  IN :setOppDelete]; 
        }
        
        
}