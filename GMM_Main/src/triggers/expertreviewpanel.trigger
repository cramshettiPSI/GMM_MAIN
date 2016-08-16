trigger expertreviewpanel on Panel_Member__c (After update) {
    
   List <Expert_Review_Panel__c> panToInsert = new List <Expert_Review_Panel__c>();
   
    
 for (Panel_Member__c o : Trigger.new) {

         
        
        
        if (o.Panel_Status__c == 'Completed') {  
        
        Expert_Review_Panel__c v = new Expert_Review_Panel__c (); 
        
         v.Panel_Member__c = o.Name; 
         
        v.Panel__c = o.Panel__c; 
        
        
        
        insert v;
        
        
        }
        
    }
    }