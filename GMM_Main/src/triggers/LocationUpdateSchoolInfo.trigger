trigger LocationUpdateSchoolInfo on Location__c (after insert) {
String SchoolNCESID;

for (Location__c Loc: Trigger.New)
{
if (Loc.School_ID_NCES__c != Null)
{
SchoolNCESID = Loc.School_ID_NCES__c;
}
}

List <Location__c> LocationInsert = new List <Location__c> ([Select Id,School_ID_NCES__c from Location__c where School_ID_NCES__c =:SchoolNCESID ]);
List<Location__c> LocUpdateList = new List<Location__c>();

for (Location__c l: LocationInsert){
l.School_ID_NCES__c = SchoolNCESID;

// l.School_Name__c =
// l. School_Street_Address_1__c
// l. School_Street_Address_2__c
// l.School_City__c = 
// l.School_State__c
// l.School_Zip__c 

LocUpdateList.add(l);
}

if (LocUpdateList.size()> 0)
{
insert LocUpdateList;
}
}