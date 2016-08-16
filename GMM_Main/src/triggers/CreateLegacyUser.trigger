trigger CreateLegacyUser on Contact (after insert) {
	
	//list<Id> CIds = new list<Id>();
	list<Contact> newContacts = new list<Contact>();
	for(Contact con : trigger.new){
		If(con.Dataloader_input__c==true){
			newContacts.add(con);
		}
	}
	Id RecordTypeId = Schema.SObjectType.Contact.getRecordTypeInfosByName().get('Grantee Admin').getRecordTypeId();
	//[Select Id, RecordTypeId,FirstName,LastName,Email,CommunityAuto__c,Name from Contact WHERE ID IN : CIds]);
	//list<User> user = new list<User>([Select Id, Name from User where contactId IN : CIds]);
	list<User> insertUser = new list<User>();
	//User u = new User();
	list<Profile> p = new list<Profile>([Select Id, Name from Profile where Name = 'Applicant']);
	list<Profile> p1 = new list<Profile>([Select Id, Name from Profile where Name = 'Grantee Admin']);
	list<Profile> p2 = new list<Profile>([Select Id, Name from Profile where Name = 'Expert Reviewers']);
	if(newContacts!=null && !newContacts.isEmpty()){
	for(Contact c : newContacts){
		    User u = new User();
			if(c.recordtypeId == Schema.SObjectType.Contact.getRecordTypeInfosByName().get('Grantee Admin').getRecordTypeId()){
				u.ProfileId = p1[0].Id;
			}
			if(c.recordtypeId == Schema.SObjectType.Contact.getRecordTypeInfosByName().get('Grantee').getRecordTypeId()){
				u.ProfileId = p[0].Id;
			}
			if(c.recordtypeId == Schema.SObjectType.Contact.getRecordTypeInfosByName().get('Expert Reviewer').getRecordTypeId()){
				u.ProfileId = p2[0].Id;
			}
			    u.FirstName=c.FirstName;
                u.LastName=c.LastName;
                u.Alias = (c.FirstName+''+c.LastName).substring(0,1);
                //u.profileId=p[0].Id;
                u.Email=c.Email;
                u.Username=c.Email+'.grantee';
                u.ContactId=c.Id;
                u.CommunityNickname = c.FirstName+''+c.LastName+''+c.CommunityAuto__c;
                u.EmailEncodingKey = 'ISO-8859-1';
                u.LanguageLocaleKey = 'en_US';
                u.LocaleSidKey = 'en_US';
                u.TimeZoneSidKey = 'America/New_York';
                insertUser.add(u);
		}	
	}	
		if(insertUser!=null && !insertUser.isEmpty()){
           insert insertUser;
		}
}