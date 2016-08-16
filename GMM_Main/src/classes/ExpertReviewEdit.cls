public  class ExpertReviewEdit{

    /*public ExpertReviewEdit() {

    }*/

    public List<Panel_Member__c> pm{get;set;}
    public Boolean isChecked { get; set; }

    public String fileName {get;set;}
    public Blob fileBody {get;set;}
    
    public string cssapply{get;set;}    
    public String id;    
    public ID acctID{get;set;}
    public ID contactID{get;set;}
    public string lastname{get;set;}
    public contact con{get;set;}
    public History__c history{get;set;}
    public History__c history2{get;set;}
    public History__c e1{get;set;}
    public History__c e2{get;set;}
    public List<History__c> historyList {get;set;}
    public List<History__c> historyList2 {get;set;}
    public string accname{get;set;}
    public Attachment__c attach{get; set;}  
    public List<Attachment__c> attachList {get; set;}
    // Add more Contact to account
    public Account accounts;
    public Contact contacts;
    public boolean button_flag=false;
    public boolean edubutton_flag=false;
    public boolean empbutton_flag=false;
    public Integer totalCount {get;set;}
    public Integer totalCount1 {get;set;}
    public Integer rowIndex {get;set;}
    public boolean abool{get;set;}
    public boolean edubool{get;set;}
    public boolean empbool {get;set;}
    public Integer rowNum{get;set;}
    public Integer rowNum1{get;set;}
    public Id rowNum3{get;set;}
    Public Boolean rend1{get;set;}
    //Ends here
    // save as draft starts here
    public Boolean displayMsg{get;set;}
    Public String rectype{get;set;}
    public List<History__c> ListToUpdate {get; set;}
    
    public ExpertReviewEdit(ApexPages.StandardController controller) {
        
        con = new contact();
        history = new History__c();
        history2 = new History__c();
        attach = new Attachment__c(); 
        // Add more Contact to account
         abool =false;
         empbool =false;
         edubool =false;
         isChecked = false;
        historyList = new List<history__c>();
        historyList2 = new List<history__c>();
   
        rend1=false;
        
          id=Apexpages.currentPage().getParameters().get('id');
          if(id==null){
            con.RecordTypeId = Schema.SObjectType.Contact.getRecordTypeInfosByName().get('Expert Reviewer').getRecordTypeId();
          } 
           If(id!=null && id!=''){
           
           
           // recordtype obj =[select id,name from recordtype where sobjecttype='history__c'];
           
            con =[SELECT AccountId,Preferred_Name__c,Highest__c ,CreatedById,CreatedDate,Date_of_Birth__c,Ethnicity_Type__c,Fax,FirstName,Gender__c,SSN__c,
            Account_Number__c,Routing_Number__c,Verify_Account_Number__c,Verify_Routing_Number__c,Verify_SSN__c,
            HomePhone,How_did_you_hear_about_CNCS_Reviews__c,Id,If_Yes_describe_what_is_needed__c,Is_this_a_Mobile_Number__c,LastName,Account_Type__c,
            Mailing_City__c,Mailing_State__c,Mailing_Street_Address_1__c,Mailing_Street_Address_2__c,Mailing_Zip_Code__c,
            Middle_Name__c,Phone,Please_Specify__c,Primary_Phone__c,otherphone,Email,External_Reviewer_Comments__c,Comments__c,
            Race_Type__c,Reasonable_Accommodations_Required__c,Re_Enter_Email__c,Salutation,State_of_Residence__c,Suffix__c,
            Would_you_like_to_receive_texts__c,Status__c,Background_rating__c,Panel_Coordinator_Performance_Rating__c,Expert_Reviewer_Performance_Rating__c,
            Panel_Coordinator_Overall_Rating__c, Expert_Reviewer_Overall_Rating__c, Performance_Rating_Validation__c 
            FROM Contact where id=:id];
            
            pm = [select Id,Expert_Reviewer__c,Active__c from Panel_Member__c where Expert_Reviewer__c = :con.Id and Active__c = true];
           system.debug('pm size = '+pm.size());
           if(pm.size()>0){
                system.debug('ischecked = '+ischecked);
                isChecked = true;
                system.debug('ischecked = '+ischecked);
            } 
            
            for(History__c hilist : [select id,Experience_Type__c ,recordtype.name,Currently_Employed__c,
            College_University__c,CollegeUniversity__c,CollegeORUniversity__c,From__c,To__c,Areas_of_Study_Degree_Details__c,
            User_Account__c,Dummyfield__c,Employer__c,Organization_Type__c,Organization_Type1__c,empFrom__c,empTo__c,Area_of_Expertise__c,
            Expertise__c,Years_of_Experience__c,Job_Description__c,Highest_Level_of_Education__c, Currently_Enrolled__c 
            from history__c where User_Account__c=:con.id ])
            {
                if(hilist.dummyfield__c==false)
                {
                    if(hilist.recordtype.name=='Education')
                    {
                        history=hilist;
                    }
                    else
                    {
                        history2=hilist;
                    }
                }
                else 
                {
                    if(hilist.recordtype.name=='Education')
                    {
                        historyList.add(hilist);
                    }
                    else
                    {
                        historyList2.add(hilist);
                    }
                }
            }
       
            system.debug('history2 in con-->'+historyList2.size());
            system.debug('history2 in con-->'+historyList2);
           }
          }



     //Save all the data to contact,education and Employment object
    public pagereference save_upsert(){
         ListToUpdate= new List<History__c>(); 
       PageReference Redirect;
       system.debug('con = '+con);         
       if(con.Salutation== null ||con.Salutation=='') 
         {
            ApexPages.Message myMsg = new  ApexPages.Message(ApexPages.Severity.ERROR,'You must enter Salutation' );
            ApexPages.addMessage(myMsg); 
            return null;
         }
         
        
         if(con.FirstName == null ||con.FirstName=='') 
         {
            ApexPages.Message myMsg = new  ApexPages.Message(ApexPages.Severity.ERROR,'You must enter Firstname' );
            ApexPages.addMessage(myMsg); 
            return null;
         }
         
        
         if(con.LastName== null ||con.LastName=='') 
         {
            ApexPages.Message myMsg = new  ApexPages.Message(ApexPages.Severity.ERROR,'You must enter LastName' );
            ApexPages.addMessage(myMsg); 
            return null;
         }  
          
         if(con.Primary_Phone__c== null ||con.Primary_Phone__c=='') 
         {
            ApexPages.Message myMsg = new  ApexPages.Message(ApexPages.Severity.ERROR,'You must enter Primary Phone' );
            ApexPages.addMessage(myMsg); 
            return null;
         }  
         if(con.Is_this_a_Mobile_Number__c == null ||con.Is_this_a_Mobile_Number__c=='') 
         {
            ApexPages.Message myMsg = new  ApexPages.Message(ApexPages.Severity.ERROR,'You must enter Is this a mobile number?' );
            ApexPages.addMessage(myMsg); 
            return null;
         } 
         if(con.Email == null ||con.Email=='') 
         {
            ApexPages.Message myMsg = new  ApexPages.Message(ApexPages.Severity.ERROR,'You must enter Email' );
            ApexPages.addMessage(myMsg); 
            return null;
         } 
         if(con.Re_Enter_Email__c == null ||con.Re_Enter_Email__c=='') 
         {
            ApexPages.Message myMsg = new  ApexPages.Message(ApexPages.Severity.ERROR,'You must enter Re-Enter Email' );
            ApexPages.addMessage(myMsg); 
            return null;
         } 
         if(con.Mailing_Street_Address_1__c == null ||con.Mailing_Street_Address_1__c =='') 
         {
            ApexPages.Message myMsg = new  ApexPages.Message(ApexPages.Severity.ERROR,'You must enter Mailing Address' );
            ApexPages.addMessage(myMsg); 
            return null;
         } 
         if(con.Mailing_State__c == null ||con.Mailing_State__c =='') 
         {
            ApexPages.Message myMsg = new  ApexPages.Message(ApexPages.Severity.ERROR,'You must enter Mailing State' );
            ApexPages.addMessage(myMsg); 
            return null;
         } 
         if(con.Mailing_City__c == null ||con.Mailing_City__c =='') 
         {
            ApexPages.Message myMsg = new  ApexPages.Message(ApexPages.Severity.ERROR,'You must enter Mailing city' );
            ApexPages.addMessage(myMsg); 
            return null;
         }
             if(con.State_of_Residence__c == null ||con.State_of_Residence__c =='') 
         {
            ApexPages.Message myMsg = new  ApexPages.Message(ApexPages.Severity.ERROR,'You must enter State of Residence' );
            ApexPages.addMessage(myMsg); 
            return null;
         } 
         if(con.How_did_you_hear_about_CNCS_Reviews__c == null ||con.How_did_you_hear_about_CNCS_Reviews__c =='') 
         {
            ApexPages.Message myMsg = new  ApexPages.Message(ApexPages.Severity.ERROR,'You must enter How did you hear about CNCS Reviews? ' );
            ApexPages.addMessage(myMsg); 
            return null;
         }
                    /**if(history.Highest_Level_of_Education__c == null ||history.Highest_Level_of_Education__c =='') 
         {
            ApexPages.Message myMsg = new  ApexPages.Message(ApexPages.Severity.ERROR,'You must enter Highest Level of Education' );
            ApexPages.addMessage(myMsg); 
            return null;
         }**/
         if(con.Highest__c == null ||con.Highest__c =='') 
         {
            ApexPages.Message myMsg = new  ApexPages.Message(ApexPages.Severity.ERROR,'You must enter Highest Level of Education' );
            ApexPages.addMessage(myMsg); 
            return null;
         }
         
                 
         if(con.How_did_you_hear_about_CNCS_Reviews__c == 'Other' && con.Please_Specify__c == null){
            ApexPages.Message myMsg = new  ApexPages.Message(ApexPages.Severity.ERROR,'If selected "other", please provide the description.' );
            ApexPages.addMessage(myMsg); 
            return null;
         }
      /**   if(history.CollegeUniversity__c == null ||history.CollegeUniversity__c =='') 
         {
            ApexPages.Message myMsg = new  ApexPages.Message(ApexPages.Severity.ERROR,'You must enter Education COllege/University field' );
            ApexPages.addMessage(myMsg); 
            return null;
         } **/
         if(history.Organization_Type1__c == null ||history.Organization_Type1__c =='') 
         {
            ApexPages.Message myMsg = new  ApexPages.Message(ApexPages.Severity.ERROR,'You must enter Education Organization Type field' );
            ApexPages.addMessage(myMsg); 
            return null;
         } 
        
         if(history.Areas_of_Study_Degree_Details__c == null ||history.Areas_of_Study_Degree_Details__c =='') 
         {
            ApexPages.Message myMsg = new  ApexPages.Message(ApexPages.Severity.ERROR,'You must enter Education Area of Study of Degree field' );
            ApexPages.addMessage(myMsg); 
            return null;
         } 
      
        if(history2.Employer__c == null ||history2.Employer__c =='') 
         {
            ApexPages.Message myMsg = new  ApexPages.Message(ApexPages.Severity.ERROR,'You must enter Employer Name' );
            ApexPages.addMessage(myMsg); 
            return null;
         } 
         if(history2.Organization_Type__c == null ||history2.Organization_Type__c =='') 
         {
            ApexPages.Message myMsg = new  ApexPages.Message(ApexPages.Severity.ERROR,'You must enter Employment Organization Type field' );
            ApexPages.addMessage(myMsg); 
            return null;
         } 
         
         if(history2.Area_of_Expertise__c == null ||history2.Area_of_Expertise__c =='') 
         {
            ApexPages.Message myMsg = new  ApexPages.Message(ApexPages.Severity.ERROR,'You must enter Area of Expertise' );
            ApexPages.addMessage(myMsg); 
            return null;
         } 
         if(history2.Experience_Type__c == null ||history2.Experience_Type__c =='') 
         {
            ApexPages.Message myMsg = new  ApexPages.Message(ApexPages.Severity.ERROR,'You must enter Experience Type' );
            ApexPages.addMessage(myMsg); 
            return null;
         } 
                 if(history2.Expertise__c == null ||history2.Expertise__c =='') 
         {
            ApexPages.Message myMsg = new  ApexPages.Message(ApexPages.Severity.ERROR,'You must enter Expertise' );
            ApexPages.addMessage(myMsg); 
            return null;
         } 
         
         if(history2.Job_Description__c == null ||history2.Job_Description__c =='') 
         {
            ApexPages.Message myMsg = new  ApexPages.Message(ApexPages.Severity.ERROR,'You must enter Employment Description' );
            ApexPages.addMessage(myMsg); 
            return null;
         } 
         
         if(history2.empFrom__c == null)
         {
             ApexPages.Message myMsg = new  ApexPages.Message(ApexPages.Severity.ERROR,'You must enter From Date in Employment History' );
             ApexPages.addMessage(myMsg); 
             return null;
         }
         
         if(history2.empTo__c == null)
         {
             ApexPages.Message myMsg = new  ApexPages.Message(ApexPages.Severity.ERROR,'You must enter To Date in Employment History' );
             ApexPages.addMessage(myMsg); 
             return null;
         }
        
        // changes by Chaitanya Alla Start
        if(history2.Currently_Employed__c == true && history2.empTo__c != null)
         {
         	//history2.Currently_Employed__c.addError('Required Test');
             ApexPages.Message myMsg = new  ApexPages.Message(ApexPages.Severity.ERROR,'To date cannot be entered if the Currently Employed checkbox is checked' );
             ApexPages.addMessage(myMsg); 
             return null;
         }
        //-------- END -------//
         if(history2.empFrom__c != null &&history2.empFrom__c != null && history2.empFrom__c > history2.empTo__c)
         {
             ApexPages.Message myMsg = new  ApexPages.Message(ApexPages.Severity.ERROR,'From Date should be less than To Date in Employment History' );
             ApexPages.addMessage(myMsg); 
             return null;
         }    
         
         if(history2.empFrom__c != null &&history2.empFrom__c != null && history2.empFrom__c < history2.empTo__c)
         {
             Double totalYearsOfExperience = 0;
             Double totalMonthsOfExperience = 0;
             totalMonthsOfExperience =  history2.empFrom__c.monthsBetween(history2.empTo__c);
             totalYearsOfExperience = Integer.valueOf(Math.ceil(totalMonthsOfExperience / 12));
             if(Integer.valueOf(Math.ceil(history2.Years_of_Experience__c)) != totalYearsOfExperience)
             {
                 ApexPages.Message myMsg = new  ApexPages.Message(ApexPages.Severity.ERROR,'Years of Expertise is not matching to From and To Date in Employment History' );
                 ApexPages.addMessage(myMsg); 
                 return null;
             }
         }
         
         if(historyList2 != null && historyList2.size() > 0)
         {
             Integer i = 1;
             system.debug('historyList2 in class = '+historyList2);
             for(History__c tempEmpHistory: historyList2)
             {   system.debug('tempEmpHistory = '+tempEmpHistory.empFrom__c);
                 if(tempEmpHistory!=null && tempEmpHistory.empFrom__c == null)
                 {
                     ApexPages.Message myMsg = new  ApexPages.Message(ApexPages.Severity.ERROR,'You must enter From Date in Employment History '+i);
                     ApexPages.addMessage(myMsg); 
                     return null;
                 }
                 
                 if(tempEmpHistory!=null && tempEmpHistory.empTo__c == null)
                 {
                     ApexPages.Message myMsg = new  ApexPages.Message(ApexPages.Severity.ERROR,'You must enter To Date in Employment History '+i);
                     ApexPages.addMessage(myMsg); 
                     return null;
                 }
                 
                 if(tempEmpHistory!=null &&  tempEmpHistory.empFrom__c != null &&tempEmpHistory.empFrom__c != null && tempEmpHistory.empFrom__c > tempEmpHistory.empTo__c)
                 {
                     ApexPages.Message myMsg = new  ApexPages.Message(ApexPages.Severity.ERROR,'From Date should be lesst than To Date in Employment History '+i);
                     ApexPages.addMessage(myMsg); 
                     return null;
                 }
                 if(tempEmpHistory!=null){
                     Double totalYearsOfExperience = 0;
                     Double totalMonthsOfExperience = 0;
                     totalMonthsOfExperience =  tempEmpHistory.empFrom__c.monthsBetween(tempEmpHistory.empTo__c);
                     totalYearsOfExperience = Integer.valueOf(Math.ceil(totalMonthsOfExperience / 12));
                     if(Integer.valueOf(Math.ceil(tempEmpHistory.Years_of_Experience__c)) != totalYearsOfExperience)
                     {
                         ApexPages.Message myMsg = new  ApexPages.Message(ApexPages.Severity.ERROR,'Years of Expertise is not matching to From and To Date in Employment History '+i);
                         ApexPages.addMessage(myMsg);
                         return null;
                     }
                 }
                  i++;
                  
             }
         }
               
    if (con.status__c=='Pending - SAI'){
    
    con.status__c='Re-Submitted';
    
    }
     else {
                     
            con.status__c='Submitted';
            }
            ID conID = con.ID;
            system.debug('Contact id----'+con.id); 
           upsert con;
         // update con;
            system.debug('Contact list----'+con);
            
               List<history__c> hislist = new List<history__c>();
               
            Map<string,id> maprecordids = new map<string,id>();
            for(recordtype obj:[select id,name from recordtype where sobjecttype='history__c'])
            {
                maprecordids.put(obj.name,obj.id);
            }
            
            if(/*history.CollegeUniversity__c!='' &&*/ history.CollegeUniversity__c!=null)
            {   
                if(history.id==null)
                {
                history.User_Account__c= con.id;    
                }   
                
                history.recordtypeid=maprecordids.get('Education');
                hislist.add(history);
                System.debug('historyList 1'+history);
            } 
            
            if(history2.Employer__c!='' && history2.Employer__c!=null)
            {   
               if(history2.id==null)
                {
                history2.User_Account__c= con.id;   
                }
                history2.recordtypeid=maprecordids.get('Employment');
                hislist.add(history2);
                System.debug('historyList 1'+history2);
            } 

            
           if(edubool==true)
            {
                for(history__c hist:historyList){
                if(hist!=null && hist.CollegeUniversity__c!=null)
                {
                if(hist.id==null)
                {
                hist.User_Account__c= con.id;   
                }
                hist.Dummyfield__c=true;
                hist.recordtypeid=maprecordids.get('Education');
                hislist.add(hist);
                }
             }
                
                System.debug('historyList 2'+historyList);
            }
            
            if(empbool==true)
            {
                for(history__c hist2:historyList2){
                if(hist2!=null && hist2.Employer__c!=null)
                {
                if(hist2.id==null)
                {
                hist2.User_Account__c= con.id;  
                }
                hist2.Dummyfield__c=true;
                hist2.recordtypeid=maprecordids.get('Employment');
                hislist.add(hist2);
                }
             }
                
                System.debug('historyList 3'+historyList2);
            }
           if(hislist.size()>0)
              // upsert hislist;
   update hislist;
            attachList = new List<Attachment__c>();       
            try
            {
                attach.contact__c = con.id;
                attach.RecordTypeId = Schema.SObjectType.Attachment__c.getRecordTypeInfosByName().get('Contact Attachment').getRecordTypeId();
                if(fileName!=null&&fileName!=''){
                    Database.SaveResult customAttachmentResult = Database.insert(attach);
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
                        update customAttachment;
                    }
                }
                /*attachList.add(attach);
                System.debug('attachList list @@@@@@@'+attachList);
                System.debug('empattendeeList list @@@@@@@'+empattendeeList);
                if(attachList.size()>0 && attachList[0].name!='')
                    insert attachList;
                */
            }
            catch(Exception e)
            {
                 ApexPages.Message myMsg = new  ApexPages.Message(ApexPages.Severity.error,'Please attach a file in attachments section' );
                 ApexPages.addMessage(myMsg); 
                 return null;
                
            }
            finally {
            //attach.name = null;
            //attach.body = null;
                attach = new attachment__c();
            }
                   
       
        PageReference pageref = new PageReference('/'+con.id);
         system.debug('Contact id@@@----'+con.id); 
        return pageref ;
   }
    public void MakeSpecificationValidation(){
        if(con.How_did_you_hear_about_CNCS_Reviews__c =='Other'){
           cssapply = 'myClass';
        }
        else {
            cssapply = null;
        }
    }
    // Save as draft functionality Start from here

    Public PageReference SaveAsDraft()
    {
            System.debug('test save as draft');
            PageReference Redirect;

            try{
            System.debug('Save as draft try method');
            System.debug('Contact Id'+id);
            System.debug('Contact'+con);
     
           
            con.status__c='Draft';
            upsert con;
            ID conID = con.ID;
               List<history__c> hislist = new List<history__c>();
            
            System.debug('@@@@con.Date_of_Birth__c'+con.Date_of_Birth__c);
            System.debug('@@@@con.Reasonable_Accommodations_Required__c'+con.Reasonable_Accommodations_Required__c);

            
                /* Start: Code inserted by Bharani */
                if(con.Date_of_Birth__c != null && con.Date_of_Birth__c >= Date.Today()){
                    ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Date of Birth must be less than today')); 
                    return null;
                   // ApexPages.Message myMsg = new  ApexPages.Message(ApexPages.Severity.ERROR,'Date of Birth must be less than today' );
           // ApexPages.addMessage(myMsg); 
            //return null;
                
                
          }
          
         /* if(con.Reasonable_Accommodations_Required__c == 'Yes' && con.If_Yes_describe_what_is_needed__c== null){
                    //ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Please enter the Reason what accommodation is needed'));
                    ApexPages.Message myMsg = new  ApexPages.Message(ApexPages.Severity.ERROR, 'Please enter the Reason what accommodation is needed'); 
                    ApexPages.addMessage(myMsg);    
                return null;
                }*/

            if(con.Reasonable_Accommodations_Required__c == 'No' && con.If_Yes_describe_what_is_needed__c != null){
                    ApexPages.Message myMsg = new  ApexPages.Message(ApexPages.Severity.ERROR, 'If Yes, describe what is needed.field must be blank.'); 
                    ApexPages.addMessage(myMsg);    
                return null;
                }
            
         /*   if(con.Reasonable_Accommodations_Required__c == 'Yes' && con.Reasonable_Accommodations_Required__c != 'null'){
            
                if(con.If_Yes_describe_what_is_needed__c == null){
                    ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Please enter the Reason what accommodation is needed')); 
                    
                    return null;
                }
            }*/
            
            /* End: Code inserted by Bharani */

               
            Map<string,id> maprecordids = new map<string,id>();
            for(recordtype obj:[select id,name from recordtype where sobjecttype='history__c'])
            {   
                system.debug('obj = '+obj);
                maprecordids.put(obj.name,obj.id);
            }
            system.debug('maprecordids = '+maprecordIds);
            system.debug('hist coll = '+history.CollegeUniversity__c);
            if(/*history.CollegeUniversity__c!='' &&*/ history.CollegeUniversity__c!=null)
            {   
                system.debug('got here');
                system.debug('hist id = '+history.Id);
                if(history.id==null)
                {
                    system.debug('con Id = '+con.Id);
                    history.User_Account__c= con.id;    
                }   
                system.debug('edu rt id = '+maprecordids.get('Education'));
                history.recordtypeid=maprecordids.get('Education');
                hislist.add(history);
                System.debug('historyList 1'+history);
            } 
            
            if(history2.Employer__c!='' && history2.Employer__c!=null)
            {   
               if(history2.id==null)
                {
                history2.User_Account__c= con.id;   
                }
                history2.recordtypeid=maprecordids.get('Employment');
                hislist.add(history2);
                System.debug('historyList 1'+history2);
            } 

            
           if(edubool==true)
            {
                for(history__c hist:historyList){
                if(hist!=null && hist.CollegeUniversity__c!=null)
                {
                if(hist.id==null)
                {
                hist.User_Account__c= con.id;   
                }
                hist.Dummyfield__c=true;
                hist.recordtypeid=maprecordids.get('Education');
                hislist.add(hist);
                }
             }
                
                System.debug('historyList 2'+historyList);
           }
           else
           {
              for(history__c hist:historyList){
                if(hist!=null && hist.CollegeUniversity__c!=null)
                {
                if(hist.id==null)
                {
                hist.User_Account__c= con.id;   
                }
                hist.Dummyfield__c=true;
                hist.recordtypeid=maprecordids.get('Education');
                hislist.add(hist);
                }
             } 
           }
            
            if(empbool==true)
            {
                for(history__c hist2:historyList2){
                if(hist2!=null && hist2.Employer__c!=null)
                {
                if(hist2.id==null)
                {
                hist2.User_Account__c= con.id;  
                }
                hist2.Dummyfield__c=true;
                hist2.recordtypeid=maprecordids.get('Employment');
                hislist.add(hist2);
                }
             }
                
                System.debug('historyList 3'+historyList2);
            }
            else{
                 for(history__c hist2:historyList2){
                if(hist2!=null && hist2.Employer__c!=null)
                {
                if(hist2.id==null)
                {
                hist2.User_Account__c= con.id;  
                }
                hist2.Dummyfield__c=true;
                hist2.recordtypeid=maprecordids.get('Employment');
                hislist.add(hist2);
                }
             }
            }
            system.debug('history list ='+hislist);
           if(hislist.size()>0)
               upsert hislist;
           Redirect = new PageReference('/'+con.id);
            displayMsg=True; 
           
            attachList = new List<Attachment__c>();       
            try
            {
                attach.contact__c = con.id;
                attach.RecordTypeId = Schema.SObjectType.Attachment__c.getRecordTypeInfosByName().get('Contact Attachment').getRecordTypeId();
                if(fileName!=null&&fileName!=''){
                    Database.SaveResult customAttachmentResult = Database.insert(attach);
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
                         update customAttachment;
                    }
                }
                /*attachList.add(attach);
                if(attachList.size()>0 && attachList[0].name!='')
                    insert attachList;
                */
            }
            catch(Exception e)
            {
                ApexPages.Message myMsg = new  ApexPages.Message(ApexPages.Severity.error,'Please attach a file in attachments section' );
                ApexPages.addMessage(myMsg); 
                return null;
            
            }
            return Redirect;
           
        }
            
            catch(Exception e){
            System.debug('@@@@@@@@!!!!!'+e.getmessage());
            }

            return null;

          
       }
       
   
       
  // Save as draft functionality ends here
  
     public void AddRow2()
    {
       
        edubool=true;
       historyList.add(new history__c());
       System.debug('edubool---->'+edubool);
       
    }
   
    public void delRow2()
    {
        
          rowNum = Integer.valueOf(apexpages.currentpage().getparameters().get('index'));
          history__c cont=historyList[rowNum];
          historyList.remove(rowNum);
          if(cont.Id!=null){
            delete cont;
          }
        
           // null the contacts list so that it is rebuilt
           //   contacts=null;
           //   rowNum3=null;
          
    }  

    public void AddEmpRow2()
    {
       empbool=true;
        historyList2.add(new history__c());
       
    }
       
    public void delEmpRow2()
    {
        rowNum1 = Integer.valueOf(apexpages.currentpage().getparameters().get('index'));
        history__c cont=historyList2[rowNum1];
        historyList2.remove(rowNum1);   
        if(cont.Id!=null){
          delete cont;
       }
    }   
    
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
    
 
}