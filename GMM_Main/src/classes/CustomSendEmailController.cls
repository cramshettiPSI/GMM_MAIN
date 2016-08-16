public with sharing class CustomSendEmailController {
        public String subject { get; set; }    
        public String body { get; set; }  
        public string toAddresses {get;set;}
        public string toCCAddresses {get;set;}
        public User auser {get;set;}
        public Id appId {get;set;}
        public Application3__c app{get;set;}
        public String status{get;set;}
        
        public CustomSendEmailController (){
            String tmpName = ApexPages.CurrentPage().getParameters().get('tmpName');
            toAddresses = ApexPages.CurrentPage().getParameters().get('toAddresses');
            status = ApexPages.CurrentPage().getParameters().get('status');
            appId = ApexPages.CurrentPage().getParameters().get('appId');
            //Application3__c app;
            system.debug('appId = '+appId);
            if(appId!=null){
             app = [Select Id,Name,Submitted_By__c,CreatedById,CreatedBy.Name,Grantee_Status__c,Status__c,
                    Authorized_Representative__c,Authorized_Representative__r.Name,Authorized_Representative__r.Title,Comments__c,
                    Applicant_User__c,Applicant_User__r.Name,Applicant_User__r.Street,Applicant_User__r.City,Applicant_User__r.LastName,
                    Application_ID__c,Nofa_Rfp__r.NOFA_name__c,Nofa_Rfp__c,NOFA_Fiscal_Yr__c,Nofa_Rfp__r.Corporate_Program__r.Director_ID__r.Name,
                    Nofa_Rfp__r.Corporate_Program__r.Director_ID__r.Title,Nofa_Rfp__r.Corporate_Program__r.Name,Application_Due_Date__c,Date_Received__c,
                    Nofa_Rfp__r.Intent_to_Apply_Due_Date__c,Program_Office_Director__r.Name,Program_Office_Director__r.Title,Application_Feedback_Summary__c,
                    Program_Office_Director__c from Application3__c where Id = :appId];
            }
            system.debug('tmpName = '+tmpName);
            EmailTemplate template = [Select Id,Name,Body,Subject from EmailTemplate where DeveloperName = :tmpName];
            subject = template.Subject;            
            body = template.Body; 
            system.debug('createdById = '+app.CreatedById);
            User createdBy = [Select Id,Name from User where Id = :app.CreatedById];  
            system.debug('after user query = '+createdBy);
            if(body.contains('{!User.Name}'))
                body = (null == app.CreatedById) ? body : body.replace('{!User.Name}',CreatedBy.Name); 
            if(body.contains('{!Application3__c.Comments__c}'))
                body = (null == app.Comments__c) ? body.replace('{!Application3__c.Comments__c}','') : body.replace('{!Application3__c.Comments__c}',app.Comments__c);  
            
            if(body.contains('{!Application3__c.Submitted_By__c}'))
                body = (null == app.Submitted_By__c) ? body.replace('{!Application3__c.Submitted_By__c}','') : body.replace('{!Application3__c.Submitted_By__c}',app.Submitted_By__c);  
                
            if(body.contains('{!NOFA__c.CreatedBy}')){                          
                body = (null == app.CreatedById) ? body : body.replace('{!NOFA__c.CreatedBy}',CreatedBy.Name);   
            }
            
            
            if(body.contains('{Current Date}')){
                system.debug('got here');
                body = (null == Date.today()) ? body : body.replace('{Current Date}',String.valueOf(Date.today()));
            }              
            if(body.contains('{!Application3__c.Authorized_Representative__c}')) 
                body = (null == app.Authorized_Representative__c) ? body.replace('{!Application3__c.Authorized_Representative__c}',' ') : body.replace('{!Application3__c.Authorized_Representative__c}',app.Authorized_Representative__r.Name);
            if(body.contains('{!Application3__c.Application_Feedback_Summary__c}'))
            	body = (null == app.Application_Feedback_Summary__c) ? body.replace('{!Application3__c.Application_Feedback_Summary__c}',' ') : body.replace('{!Application3__c.Application_Feedback_Summary__c}',app.Application_Feedback_Summary__c);
            	
            
            	             
            if(body.contains('{Authorized Representative Name}'))
                body = (null == app.Authorized_Representative__c) ? body.replace('{Authorized Representative Name}',' ') : body.replace('{Authorized Representative Name}',app.Authorized_Representative__r.Name);
            system.debug(' title = '+app.Authorized_Representative__r.Title);   
            if(body.contains('{Authorized Representative TITLE}'))
                body = (null == app.Authorized_Representative__r.Title) ? body.replace('{Authorized Representative TITLE}','') : body.replace('{Authorized Representative TITLE}',app.Authorized_Representative__r.Title);
            if(body.contains('{Legal Applicant Name}'))
                body = (null == app.Applicant_User__c) ? body.replace('{Legal Applicant Name}','') : body.replace('{Legal Applicant Name}',app.Applicant_User__r.Name);
            if(body.contains('{Legal Applicant Address}'))
                body = (null == app.Applicant_User__r.Street) ? body.replace('{Legal Applicant Address}','') : body.replace('{Legal Applicant Address}',app.Applicant_User__r.Street+' '+app.Applicant_User__r.City);
            if(body.contains('{Prefix} {LastName}'))
                body = (null == app.Applicant_User__c) ? body.replace('{Prefix} {LastName}','') : body.replace('{Prefix} {LastName}',app.Applicant_User__r.LastName);
            if(body.contains('{Application ID}'))
                body = (null == app.Application_ID__c) ? body.replace(' {Application ID}','') : body.replace(' {Application ID}',app.Application_ID__c);
            if(body.contains('{NOFA Name}'))
                body = (null == app.Nofa_Rfp__c) ? body.replace('{NOFA Name}','') : body.replace('{NOFA Name}',app.Nofa_Rfp__r.NOFA_name__c);
            if(body.contains('{Date of Applicant’s correspondence}'))
                body = (null == app.Date_Received__c) ? body.replace('{Date of Applicant’s correspondence}','') : body.replace('{Date of Applicant’s correspondence}',String.valueof(app.Date_Received__c));
            //if(body.contains('*Date of original Compliance letter*'))
            //  body = (null == app.Nofa_Rfp__c) ? body : body.replace('*Date of original Compliance letter*',app.Nofa_Rfp__r.NOFA_name__c);
            if(body.contains('{Fiscal year}'))
                body = (null == app.NOFA_Fiscal_Yr__c) ? body.replace('{Fiscal year}','') : body.replace('{Fiscal year}',app.NOFA_Fiscal_Yr__c);
            if(body.contains('{CNCS Program Director Name}'))
                body = (null == app.Nofa_Rfp__r.Corporate_Program__r.Director_ID__r.Name) ? body.replace('{CNCS Program Director Name}','') : body.replace('{CNCS Program Director Name}',app.Nofa_Rfp__r.Corporate_Program__r.Director_ID__r.Name);
            if(body.contains('{CNCS Program Director Title}'))
                body = (null == app.Nofa_Rfp__r.Corporate_Program__r.Director_ID__r.Title) ? body.replace('{CNCS Program Director Title}','') : body.replace('{CNCS Program Director Title}',app.Nofa_Rfp__r.Corporate_Program__r.Director_ID__r.Title);
            if(body.contains('{CNCS Program Name}'))
                body = (null == app.Nofa_Rfp__r.Corporate_Program__r.Name) ? body.replace('{CNCS Program Name}','') : body.replace('{CNCS Program Name}',app.Nofa_Rfp__r.Corporate_Program__r.Name); 
                
            if(body.contains('{Application Due Date}'))
                body = (null == app.Application_Due_Date__c) ? body.replace('{Application Due Date}','') : body.replace('{Application Due Date}',String.valueOf(app.Application_Due_Date__c));
            if(body.contains('{Application Submission Date}'))
                body = (null == app.Date_Received__c) ? body.replace('{Application Submission Date}','') : body.replace('{Application Submission Date}',String.valueOf(app.Date_Received__c));
            if(body.contains('{Intent Due Date from Notice}'))
                body = (null == app.Nofa_Rfp__r.Intent_to_Apply_Due_Date__c) ? body.replace('{Intent Due Date from Notice}','') : body.replace('{Intent Due Date from Notice}',string.valueOf(app.Nofa_Rfp__r.Intent_to_Apply_Due_Date__c));
            if(body.contains('{Director of OGPO Name}'))
                body = (null == app.Program_Office_Director__r.Name) ? body.replace('{Director of OGPO Name}','') : body.replace('{Director of OGPO Name}',app.Program_Office_Director__r.Name);
            if(body.contains('{Director of OGPO TITLE}'))
                body = (null == app.Program_Office_Director__r.Title) ? body.replace('{Director of OGPO TITLE}','') : body.replace('{Director of OGPO TITLE}',app.Program_Office_Director__r.Title);
            if(body.contains('{Office Title of OGPO}'))
                body = (null == app.Program_Office_Director__c) ? body.replace('{Office Title of OGPO}','') : body.replace('{Office Title of OGPO}',app.Program_Office_Director__c);
             
                
            
        }
        
        public PageReference sendEmails(){
            Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage(); 
            list<String> addressesToSend = new list<String>();
            list<String> addressesToCC = new list<String>();
            if(toAddresses!=null){
                addressesToSend.add(toAddresses);
            }
            if(toCCAddresses != null && toCCAddresses !=''){                
                addressesToCC = toCCAddresses.split(';');
            }            
            email.setSubject( subject );
            email.setToAddresses( addressesToSend );
            email.setPlainTextBody( body );      
            if(addressesToCC.size()>0){             
                email.setCcAddresses(addressesToCC);
            }                            
           if(status!=null&&status!=''){      
                /*app.Grantee_Status__c = status;
                app.Status__c = status;      
                Database.Saveresult appUpdate = Database.update(app);*/
                //update app;     
                
                    try{
                        Messaging.SendEmailResult [] r = Messaging.sendEmail(new Messaging.SingleEmailMessage[] {email});    
                        //ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO,'Successfully sent email(s) to contacts'));
                        if(r[0].isSuccess()){
                        	app.Grantee_Status__c = status;
                			app.Status__c = status;      
                			Database.Saveresult appUpdate = Database.update(app);
                			if(!appUpdate.isSuccess()){                        
                   			 ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error,'Unable to update Concept Paper/Application, please contact your admin'));
                    	     return null;
                			}
                        }                                              
                    } catch(Exception e){               
                         ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error,'Unable to send email, please contact your admin'));
                         return null;
                    }                        
            }else{
                try{
                    Messaging.SendEmailResult [] r = Messaging.sendEmail(new Messaging.SingleEmailMessage[] {email}); 
                    Task newTask = new Task();
                    newTask.OwnerId = userInfo.getUserId();
                    newTask.Subject = subject;
                    newTask.Description = body;
                    newTask.ActivityDate = date.today();
                    newTask.Status = 'Completed';
                    newTask.Priority = 'Normal';
                    newTask.whatId = app.Id;
                    insert newTask;
                }catch(Exception e){
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error,'Unable to send email, please contact your admin'));
                    return null;
                }
                
            }   
            PageReference pg = new PageReference('/'+appId);
            pg.setRedirect(true);
            return pg;
        }
        
        public PageReference cancel(){
             PageReference pg = new PageReference('/'+appId);
             system.debug('appId = '+appId);
             pg.setRedirect(true);
             return pg;
        }
}