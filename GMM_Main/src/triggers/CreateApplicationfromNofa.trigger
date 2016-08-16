trigger CreateApplicationfromNofa on NOFA__c (After insert, After update) {
List <Application3__c> AppToInsert = new List <Application3__c> ();
for (NOFA__c c : Trigger.new) {
if (c.RSVP_Only__c == True) {
Application3__c a = new Application3__c ();
a.State_Application_Identifier__c='Test';
AppToInsert.add(a);
}
}
insert AppToInsert;
/*Set<Id> noFAids = new set<Id>();
for(NOFA__c nr : Trigger.new){
    noFAids.add(nr.Id);
}
list<NOFA__c> noFAList = new list<NOFA__c>([Select Id,Name,Match_Year__c,Year_1__c,Year_2__c,Year_3__c,Year_4__c,Year_5__c,Year_6__c,Year_7__c,Year_8__c,Year_9__c,Year_10__c,(Select Id,Name,Match_Rate_Percentage__c from Application__r) from NOFA__c where ID IN:noFAids]);
list<Application3__c> appToUpdate = new list<Application3__c>();
if(noFAList !=null && !noFAList.isEmpty()){
    for(NOFA__c noFA : noFAList){
        if(noFA.Match_Year__c == 0){
            for(Application3__c a : noFA.Application__r){
                a.Match_Rate_Percentage__c = noFA.Year_1__c;
                appToUpdate.add(a);
            }
        }else if(noFA.Match_Year__c == 1){
            for(Application3__c a : noFA.Application__r){
                a.Match_Rate_Percentage__c = noFA.Year_2__c;
                appToUpdate.add(a);
    }
        }else if(noFA.Match_Year__c == 2){
            for(Application3__c a : noFA.Application__r){
                a.Match_Rate_Percentage__c = noFA.Year_3__c;
                appToUpdate.add(a);
    }
        }else if(noFA.Match_Year__c == 3){
            for(Application3__c a : noFA.Application__r){
                a.Match_Rate_Percentage__c = noFA.Year_4__c;
                appToUpdate.add(a);
    }
        }else if(noFA.Match_Year__c == 4){
            for(Application3__c a : noFA.Application__r){
                a.Match_Rate_Percentage__c = noFA.Year_5__c;
                appToUpdate.add(a);
    }
        }else if(noFA.Match_Year__c == 5){
            for(Application3__c a : noFA.Application__r){
                a.Match_Rate_Percentage__c = noFA.Year_6__c;
                appToUpdate.add(a);
    }
        }else if(noFA.Match_Year__c == 6){
            for(Application3__c a : noFA.Application__r){
                a.Match_Rate_Percentage__c = noFA.Year_7__c;
                appToUpdate.add(a);
    }
        }else if(noFA.Match_Year__c == 7){
            for(Application3__c a : noFA.Application__r){
                a.Match_Rate_Percentage__c = noFA.Year_8__c;
                appToUpdate.add(a);
    }
        }else if(noFA.Match_Year__c == 8){
            for(Application3__c a : noFA.Application__r){
                a.Match_Rate_Percentage__c = noFA.Year_9__c;
                appToUpdate.add(a);
    }
        }else if(noFA.Match_Year__c > 8){
            for(Application3__c a : noFA.Application__r){
                a.Match_Rate_Percentage__c = noFA.Year_10__c;
                appToUpdate.add(a);
    }
        }
    }
    update appToUpdate;
}*/
}