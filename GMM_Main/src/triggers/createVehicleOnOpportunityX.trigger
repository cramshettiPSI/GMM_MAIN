trigger createVehicleOnOpportunityX on Panel_Member__c (After insert,After update) {
    
   List <Expert_Review_Panel__c> vehToInsert = new List <Expert_Review_Panel__c>();
   
    
 for (Panel_Member__c o : Trigger.new) {

         
        
        
        if (o.Panel_Status__c == 'Completed' ) {  
        
        Expert_Review_Panel__c v = new Expert_Review_Panel__c (); 
        
         v.Test__c = o.Name; 
        v.Status__c = 'In Progress'; 
        
        
        
        vehToInsert.add(v);
        
        
        }
        
    }
    
 
  
        insert vehToInsert; 
    
    
}