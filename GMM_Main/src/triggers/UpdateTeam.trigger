trigger UpdateTeam on Team_Assignment__c (after insert) {
    if(trigger.isinsert){
        list<Id> TeamIdList = new list<id>();
        for(Team_Assignment__c TA : trigger.new){
           TeamIdList.add(TA.Team_Name__c); 
        }

         list<Team__c> Team = [SELECT id,Available_for_Team_Assignments__c from Team__c WHERE id in: TeamIdList];
            for(Team__c T : Team){
                T.Available_for_Team_Assignments__c = false;
              }
         update Team;
    }
}