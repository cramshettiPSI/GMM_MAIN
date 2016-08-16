public with sharing class RLController {    
    
    public String aFields {get; set;}
    public String aObjType {get; set;}
    public String arecId {get; set;}
    public String arecordType{get; set;}
    public String arelationfield{get; set;}
    public list<ObjectWrapper> objWrapperList{get;set;}
    public list<ColumnWrapper> ColumnWrapList {get;set;}   
    public string pbTitle{get;set;}  
    public String ActionId {get; set;}
    public boolean isRendered{get;set;}
    public String selectedstatus{get;set;} 
   

    public RLController() {
        isrendered = false;                     
    }
    
    public List<SelectOption> options{
		set;
		get{
			Schema.DescribeFieldResult statuses = Application3__c.Status__c.getDescribe();

   		    List<Schema.PicklistEntry> statuslist = statuses.getPicklistValues();

   		    List<SelectOption> options = new List<SelectOption>();
   		    options.add(new Selectoption('','--None--'));
   			for(Schema.PicklistEntry c:statuslist)
   		    {
    		 options.add(new SelectOption(c.getValue(),c.getValue())); 
		    }
			return options;
		}
    }
      public list<ColumnWrapper> ColumnList {
        get {
            if (ColumnWrapList == null) {              
                String tmpStr = aFields;
                String[] aFieldsList= tmpStr.split(',');                  
                ColumnWrapList = LoadColumnList(aObjType, aFieldsList);                              
            }
            return ColumnWrapList;
        }
        set;
    }
    
    public list<ObjectWrapper> getobjList() {
        
        //get{        	        	
        	
            if(objWrapperList == null){              
            	objWrapperList = new list<ObjectWrapper>();        	             	
                objWrapperList = LoadObjectList(aRecId,aObjType,aRecordType,aFields,arelationfield);
            }       
            /*if(objWrapperList!=null){
            	return objWrapperList;
            }else{
            	objList.clear();
            	return null;
            }*/
            return objWrapperList;
        //}
        //set; 
    }
    
    public void run(){   
    	    if(objWrapperList.size()==0) {	            
	            objWrapperList = new list<ObjectWrapper>(); 	
    			objWrapperList = LoadObjectList(aRecId,aObjType,aRecordType,aFields,arelationfield); 	 
    			/*for(ObjectWrapper o: objWrapperList){
    				objList.add(o);
    			}*/                               
        	}
	        else if(objWrapperList.size()>0){	        	
	            objWrapperList.clear();
	            objWrapperList = new List<ObjectWrapper>();  
	            objWrapperList = LoadObjectList(aRecId,aObjType,aRecordType,aFields,arelationfield);
	            /*for(ObjectWrapper o: objWrapperList){
    				objList.add(o);
    			}*/                
	        }    	        	    	
    }
    
    public list<ObjectWrapper> LoadObjectList(String recId, String objType, String recordTypeName,String lfields,String relationfield){
    	system.debug('****');
        list<ObjectWrapper> TmpObjList = new list<ObjectWrapper>();                 
        tmpobjList.clear();
        String t1 = '\'';
        String t2 = '\'';
        String qry = 'Select Id,';
        qry += lfields;
        qry += '  from '+objType+' where '+relationfield+ ' = '+t1+recId+t2;
        if(recordTypeName!=null){
            Id recordTypeId = getrecordTypeId(objType,recordTypeName);
            qry += ' AND recordTypeId = '+t1+recordTypeId+t2;
        }
        if(selectedstatus!=null){
        	qry += ' AND (Status__c = '+t1+selectedstatus+t2 +' OR Grantee_Status__c = '+t1+selectedStatus+t2+ ')';
        }
        system.debug('qry = '+qry);
        list<sObject> objs = Database.query(qry);
        //if(objs.size()>0){
	        for(sObject obj: objs){
	        	system.debug('obj  = '+obj);
	        	//if(obj.get('Status__c')==selectedstatus){
	             TmpObjList.add(new objectWrapper(obj));
	        	//}
	        } 
	        return TmpObjList;
        /*}else{
        	return null;
        }                               
               
        return null;*/
    } 
    
      public static list<ColumnWrapper> LoadColumnList(String objType, list<String> fieldslist) {
         
        list<ColumnWrapper> TmpColumnList = new list<ColumnWrapper>();
        
        map<String, Schema.sObjectField> FieldMap = Schema.getGlobalDescribe().get(objType).getDescribe().fields.getMap();
        
        for (String s : fieldslist) {
            Schema.sObjectField FieldObj;
            Schema.DescribeFieldResult DescField;
            String TmpLabel;                                 
            TmpLabel = s;

            // fields of the object retrieve label and permissions, related object fields do not
            FieldObj = FieldMap.get(s);
            if (FieldObj != null) {
                DescField = FieldObj.getDescribe();
                if (DescField != null) {
                    if (DescField.isAccessible() == false) {
                        system.debug('Field: ' + s + ' is not accessable for the user. Field ignored.');
                        continue;
                    }                    
                    TmpLabel = FieldObj.getDescribe().getLabel();                    
                }
            }           
            
                
            TmpColumnList.add(new ColumnWrapper(s, TmpLabel));
        }
        return TmpColumnList;
    }
    
  
    
     public pageReference edit(){                          
        PageReference pg = new PageReference('/apex/ApplicationEditpage?id='+ActionId);
        pg.setRedirect(true);
        return pg;
        
     }
     
     /* public pageReference del(){    
        system.debug('actionId = '+actionId);
        try{
            database.delete(ActionId);
        }
        catch(Exception e){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error, e.getMessage()));
        }
        
        return null;
        
     }*/
   
    
    
    
    
    public Id getrecordTypeId(String objType,String recordTypeName){
        map<String, Schema.RecordTypeInfo> rt_map = Schema.getGlobalDescribe().get(ObjType).getDescribe().getRecordTypeInfosByName();
        Schema.Recordtypeinfo rtInfo = rt_map.get(recordTypeName);
        Id desiredRTId = rtInfo.getRecordTypeId();      
        return desiredRTId;
    }
    
    public class ColumnWrapper { 
        public String FieldName {get; set;}
        public String FieldLabel {get; set;}        
        
        public ColumnWrapper(String FieldName, String FieldLabel) {
            this.FieldName = FieldName; 
            this.FieldLabel = FieldLabel;            
        }
    }
    
    
    public class ObjectWrapper { 
        public sObject obj {get; set;}
        public Id objId{get;set;}
        
        public ObjectWrapper(sObject obj) {
            this.obj = obj;           
            this.objId = obj.Id;
        }
    }

}