trigger TeamAssignerrortrigger on Team_Assignment__c (before insert,before update)
{
string teamn = '';
set<id> set1 = new set<id>();
list<id> teamidset = new list<id>();
map<id,string> namemap = new map<id,string>();
        for(Team_Assignment__c tass : trigger.new)
        {
            teamidset.add(tass.Team_Name__c);
        } 
                 list<Team_Assignment__c> teamassn = [select id,name,Campus_Arrival_Date__c,Campus_Departure_Date__c,Project_Departure_Date__c from Team_Assignment__c where Team_Name__c in : teamidset];
        
            list<team__c> teamt = [select id,name from team__c where id in : teamidset];
                for(team__c t :teamt )
                {
                    namemap.put(t.id,t.name);
                }
   //if(Trigger.isInsert)  {                  
   for(Team_Assignment__c ta : trigger.new){
            for(Team_Assignment__c teamassg : teamassn )
            {
              if(ta.id != teamassg.id)
              {
                    teamn= namemap.get(ta.Team_Name__c);
                    if(ta.No_Transition__c == true){
                    if((ta.Campus_Departure_Date__c >= teamassg.Campus_Departure_Date__c && ta.Campus_Departure_Date__c <= teamassg.Project_Departure_Date__c) && ta.Project_Departure_Date__c >= teamassg.Project_Departure_Date__c){
                    ta.adderror(teamn+ ' ' + 'cannot be associated to this award for the specified dates because the team is associated with a different award during that period.');
                    }
                    else if (ta.Campus_Departure_Date__c <=teamassg.Campus_Departure_Date__c && (ta.Project_Departure_Date__c >= teamassg.Campus_Departure_Date__c && ta.Project_Departure_Date__c <= teamassg.Project_Departure_Date__c )){
                    ta.adderror(teamn+ ' ' +'cannot be associated to this award for the specified dates because the team is associated with a different award during that period.');
                    }
                    else if(ta.Campus_Departure_Date__c >= teamassg.Campus_Departure_Date__c && ta.Project_Departure_Date__c <= teamassg.Project_Departure_Date__c){
                    ta.adderror(teamn+' '+'cannot be associated to this award for the specified dates because the team is associated with a different award during that period.');
                    }
                    else if(ta.Campus_Departure_Date__c <= teamassg.Campus_Departure_Date__c && ta.Project_Departure_Date__c >= teamassg.Project_Departure_Date__c){
                    ta.adderror(teamn+' '+'cannot be associated to this award for the specified dates because the team is associated with a different award during that period.');
                    }
       else
       {
       }
                }
   else
   {
                    if((ta.Campus_Departure_Date__c >= teamassg.Campus_Departure_Date__c && ta.Campus_Departure_Date__c <= teamassg.Campus_Arrival_Date__c) && ta.Campus_Arrival_Date__c >= teamassg.Campus_Arrival_Date__c){
                    ta.adderror(teamn+' '+'cannot be associated to this award for the specified dates because the team is associated with a different award during that period.');
                    }
                    else if (ta.Campus_Departure_Date__c <= teamassg.Campus_Departure_Date__c && (ta.Campus_Arrival_Date__c >= teamassg.Campus_Departure_Date__c && ta.Campus_Arrival_Date__c <= teamassg.Campus_Arrival_Date__c )){
                    ta.adderror(teamn+' '+'cannot be associated to this award for the specified dates because the team is associated with a different award during that period.');
                    }
                    else if(ta.Campus_Departure_Date__c >= teamassg.Campus_Departure_Date__c && ta.Campus_Arrival_Date__c <= teamassg.Campus_Arrival_Date__c){
                    ta.adderror(teamn+' '+'cannot be associated to this award for the specified dates because the team is associated with a different award during that period.');
                    }
                    else if(ta.Campus_Departure_Date__c <= teamassg.Campus_Departure_Date__c && ta.Campus_Arrival_Date__c >= teamassg.Campus_Arrival_Date__c){
                    ta.adderror(teamn+' '+'cannot be associated to this award for the specified dates because the team is associated with a different award during that period.');
                    }
       else
       {
       }
      }
      }
              }
        } 
    //}                        
}