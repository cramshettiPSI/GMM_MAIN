public class searchproject{
    public  Project__c actobj{get;set;}
    public List<Project__c> projectList{get;set;}
    public integer actcount{get;set;}
    public searchproject(){
        projectList = new List<Project__c>();
        actobj = new Project__c();
        actcount = 0;
    }
    public void searchProjects(){
        String query ='select Name,Organization__c,Project_State__c,Project_Title__c,Street_Address_1__c,City__c,State__c from Project__c where id!=null';
       
    }
    public pagereference registration(){
    
        return null;
    }
    public pagereference createProject(){
        return new Pagereference('/a0b/e?retURL=%2Fa0b%2Fo');
    }
     public pagereference cancel(){
    
        return new Pagereference('/apex/Login_Page');
    }
    
}