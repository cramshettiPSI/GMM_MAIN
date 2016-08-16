trigger NOFATrigger on NOFA__c (before insert,Before update,after insert,after update) {
    //public NOFA__c nofa{get;set;}
    Public String id{get;set;}
    //List<NOFA__c> nofa = new List<NOFA__c>([Select id,name from NOFA__C where id=:id]);
    //System.debug('######'+nofa.size());
    
    set<Id> cncsIds = new set<Id>();
    set<String> cncsProgramNames = new set<String>();
    map<Id,String> cncsCPIdtoName = new map<Id,String>();
    map<String,Id> pNametoId = new map<String,Id>();
    if(trigger.isBefore){
        if(trigger.isInsert || trigger.isUpdate){
            for(NOFA__c a: trigger.new){
              cncsIds.add(a.CNCS_Corporate_Program__c);
            }
            list<CNCS_Corporate_Program__c> lcncsp = new list<CNCS_Corporate_Program__c>([Select Id,Name from CNCS_Corporate_Program__c where id in :cncsIds ]);
            for(CNCS_Corporate_Program__c c: lcncsp){
            system.debug('@@@@'+c.Name);
            
           // nofa.Program_Name__c=c.Name;
              cncsProgramNames.add(c.Name);
              cncsCPIdtoName.put(c.Id,c.Name);
            }
            
            list<Product2> lprod = new list<Product2>([select Id,Name from Product2 where name in :cncsProgramNames]);
            for(Product2 p: lprod){
              pNametoId.put(p.Name,p.Id);
            }
            for(NOFA__c a: trigger.new){
              a.Corporate_Program__c = pNametoId.get(cncsCPIdtoName.get(a.CNCS_Corporate_Program__c));
            }
        
      }
   }
   if(trigger.isAfter){
      if(trigger.isInsert || trigger.isUpdate){
         NofoHelper.shareNofos(trigger.oldMap,trigger.newmap);
      }
   } 
  
  
}