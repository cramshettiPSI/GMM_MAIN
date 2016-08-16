public class PIWISelectClassController{
 
    //Our collection of the class/wrapper objects wrapPIWI
    public List<wrapPIWI> wrapPIWIList {get; set;}
    public List<Processinstanceworkitem> selectedPIWIs{get;set;}
    public Set<Id> NoticeIds = new Set<Id>();
 
    public PIWISelectClassController(){
        if(wrapPIWIList == null) {
            wrapPIWIList = new List<wrapPIWI>();
            for(Processinstanceworkitem a: [select processinstance.targetobjectid,processinstance.targetobject.name from processinstanceworkitem where actorid = :userinfo.getuserid() limit 50]) {
                // As each Processinstanceworkitem is processed we create a new wrapPIWI object and add it to the wrapPIWIList
                wrapPIWIList.add(new wrapPIWI(a));
                NoticeIds.add(a.processinstance.targetobjectid);
                    
            }
            
        }
    }

    // This is our wrapper/container class. In this example a wrapper class contains both the standard salesforce object Processinstanceworkitem and a Boolean value
    public class wrapPIWI {
        public Processinstanceworkitem acc {get; set;}
        public ID piwiID {get; set;}
        public String piwiName {get; set;}
        public String FundingOpportunityTitle {get; set;}
 
        public wrapPIWI(Processinstanceworkitem p) {
            acc = p;
            piwiID = p.processinstance.targetobjectid;
            piwiName = p.processinstance.targetobject.name;
            FundingOpportunityTitle = 'myFundingOpportunity';
            }
    }
}