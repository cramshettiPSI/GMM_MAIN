public class searchOrganizationcls{
    public Account actobj{get;set;}
    public List<Account> accountList{get;set;}
    public integer actcount{get;set;}
    public String MyAccountId {get; set;}   
    public string userId = ApexPages.currentPage().getParameters().get('uid');
    public string userName = ApexPages.currentPage().getParameters().get('uname');
    public string password = ApexPages.currentPage().getParameters().get('password');
    //Added Code by Sravan on 12/19/2015 - Start
    //retrieveing Profile Grantee Admin
    profile pf = new profile();
    list<profile> pfList = [Select Id, Name from profile where name = 'Grantee Admin'];
    //Added Code by Sravan on 12/19/2015 - End
    public searchOrganizationcls(){
        //Added Code by Sravan on 12/19/2015 - Start
        if(pfList != null && !pfList.isEmpty()){
            pf = pfList[0];
        }
        //Added Code by Sravan on 12/19/2015 - End
        accountList = new List<Account>();
        actobj = new Account();
        actcount = 0;
    }
    
    //Added by Sravan on 12/16/2015 - Start
    //Varibale for Accounts Map
    map<Id,Account> accountMap = new map<Id,Account>();
    
    public void searchOrganization(){
        String query ='select id,Name,EIN__c,Legal_Name__c,First_Name__c,Address_1__c,City__c,state__c, (Select Id from Contacts) from Account where id!=null';
        system.debug('###query##' +query);   
        if((actObj.EIN__c!=null && actObj.EIN__c!='')||(actobj.Name != null && actobj.Name !='')){
        //   query+=' and (EIN__c=\''+actObj.EIN__c+'\'';
            
           query+=' and (EIN__c LIKE \'%'+actObj.EIN__c+'%\'';

           //   query+=' OR  Name = \''+actobj.Name+'\')';
         query+=' OR  Name LIKE \'%'+actobj.Name+'%\')';
                 
            accountList=database.query(query);
            if(accountList.size()==0){
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Info, 'EIN does not exist in system. Please create a new organization'));
            }
                       
            //Added Code by Sravan on 12/16/2015 - Start
            else{
                accountMap = new map<Id,Account>();
                for(Account a : accountList){
                    accountMap.put(a.Id,a);
                }
            }
            //Added Code by Sravan on 12/16/2015 - End
            actcount = accountList.size();
            
        }
        else{
            actcount = 0;
              
        }
        System.debug(query);
    
    }
   
    public pagereference choose(){
        //Added Code by Sravan on 12/16/2015 - Start
        PageReference pr;
        IF(MyAccountId != NULL){
            try{
            Contact newContact =[Select id,AccountId,RecordTypeId,FirstNAme,LastName,Email from Contact where Id =:userId limit 1];
            newContact.AccountId = MyAccountId;         
                                    
            if(accountMap != null && accountMap.get(MyAccountId) != null){
                if(accountMap.get(MyAccountId).Contacts.size() > 0){
                    newContact.RecordTypeId = Schema.SObjectType.Contact.getRecordTypeInfosByName().get('Grantee').getRecordTypeId();
                }else{
                    newContact.RecordTypeId = Schema.SObjectType.Contact.getRecordTypeInfosByName().get('Grantee Admin').getRecordTypeId();
                                        
                    User u = new User(ProfileId = pf.Id);
                    u.Username = ApexPages.currentPage().getParameters().get('uname');
                    u.Email = newContact.Email;
                    u.FirstName = newContact.FirstName;
                    u.LastName = newContact.LastName;
                    u.Contactid=newContact.Id;
                    u.CommunityNickname = newContact.FirstName+''+newContact.LastName;
                    u.Alias = (newContact.FirstName+''+newContact.LastName).substring(0,1);
                    u.EmailEncodingKey = 'ISO-8859-1';
                    u.LanguageLocaleKey = 'en_US';
                    u.LocaleSidKey = 'en_US';
                    u.TimeZoneSidKey = 'America/New_York';
                    insert u;
                }
            }
            
            update newContact;
            pr = new pagereference('/apex/communitiesSelfRegConfirmPageOrg');
            }catch(exception e){
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'======'+e));
            }
        }
        //Added Code by Sravan on 12/16/2015 - End
        
        //Commented by Sravan on 12/16/2015 - Start
        /*Contact newContact =[Select id,AccountId from Contact where Id =:userId limit 1];
        newContact.AccountId = MyAccountId;
        update newContact;*/
        //Commented by Sravan on 12/16/2015 - End
        return pr;
    }

    public pagereference registration(){    
        return null;
    }
    
    public pagereference createOrganization(){
        system.Debug('userId-------'+userId);
        return new Pagereference('/apex/Createorganization?uid='+userId+'&uname='+userName+'&password='+password+'&profile='+pf.Id);
    }
    
    public pagereference cancel(){    
        return new Pagereference('/apex/Login_Page');
    }
    
}