public with sharing class AddAttachmentsController{

     public Nofa__c nofa{get;set;}
     public Application3__c app{get;set;}
     public Stages__c stage{get;set;}
     public Attachment__c attachment{get;set;} 
     public String fileName {get;set;}
     public Blob fileBody {get;set;}     
     public sObject sobj{get;set;} 
     public String fieldName{get;set;}
     static public string sObjType;
     public Id rId; 
     public boolean isrendered{get;set;}
     public boolean isAvailable{get;set;}
     public string selectedValue{get;set;}
     public boolean isrendered2{get;set;}
     static public Map<String, Schema.RecordTypeInfo> mapRTName = Schema.SObjectType.Attachment__c.getRecordTypeInfosByName();
   
     public AddAttachmentsController(ApexPages.StandardController controller) {
        attachment = new Attachment__c();       
        isrendered = true;
        isrendered2 = true;
        isAvailable = false;
        system.debug('params = '+ApexPages.currentPage().getParameters());
        
        Map<String, Field_Ids__c> fieldIdsMap = Field_Ids__c.getAll();
        system.debug('map = '+fieldIdsMap);
        fieldName = 'Name';
        
        for(Field_Ids__c fId: fieldIdsMap.values()){
            String s = fId.Id__c;
            system.debug('s = '+s);
            system.debug('param = '+ApexPages.currentPage().getParameters().get(s));
            if(s!=null){
                if(ApexPages.currentPage().getParameters().get(s)!=null)
                 rId = ApexPages.currentPage().getParameters().get(s);        
            }       
        }                
            
        system.debug('rId = '+rId);
        if(rId!=null){
            sObjType = rId.getsObjectType().getDescribe().getName();
            String t1 = '\'';
            String t2 = '\'';
            String qry = 'Select Id,Name from '+sObjType+' where id = '+t1+rId+t2;
            sobj = Database.query(qry);         
            if(sObjType == 'Application3__c'){
                app = [Select Id,NOFA_RFP__c,NOFA_RFP__r.Required__c,NOFA_RFP__r.Organization_Docs__c,NOFA_RFP__r.Optional__c,RecordTypeId,Project__r.Organization__c,Status__c,Grantee_Status__c from Application3__c where Id = :sobj.Id];
                if(app.RecordTypeId == Schema.SObjectType.Application3__c.getRecordTypeInfosByName().get('Application').getRecordTypeId())
                	isRendered =  false;                    
            }     
            system.debug('record Type Info '+Schema.SObjectType.Attachment__c.getRecordTypeInfosByName());             
           
            
            if(sObjType == 'Nofa__c'){              
                attachment.RecordTypeId = Schema.SObjectType.Attachment__c.getRecordTypeInfosByName().get('Nofa Attachment').getRecordTypeId();
            }
            if(sObjType == 'Application3__c'){                  
                attachment.RecordTypeId = Schema.SObjectType.Attachment__c.getRecordTypeInfosByName().get('Application Attachment').getRecordTypeId();
            }
            if(sObjType == 'Stages__c'){                
                attachment.RecordTypeId = Schema.SObjectType.Attachment__c.getRecordTypeInfosByName().get('Stage Attachment').getRecordTypeId();
            }
            if(sObjType == 'Award__c'){             
                attachment.RecordTypeId = Schema.SObjectType.Attachment__c.getRecordTypeInfosByName().get('Award Attachment').getRecordTypeId();
            }
            if(sObjType == 'Award_Reporting__c'){               
                attachment.RecordTypeId = Schema.SObjectType.Attachment__c.getRecordTypeInfosByName().get('Award Reporting Attachment').getRecordTypeId();
                isrendered2 = false;
            }
            if(sObjType == 'Account'){              
                attachment.RecordTypeId = Schema.SObjectType.Attachment__c.getRecordTypeInfosByName().get('Account Attachment').getRecordTypeId();
                isAvailable = true;
            }
            if(sObjType == 'Monitoring_Activity__c'){               
                attachment.RecordTypeId = Schema.SObjectType.Attachment__c.getRecordTypeInfosByName().get('Monitoring Activity').getRecordTypeId();
            }
             if(sObjType == 'Contact'){             
                attachment.RecordTypeId = Schema.SObjectType.Attachment__c.getRecordTypeInfosByName().get('Contact Attachment').getRecordTypeId();
            }
             if(sObjType == 'Grant_Close_Out__c'){             
                attachment.RecordTypeId = Schema.SObjectType.Attachment__c.getRecordTypeInfosByName().get('Grant Close Out Attachment').getRecordTypeId();
            }
            
        }
        
     }
        
        public list<selectOption> Options{
            set;
            get{
                options = new list<SelectOption>(); 
                options.add(new Selectoption('--None--','--None--'));
                list<String> allTypes = new list<String>();
                if(app!=null){
                     if(app.NOFA_RFP__r.required__c!=null){
                        list<String> tmpvalues = app.NOFA_RFP__r.required__c.split(';');
                        allTypes.addall(tmpvalues);
                     }
                     if(app.NOFA_RFP__r.Organization_Docs__c!=null){    
                        list<String> tmpvalues1 = app.NOFA_RFP__r.Organization_Docs__c.split(';');
                        allTypes.addall(tmpvalues1);       
                     }              
                     if(app.NOFA_RFP__r.Optional__c!=null){
                        list<String> tmpvalues2 = app.NOFA_RFP__r.Optional__c.split(';');
                        allTypes.addall(tmpvalues2);
                     }                      
                     
                }
                for(String s: allTypes){
                    options.add(new Selectoption(s,s,false));
                }
                return options;
            }
        }
        
       

        
    // creates a new Attachment__c record
    private Database.SaveResult saveCustomAttachment() {
        
        sObjType = rId.getsObjectType().getDescribe().getName();        
               
        if(sObjType == 'Account'){
            attachment.Account__c = sobj.Id;       
            Account acc = [Select Id,Organization_Type__c,O__c from Account where Id = :sobj.Id];
            if((acc.Organization_Type__c != null && acc.Organization_Type__c != '') && (acc.Organization_Type__c == 'National Non-Profit' || acc.Organization_Type__c == 'Community' || acc.Organization_Type__c == 'Faith-Based')){
            		if(attachment.Type__c == null || attachment.Type__c == '' || attachment.Type__c != 'Non Profit Status File'){            			
            			ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'File Type can only be "Non Profit Status File"'));
                		return null;
            		}            	
            } 
            if((acc.O__c != null && acc.O__c != '') && (acc.O__c.contains('National Non-Profit (Multi-State)') || acc.O__c.contains('Community') || acc.O__c.contains('Faith-Based'))){
            		if(attachment.Type__c == null || attachment.Type__c == '' || attachment.Type__c != 'Non Profit Status File'){            			
            			ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'File Type can only be "Non Profit Status File"'));
                		return null;
            		}            	
            }      
        }
        if(sObjType == 'Contact'){
            attachment.Contact__c = sobj.Id;             
        }
        
        if(sObjType == 'Application3__c'){
            attachment.Application__c = sobj.Id;   
            if(app!= null && app.RecordTypeId == Schema.SObjectType.Application3__c.getRecordTypeInfosByName().get('Application').getRecordTypeId()){              
            	attachment.Type__c = selectedValue;            
            }
        }
         if(sObjType == 'Grant_Close_Out__c'){
            attachment.Grant_Close_Out_Name__c = sobj.Id;                 
        }
        
        if(sobjType != 'Application3__c' && sobjType != 'Account' && sobjType != 'Contact' && sobjType != 'Grant_Close_Out__c'){
            attachment.put(sObjType,sobj.Id);
        }
        
                 
        system.debug('sObj = '+sObj.Id);
        system.debug('attachment = '+attachment);   
        return Database.insert(attachment);
    }
    
   
    
    // create an actual Attachment record with the Attachment__c as parent
    private Database.SaveResult saveStandardAttachment(Id parentId) {
        Database.SaveResult result;
        
        Attachment actualattachment = new Attachment();
        actualattachment.body = this.fileBody;
        actualattachment.name = this.fileName;
        actualattachment.parentId = parentId;
        // inser the attahcment
        result = Database.insert(actualattachment);
        
        fileBody = Blob.valueOf(' ');
        return result;
    }
    
  
    public PageReference processUpload() {
        try {
        	
        	Id conceptPaperRT = Schema.SObjectType.Application3__c.getRecordTypeInfosByName().get('Concept Paper').getRecordTypeId();        	
        	sObjType = rId.getsObjectType().getDescribe().getName(); 
        	if(sObjType == 'Application3__c' && app!= null && (app.Status__c == 'Submitted' || app.Grantee_Status__c == 'Submitted'
        														|| app.Status__c == 'Accepted' || app.Grantee_Status__c == 'Accepted'
        														|| app.Status__c == 'Submitted to CNCS' || app.Grantee_Status__c == 'Submitted to CNCS')){
        		ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 
                  'Attachment cannot be uploaded when Concept Paper is in Submitted Status.'));            
                return null;
        		
        	}
        	
            Database.SaveResult customAttachmentResult = saveCustomAttachment();
            
            if (customAttachmentResult == null || !customAttachmentResult.isSuccess()) {
                ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 
                  'Could not save attachment.'));
                return null;
            }
        
            Database.SaveResult attachmentResult = saveStandardAttachment(customAttachmentResult.getId());
        
            if (attachmentResult == null || !attachmentResult.isSuccess()) {
                ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 
                  'Could not save attachment.'));            
                return null;
            } else {
                // update the custom attachment record with some attachment info
                Attachment__c customAttachment = [select id from Attachment__c where id = :customAttachmentResult.getId()];
                customAttachment.name = this.fileName;
                customAttachment.Attachment_Id__c = attachmentResult.getId();
                Attachment stdAttachment = [Select Id,BodyLength  from Attachment where id = :attachmentResult.getId()];
                if(stdAttachment.bodyLength>1048576){
                	Integer size = stdAttachment.bodyLength/1048576;
                	customAttachment.size__c = string.valueOf(size)+ ' MB';
                }else if(stdAttachment.bodylength<=1048576){
                	Integer size2 = stdAttachment.bodyLength/1024;
                	customAttachment.size__c = string.valueOf(size2)+ ' KB';
                }
               // customAttachment.size__c = stdAttachment.BodyLength; 
                update customAttachment;
            }
        
        } catch (Exception e) {
            ApexPages.AddMessages(e);
            return null;
        }
        
        return new PageReference('/'+rId);
        //return null;
    }
    
    public PageReference back() {
        if(rId!=null)
            return new PageReference('/'+rId);
        return null;
        
    }     
 
    
    

}