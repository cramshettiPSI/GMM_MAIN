public class ReopenProjectOnGrantCloseOutCtrl
{
    public String grantClosedOutId;
    public ReopenProjectOnGrantCloseOutCtrl()
    {
        grantClosedOutId = ApexPages.CurrentPage().getParameters().get('Id');
    }
    
    public void  reOpenProject()
    {
        grantClosedOutId = ApexPages.CurrentPage().getParameters().get('Id');
        system.debug('###grantClosedOutId : '+grantClosedOutId);
        
        if(grantClosedOutId != null && grantClosedOutId.trim().length() > 0)
        {
            Grant_Close_Out__c gco = [Select Id, Name, Master_Award__c From Grant_Close_Out__c Where Id = : grantClosedOutId Limit 1];
            if(gco != null)
            {
                Master_Award__c masterAward = [Select Id, Name, Status__c, Project_Name__c, 
                                                    (Select Id, Name, Grant_Status__c 
                                                        From Award__r) 
                                               From Master_Award__c 
                                               Where Id = : gco.Master_Award__c Limit 1];
                if(masterAward != null)
                {
                    // status of the Project should change to Open
                    if(masterAward.Project_Name__c != null)
                    {
                        Project__c pro = new Project__c(Id = masterAward.Project_Name__c, Status__c  = 'Open');
                        update pro;
                    }
                    
                    // status of the children awards should change to Awarded 
                    if(masterAward.Award__r != null && masterAward.Award__r.size() > 0)
                    {
                        for(Award__c award: masterAward.Award__r)
                        {
                            award.Grant_Status__c = 'Awarded';
                        }
                        update masterAward.Award__r;
                    }
                    
                    //Award__c newAward = new Award__c(Name = '', Master_Award__c = masterAward.Id, Grant_Status__c = 'Awarded');
                    // status of the Master Award should change from Complete to Active
                    masterAward.Status__c = 'Active';
                    update masterAward;
                }
            }
        }
    }
}