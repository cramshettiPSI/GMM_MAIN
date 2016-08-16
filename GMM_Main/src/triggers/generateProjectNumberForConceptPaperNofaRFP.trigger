trigger generateProjectNumberForConceptPaperNofaRFP on Application3__c(before insert, before update){
    System.debug('***generateProjectNumberForConceptPaperNofaRFP***');
    List<Application3__c> lstApp = new List<Application3__c>();
    List<Application3__c> lstAppConceptPaperWithNofaRFP = new List<Application3__c>();
    set<String> setAppParentNofaId=new Set<String>();
    
    if (Trigger.isBefore && (Trigger.isInsert || Trigger.isUpdate )){
        lstApp = Trigger.isInsert || Trigger.isUpdate  ? Trigger.new : Trigger.old;
        
        for(Application3__c objApp:lstApp){
            if(objApp.RecordType.name=='Concept_Paper' &&   objApp.NOFA_CRPP_Code__c=='NCCC') {  //objApp.NOFA_RFP__r.RecordType.Name=='RFP') {
                setAppParentNofaId.add(objApp.NOFA_RFP__c);
                lstAppConceptPaperWithNofaRFP.add(objApp);
            }
        }
        
        List<Class__c> lstClass=[SELECT Id,Name,Team_Leader_Arrival__c
                                 FROM Class__c 
                                 WHERE RFP__c in :setAppParentNofaId];
        Map<String,class__c> mpClass = new Map<String,class__c>();
        Map<String,class__c> mpNofaToClass= new Map<String,class__c>();                          
        for(class__c objClass : lstClass){
            mpClass.put(objClass.id,objClass);
            mpNofaToClass.put(objClass.RFP__c,objClass);
        }
        
        
         System.debug('lstAppConceptPaperWithNofaRFP*** '+lstAppConceptPaperWithNofaRFP);
        class__c tmpClass;      
        Date teamLeadArrivalDate;
        String teamLeadArrivalYear;
        String prjNmbr;
        List<Application3__c> lstUpdApp=new List<Application3__c>();
        for(Application3__c objApp :lstAppConceptPaperWithNofaRFP){
           objApp.RegionNumber__c=objApp.Primary_state_of_service_Activities__c;
           System.debug('Region_Number*** '+objApp.RegionNumber__c);
           tmpClass=mpclass.get(objApp.NOFA_RFP__c)    ;
           teamLeadArrivalDate=tmpClass.Team_Leader_Arrival__c;
           System.debug('teamLeadArrivalDate'+teamLeadArrivalDate);
           teamLeadArrivalYear=(teamLeadArrivalDate.Year()!=null)? String.valueOf(teamLeadArrivalDate.Year()):'xyz';
           System.debug('teamLeadArrivalYear'+teamLeadArrivalYear);
           System.debug('***objApp.ProjAutoNbr__c***'+objApp.ProjAutoNbr__c);
           prjNmbr= teamLeadArrivalYear+ '-' +objApp.RegionNumber__c + '-' + objApp.ProjAutoNbr__c;
           objApp.Project_Number__c=prjNmbr;
           lstUpdApp.add(objApp);
           System.debug('prjNmbr'+prjNmbr);
        } 
        
        try{
            if(lstUpdApp.size()>0)
                 update lstUpdApp;
        }
        catch(Exception exc){
        System.debug('update execption in trigger-generateProjectNumberForConceptPaperNofaRFP***'+exc.getmessage());
        }      
                                 
    }

}