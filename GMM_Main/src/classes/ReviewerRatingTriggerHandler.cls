public without sharing class ReviewerRatingTriggerHandler{

    public ReviewerRatingTriggerHandler(ApexPages.StandardController controller) {

    }

    public static boolean hasAlreadyRanAfterDelete = false;
    public static boolean hasAlreadyRanAfterInsert = false;
    public static boolean hasAlreadyRanAfterUpdate = false;
    
    public static void handleAfterInsert(map<Id, Reviewer_Rating__c> newReviewerRatingMap)
    {   
        if(!hasAlreadyRanAfterInsert)
            hasAlreadyRanAfterInsert = true;
        Set<Id> userAccountIds = new Set<Id>();
        for(Reviewer_Rating__c rr: newReviewerRatingMap.values()){
            userAccountIds.add(rr.Reviewer_Name__c);
        }
        
        if(userAccountIds != null && userAccountIds.size() > 0){
            rollupToContact(newReviewerRatingMap.values(), userAccountIds);
        }
    }
    
    public static void handleAfterUpdate(map<Id, Reviewer_Rating__c> newReviewerRatingMap, map<Id, Reviewer_Rating__c> oldReviewerRatingMap)
    {   
        if(!hasAlreadyRanAfterUpdate)
            hasAlreadyRanAfterUpdate = true;
        Set<Id> userAccountIds = new Set<Id>();
        for(Reviewer_Rating__c rr: newReviewerRatingMap.values()){
            userAccountIds.add(rr.Reviewer_Name__c);
        }
        if(userAccountIds != null && userAccountIds.size() > 0){
            rollupToContact(newReviewerRatingMap.values(), userAccountIds);
        }
    }
    
    public static void handleAfterDelete(map<Id, Reviewer_Rating__c> oldReviewerRatingMap)
    {   
        if(!hasAlreadyRanAfterDelete)
            hasAlreadyRanAfterDelete = true;
        
        Set<Id> userAccountIds = new Set<Id>();
        for(Reviewer_Rating__c rr: oldReviewerRatingMap.values()){
            userAccountIds.add(rr.Reviewer_Name__c);
        }
        if(userAccountIds != null && userAccountIds.size() > 0){
            rollupToContact(oldReviewerRatingMap.values(), userAccountIds);
        }
    }
    
    private static void rollupToContact(List<Reviewer_Rating__c> newReviewerRatingMap, set<Id> userAccountIds)
    {
        List<Contact> updateUserAccounts = new List<Contact>();
        
        map<String, Contact> userAccountEmployementHistoryMap = new map<String, Contact>([Select Id, Name, Background_rating__c, Panel_Coordinator_Performance_Rating__c,
                                                Expert_Reviewer_Performance_Rating__c, Panel_Coordinator_Overall_Rating__c, Performance_Rating__c, Total_Years_of_Experience__c, 
                                                Performance_Rating_Validation__c, Expert_Reviewer_Overall_Rating__c, 
                                                (Select Id, Name, Area_Of_Expertise__c, Areas_Of_Study_Degree_Details__c, 
                                                CollegeORUniversity__c, Degree_Earned__c, Education_Name__c, Employer__c, 
                                                Experience_Type__c, Expertise__c, From__c, empFrom__c, Highest_Level_Of_Education__c, 
                                                Job_Description__c, Organization_Type__c, Organization_Type1__c, To__c, 
                                                empTo__c, Total_Employee_Experience_History__c, User_Account__c, Years_Of_Experience__c 
                                                From History__r) 
                                                From Contact 
                                                Where Id IN: userAccountIds]);
        
        map<String, Double> userAccountRatingMapPanelCoordinator = new map<String, Double>();
        AggregateResult[] groupedResults = [SELECT Reviewer_Name__c, AVG(Performance_Rating__c) FROM Reviewer_Rating__c Where Role__c = 'Panel Co-Ordinator' GROUP BY Reviewer_Name__c];
        for (AggregateResult ar : groupedResults)  {
            System.debug('Reviewer Name : ' + ar.get('Reviewer_Name__c'));
            System.debug('Average Performance Rating' + ar.get('expr0'));
            String reviewerName = String.valueOf(ar.get('Reviewer_Name__c'));
            Double avgRating = Double.valueOf(ar.get('expr0'));
            userAccountRatingMapPanelCoordinator.put(reviewerName, avgRating);
        }

        map<String, Double> userAccountRatingMapExpertReviewer = new map<String, Double>();
        AggregateResult[] groupedResults1 = [SELECT Reviewer_Name__c, AVG(Performance_Rating__c) FROM Reviewer_Rating__c Where Role__c = 'Expert Reviewer' GROUP BY Reviewer_Name__c];
        for (AggregateResult ar : groupedResults1)  {
            System.debug('Reviewer Name : ' + ar.get('Reviewer_Name__c'));
            System.debug('Average Performance Rating' + ar.get('expr0'));
            String reviewerName = String.valueOf(ar.get('Reviewer_Name__c'));
            Double avgRating = Double.valueOf(ar.get('expr0'));
            userAccountRatingMapExpertReviewer.put(reviewerName, avgRating);
        }
        
        for(Reviewer_Rating__c rr: newReviewerRatingMap){
            // User Account Record for Employement History
            Contact con = userAccountEmployementHistoryMap.get(rr.Reviewer_Name__c);
            
            Integer backGroundRatingUserccount  = 0;
            Double totalYearsOfExperience = 0;
            Double totalMonthsOfExperience = 0;
            String education = '';
            system.debug('### History Size : '+con.History__r.size());
            if(con != null && con.Id != null && con.History__r != null && con.History__r.size() > 0){
                
                for(History__c empHistory: con.History__r){
                    // Date.monthsBetween(Date) method returns the number of months between the Date that called the method 
                    //and the specified date, ignoring the difference in days.
                    
                    if(empHistory.empFrom__c != null && empHistory.empTo__c != null){
                        totalMonthsOfExperience +=  empHistory.empFrom__c.monthsBetween(empHistory.empTo__c);
                    }
                    
                    if(education != 'Graduate Degree (e.g. MA, PhD, MD, JD)'){
                        education = empHistory.Education_Name__c;
                    }
                }
                
                // Multiple Areas of Expertise for BackgroundRating: [Determined by the number of Employee History records]
                if(con.History__r.size() == 2){
                    backGroundRatingUserccount += 1;
                }else if(con.History__r.size() > 3){
                    backGroundRatingUserccount += 2;
                }
                totalYearsOfExperience = con.Total_Years_of_Experience__c;
               
                // Years of Expertise for BackgroundRating
                if(totalYearsOfExperience >= 5 && totalYearsOfExperience < 8){
                    backGroundRatingUserccount += 2;
                }else if(totalYearsOfExperience >= 8 && totalYearsOfExperience < 11){
                    backGroundRatingUserccount += 3;
                }else if(totalYearsOfExperience >= 11 && totalYearsOfExperience < 15){
                    backGroundRatingUserccount += 4;
                }else if(totalYearsOfExperience >= 15){
                    backGroundRatingUserccount += 5;
                }
                
                // Education for BackgroundRating
                // Need field-api to apply the logic
                if(education == 'Graduate Degree (e.g. MA, PhD, MD, JD)'){
                    backGroundRatingUserccount += 1;
                }
                
                // User Account Record for Reviewer_Ratings - Panel Coordinator
                Double avrRatingPanelCoordinator = userAccountRatingMapPanelCoordinator.get(rr.Reviewer_Name__c);
                
                // User Account Record for Reviewer_Ratings - Expert Reviewer
                Double avrRatingExpertReviewer = userAccountRatingMapExpertReviewer.get(rr.Reviewer_Name__c);
                
                con.Background_rating__c = backGroundRatingUserccount;
                if(avrRatingPanelCoordinator != null){
                    con.Panel_Coordinator_Performance_Rating__c = avrRatingPanelCoordinator;
                    con.Panel_Coordinator_Overall_Rating__c = backGroundRatingUserccount + avrRatingPanelCoordinator;
                }
                
                if(avrRatingExpertReviewer != null){
                    con.Expert_Reviewer_Performance_Rating__c = avrRatingExpertReviewer;
                    con.Expert_Reviewer_Overall_Rating__c = backGroundRatingUserccount + avrRatingExpertReviewer;
                }
                
                //con.Performance_Rating_Validation__c = ;
                //con.SSN__C = '111';
                //con.Verify_SSN__c = con.SSN__C;
                updateUserAccounts.add(con);
            }
        }
        if(updateUserAccounts != null && updateUserAccounts.size() > 0){
            update updateUserAccounts;
        }
    }
}