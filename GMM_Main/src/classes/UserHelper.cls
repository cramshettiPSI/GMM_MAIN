public without sharing class UserHelper {
	public static void shareOrganizationEditPermission(map<Id,User> oldmap, map<Id,User> newmap){
		list<Profile> p = [Select Id,Name from Profile where Name = 'Grantee Admin' or Name = 'State Commission Profile' or Name = 'Applicant'];		
		list<Id> uIds = new list<Id>();
		for(User u: newmap.values()){
			if(u.ProfileId==p[0].Id || u.ProfileId ==p[1].Id || u.ProfileId == p[2].Id){
				if(oldmap==null){
					if(u.AccountId!=null){
						uIds.add(u.Id);						
					}				
				}else{
					if(u.AccountId!=null && oldmap.get(u.Id).AccountId!=u.AccountId){
						uIds.add(u.Id);	
					}
				}
			}
		}
		if(uIds.size()>0){
			shareOrgsFuture(uIds);
		}		
		
	}
	
	@future
	public static void shareOrgsFuture(list<Id> uIds){
		list<User> users = new list<User>([Select Id,Name,AccountId from User where Id in : uIds]);
		list<AccountShare> accShares = new list<AccountShare>();
		for(User u: users){
			AccountShare accShare = new AccountShare();
		    accShare.AccountId = u.AccountId;
		    accShare.userorgroupId = u.Id;
		    accShare.AccountAccessLevel = 'Edit';
		    accShare.OpportunityAccessLevel = 'Read';
		    accShares.add(accShare);
		}
		if(accShares.size()>0){
			insert accShares;
		}
	}
}