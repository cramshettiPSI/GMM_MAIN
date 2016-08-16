public with sharing class CreatePanelAssignments1
{
    private ApexPages.StandardController standardController;
    
 
    public CreatePanelAssignments1(ApexPages.StandardController standardController)
    {
        this.standardController = standardController;
    }
    public Application_Feedback__c appfeed1{get;set;}
    public PageReference AssignPanels()
    {
     
        // Apex code for handling record from a Detail page goes here
        Id recordId = standardController.getId();
        list<Attachment__c> attachmentsToAdd = new list<Attachment__c>();
        Paneling__c panel = [Select Id,Staff_Liasion1__c,Panel_Coordinator__c,Name,Stage_Number__c from Paneling__c where Id = :recordId];
        Stages__c stage = [Select Name, Id, Stage_Question1__c, Section_1__c, Section_2__c, Section_3__c, Section_4__c, Section_5__c, Instructions_to_Reviewers__c,(Select Id, Attachment_Id__c, Name, Description__c, Type__c, Stages__c From Attachments__r) 
                             From Stages__c  where Id = :panel.Stage_Number__c];
        //appfeed1 =[SELECT Application__c,Name,Instructions__c,Expert_Review_Panel__c,id from Application_Feedback__c where id =:stage.id];
       // Stage_Question__c stageque = [ Select Id, Name, Active__c, Allow_Comments__c, If_Yes_Comments_Required__c, Question__c, Roles__c, Scoring_Method__c, Section__c, Weight__c from Stage_Question__c where Id = :stage.Stage_Question1__c];
       //  Stage_Question__c stageque = [ Select Id, Name, Active__c, Allow_Comments__c, If_Yes_Comments_Required__c, Question__c, Roles__c, Scoring_Method__c, Section__c, Weight__c from Stage_Question__c where Id = :stage.Stage_Question1__c ];
        Set<Id> PanelMembers = new Set<Id>();
        Set<Id> PanelMembers1 = new Set<Id>();
        Set<Id> PanelApplications = new Set<Id>();
        Set<Id> PanelQuestion = new Set<Id>();
        set<Id> contactIds = new set<Id>();
        set<Id> userIds = new set<Id>();
        //Set<Id> SQ= new Set<Id>();
        if(panel.Panel_Coordinator__c!=null)
            contactIds.add(panel.Panel_Coordinator__c);
        if(panel.Staff_Liasion1__c!=null)
            contactIds.add(panel.Staff_Liasion1__c);
        
        map<Id,Id> reviewerIdtoPMId = new map<Id,Id>();
        map<Id, Id> staffReviewerIdtoPMId = new map<Id,Id>();
        map<Id,Id> PQ= new map<Id,Id>();
        List<Expert_Review_Panel__c> ExpertReviewPanels = new List<Expert_Review_Panel__c>();
        List<Application_Feedback__c> AppFeedbackList = new List<Application_Feedback__c>();
        List<Feedback_questions__c> Feedques = new List<Feedback_questions__c>();
        List<Stage_Question__c > SQ1= new List<Stage_Question__c >();
        
        /* Get a list of all of the Contacts associated with the panel */
        List<Panel_Member__c> panelMemberList = new List<Panel_Member__c>();
        List<Panel_Member__c> panelMemberList1 = new List<Panel_Member__c>();
        panelMemberList1 = [SELECT Id,Staff_Member__c FROM Panel_Member__c where Panel__c = :recordId];
        panelMemberList = [SELECT Id,Expert_Reviewer__c FROM Panel_Member__c where Panel__c = :recordId];
        for(Panel_Member__c pm: panelMemberList){
          PanelMembers.add(pm.Expert_Reviewer__c);
          reviewerIdtoPMId.put(pm.Expert_Reviewer__c,pm.Id); 
        }
         for(Panel_Member__c pm1: panelMemberList1){
          PanelMembers1.add(pm1.Staff_Member__c);
          staffReviewerIdtoPMId.put(pm1.Staff_Member__c,pm1.Id);
          
        }
        
        
        

        /* Get a list of all of the Applications associated with the panel */
        List<Panel_Application__c> panelApplicationList = new List<Panel_Application__c>();
        panelApplicationList = [SELECT Application__c FROM Panel_Application__c where Paneling__c = :recordId];
        for(Panel_Application__c pm: panelApplicationList){
          PanelApplications.add(pm.Application__c);
        }
        
        //List<Stage_Question__c > SQ1 = new List<Stage_Question__c >();
        SQ1 = [SELECT ID, Name,Active__c, If_Yes_Comments_Required__c,Question__c,Scoring_Method__c,Section__c,Weight__c FROM Stage_Question__c where Stages_ID__c = :stage.Id order by Section__c];
        /*for(Stage_Question__c sq: SQ1 ){
          PanelQuestion.add(pm1.Question__c);
          PQ.put(pm1.Question__c,pm1.Id);
        }*/
        
        /* Create an Expert Reviewer Panel Object for each Reviewer */
        for (ID PanelMembersID: PanelMembers){
            Expert_Review_Panel__c exp = new Expert_Review_Panel__c();
            if(PanelMembersID != null)
            {
            exp.Reviewer__c = PanelMembersID;
            exp.Panel__c = recordId;
            exp.Panel_Member__c = reviewerIdtoPMId.get(PanelMembersID);
            contactIds.add(exp.Reviewer__c);
            //Set the Status 
            ExpertReviewPanels.add(exp);
            }
        }
        for (ID PanelMembersID: PanelMembers1){
            Expert_Review_Panel__c exp1 = new Expert_Review_Panel__c();
            if(PanelMembersID != null)
            {
            exp1.Staff_Reviewer__c= PanelMembersID;
            exp1.Panel__c = recordId;
            exp1.Panel_Member__c = staffReviewerIdtoPMId.get(PanelMembersID);
            userIds.add(exp1.Staff_Reviewer__c);
            //Set the Status 
            ExpertReviewPanels.add(exp1);
            }
         }
        insert ExpertReviewPanels;
       /* list<Expert_Review_Panel__c> Exp1 = new list<Expert_Review_Panel__c> ([select Id, OwnerId, Reviewer__c from Expert_Review_Panel__c ]);
          
          for (Expert_Review_Panel__c ExpertPanel1: Exp1 ){
          
          ExpertPanel1.OwnerId = ExpertPanel1.Reviewer__c;
          }
        */  
        
        
        list<Contact> contacts = new list<Contact>([select Id,Name from Contact where Id in :contactIds]);
        map<Id,Contact> contactMap = new map<Id,Contact>();
        set<String> names = new set<String>();
        for(Contact c: contacts){
            contactMap.put(c.Id,c);
            names.add(c.Name);
        }
        system.debug('contact Map = '+contactMap);
       list<User> users = new list<User>([select Id,Name from User where Name in :names]);
        map<String,User> userMap = new map<String,User>();
        for(User u: users){
            userMap.put(u.Name,u);
        }
        system.debug('userMap = '+userMap);
        
        
        /* Create an Expert Reviewer Panel Object for each Reviewer */
        for (Expert_Review_Panel__c ExpertPanel: ExpertReviewPanels){
        
        
            for (ID ApplicationID: PanelApplications){
                Application_Feedback__c appFeedback = new Application_Feedback__c();
                appFeedback.Expert_Review_Panel__c = ExpertPanel.Id;
                
                appFeedback.Application__c = ApplicationID;
                 appFeedback.Instructions__c = stage.Instructions_to_Reviewers__c ;
                 appFeedback.Staff_Liasion1__c= panel.Staff_Liasion1__c;
                appFeedback.Panel_Coordinator__c = panel.Panel_Coordinator__c; 
                //Need to add the Feedback Form
                AppFeedbackList.add(appFeedback);
                    
            }  
        
        }
        
        if(AppFeedbackList.size()>0){           
            insert AppFeedbackList;
        }
        
        /*if(panel.Panel_Coordinator__c!=null){
            if(userMap.get(contactMap.get(panel.Panel_Coordinator__c).name)!=null){
                    Paneling__Share pshare = new Paneling__Share();
                    pshare.ParentId = panel.Id;
                    pshare.userorgroupId = userMap.get(contactMap.get(panel.Panel_Coordinator__c).Name).Id;
                    pshare.AccessLevel = 'Edit';
                    insert pshare; 
            }
        }
        if(panel.Staff_Liasion1__c!=null){
            if(userMap.get(contactMap.get(panel.Staff_Liasion1__c).name)!=null){
                    Paneling__Share sshare = new Paneling__Share();
                    sshare.ParentId = panel.Id;
                    sshare.userorgroupId = userMap.get(contactMap.get(panel.Staff_Liasion1__c).Name).Id;
                    sshare.AccessLevel = 'Edit';
                    insert sshare;
            }
        }
        list<Paneling__Share> panelShares = new list<Paneling__Share>();
        if(PanelMembers.size()>0){
            for(Id i: PanelMembers){                                
                if(userMap.get(contactMap.get(i).Name)!=null){
                    Paneling__Share pshare = new Paneling__Share();
                    pshare.ParentId = panel.Id;
                    pshare.userorgroupId = userMap.get(contactMap.get(i).Name).Id;
                    pshare.AccessLevel = 'Edit';   
                    panelShares.add(pshare);                                 
                }                                
            }
            if(panelShares.size()>0){
                insert panelShares;
            }
        }*/
        
       // Stage_Question__c stageque = [ Select Id, Name, Active__c, Allow_Comments__c, If_Yes_Comments_Required__c, Question__c, Roles__c, Scoring_Method__c, Section__c, Weight__c from Stage_Question__c where Id = :stage];
        
       if(AppFeedbackList.size()>0 && SQ1.size()>0){ 
           for(Application_Feedback__c AppFeedback:AppFeedbackList)
           {
                for( Stage_Question__c sq: SQ1 ) 
                {
                   Feedback_questions__c fq = new Feedback_questions__c();
                   fq.Application_Feedback__c = AppFeedback.Id;
                   fq.Stage_Question2__c = sq.Id;
                   fq.Stages_ID__c = stage.id;
                   fq.Question__c = sq.Question__c;
                   fq.Scoring_Method__c = sq.Scoring_Method__c;
                   fq.weight__c = sq.Weight__c;
                   fq.Active__c = sq.Active__c;
                   fq.Comments_Required__c = sq.If_Yes_Comments_Required__c;
                  
                 
                   if(sq.Section__c == 'Section 1')
                   {
                   fq.Name__c = stage.Section_1__c;
                   }
                   else if(sq.Section__c== 'Section 2')
                   {
                   fq.Name__c = stage.Section_2__c;
                   }
                   else if(sq.Section__c== 'Section 3')
                   {
                   fq.Name__c = stage.Section_3__c;
                   }
                   else if(sq.Section__c== 'Section 4')
                   {
                   fq.Name__c = stage.Section_4__c;
                   }
                   else
                   {
                   fq.Name__c = stage.Section_5__c;
                   }
                   
                   
                   //fq.ID= panelQuestion2;
                   Feedques.add(fq);
                
                }
           }
       }
       if(Feedques.size()>0){
          insert Feedques;
       }
        
        
        
        for(Expert_Review_Panel__c ExpertPanel: ExpertReviewPanels){
            if(stage.Attachments__r.size()>0){
                for(Attachment__c a: stage.Attachments__r){
                    Attachment__c newAttachment = new Attachment__c();
                    newAttachment.Name = a.Name;
                    newAttachment.Attachment_Id__c = a.Attachment_Id__c;
                    newAttachment.Expert_Review_Panel__c = ExpertPanel.Id;
                    newAttachment.Type__c = a.Type__c;
                    newAttachment.Description__c = a.Description__c;
                    newAttachment.RecordTypeId = Schema.SObjectType.Attachment__c.getRecordTypeInfosByName().get('Panel Attachment').getRecordTypeId();
                    attachmentsToAdd.add(newAttachment);
                }
            }
        }
        
        if(attachmentsToAdd.size()>0){
            insert attachmentsToAdd;
        }       
        PageReference pageRef = new PageReference('/'+panel.Id);
        pageRef.setRedirect(true);
       return pageRef;
    }
    
    
    
  
}