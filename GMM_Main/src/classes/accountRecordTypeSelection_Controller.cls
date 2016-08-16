public with sharing class accountRecordTypeSelection_Controller {

public List<recordtype> accRtLst {get;set;}
public String selectedRtType{get;set;}
public Set<String> selectedRtValues = new Set<string>();
public List<SelectOption> rtValues {get;set;}
Map<id,String> rtMap = new Map<id,string>();
public Set<String> deletedRtValues = new Set<string>();
private final Contact acct;
profile p = new profile();
public boolean child{get;set;}
public id rtId;
public String URLString{get;set;}

    public accountRecordTypeSelection_Controller(ApexPages.StandardController controller) {
         
         child = true;
         rtId = ApexPages.currentPage().getParameters().get('rtType');
         system.debug('Rt Id'+rtId);
           
                 
                 accRtLst = [Select id,name,SobjectType,description from recordtype where SobjectType='Contact' AND name NOT IN:deletedRtValues]; 
                 rtValues = new List<SelectOption>();
                 this.acct = (Contact)controller.getRecord();
                 p = [Select id,name from profile where id =: UserInfo.getProfileId() ];
                 System.debug('User Profile info-->'+p);
                 recordTypeName();
             
             
    }
    
    public void recordTypeName() {
           
        
             for(recordtype r : accRtLst){
                 String str = r.name;
                   if(!deletedRtValues.Contains(str )){
                     rtMap.put(r.id,str);
                     rtValues.add(new SelectOption(r.id,r.name));
                   }  
             }
             
        
    }
    public pagereference continueWtSelection(){
       system.debug('Selected record type '+selectedRtType);
       string rt = rtMap.get(selectedRtType);
       system.debug('rtmap = '+rtMap);
       Contact acc = new Contact();
       acc.recordtypeID = selectedRtType;
       system.debug('Contact + '+acct);
        if( rt == 'Expert Reviewer' ){   
           
            pagereference pr = new pagereference('/apex/ExpertReviewEdit');
            return pr;
        } else {       
                  if(p.name!='Expert Reviewers')   
                  {           
                  PageReference acctPage = new pageReference('/003/e?retURL=%2F003%2Fo&RecordType='+acc.recordtypeID+'&ent=Contact&nooverride=1');
                  
                    acctPage.setRedirect(true);
                    return acctPage;
                }    
        }  
            return null;   
    }
    

}