trigger paymentAmountUpdate on Panel_Member__c (after update) {

list<Id> pmIds= new list<Id>();
list<Id> PanelIds = new list<Id>();
list<Id> StagesIds = new list<Id>();
list<Id> NofoGroupIDs = new list<Id>();
list<Panel_Member__c> panelToUpdate = new list<Panel_Member__c>();

for(Panel_Member__c r: Trigger.New)
 {
   pmIds.add(r.Id);
   PanelIds.add(r.Panel__c);
  }
  list<Panel_Member__c> panMemList = new list<Panel_Member__c>([select Id,Name,Role__c,Payment_Amount__c from Panel_Member__c where ID IN:pmIds]);
  list<Paneling__c> panelList = new list<Paneling__c>([Select Id, Stage_Number__c,Name from Paneling__c where ID IN:PanelIds]);
  if(PanelList !=null && !PanelList.isEmpty()){
  for(Paneling__c pan :panelList ){
    StagesIds.add(pan.Stage_Number__c);
  }
  }
  list<Stages__c> StageList = new list<Stages__c>([Select Id, Name, NOFA_Group__c from Stages__c where ID IN:StagesIds]);
  if(StageList !=null && !StageList.isEmpty()){
  for(Stages__c stageNum : StageList){
    NofoGroupIDs.add(stageNum.NOFA_Group__c);
  }
  }
  list<NOFA_Group__c> NOFOGroup = new list<NOFA_Group__c>([Select Id,Name, (Select Id, Name,Position__c,Payment_Amount__c from Honorarium_Informations__r) from NOFA_Group__c where ID IN:NofoGroupIDs]);
  if(NOFOGroup!=null && !NOFOGroup.isEmpty()){
    for(Panel_Member__c p : panMemList){
      for(Paneling__c paneling :panelList){
        for(Stages__c stag :StageList){
          for(NOFA_Group__c nofGrp : NOFOGroup){
            for(Honorarium_Information__c hrInf : nofGrp.Honorarium_Informations__r){
              if(nofGrp.Honorarium_Informations__r !=null && !nofGrp.Honorarium_Informations__r.isEmpty()){
              if(hrInf.Position__c == p.Role__c){
                if(p.Payment_Amount__c != hrInf.Payment_Amount__c){
                p.Payment_Amount__c = hrInf.Payment_Amount__c;
                panelToUpdate.add(p);
                }
              }
            }
          }
        }
      }
    }
  }
    update PanelToUpdate;
}
}