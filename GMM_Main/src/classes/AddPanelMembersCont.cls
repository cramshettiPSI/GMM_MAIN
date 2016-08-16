public class AddPanelMembersCont {
    
    public string qryStr{get;set;}
    public List<contactWrapper> wrappedContacts {get; set;}
    public Contact con{get;set;}
    public decimal rating{get;set;}
    public decimal Experience{get;set;}
    public set<Id> contactIdsfromPool = new set<Id>();
    public list<Contact> lContacts{get;set;} 
    public string debugsoql{get;set;}
    public Paneling__c panel;
    
    public AddPanelMembersCont() {
        
        list<Reviewer_Pool__c> poolMembers = new list<Reviewer_Pool__c>();
        //String panelId = ApexPages.currentPage.getParameters.get('id');
        
        if(ApexPages.currentPage().getParameters().get('id')!=null)
            panel = [Select Id,Name,Stage_Number__c,Stage_Number__r.NOFA_Group__c,NOFA_Group_Name__c from Paneling__c where Id = :ApexPages.currentPage().getParameters().get('id')];
            
        if(panel!=null)         
            poolMembers = new list<Reviewer_Pool__c>([Select Id,Expert_Reviewer_Name__c from Reviewer_Pool__c where Status__c = 'Available' and (NOFA_Group__c = :panel.Stage_Number__r.NOFA_Group__c or NOFA_Group__c = :panel.NOFA_Group_Name__c)]);
        
        if(poolMembers.size()>0){   
            for(Reviewer_Pool__c r: poolMembers){
                contactIdsfromPool.add(r.Expert_Reviewer_Name__c);
            }
        }
        con = new Contact();
        
    }
    
    public List<contactWrapper> getContacts() {
        lContacts = new list<Contact>([Select Id,Name,Email,Area_of_Expertise__c,Highest__c,Expert_Reviewer_Performance_Rating__c,Performance_Rating__c,State_of_Residence__c,Status__c,Years_of_Experience__c from Contact where Id in :contactIdsfromPool]);
        
        if(wrappedContacts == null) {
            wrappedContacts = new List<contactWrapper>();  
            for(Contact c: lContacts){
                wrappedContacts.add(new contactWrapper(c));
            }                     
        }
        return wrappedContacts;

    }

    public void runSearch(){
        system.debug('in search');
        string soql;
        /*string area = Apexpages.currentPage().getParameters().get('area');
        string education = Apexpages.currentPage().getParameters().get('education');
        string status = Apexpages.currentPage().getParameters().get('status');
        string residence = Apexpages.currentPage().getParameters().get('residence');
        String  rating1= Apexpages.currentPage().getParameters().get('rating');
        String  Experience1= Apexpages.currentPage().getParameters().get('Experience');
        
        system.debug('rating parameter = '+Apexpages.currentPage().getParameters().get('rating'));
        system.debug('area = '+area);
        system.debug('education = '+education);
        system.debug('status = '+status);
        system.debug('residence = '+residence);   
        system.debug('Experience parameter = '+Apexpages.currentPage().getParameters().get('Experience'));*/
        
        
                    
        string rating1 = '';
        if(con.Expert_Reviewer_Performance_Rating__c != null)
            rating1 = string.valueOf(con.Expert_Reviewer_Performance_Rating__c);
            
                         
        string Experience1 = '';
        if(con.Years_of_Experience__c!= null)
            Experience1 = string.valueOf(con.Years_of_Experience__c);   
                
        string education = '';
        if(con.Highest__c != null)
            education = con.Highest__c;
            
        string residence = '';        
        if(con.State_of_Residence__c != null)
            residence = con.State_of_Residence__c;
            
        string area = '';
        if(con.Area_of_Expertise__c != null)
            area = con.Area_of_Expertise__c;
            
        system.debug('Experience 1  = '+Experience1);
        system.debug('rating 1 = '+rating1);
        if(rating1 !='' && rating1 != null) {
            rating  = decimal.Valueof(rating1);
        }
        else{
            rating = 0;
        }
        System.debug('test::'+rating);
        
      
      if(Experience1 != '' && Experience1!= null) {
            Experience = decimal.Valueof(Experience1);
        }
        else{
            Experience = 0;
        }
          System.debug('test::'+Experience);    
      
        string t1='\'';
        string t2= '\'';
        
       
        
       
         if((area =='' || area == null) && (education =='' || education == null) && (residence =='' || residence == null) /*&& (status =='' || status == null)*/ && rating < 1 && Experience <1)
        {
             soql = 'select Id,Name,firstname,lastname,Email,Area_of_Expertise__c,Highest__c,Expert_Reviewer_Performance_Rating__c,State_of_Residence__c,Status__c,Years_of_Experience__c from contact where Id in :contactIdsfromPool ';     
        }
        else
        {
            soql = 'select Id,name,firstname,lastname,Email,Area_of_Expertise__c,Highest__c,Expert_Reviewer_Performance_Rating__c,State_of_Residence__c,Status__c,Years_of_Experience__c from contact where Id in :contactIdsfromPool and lastname!=null '  ;
            if (!area.equals(''))
                soql += ' AND Area_of_Expertise__c = '+t1+area+t2;
        
            if (!education.equals(''))
                soql += 'AND  Highest__c = '+t1+education+t2;
      
     
            if (!residence.equals(''))
                soql += ' AND State_of_Residence__c = '+t1+residence+t2;
                
      
            /*if (!status.equals(''))
                soql += ' AND Status__c = '+t1+status+t2;*/
            if(rating <1) {
                soql+='';
            }
            else {
                soql += ' AND Expert_Reviewer_Performance_Rating__c= '+rating;
            }
            
            if(Experience <1) {
                soql+='';
            }
            else {
                soql += ' AND Years_of_Experience__c= '+Experience;
            }
       
           system.debug('**************************************query'+soql);
            debugsoql = soql;
           
           
            //return wrappedContacts;
            
        
        }    
        
        if(lContacts.size()>0)
                lContacts.clear();
        lContacts = new list<Contact>();
        lContacts = database.query(soql);
            
        if(wrappedContacts.size()==0) {
            wrappedContacts = new List<contactWrapper>();  
            for(Contact c: lContacts){
                wrappedContacts.add(new contactWrapper(c));
            }                     
        }
        else if(wrappedContacts.size()>0){
            wrappedContacts.clear();
            wrappedContacts = new List<contactWrapper>();  
            for(Contact c: lContacts){
                wrappedContacts.add(new contactWrapper(c));
            }               
        }   
                
    }
    
    public class contactWrapper{
        public Contact con{get;set;}        
        public Boolean isSelected{get;set;}     
        
        public contactWrapper(Contact c) {
            con = c;
            isSelected = false;

        }
    }           
    
    public PageReference savePanelMembers(){
        list<Panel_Member__c> newpanelMembers = new list<Panel_Member__c>();
        set<Id> selectedContactIds = new set<Id>();
        for(ContactWrapper c: wrappedContacts){
            if(c.isSelected){
                selectedContactIds.add(c.con.Id);
            }
        }
        map<String,Panel_Member__c> existingMembersMap = new map<String,Panel_Member__c>();
        list<Panel_Member__c> existingPanelMembers = new list<Panel_Member__c>([Select Id,Expert_Reviewer__c,Panel__c from Panel_Member__c where Expert_Reviewer__c in :selectedContactIds]);
        for(Panel_Member__c pm: existingPanelMembers){
            existingMembersMap.put(String.valueOf(pm.Expert_Reviewer__c)+String.valueOf(pm.Panel__c),pm);
        }
        
        if(selectedContactIds.size()>0){
            for(Id i: selectedContactIds){
                String key = String.valueOf(i)+String.valueOf(panel.Id);
                system.debug('key = '+key);
                system.debug('map = '+existingMembersMap);
                if(existingMembersMap.get(key) == null){
                    Panel_Member__c pm = new Panel_Member__c();
                    pm.Expert_Reviewer__c = i;
                    pm.Panel__c = ApexPages.currentPage().getParameters().get('id');
                    pm.Status__c = 'Active';
                    // pm.Reviewer__c = 
                    newpanelMembers.add(pm);
                }
            }
        }
        
        if(newpanelMembers.size()>0){
            insert newpanelMembers;
        }
        PageReference pg = new PageReference('/'+ApexPages.currentPage().getParameters().get('id'));
        return pg;
    }
    
    public PageReference cancel(){
        PageReference pg = new PageReference('/'+ApexPages.currentPage().getParameters().get('id'));
        return pg;
    }

}