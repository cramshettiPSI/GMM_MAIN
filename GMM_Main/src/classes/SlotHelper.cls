/*
Helper class for Slot__c object; Trigger - "SlotsTrigger" 
Created by Krishna Yama. 07.11.16
Methods included: 1. TotalSlots - Sum of all (Requested_w_Allowance__c) values from all Slots for an Application. 

*/
public with sharing class SlotHelper {
    
/*
Method to calculate the sum of all (Requested_w_Allowance__c) values from an Application. 
Calculated values are saved in (Requested_w_Allowance__c) field on Application. 
*/
    public static void TotalSlots(map<Id,Slot__c> newMap,map<Id,Slot__c> oldMap){
        
        system.debug('newmap = '+newMap);
        system.debug('oldmap = '+oldMap);
        set<Id> parentIds = new set<Id>(); 
        if(oldMap == null){
            //after insert
            for(Id i: newMap.keyset()){
                parentIds.add(newMap.get(i).Application__c);
            }
        }else{
            //after update
            if(newMap!=null){
                for(Id i:newMap.keyset()){
                    if(newmap.get(i).Requested_w_Allowance__c != null && (oldMap.get(i).Requested_w_Allowance__c != newMap.get(i).Requested_w_Allowance__c)){
                        parentIds.add(newMap.get(i).Application__c);
                    }
                }
            }else{
                for(Id i:oldMap.keyset()){                  
                    parentIds.add(oldMap.get(i).Application__c);                   
                }
            }
        }
        
        list<Application3__c> Apps = new list<Application3__c>([Select r.Requested_w_Allowance__c, r.Name, r.Id, (Select Id, Requested_w_Allowance__c,Application__c  From Slots__r) From Application3__c r where Id in :parentIds]);
        Map<Id, Decimal> parentValues = new Map<Id, Decimal>();
        if(Apps.size()>0){
            for(Application3__c ap: Apps){
                if(ap.Slots__r.size()>0){
                    for(Slot__c sl: ap.Slots__r){
                        if(parentValues.keySet().contains(ap.id) && sl.Requested_w_Allowance__c  != null && sl.Requested_w_Allowance__c != null)
                        {
                            Decimal tmp = parentValues.get(ap.id);
                            tmp += sl.Requested_w_Allowance__c;
                            parentValues.put(ap.id, tmp);
                        }
                        else
                        {
                            if(sl.Requested_w_Allowance__c != null){
                                parentValues.put(ap.id, sl.Requested_w_Allowance__c);
                            }
                        }
                    }
                }
                if(parentValues.get(ap.Id)!=null){
                    ap.Requested_w_Allowance__c = parentValues.get(ap.Id);
                }else{
                    ap.Requested_w_Allowance__c = 0;
                }    
                
            }
            system.debug('Apps = '+Apps);
            update Apps;
        }
    }
}