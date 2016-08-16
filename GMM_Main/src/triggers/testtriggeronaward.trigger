trigger testtriggeronaward on Award__c (after insert) {
if(trigger.isafter)
   { 
   
      set<id> projectid = new set<id>();
     set<id> applicationid= new set<id>();

        map<id,list<Award__c>> relatedawardlist = new map<id,list<Award__c>>();
        
         map<id,list<Award__c>> apprelatedawardlist = new map<id,list<Award__c>>();
   //list<Award__c>  awardlisttt = [select id,name,Application_ID__r.Id,Application_ID__r.Corporate_Program__c from Award__c where id=:'a1mr00000004EwF'];   
        
   for(Award__c award:trigger.new)
   {
  applicationid.add(award.Application_ID__c);
     system.debug('#######sowmya124345678#############debug1'+award.Application_ID__c);
        system.debug('#######sowmyaawrd#############debug1'+award);
  if(apprelatedawardlist.containsKey(award.Application_ID__c)) {
        List<Award__c> awardlist = apprelatedawardlist.get(award.Application_ID__c);
        awardlist.add(award);
        apprelatedawardlist.put(award.Application_ID__c, awardlist);
    } else {
        apprelatedawardlist.put(award.Application_ID__c, new List<Award__c> {award});
    }

   }
   system.debug('#######sowmya#############debug1'+apprelatedawardlist);
   system.debug('#######debugsowmya#############debug2'+applicationid);


   for(Application3__c app : [select id,name,Project__r.id,Status__c,Corporate_Program__c from Application3__c where id in : applicationid])
   {
  system.debug('####################debug2'+app.Project__r.id);
       projectid.add(app.Project__r.id);
       relatedawardlist.put(app.Project__r.Id,apprelatedawardlist.get(app.id));
   
}

system.debug('###################debug3'+relatedawardlist);

list<project__c> listtoupdate = new list<project__c>();
for(Project__c p : [select id,name,CorporateProgram__c from project__c where id in : projectid] )
{
  system.debug('################### debug4'+p);
    
list<Award__c> awlist = relatedawardlist.get(p.id);
system.debug('########awlist###########'+awlist);
// system.debug('########awlist#Application_ID__r.Status__c##########'+awlist[0].Application_ID__c.Status__c);
if(awlist.size()==1)
{
system.debug('########awlist###########'+awlist);
  //product2 c = awlist[0].Corporate_Program1__c;
 product2 c = [select id,name from product2 where name =: awlist[0].Corporate_Program1__c];
 system.debug('########awlist[0].Application_ID__r.Corporate_Program1__c##########'+awlist[0].Corporate_Program1__c);
system.debug('######Application_ID__r.Corporate_Program__c############# debug4'+ awlist[0].Application_ID__r.NOFA_RFP__r.Corporate_Program__c);
// system.debug('###########awlist[0].Application_ID__c.Corporate_Program__cgfhg######## debug4'+awlist[0].Application_ID__c.Corporate_Program__c);
//system.debug('###########awlist[0].Application_ID__c######## debug4'+awlist.Application_ID__r.Corporate_Program__c);


p.CorporateProgram__c = c.id;
listtoupdate.add(p);
}
}
system.debug('###################'+listtoupdate);

if(listtoupdate.size()>0)
{
update listtoupdate;
}
}


}