trigger AsignTasks on Grant_Close_Out__c (After update) {
   
    Map<Id,list<Task>> gcoTaskMap = new Map<Id,list<Task>>();
    list<Task> Tasklist = new List<Task>();
    Map<id,id> POOfficermap = New Map<id,id>();
    Map<id,id> GrantOfficermap = New Map<id,id>();
    
    list<Grant_Close_Out__c> GCOlist= new list<Grant_Close_Out__c>([Select Id,Master_Award__r.Program_Officer__c,Master_Award__r.Grants_Officer__c,(Select WhatId,Status from Tasks) from Grant_Close_Out__c where Id in : Trigger.newmap.keyset()]);
    
    for(Grant_Close_Out__c gco : GCOlist){
      gcoTaskMap.put(gco.Id,gco.Tasks);
      POOfficermap.put(gco.id,gco.Master_Award__r.Program_Officer__c);
      GrantOfficermap.put(gco.id,gco.Master_Award__r.Grants_Officer__c);
    }
    
    System.debug('POOfficermap'+POOfficermap);
    System.debug('gcoTaskMap'+gcoTaskMap);
    System.debug('GrantOfficermap'+GrantOfficermap);
    
    if(trigger.isafter && trigger.isupdate){
        for(Grant_Close_Out__c GCO: Trigger.new){
              if((gcoTaskMap.get(gco.id) == null || gcoTaskMap.get(gco.id).isempty()) && GCO.Assign_Tasks__c == true){
                  If(POOfficermap.get(GCO.id) != null){
                      Task T = new Task();
                                T.Subject = 'Perform a Grant Close out task';
                                T.ActivityDate = System.today().adddays(90);
                                T.Ownerid = POOfficermap.get(GCO.id);
                                //T.Owner= '003r0000002LBTNAA4';
                                T.WhatId = GCO.Id;
                       Tasklist.add(T);
                       
                       
                  }
                  
                  If(GrantOfficermap.get(GCO.id) != null){
                      Task T1 = new Task();
                                T1.Subject = 'Perform a Grant Close out task';
                                T1.ActivityDate = System.today().adddays(90);
                                T1.Ownerid = POOfficermap.get(GCO.id);
                                //T1.Owner= '003r0000002LBTNAA4';
                                T1.WhatId = GCO.Id;
                       Tasklist.add(T1);
                  }
              }
        } 
        
       If(Tasklist.size()>0){
           System.debug('In try');
           Try{
               Insert Tasklist;
           }
           Catch(exception e){
               System.debug('In catch'+e.getmessage());
               System.debug('In catch'+e.getlinenumber());           
           }    
       }      
    }
}