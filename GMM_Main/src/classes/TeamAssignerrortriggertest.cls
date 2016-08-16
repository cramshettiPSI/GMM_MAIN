@istest
public class  TeamAssignerrortriggertest
{

 static testMethod void testmethod1()
{
 Award__c testawd = UtilityClass.createAward();

 Insert testawd;
 
Team__c team = new Team__c();
team.Team_Number__c = '58'; 
team.Effective_Date__c = system.today()-50;
team.End_Date__c = system.today()+25;
team.Reason_No_Longer_in_Use__c = 'abcd';

//team.TeamName__c = 'xyz';
insert team;

Team_Assignment__c teamassign = new Team_Assignment__c();
teamassign.Award__c = testawd.id;
teamassign.Campus_Arrival_Date__c =  system.today();
teamassign.Campus_Departure_Date__c =  system.today();
teamassign.Project_Arrival_Date__c = system.today();
teamassign.Project_Departure_Date__c =  system.today();
teamassign.Number_of_Members__c = 4;
teamassign.Team_Type__c = 'Standard';
teamassign.Team_Name__c = team.id;
teamassign.No_Transition__c = true;


Team_Assignment__c teamassign1 = new Team_Assignment__c();
teamassign1.Award__c = testawd.id;
teamassign1.Campus_Arrival_Date__c =  system.today()+25;
teamassign1.Campus_Departure_Date__c =  system.today()+10;
teamassign1.Project_Arrival_Date__c = system.today()+14;
teamassign1.Project_Departure_Date__c =  system.today()+20;
teamassign1.Number_of_Members__c = 4;
teamassign1.Team_Type__c = 'Standard';
teamassign1.Team_Name__c = team.id;
teamassign1.No_Transition__c = true;

Team_Assignment__c teamassign2 = new Team_Assignment__c();
teamassign2.Award__c = testawd.id;
teamassign2.Campus_Arrival_Date__c =  system.today()-5;
teamassign2.Campus_Departure_Date__c =  system.today()-10;
teamassign2.Project_Arrival_Date__c = system.today()-9;
teamassign2.Project_Departure_Date__c =  system.today()-7;
teamassign2.Number_of_Members__c = 4;
teamassign2.Team_Type__c = 'Standard';
teamassign2.Team_Name__c = team.id;
teamassign2.No_Transition__c = true;

try
{
insert teamassign;
insert teamassign1;
insert teamassign2;
}
catch(exception e)
{
}
}
static testMethod void testmethod2()
{
 Award__c testawd = UtilityClass.createAward();

 Insert testawd;
 
Team__c team = new Team__c();
team.Team_Number__c = '59'; 
team.Effective_Date__c = system.today()-200;
team.End_Date__c = system.today()+100;
team.Reason_No_Longer_in_Use__c = 'abcd';

//team.TeamName__c = 'xyz';
insert team;

Team_Assignment__c teamassign = new Team_Assignment__c();
teamassign.Award__c = testawd.id;
teamassign.Campus_Arrival_Date__c =  system.today();
teamassign.Campus_Departure_Date__c =  system.today();
teamassign.Project_Arrival_Date__c = system.today();
teamassign.Project_Departure_Date__c =  system.today();
teamassign.Number_of_Members__c = 4;
teamassign.Team_Type__c = 'Standard';
teamassign.Team_Name__c = team.id;
teamassign.No_Transition__c = false;


Team_Assignment__c teamassign1 = new Team_Assignment__c();
teamassign1.Award__c = testawd.id;
teamassign1.Campus_Arrival_Date__c =  system.today()+3;
teamassign1.Campus_Departure_Date__c =  system.today()+10;
teamassign1.Project_Arrival_Date__c = system.today()+4;
teamassign1.Project_Departure_Date__c =  system.today()+7;
teamassign1.Number_of_Members__c = 4;
teamassign1.Team_Type__c = 'Standard';
teamassign1.Team_Name__c = team.id;
teamassign1.No_Transition__c = false;

Team_Assignment__c teamassign2 = new Team_Assignment__c();
teamassign2.Award__c = testawd.id;
teamassign2.Campus_Arrival_Date__c =  system.today()-5;
teamassign2.Campus_Departure_Date__c =  system.today()-10;
teamassign2.Project_Arrival_Date__c = system.today()-9;
teamassign2.Project_Departure_Date__c =  system.today()-7;
teamassign2.Number_of_Members__c = 4;
teamassign2.Team_Type__c = 'Standard';
teamassign2.Team_Name__c = team.id;
teamassign2.No_Transition__c = false;



try
{
insert teamassign;
insert teamassign1;
insert teamassign2;

}
catch(exception e)
{
}
}
 }