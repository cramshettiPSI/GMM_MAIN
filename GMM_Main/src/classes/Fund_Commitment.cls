Public Class Fund_Commitment{


Public Fund_Commitment__c fc;
Public List<Funding_Source__c> fs_List{get;set;}
Public Funding_Source__c Selected_fs_radio{get;set;}
public boolean displayPopup {get; set;} 
Public String selected_fs{get;set;}
Public List<SelectOption> options{get;set;}
Public List<Award__c> award_List;
 Public Fund_Commitment(ApexPages.StandardController con){
 
 fc=(Fund_Commitment__c)con.getRecord();
 fs_List=new List<Funding_Source__c>();
 Map<String,String> parammap=apexPages.currentPage().getParameters();
 String awardId = apexPages.currentPage().getParameters().get('rid');

 System.debug('MAP%%%'+parammap.keyset()+'^^^'+fc);
 System.debug('Award_ID'+awardId);
 
  award_List = [Select Application_ID__r.NOFA_RFP__c from Award__c where id=:awardId];
  System.debug('Award_ID'+award_List[0]);
   if(award_List.size()>0){
    fs_List=[Select name from Funding_Source__c where NOFA__c=:award_List[0].Application_ID__r.NOFA_RFP__c];
  System.debug('test'+fs_List);
   } 
 
}

 Public void Select_Action(){
 options = new List<SelectOption>();
 displayPopup = true;
 for(Funding_Source__c fs:fs_List){
 options.add(new SelectOption(fs.id,fs.name));
 }
 }

 Public Pagereference Submit(){
 PageReference PR;
  System.debug('Selected_Record'+selected_fs);
  String fiscal_year_basis;
  List<String> split_List;
  displayPopup = false; 
  if(selected_fs!=null){
    Selected_fs_radio = [Select name,Fiscal_Yr_Basis__r.name from Funding_Source__c where id=:selected_fs];
  System.debug('Selected_Record_ID'+Selected_fs_radio.Fiscal_Yr_Basis__r.name);
  fiscal_year_basis=Selected_fs_radio.Fiscal_Yr_Basis__r.name;
  split_List=fiscal_year_basis.split('-');
  
  if(split_List.size()==2){
     Fund_Commitment__c fc = new Fund_Commitment__c();
     fc.name=Selected_fs_radio.name;
     fc.Start_FY__c=split_List[0];
     fc.Fund__c=split_List[1];
     fc.Award__c=award_List[0].id;
     Insert fc;
     PR = new PageReference('/'+award_List[0].id);
     return PR;
  }
  
  else if(split_List.size()==3){
     Fund_Commitment__c fc = new Fund_Commitment__c();
     fc.name=Selected_fs_radio.name;
     fc.Start_FY__c=split_List[0];
     fc.Ending_FY__c=split_List[1];
     fc.Fund__c=split_List[2];
     fc.Award__c=award_List[0].id;
     Insert fc;
     PR = new PageReference('/'+award_List[0].id);
     return PR;
  }
  
  }
     return null;
 }

 public void closePopup() {        
        displayPopup = false;    
    }     
    
 public void showPopup() {        
        displayPopup = true;    
    }



}