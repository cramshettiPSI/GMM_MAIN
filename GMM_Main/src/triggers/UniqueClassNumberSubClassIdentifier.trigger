trigger UniqueClassNumberSubClassIdentifier on Class__c (before insert, before update) {

    if(trigger.isbefore){
        set<id> parentids = new set<id>();
        for(Class__c c: trigger.new)
        {
            parentids.add(c.Region__c);
        }
        map<id,list<Class__c>> parentmap = new map<id,list<Class__c>>();
        for(Class__c c : [select id,Region__c,Class_Number__c, Sub_Class_Identifier__c from Class__c where Region__c in: parentids ])
        {
            if(parentmap.containskey(c.Region__c))
            {
                list<Class__c> dlist = parentmap.get(c.Region__c);
                dlist.add(c);
                parentmap.put(c.Region__c,dlist);
            }
            else
            {
                parentmap.put(c.Region__c,new list<Class__c>{c});
            }
        }
        system.debug('!!!!!!'+parentmap);
        for(Class__c c : trigger.new)
        {
            if(parentmap.get(c.Region__c) != null)
            {
                for(Class__c existingClass : parentmap.get(c.Region__c))
                {
                    if(c.Id != existingClass.Id && c.Class_Number__c == existingClass.Class_Number__c)
                    {
                        if(c.Sub_Class_Identifier__c==null || (c.Sub_Class_Identifier__c!=null && c.Sub_Class_Identifier__c == existingClass.Sub_Class_Identifier__c)){ 
                            c.adderror('Record with Class number already exists');
                        }
                    }
                }
            }
        }
    }
}