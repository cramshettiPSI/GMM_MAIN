public without sharing class ContactCreateController8 {

    public List<Panel_Member__c> pm{get;set;}
    public Boolean isChecked { get; set; }
    public String id;    
    public ID acctID{get;set;}
    public ID contactID{get;set;}
    public string lastname{get;set;}
    public Education__C edu{get;set;}
    public contact con{get;set;}
    public History__c history{get;set;}
    public History__c history2{get;set;}
    public List<History__c> historyList {get;set;}
    public List<History__c> historyList2 {get;set;}
    public Employment__c emp{get;set;}
    public string accname{get;set;}
    public Attachment attach{get; set;}  
    public List<Attachment> attachList {get; set;}
    // Add more Contact to account 
    
    public Account accounts;
    public Contact contacts;
    public Education__c del;
    public Employment__c empdel;
    public boolean button_flag=false;
    public boolean edubutton_flag=false;
    public boolean empbutton_flag=false;
    public List<Education__c> addattendeeList {get;set;}
    public List<Employment__c> empaddattendeeList {get;set;}
    public List<Education__c> delattendeeList {get;set;}
    public List<Employment__c> empdelattendeeList {get;set;}
    public List<Education__c> attendeeList {get;set;}
    public List<Employment__c> empattendeeList {get;set;}
    public Integer totalCount {get;set;}
    public Integer totalCount1 {get;set;}
    public Integer rowIndex {get;set;}
    public boolean abool{get;set;}
    public boolean edubool{get;set;}
    public boolean empbool {get;set;}
    public Integer rowNum{get;set;}
    public Integer rowNum1{get;set;}
    
    public List<Education__c> delAttendees {get; set;} 
    public List<Employment__c> empdelAttendees {get; set;} 
    Public Boolean rend1{get;set;}
    //Ends here
    // save as draft starts here
    public Boolean displayMsg{get;set;}
    Public String rectype{get;set;}
    public List<History__c> ListToUpdate {get; set;}
    public List<Education__c> educationLists {get; set;}
    public List<Employment__c> employementLists {get; set;}
    


    public ContactCreateController8(ApexPages.StandardController controller) {
        
        con = new contact();
        edu = new Education__c();
        emp= new Employment__c();
        history = new History__c();
        history2 = new History__c();
        attach = new Attachment(); 
        
        // Add more Contact to account
         abool =false;
         empbool =false;
         edubool =false;
        isChecked = false;
     
        delattendeeList = new List<Education__C>();
        delattendees = new List<Education__C>();
        
        
        addattendeeList = new List<education__c>();
        empaddattendeeList = new List<Employment__c>();
        historyList = new List<history__c>();
        historyList2 = new List<history__c>();
   
        rend1=false;
        
            educationLists =new List<education__c>();
            education__c dummyLogicModel = new  education__c();   
            educationLists .add(dummyLogicModel); 
            
            employementLists=new List<Employment__c>();
            Employment__c dummyLogicModel1 = new  Employment__c();   
            employementLists.add(dummyLogicModel1); 
            
            
          id=Apexpages.currentPage().getParameters().get('id');
           If(id!=null && id!=''){
           
            
           // recordtype obj =[select id,name from recordtype where sobjecttype='history__c'];
           
            con =[SELECT AccountId,Preferred_Name__c,CreatedById,CreatedDate,Date_of_Birth__c,Comments__c,Ethnicity_Type__c,Fax,FirstName,Gender__c,Highest__c,
            HomePhone,How_did_you_hear_about_CNCS_Reviews__c,Id,If_Yes_describe_what_is_needed__c,Is_this_a_Mobile_Number__c,LastName,
            Mailing_City__c,Mailing_State__c,Mailing_Street_Address_1__c,Mailing_Street_Address_2__c,Mailing_Zip_Code__c,SSN__c,Account_Number__c,Routing_Number__c,Verify_Account_Number__c,Verify_Routing_Number__c,Verify_SSN__c,
            Middle_Name__c,Phone,Please_Specify__c,Primary_Phone__c,otherphone,Email,Currently_Employed__c,Currently_Enrolled__c,
            Race_Type__c,Reasonable_Accommodations_Required__c,Re_Enter_Email__c,Salutation,State_of_Residence__c,Suffix__c,
            Would_you_like_to_receive_texts__c,Status__c,Years_of_Experience__c,Area_of_Expertise__c,Expertise__c,Area1_of_Expertise__c,Expertise1__c,External_Reviewer_Comments__c, Background_rating__c,Expert_Reviewer_Performance_Rating__c,Panel_Coordinator_Performance_Rating__c,Panel_Coordinator_Overall_Rating__c,Expert_Reviewer_Overall_Rating__c FROM Contact where id=:id];
            
             
            pm = [select Id,Expert_Reviewer__c,Active__c from Panel_Member__c where Expert_Reviewer__c = :con.Id and Active__c = true];
            if(pm.size()>0){
                isChecked = true;
            }
          
            for(History__c hilist : [select id,Education_Name__c,Experience_Type__c,Currently_Enrolled__c,CollegeUniversity__c,CollegeORUniversity__c,Organization_Type1__c,Currently_Employed__c,recordtype.name,College_University__c,From__c,To__c,Expertise__c,Areas_of_Study_Degree_Details__c,User_Account__c,Dummyfield__c,Employer__c,Organization_Type__c,empFrom__c,empTo__c,Area_of_Expertise__c,Years_of_Experience__c,Job_Description__c from history__c where User_Account__c=:con.id ])
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
            
           con.Years_of_Experience__c=calculatetotalExp(con.id);
            con.Area1_of_Expertise__c=areaofexpertise(con.id);
            con.Expertise1__c=expertise(con.id);
            
        
       
        
    }

     //Save all the data to contact,education and employee object
    /*public pagereference save_upsert(){
         ListToUpdate= new List<History__c>(); 
       PageReference Redirect;
                
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
               
               
  
     
          
            con.status__c='Submitted';
            upsert con;
            ID conID = con.ID;
               List<history__c> hislist = new List<history__c>();
               
            Map<string,id> maprecordids = new map<string,id>();
            for(recordtype obj:[select id,name from recordtype where sobjecttype='history__c'])
            {
                maprecordids.put(obj.name,obj.id);
            }
            
            if(history.Education_Name__c!='' && history.Education_Name__c!=null)
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
                history2.recordtypeid=maprecordids.get('Employee');
                hislist.add(history2);
                System.debug('historyList 1'+history2);
            } 

            
           if(edubool==true)
            {
                for(history__c hist:historyList){
                if(hist!=null && hist.Education_Name__c!=null)
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
                hist2.recordtypeid=maprecordids.get('Employee');
                hislist.add(hist2);
                }
             }
                
                System.debug('historyList 3'+historyList2);
            }
           if(hislist.size()>0)
               upsert hislist;
      
            attachList = new List<Attachment>();       
            try
            {
            attachList.add(new Attachment(parentId = con.id, name= attach.name, body= attach.body));
            System.debug('attachList list @@@@@@@'+attachList);
            System.debug('empattendeeList list @@@@@@@'+empattendeeList);
            if(attachList.size()>0 && attachList[0].name!='' && attachList[0].body!=null)
            insert attachList;
            }
            catch(Exception e)
            {
            ApexPages.Message myMsg = new  ApexPages.Message(ApexPages.Severity.error,'Please attach a file in attachments section' );
            ApexPages.addMessage(myMsg); 
            return null;
            
            }
            finally {
            attach.name = null;
            attach.body = null;
            attach = new attachment();
            }
                   
       
        PageReference pageref = new PageReference('/'+con.id);
        return pageref ;
   }

    // Save as draft functionality Start from here

    /*Public PageReference SaveAsDraft()
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
               
            Map<string,id> maprecordids = new map<string,id>();
            for(recordtype obj:[select id,name from recordtype where sobjecttype='history__c'])
            {
                maprecordids.put(obj.name,obj.id);
            }
            
            if(history.Education_Name__c!='' && history.Education_Name__c!=null)
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
                history2.recordtypeid=maprecordids.get('Employee');
                hislist.add(history2);
                System.debug('historyList 1'+history2);
            } 

            
           if(edubool==true)
            {
                for(history__c hist:historyList){
                if(hist!=null && hist.Education_Name__c!=null)
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
                if(hist!=null && hist.Education_Name__c!=null)
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
                hist2.recordtypeid=maprecordids.get('Employee');
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
                hist2.recordtypeid=maprecordids.get('Employee');
                hislist.add(hist2);
                }
             }
            }
           if(hislist.size()>0)
               upsert hislist;
           Redirect = new PageReference('/'+con.id);
            displayMsg=True; 
           
            attachList = new List<Attachment>();       
            try
            {
            attachList.add(new Attachment(parentId = con.id, name= attach.name, body= attach.body));
            System.debug('attachList list @@@@@@@'+attachList);
            System.debug('empattendeeList list @@@@@@@'+empattendeeList);
            if(attachList.size()>0 && attachList[0].name!='' && attachList[0].body!=null)
            insert attachList;
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

          
       }*/
       
   
       
  // Save as draft functionality ends here
  
    /* public void AddRow2()
    {
       
        edubool=true;
       historyList.add(new history__c());
       System.debug('edubool---->'+edubool);
       
    }
   
    public void delRow2()
    {
        rowNum = Integer.valueOf(apexpages.currentpage().getparameters().get('index'));
        historyList.remove(rowNum);   
    }  

    public void AddEmpRow2()
    {
       empbool=true;
        historyList2.add(new history__c());
       
    }
       
    public void delEmpRow2()
    {
        rowNum1 = Integer.valueOf(apexpages.currentpage().getparameters().get('index'));
        historyList2.remove(rowNum1);   
    }*/
    public pagereference editbtn()
    {
        PageReference Redirect;
        If(id!=null && id!=''){
        Redirect = new PageReference('/apex/ExpertReviewEdit?id='+id);
        system.debug('Redirect id-->'+Redirect);
        return Redirect;
        }
        
        return null;
    }   
    public pagereference rejectbtn()
    {
        PageReference Redirect;
        EmailTemplate template = [SELECT name,Id from EmailTemplate where DeveloperName = 'reject_user'];
        If(id!=null && id!=''){
            con.status__c='Rejected';
            update con;
            Redirect = new PageReference('/_ui/core/email/author/EmailAuthor?p2_lkid=' + id + '&template_id='+template.Id+'&retURL=%2F'+id);
            system.debug('Redirect id-->'+Redirect);
            return Redirect;
        }
        
        return null;
    }   
    
    public pagereference pendingbtn()
    {
        PageReference Redirect;
        If(id!=null && id!=''){
           EmailTemplate template = [SELECT name,Id from EmailTemplate where Name = 'Pending – SAI'];              
           con.Status__c = 'Pending - SAI'; 
           con.ExpertReviewerStatus__c ='Pending - SAI'; 
           update con; 
           Redirect = new PageReference('/_ui/core/email/author/EmailAuthor?&template_id='+template.Id+'&p2_lkid='+id+'&retURL=%2F'+id);               
           return Redirect;
        }
    
        return null;
    }   
    
    public pagereference Acceptbtn()
    {
        PageReference Redirect;
        EmailTemplate tmp = [Select e.Name, e.Id, e.DeveloperName From EmailTemplate e where DeveloperName = 'Accept'];
        If(id!=null && id!=''){
            con.status__c='Accepted';
            update con;
            Redirect = new PageReference('/_ui/core/email/author/EmailAuthor?p2_lkid=' + id + '&template_id='+tmp.Id+'&retURL=%2F'+id);
            system.debug('Redirect id-->'+Redirect);
            return Redirect;
        }
        
        return null;
    } 
    
    public pagereference Applybtn()
    {
        PageReference Redirect;
        If(id!=null && id!=''){
        con.status__c='Pending SAI';
        update con;
        Redirect = new PageReference('/apex/ExpertReviewerDetail?id=' + id );
        system.debug('Redirect id-->'+Redirect);
        return Redirect;
        }
        
        return null;
    }   
 


    public static  decimal calculatetotalExp(string contactId)
    {
        decimal totalexp=0;
        if(contactId!=null)
        {
        List<AggregateResult> AggrRest = [select sum(Years_of_Experience__c) exp,Area_of_Expertise__c from history__c where recordtype.name='Employment' and User_Account__c=:contactId group By Area_of_Expertise__c ];
        
        for(AggregateResult res: AggrRest )
        {
        decimal exp;
        if(res.get('exp')!=null){
            exp = Decimal.valueOf(res.get('exp')+'');
        //Decimal exp = Decimal.valueOf(res.get('Years_of_Experience__c'));
        }
        if(totalexp< exp)
        {
        totalexp=exp;
        }
        }
        }
        return totalexp;
    }



    public static  string areaofexpertise(string contactId)
    {
        string area='';
        if(contactId!=null)
        {
        List<History__c> AreaHist = [select Area_of_Expertise__c  from history__c where recordtype.name='Employment' and User_Account__c=:contactId ];
        
        for(History__c res: AreaHist )
        {
        String areaexp = String.valueOf(res.get('Area_of_Expertise__c')+'');
        String area1= area + ','+' '+areaexp;
        area=area1.substring(1,area1.length()-0);
        system.debug('area of expertise value-->'+area);
        }
        }
        return area;
    }
    
    public static  string expertise(string contactId)
    {
        string expt='';
        if(contactId!=null)
        {
        List<History__c> exptHist = [select Expertise__c  from history__c where recordtype.name='Employment' and User_Account__c=:contactId ];
        
        for(History__c res:exptHist  )
        {
        String exptise = String.valueOf(res.get('Expertise__c')+'');
        
        String expt1= expt +' , '+' '+exptise;
        expt=expt1.substring(1,expt1.length()-0);
        system.debug('expertise value-->'+expt);
        }
        }
        return expt;
    }
       
    // New Requirement on 11 Sept 15
    
    public pagereference SubmitBtn()
    {    String strErrMsg='';
         Boolean errFlag=false;
         if(con.Salutation== null ||con.Salutation=='') 
         {
            ApexPages.Message myMsg = new  ApexPages.Message(ApexPages.Severity.ERROR,'You must enter Salutation' );
            ApexPages.addMessage(myMsg); 
           // return null;
         }
         
        
         if(con.FirstName == null ||con.FirstName=='') 
         {
            ApexPages.Message myMsg = new  ApexPages.Message(ApexPages.Severity.ERROR,'You must enter Firstname' );
            ApexPages.addMessage(myMsg); 
           // return null;
         }
         
        
         if(con.LastName== null ||con.LastName=='') 
         {
            ApexPages.Message myMsg = new  ApexPages.Message(ApexPages.Severity.ERROR,'You must enter LastName' );
            ApexPages.addMessage(myMsg); 
            //return null;
         }  
          
         if(con.Primary_Phone__c== null ||con.Primary_Phone__c=='') 
         {
            
            ApexPages.Message myMsg = new  ApexPages.Message(ApexPages.Severity.ERROR,'You must enter Primary Phone' );
            ApexPages.addMessage(myMsg); 
            //con.Primary_Phone__c.addError('You must enter Primary Phone');
            //return null;
            
            errFlag=true;
          /* strErrMsg+='You must enter Primary Phone \n';*/
            
         }  
         if(con.Is_this_a_Mobile_Number__c == null ||con.Is_this_a_Mobile_Number__c=='') 
         {
            
            ApexPages.Message myMsg = new  ApexPages.Message(ApexPages.Severity.ERROR,'You must enter Is this a mobile number?' );
            ApexPages.addMessage(myMsg); 
           // return null;
            
           /*  errFlag=true;
            strErrMsg+='You must enter Is this a mobile number? \n';*/
         } 
         if(con.Email == null ||con.Email=='') 
         {
            
            ApexPages.Message myMsg = new  ApexPages.Message(ApexPages.Severity.ERROR,'You must enter Email' );
            ApexPages.addMessage(myMsg); 
           // return null;
            
           /* errFlag=true;
            strErrMsg+='You must enter Email \n';*/
         } 
         if(con.Re_Enter_Email__c == null ||con.Re_Enter_Email__c=='') 
         {
            
            ApexPages.Message myMsg = new  ApexPages.Message(ApexPages.Severity.ERROR,'You must enter Re-Enter Email' );
            ApexPages.addMessage(myMsg); 
           // return null;
            
            /* errFlag=true;
            strErrMsg+='You must enter Re-Enter Email \n';*/
         } 
         if(con.Mailing_Street_Address_1__c == null ||con.Mailing_Street_Address_1__c =='') 
         {
            
            ApexPages.Message myMsg = new  ApexPages.Message(ApexPages.Severity.ERROR,'You must enter Mailing Address' );
            ApexPages.addMessage(myMsg); 
           // return null;
            
           /* errFlag=true;
            strErrMsg+='You must enter Mailing Address \n'; */
            
         } 
         if(con.Mailing_State__c == null ||con.Mailing_State__c =='') 
         {
            
            ApexPages.Message myMsg = new  ApexPages.Message(ApexPages.Severity.ERROR,'You must enter Mailing State' );
            ApexPages.addMessage(myMsg); 
           // return null;
            
           /* errFlag=true;
            strErrMsg+='You must enter Mailing State \n';*/
            
         } 
         if(con.Mailing_City__c == null ||con.Mailing_City__c =='') 
         {
            
            ApexPages.Message myMsg = new  ApexPages.Message(ApexPages.Severity.ERROR,'You must enter Mailing city' );
            ApexPages.addMessage(myMsg); 
           // return null;
            
          /* errFlag=true;
           strErrMsg+='You must enter Mailing city \n';*/
         }
             if(con.State_of_Residence__c == null ||con.State_of_Residence__c =='') 
         {
            
            ApexPages.Message myMsg = new  ApexPages.Message(ApexPages.Severity.ERROR,'You must enter State of Residence' );
            ApexPages.addMessage(myMsg); 
           // return null;
            
            /* errFlag=true;
            strErrMsg+='You must enter State of Residence \n ';*/
         } 
         if(con.How_did_you_hear_about_CNCS_Reviews__c == null ||con.How_did_you_hear_about_CNCS_Reviews__c =='') 
         {
            
            ApexPages.Message myMsg = new  ApexPages.Message(ApexPages.Severity.ERROR,'You must enter How did you hear about CNCS Reviews? ' );
            ApexPages.addMessage(myMsg); 
           // return null;
            
            /* errFlag=true;
             strErrMsg+='You must enter How did you hear about CNCS Reviews? \n';*/
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
            //return null;
            
             errFlag=true;/*
            strErrMsg+='You must enter Highest Level of Education \n'; */
         }
         if(con.How_did_you_hear_about_CNCS_Reviews__c == 'Other' && con.Please_Specify__c == null){
            
            ApexPages.Message myMsg = new  ApexPages.Message(ApexPages.Severity.ERROR,'If selected "other", please provide the description.' );
            ApexPages.addMessage(myMsg); 
           // return null;
            
             errFlag=true;/*
            strErrMsg+='If selected "other", please provide the description. \n'; */
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
           // return null;
           
            errFlag=true; /*
            strErrMsg+='You must enter Education Organization Type field \n';*/
         } 
        
         if(history.Areas_of_Study_Degree_Details__c == null ||history.Areas_of_Study_Degree_Details__c =='') 
         {
            
            ApexPages.Message myMsg = new  ApexPages.Message(ApexPages.Severity.ERROR,'You must enter Education Area of Study of Degree field' );
            ApexPages.addMessage(myMsg); 
           // return null;
        
            errFlag=true;    /*
            strErrMsg+='You must enter Education Area of Study of Degree field \n';*/
         } 
      
        if(history2.Employer__c == null ||history2.Employer__c =='') 
         {
            
            ApexPages.Message myMsg = new  ApexPages.Message(ApexPages.Severity.ERROR,'You must enter Employer Name' );
            ApexPages.addMessage(myMsg); 
            // return null;
            
            errFlag=true;/*
            strErrMsg+='You must enter Employer Name \n';*/
         } 
         if(history2.Organization_Type__c == null ||history2.Organization_Type__c =='') 
         {
            
            ApexPages.Message myMsg = new  ApexPages.Message(ApexPages.Severity.ERROR,'You must enter Employment Organization Type field' );
            ApexPages.addMessage(myMsg); 
           // return null;
           
            errFlag=true; /*
            strErrMsg+='You must enter Employment Organization Type field \n';*/
         } 
         
         if(history2.Area_of_Expertise__c == null ||history2.Area_of_Expertise__c =='') 
         {
            
            ApexPages.Message myMsg = new  ApexPages.Message(ApexPages.Severity.ERROR,'You must enter Area of Expertise' );
            ApexPages.addMessage(myMsg); 
          //  return null;
          
            errFlag=true;  /*
            strErrMsg+='You must enter Area of Expertise \n';*/
         } 
         if(history2.Experience_Type__c == null ||history2.Experience_Type__c =='') 
         {
            
            ApexPages.Message myMsg = new  ApexPages.Message(ApexPages.Severity.ERROR,'You must enter Experience Type' );
            ApexPages.addMessage(myMsg); 
          //  return null;
            
            errFlag=true;/*
            strErrMsg+='You must enter Experience Type \n';*/
         } 
         if(history2.Expertise__c == null ||history2.Expertise__c =='') 
         {
            
            ApexPages.Message myMsg = new  ApexPages.Message(ApexPages.Severity.ERROR,'You must enter Expertise' );
            ApexPages.addMessage(myMsg); 
          //  return null;
            
            errFlag=true;/*
            strErrMsg+='You must enter Expertise \n';*/
         } 
         
         if(history2.Job_Description__c == null ||history2.Job_Description__c =='') 
         {
            
            ApexPages.Message myMsg = new  ApexPages.Message(ApexPages.Severity.ERROR,'You must enter Employment Description' );
            ApexPages.addMessage(myMsg); 
          //  return null;
           
            errFlag=true; /*
            strErrMsg+='You must enter Employment Description \n ';*/
         }
         
         if(history2.empFrom__c == null)
         {
            
             ApexPages.Message myMsg = new  ApexPages.Message(ApexPages.Severity.ERROR,'You must enter From Date in Employment History' );
             ApexPages.addMessage(myMsg); 
            // return null;
             
             errFlag=true;/*
             strErrMsg+='You must enter From Date in Employment History \n';*/
         }
         
         if(history2.Currently_Employed__c == false && history2.empTo__c == null)
         {
             
             ApexPages.Message myMsg = new  ApexPages.Message(ApexPages.Severity.ERROR,'You must enter To Date in Employment History' );
             ApexPages.addMessage(myMsg); 
           //  return null;
             
              errFlag=true;/*
             strErrMsg+='You must enter To Date in Employment History \n';*/
         }
         
         if(history2.empFrom__c != null &&history2.empFrom__c != null && history2.empFrom__c > history2.empTo__c)
         {
             
             ApexPages.Message myMsg = new  ApexPages.Message(ApexPages.Severity.ERROR,'From Date should be less than To Date in Employment History' );
             ApexPages.addMessage(myMsg); 
           //  return null;
           
              errFlag=true;  /*
             strErrMsg+='From Date should be less than To Date in Employment History \n';*/
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
               //  return null;
                 
                 errFlag=true;/*
                 strErrMsg+='Years of Expertise is not matching to From and To Date in Employment History \n';*/
             }
         }
         if(errFlag){
            // ApexPages.Message myMsg = new  ApexPages.Message(ApexPages.Severity.ERROR,strErrMsg );
           //  ApexPages.addMessage(myMsg); 
             return null;
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
        PageReference Redirect;
        If(id!=null && id!=''){
        if(con.status__c=='Pending - SAI'|| con.status__c=='Rejected')
       { 
        con.status__c='Re-Submitted';
               }
       else
       { 
        con.status__c='Submitted';
        
       }
       upsert con;  
        Redirect = new PageReference('/apex/ExpertReviewerDetail?id='+id);
        system.debug('Redirect id-->'+Redirect);
        
        }
        
        return Redirect;
     }   
    
    // Ends here    
}