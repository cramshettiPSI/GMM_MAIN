trigger insertAttachment on Award_Reporting__c (after insert) {
	//List for Award Reporting IDs
	list<Award_Reporting__c> arList = new list<Award_Reporting__c>();
	list<Award_Reporting__c> arIURSList = new list<Award_Reporting__c>();
	list<id> arIDs = new list<id>();
	list<Id> arIURSids = new list<id>();
	Award_Reporting__c arp = new Award_Reporting__c();
	
	//Retrieving Award Reporting IDs of type Equipment Inventory
	for(Award_Reporting__c ar : Trigger.New){
		if(ar.recordtypeId == Schema.SObjectType.Award_Reporting__c.getRecordTypeInfosByName().get('Equipment Inventory').getRecordTypeId()){
		arIDS.add(ar.Id);
		}
	}
		for(Award_Reporting__c ar : Trigger.New){
		if(ar.recordtypeId == Schema.SObjectType.Award_Reporting__c.getRecordTypeInfosByName().get('Inventory of Unused or Residual Supplies').getRecordTypeId())
		arIURSids.add(ar.Id);
		}	
	if(arIDs != null && !arIDs.isEmpty()){
	arList = [Select Id, Name,(Select Id,Name from Attachments) from Award_Reporting__c where Id =: arIDs];
	}
	if(arIURSids != null && !arIURSids.isEmpty()){
    arIURSList = [Select Id,Name,(Select Id,Name from Attachments) from Award_Reporting__c where Id IN:arIURSids];
	}
	
	if(arList!=null && !arList.isEmpty()){
	list<Document> myDocument = new list<Document>([Select Body, DeveloperName from Document where DeveloperName = 'Equipment_Inventory']);
	list<Attachment__c> customAttachments = new list<Attachment__c>();
	list<Attachment> standardAttachments = new list<Attachment>();
	for(Award_Reporting__c awarRep:arList){
		Attachment__c a = new Attachment__c();
		a.Type__c = 'Equipment Inventory';
		a.Name = awarRep.Name+' - '+myDocument[0].DeveloperName+'.xlsx';
		a.Award_Reporting__c = awarRep.Id;		
		a.RecordTypeId = Schema.SObjectType.Attachment__c.getRecordTypeInfosByName().get('Award Reporting Attachment').getRecordTypeId();
		customAttachments.add(a);
		
        
	}
	map<String,Id> standardAttachmentMap = new map<String,Id>();
	
	if(customAttachments!=null && !customAttachments.isEmpty()){
		insert customAttachments;
		for(Attachment__c a: customAttachments){
			Attachment actualattachment = new Attachment();
        	actualattachment.body = myDocument[0].body;
        	actualattachment.name = a.Name; //myDocument[0].DeveloperName+'.docx'; //;
        	actualattachment.parentId = a.Id;
        	standardAttachments.add(actualattachment);
		}
		
	}
	if(standardAttachments!=null && !standardAttachments.isEmpty()){
		insert standardAttachments;		
		for(Attachment a: standardAttachments){	
			standardAttachmentMap.put(a.Name,a.Id);
		}
	}
	for(Attachment__c a: customAttachments){
		system.debug('id = '+standardAttachmentMap.get(a.Name));
		a.Attachment_Id__c = String.valueOf(standardAttachmentMap.get(a.Name));
	}
	
	update customAttachments;
  }
  if(arIURSList!=null && !arIURSList.isEmpty()){
	list<Document> myDocument1 = new list<Document>([Select Body, DeveloperName from Document where DeveloperName = 'Inventory_of_Unused_or_Residual_Supplies']);
	list<Attachment__c> customAttachments1 = new list<Attachment__c>();
	list<Attachment> standardAttachments1 = new list<Attachment>();
	for(Award_Reporting__c awarRep1:arIURSList){
		Attachment__c a1 = new Attachment__c();
		a1.Type__c = 'Inventory of Unused or Residual Supplies';
		a1.Name = awarRep1.Name+' - '+myDocument1[0].DeveloperName+'.xlsx';
		a1.Award_Reporting__c = awarRep1.Id;		
		a1.RecordTypeId = Schema.SObjectType.Attachment__c.getRecordTypeInfosByName().get('Award Reporting Attachment').getRecordTypeId();
		customAttachments1.add(a1);    
	}
	map<String,Id> standardAttachmentMap1 = new map<String,Id>();
	
	if(customAttachments1!=null && !customAttachments1.isEmpty()){
		insert customAttachments1;
		for(Attachment__c a: customAttachments1){
			Attachment actualattachment1 = new Attachment();
        	actualattachment1.body = myDocument1[0].body;
        	actualattachment1.name = a.Name; //myDocument[0].DeveloperName+'.docx'; //;
        	actualattachment1.parentId = a.Id;
        	standardAttachments1.add(actualattachment1);
		}
		
	}
	if(standardAttachments1!=null && !standardAttachments1.isEmpty()){
		insert standardAttachments1;		
		for(Attachment a: standardAttachments1){	
			standardAttachmentMap1.put(a.Name,a.Id);
		}
	}
	for(Attachment__c a: customAttachments1){
		system.debug('id = '+standardAttachmentMap1.get(a.Name));
		a.Attachment_Id__c = String.valueOf(standardAttachmentMap1.get(a.Name));
	}
	update customAttachments1;
  } 
}