/*trigger UpdateOrgnization on award__c(after insert,after update){
    List<Account> parentObjList = new List<Account>();
    List<Id> listIds = new List<Id>();

    for(award__c childObj : Trigger.new){
        listIds.add(childObj.Organization__c);
    }

    parentObjList = [SELECT id, Name,(SELECT ID, Grant_Status__c,Master_Corporate_Program__c FROM award__r)
                        FROM Account
                        WHERE ID IN :listIds];

    for (Account bid : parentObjList){
        Boolean setToApproved;
        for(award__c bsaa : bid.award__r) {
            //if an approval is encountered for which the condition doesn't
            //hold, set the boolean to false, indicating no update is required
            system.debug('Hiiiiii' +bsaa.Grant_Status__c);
            if((bsaa.Grant_Status__c != 'Expired' || bsaa.Grant_Status__c != 'Being Closed' || bsaa.Grant_Status__c != 'Closed' || bsaa.Grant_Status__c != 'Suspended' ) && (bsaa.Master_Corporate_Program__c =='AmeriCorps' || bsaa.Master_Corporate_Program__c=='SeniorCorps')) {
                setToApproved = true;
                break;
                
            }
            else
            {
            setToApproved = false;
            }
           
       }
        system.debug('Hiiiiii ------->'+setToApproved);
       if(setToApproved){
            bid.ActiveAmericorpsOrSeniorCorpsAward__c = true;
            
       }
       else if(setToApproved == false)
       {
       bid.ActiveAmericorpsOrSeniorCorpsAward__c = false;
       }
    }
    update parentObjList;
} */

// Trigger updated - Replaced "Master Corporate Program" with "CNCS Corporate Structure". (KY)
trigger UpdateOrgnization on award__c(after insert,after update){
    List<Account> parentObjList = new List<Account>();
    List<Id> listIds = new List<Id>();

    for(award__c childObj : Trigger.new){
        listIds.add(childObj.Organization__c);
    }

    parentObjList = [SELECT id, Name,(SELECT ID, Grant_Status__c,CNCS_Corporate_Program__c FROM award__r)
                        FROM Account
                        WHERE ID IN :listIds];

    for (Account bid : parentObjList){
        Boolean setToApproved;
        for(award__c bsaa : bid.award__r) {
            //if an approval is encountered for which the condition doesn't
            //hold, set the boolean to false, indicating no update is required
            system.debug('Hiiiiii' +bsaa.Grant_Status__c);
            if((bsaa.Grant_Status__c != 'Expired' || bsaa.Grant_Status__c != 'Being Closed' || bsaa.Grant_Status__c != 'Closed' || bsaa.Grant_Status__c != 'Suspended' ) && (bsaa.CNCS_Corporate_Program__c =='AmeriCorps' || bsaa.CNCS_Corporate_Program__c=='SeniorCorps')) {
                setToApproved = true;
                break;
                
            }
            else
            {
            setToApproved = false;
            }
           
       }
        system.debug('Hiiiiii ------->'+setToApproved);
       if(setToApproved){
            bid.ActiveAmericorpsOrSeniorCorpsAward__c = true;
            
       }
       else if(setToApproved == false)
       {
       bid.ActiveAmericorpsOrSeniorCorpsAward__c = false;
       }
    }
    update parentObjList;
}