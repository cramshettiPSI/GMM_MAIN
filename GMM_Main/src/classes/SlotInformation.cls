public class SlotInformation{

     public String slotType{get;set;}
    public Decimal reqWAllowance{get;set;}
    public Decimal  reqWOAllowance{get;set;}
    public Decimal recWAllowance{get;set;}
    public Decimal recWOAllowance{get;set;}
    public Decimal apprvdWAllowance{get;set;}
    public Decimal apprvdWOAllowance{get;set;}
    public Decimal livingAllowanceStipendAmountUnits_TotalAmount{get;set;}
    public Decimal quantity_Rate{get;set;}
    public String  bdglineId{get;set;}
    public String  acctClassId{get;set;}
    public String  awardId{get;set;}
    public String  primeAppId{get;set;}
    public String  appId{get;set;} 
    public String  bdgAppId{get;set;}   
    public String  slotId{get;set;}
    
    
    public SlotInformation(){
        slotType='';
      /*  String reqWAllowance='';
        String reqWOAllowance='';
        String recWAllowance='';
        String recWOAllowance='';
        String apprvdWAllowance='';
        String apprvdWOAllowance='';*/
    }


}