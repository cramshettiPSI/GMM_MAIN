public with sharing class ApplicationCheck{
     
       public static map<String,Boolean> checkNarrativeFields(Application3__c app,Id nofaId){
        //map<String,Boolean> booleanMap = new map<String,Boolean>();
        boolean check = true;
        map<String,Boolean> reqNarrativeFields = new map<String,Boolean>();
        String t1 = '\'';
        String t2 = '\'';
        List<Schema.FieldSetMember> nofaNarratives = SObjectType.NOFA__c.FieldSets.Narratives.getFields();
        String query = 'SELECT ';
		
        for(Schema.FieldSetMember f : nofaNarratives) {
            System.debug('Field_Set Member'+f);
            query += f.getFieldPath() + ', ';

        }

        System.debug('Prashant_Nofa'+nofaNarratives);
        query += 'Id, Name FROM NOFA__c where id = '+t1+nofaId+t2;
        
        List<Schema.FieldSetMember> appNarratives = SObjectType.Application3__c.FieldSets.Narratives.getFields();
        map<String,String> fieldLabelMapping = new map<String,String>();
        for(Schema.FieldSetMember af : appNarratives){
            fieldLabelMapping.put(af.getFieldPath(),af.getLabel());
        }
        map<String,String> fieldMapping = new map<String,String>();
    
        
        for(Schema.FieldSetMember nf : nofaNarratives) {
            if(nf.getFieldPath() == 'Strengthening_Communities__c'){
               fieldMapping.put(nf.getFieldPath(),'Strengthen_Communities__c');
            }
            else if(nf.getFieldPath() == 'Program_Design__c'){
               fieldMapping.put(nf.getFieldPath(),'Program_Design__c'); 
            }
            else if(nf.getFieldPath() == 'Program_Management_CP__c'){
               fieldMapping.put(nf.getFieldPath(),'Program_Management__c'); 
            }
                           else{
                for(Schema.FieldSetMember af : appNarratives) {
                    String s = nf.getFieldPath();
                    Integer i = s.indexOf('_');
                    String shortForm = s.left(i);
                    System.debug('Fields_shortForm'+shortForm);
                    if(af.getFieldPath().contains(shortForm)){
                         System.debug('$$$$$$$appNarratives Fields'+af.getFieldPath());
                        fieldMapping.put(nf.getFieldPath(),af.getFieldPath());
                    }
                    
                }
            }
            
        }
        system.debug('fieldMap = '+fieldMapping);
        system.debug('app = '+app);
        NOFA__c nofa;
        try{
         	nofa = Database.query(query);              
        }
        catch(Exception e){
        	ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error,'Application is not linked to any Nofa'));
        }
        
        if(nofa!=null){        	
	       for(Schema.FieldSetMember f : nofaNarratives) {
	            if(nofa.get(f.getFieldPath()) == true){       
	                system.debug('app field value = '+app.get(fieldMapping.get(f.getFieldPath())));                       
	                if(app.get(fieldMapping.get(f.getFieldPath())) == null){
	                    check = false;
	                    system.debug('f = '+f);
	                    reqNarrativeFields.put(fieldLabelMapping.get(fieldMapping.get(f.getFieldPath())),false);
	                    //booleanMap.put(fieldMapping.get(f.getFieldPath()),false);
	                }               
	                /*else
	                    check = true;*/
	               
	            }
	        }
        }
     //   reqNarrativeFields.put('Project website URL',False);
        system.debug('check = '+check);
        For(String s:reqNarrativeFields.keyset())
        {
          System.debug('Prashant_reqNarrativeFields'+s+'$$$$$'+reqNarrativeFields.get(s));
        }       // Added by me
        return reqNarrativeFields;
        
     } 
     
     public static map<String,Boolean> checkCPNarrativeFields(Application3__c app,Id nofaId){
        
        boolean check = true;
        map<String,Boolean> reqNarrativeFields = new map<String,Boolean>();
        String t1 = '\'';
        String t2 = '\'';
        List<Schema.FieldSetMember> nofaNarratives = SObjectType.NOFA__c.FieldSets.CP_Narratives.getFields();
        String query = 'SELECT ';

        for(Schema.FieldSetMember f : nofaNarratives) {

            query += f.getFieldPath() + ', ';

        }

        query += 'Id, Name FROM NOFA__c where id = '+t1+nofaId+t2;

        NOFA__c nofa = Database.query(query);    
        
        List<Schema.FieldSetMember> appNarratives = SObjectType.Application3__c.FieldSets.Narratives.getFields();
        map<String,String> fieldLabelMapping = new map<String,String>();
        for(Schema.FieldSetMember af : appNarratives){
            fieldLabelMapping.put(af.getFieldPath(),af.getLabel());
        }
        map<String,String> fieldMapping = new map<String,String>();
        
        for(Schema.FieldSetMember nf : nofaNarratives) {
             if(nf.getFieldPath() == 'Strengthening_Communities_CP__c'){
               fieldMapping.put(nf.getFieldPath(),'Strengthen_Communities__c');
            }
            else if(nf.getFieldPath() == 'Program_Design_CP__c'){
               fieldMapping.put(nf.getFieldPath(),'Program_Design__c'); 
            }
            else if(nf.getFieldPath() == 'Program_Management_CP__c'){
               fieldMapping.put(nf.getFieldPath(),'Program_Management__c'); 
            }
            else{
                for(Schema.FieldSetMember af : appNarratives) {
                    String s = nf.getFieldPath();
                    Integer i = s.indexOf('_');
                    String shortForm = s.left(i);
                    if(af.getFieldPath().contains(shortForm)){
                        fieldMapping.put(nf.getFieldPath(),af.getFieldPath());
                    }
                }
            }
        }    
        
        for(Schema.FieldSetMember f : nofaNarratives) {
            if(nofa.get(f.getFieldPath()) == true){
                system.debug('nofa fieldName = '+f.getFieldPath());
                if(app.get(fieldMapping.get(f.getFieldPath())) == null){
                    check = false;
                    reqNarrativeFields.put(fieldLabelMapping.get(fieldMapping.get(f.getFieldPath())),false);
                }               
                /*else
                    check = true;*/
            }
        }
        
       
        system.debug('check = '+check);
        return reqNarrativeFields;
        
     } 
     
     public static map<String,Boolean> checkCPFocusAreaFields(Application3__c app,Id nofaId){
        
        boolean check = true;
        map<String,Boolean> reqFocusFields = new map<String,Boolean>();
        String t1 = '\'';
        String t2 = '\'';
        List<Schema.FieldSetMember> nofafocusFields = SObjectType.NOFA__c.FieldSets.CP_Focus_Areas.getFields();
        String query = 'SELECT ';

        for(Schema.FieldSetMember f : nofafocusFields) {

            query += f.getFieldPath() + ', ';

        }

        query += 'Id, Name FROM NOFA__c where id = '+t1+nofaId+t2;

        NOFA__c nofa = Database.query(query);    
        
        List<Schema.FieldSetMember> appFocusFields = SObjectType.Application3__c.FieldSets.Concept_Paper_Focus_Areas_Objectives.getFields();
        map<String,String> fieldLabelMapping = new map<String,String>();
        for(Schema.FieldSetMember af : appFocusFields){
            fieldLabelMapping.put(af.getFieldPath(),af.getLabel());
        }
        map<String,String> fieldMapping = new map<String,String>();
        
        for(Schema.FieldSetMember nf : nofafocusFields) {
            if(nf.getFieldPath() == 'Environmental_Stewardship_CP__c'){
               fieldMapping.put(nf.getFieldPath(),'Environment_Stewardship_CP__c');
            }
            /*else if(nf.getFieldPath() == 'Program_Design_CP__c'){
               fieldMapping.put(nf.getFieldPath(),'Program_Design__c'); 
            }
            else if(nf.getFieldPath() == 'Program_Management_CP__c'){
               fieldMapping.put(nf.getFieldPath(),'Program_Management__c'); 
            }*/
            else{
                for(Schema.FieldSetMember af : appFocusFields) {
                    String s = nf.getFieldPath();
                    Integer i = s.indexOf('_');
                    String shortForm = s.left(i);
                    if(af.getFieldPath().contains(shortForm)){
                        fieldMapping.put(nf.getFieldPath(),af.getFieldPath());
                    }
                }
            }
        }    
        
        for(Schema.FieldSetMember f : nofafocusFields) {
            if(nofa.get(f.getFieldPath()) == true){
                system.debug('nofa fieldName = '+f.getFieldPath());
                if(app.get(fieldMapping.get(f.getFieldPath())) == null){
                    check = false;
                    reqFocusFields.put(fieldLabelMapping.get(fieldMapping.get(f.getFieldPath())),false);
                }               
                /*else
                    check = true;*/
            }
        }
        
       
        system.debug('check = '+check);
        return reqFocusFields;
        
     }
     
     public static map<String,Boolean> checkAppFocusAreaFields(Application3__c app,Id nofaId){
        
        boolean check = true;
        map<String,Boolean> reqFocusFields = new map<String,Boolean>();
        String t1 = '\'';
        String t2 = '\'';
        List<Schema.FieldSetMember> nofafocusFields = SObjectType.NOFA__c.FieldSets.App_Focus_Areas.getFields();
        String query = 'SELECT ';

        for(Schema.FieldSetMember f : nofafocusFields) {

            query += f.getFieldPath() + ', ';

        }
		if(nofaId!=null){
        	query += 'Id, Name FROM NOFA__c where id = '+t1+nofaId+t2;
		}

        NOFA__c nofa = Database.query(query);    
        
        List<Schema.FieldSetMember> appFocusFields = SObjectType.Application3__c.FieldSets.App_Focus_Areas.getFields();
        map<String,String> fieldLabelMapping = new map<String,String>();
        for(Schema.FieldSetMember af : appFocusFields){
            fieldLabelMapping.put(af.getFieldPath(),af.getLabel());
        }
        map<String,String> fieldMapping = new map<String,String>();
        
        for(Schema.FieldSetMember nf : nofafocusFields) {
             /*if(nf.getFieldPath() == 'Strengthening_Communities_CP__c'){
               fieldMapping.put(nf.getFieldPath(),'Strengthen_Communities__c');
            }
            else if(nf.getFieldPath() == 'Program_Design_CP__c'){
               fieldMapping.put(nf.getFieldPath(),'Program_Design__c'); 
            }
            else if(nf.getFieldPath() == 'Program_Management_CP__c'){
               fieldMapping.put(nf.getFieldPath(),'Program_Management__c'); 
            }
            else{*/
                for(Schema.FieldSetMember af : appFocusFields) {
                    String s = nf.getFieldPath();
                    Integer i = s.indexOf('_');
                    String shortForm = s.left(i);
                    if(af.getFieldPath().contains(shortForm)){
                        fieldMapping.put(nf.getFieldPath(),af.getFieldPath());
                    }
                }
            //}
        }    
        
        for(Schema.FieldSetMember f : nofafocusFields) {
            if(nofa.get(f.getFieldPath()) == true){
                system.debug('nofa fieldName = '+f.getFieldPath());
                if(app.get(fieldMapping.get(f.getFieldPath())) == null){
                    check = false;
                    reqFocusFields.put(fieldLabelMapping.get(fieldMapping.get(f.getFieldPath())),false);
                }               
                /*else
                    check = true;*/
            }
        }
        
       
        system.debug('check = '+check);
        return reqFocusFields;
        
     }
     
     public static void attachOrgDocs(Application3__c app,String OrgDocTypes){
        list<Attachment__c> attachments = new list<Attachment__c>([Select a.View__c, a.Type__c, a.Name, a.Id, a.Description__c, a.Application__c From Attachment__c a where Application__c = :app.Id]);
        if(attachments.size()>0){
            for(Attachment__c a: attachments){
                if(OrgDocTypes.contains(a.Type__c)){
                    system.debug('Organization == '+app.Organization__c);
                    a.Account__c = app.Organization__c;
                }
            }
            system.debug('attachments = '+attachments);
            update attachments;
        }
     } 
	 public Static Void  Validate(Application3__c apps){
 		List<Application3__c> app1=new List<Application3__c>([select id,Have_funding_history_with_any_CNCS_org__c from Application3__c where id=:apps.id]);
		for(Application3__c ap:app1){
			if(ap.Have_funding_history_with_any_CNCS_org__c  == null || ap.Have_funding_history_with_any_CNCS_org__c=='') 
			{
  				ap.Have_funding_history_with_any_CNCS_org__c.addError('');
  //return false;
			}
		}
	}
}