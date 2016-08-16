trigger IndirectCostRateDefault on In_direct__c (before insert, before update) {
	
	list<ID> orgList = new list<ID>();
	list<In_direct__c> indirect = new list<In_direct__c>([Select id, name,Organization_Name__c from In_direct__c]);
    
    for(In_direct__c ICR : indirect){
    	orgList.add(ICR.Organization_Name__c);
    }
    list<In_direct__c> IndcostRate = new list<In_direct__c>([Select id, Name,Organization_Name__c, Is_this_your_default_cost_rate__c from In_direct__c Where (Is_this_your_default_cost_rate__c='Yes' AND Organization_Name__c IN : orgList) ]);
    
    
    for(In_direct__c i : Trigger.new){
	    System.debug('IndCostRate Size...............' +IndcostRate.size());
	    if(i.Is_this_your_default_cost_rate__c == 'Yes'){
		    if(IndcostRate.size()>0){
		    	for(In_direct__c j: IndcostRate){
		    		if(i.Organization_Name__c == j.Organization_Name__c){
		    			i.Is_this_your_default_cost_rate__c.addError('Only one Indirect Cost Rate Info record under same Organization can have the Is this your default cost rate? Field populated with ‘Yes.’');
		    		}
		    	}
		    }
	    }
    }  
}