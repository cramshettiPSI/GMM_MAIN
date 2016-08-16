public class LocationDetailExt {
    
    
    Public Location__c locationInput{get;set;}    
    public String id;
    public String LocationId;
    Public String nofaid;
    public Application3__c Application {get;set;}
    public NOFA__c Nofa{get;set;}
    public String queryString {get;set;} 
    Public String Address{get;set;}
    private ApexPages.StandardController scontroller;

   
    public LocationDetailExt (ApexPages.StandardController controller) 
    {      
           
        //locationInput= new Location__c();
        locationInput = (Location__c)controller.getRecord();
        id=Apexpages.currentPage().getParameters().get('id');  
        // nofaid=Apexpages.currentPage().getParameters().get('nofaid');  
        // id=Apexpages.currentPage().getParameters().get('applicationid');  
        
        
        If(id!=null && id!='')
            locationInput=[select Application__r.NOFA_RFP__r.Lodging_Information__c,Accessible_for_people_with_disablities__c,Economic_Opportunities__c,Capacity_Building__c,Healthy_Futures__c,Environmental_Stewardship__c ,Disaster_Services__c ,School_Zip_new__c,Name,School_City_new__c,School_State_new__c ,School_Street_Address_new__c ,School_ID_NCES__c , RecordType.Name,School_Name__c, School_Street_Address_1__c, School_Street_Address_2__c, School_City__c, School_State__c, School_Zip__c, Application__r.NOFA_RFP__r.Site_Type_and_Summer_Associates__c,Application__r.NOFA_RFP__r.Additional_Operating_Site_Information__c,Application__r.NOFA_RFP__r.Site_Date_Information__c,Application__r.NOFA_RFP__r.Site_Type__c,Application__r.NOFA_RFP__r.Focus_Area_and_Objectives_Location__c,Application__r.NOFA_RFP__r.EIN_Information__c,Application__r.NOFA_RFP__r.School_Information__c,Application__r.NOFA_RFP__r.Standard_Information__c,Application__r.NOFA_RFP__r.Volunteer_Information__c,Application__c,Beds_Provided__c,City__c,Description_of_Accessibility__c,Distance_to_Location_of_Service__c,Education__c,Is_this_a_K_12_school__c,Kitchen__c,Laundry__c,Location_EIN__c,Location_Type__c,Lodging_Arrival_Date__c,Lodging_Category__c,Lodging_Departure_Date__c,Lodging_Description__c,Lodging_Type__c,NCES_ID__c,NOFA1__c,Application__r.NOFA_RFP__c,NOFA__c,Number_of_Unduplicated_Volunteers__c,Number_of_Volunteers__c,Other_Capacity_Building__c,Other_Disaster_Services__c,Other_Economic_Opportunities__c,Other_Education__c,Other_Environmental_Stewardship__c,Other_Healthy_Futures__c,Other_Veterans_Military_Families__c,Projected_End_Date__c,Projected_Start_Date__c,Refrigerator_Microwave__c,Shower__c,Site_Type__c,State__c,Station_Type__c,Street_Address_1__c,Street_Address_2__c,Summer_Associates__c,Supervisor_Email__c,Supervisor_Name__c,Supervisor_Organization__c,Supervisor_Phone_Number__c,Supervisor_Phone_Number_Extension__c,Undisclosed_Location__c,Veterans_Military_Families__c,Veterans_Served__c,Zip__c from Location__c where id=:id];                    
        
        /*  If(id!=null && id!='')
Application=[Select Id, Name,NOFA_RFP__c,NOFA_RFP__r.Volunteer_Information__c,Nofa_RFP__r.School_Information__c,NOFA_RFP__r.Focus_Area_and_Objectives_Location__c,Nofa_RFP__r.Standard_Information__c,
NOFA_RFP__r.EIN_Information__c,Nofa_RFP__r.Site_Date_Information__c,NOFA_RFP__r.Site_Type__c,Nofa_RFP__r.Site_Type_and_Summer_Associates__c,NOFA_RFP__r.Additional_Operating_Site_Information__c,Nofa_RFP__r.Lodging_Information__c from Application3__c where id=:id]; 

*/

        
    }
    
  public pagereference edit()
  {
  pagereference p = new pagereference('/apex/LocationEditPage?id='+locationInput.id);
  return p;
  }
    
    
}