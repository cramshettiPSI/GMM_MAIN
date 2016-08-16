trigger AwardTrigger on Award__c (before insert,Before update) {

List <Award__c> AwardUpdate = new List <Award__c> ();
List<ID> Officers=new List<Id>();
// AwardUpdate = Trigger.new;

for (Award__c A : Trigger.new)
{
/*if (A.Grant_Status__c == 'Awaiting SPO Approval') {
A.OwnerId = A.Senior_Program_Officer__c;
// Award.PO_Certification_Date__c = Award.LastModifiedDate;
} 

if (A.Grant_Status__c == 'Being Committed') {
A.OwnerId = A.Executive_Officer__c;
A.SPO__c = A.OwnerId;
// Award.PO_Certification_Date__c = Award.LastModifiedDate;
}

if (A.Grant_Status__c == 'Awaiting GO Certification') {
A.OwnerId = A.Grants_Officer__c;
A.SPO__c = A.OwnerId;
// Award.PO_Certification_Date__c = Award.LastModifiedDate;
}

if (A.Grant_Status__c == 'Awaiting SGO Approval') {
A.OwnerId = A.Senior_Grants_Officer__c;
A.SPO__c = A.OwnerId;
// Award.PO_Certification_Date__c = Award.LastModifiedDate;
}*/
if(A.Grant_Status__c == 'Awaiting SPO Approval'){
A.PO__c=Userinfo.getName();}
if(A.Grant_Status__c == 'Being Committed'){
A.SPO__c=Userinfo.getName();}
}

/*
set<Id> cncsIds = new set<Id>();
set<String> cncsProgramNames = new set<String>();
map<Id,String> cncsCPIdtoName = new map<Id,String>();
map<String,Id> pNametoId = new map<String,Id>();
if(trigger.isBefore){
    if(trigger.isInsert || trigger.isUpdate){
        for(Award__c a: trigger.new){
            cncsIds.add(a.CNCS_Corporate_Program__c);
        }
        list<CNCS_Corporate_Program__c> lcncsp = new list<CNCS_Corporate_Program__c>([Select Id,Name from CNCS_Corporate_Program__c where id in :cncsIds ]);
        for(CNCS_Corporate_Program__c c: lcncsp){
            cncsProgramNames.add(c.Name);
            cncsCPIdtoName.put(c.Id,c.Name);
        }
        
        list<Product2> lprod = new list<Product2>([select Id,Name from Product2 where name in :cncsProgramNames]);
        for(Product2 p: lprod){
            pNametoId.put(p.Name,p.Id);
        }
        for(Award__c a: trigger.new){
            a.Corporate_Program__c = pNametoId.get(cncsCPIdtoName.get(a.CNCS_Corporate_Program__c));
        }
        
    }
    
    
}*/
}