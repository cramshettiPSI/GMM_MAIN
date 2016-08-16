public class  SlotInformationWithPrmAppCntrl{

    public ApexPages.StandardController stdcontroller;
    public Prime_Application__c prmApp{get;set;}
    public List<Slot__c> lstSlot{get;set;}
    public List<SlotGroupedData> lstSlotGroupedData{get;set;}
    
    public SlotInformationWithPrmAppCntrl(){
          System.debug('***SlotInformationWithApp constructor***');
    
    }
    
    public SlotInformationWithPrmAppCntrl(ApexPages.StandardController p_controller){
     try{
          this.stdcontroller= p_controller;
          this.prmApp= (Prime_Application__c )stdController.getrecord();
          System.debug('***prmApp***'+prmApp);
          String strPrmAppId='';
          strPrmAppId=(prmApp!=null )? prmApp.id:'';
          //readSlotInformation(strPrmAppId);
          deriveAggregateData( strPrmAppId);
     }     
     catch(Exception exc){
            System.debug('***error in SlotInformationWithPrmAppCntrl constructor***'+exc.getMessage());
        }   
      }
      
   
    
    public void deriveAggregateData(String p_strPrmAppId){  
            
        AggregateResult[] groupedResults;
        //List<SLOt__c> lstSlot=[select name from slot__c where name = :strPrmAppId];
        //System.debug('***lstSlot' + lstSlot);
        try{
            groupedResults=[select Slot_Type__c st,avg(Recommended_w_Allowance__c) awa,avg(Recommended_w_o_Allowance__c) awoa 
                                  from slot__c where Prime_Application__c= :p_strPrmAppId  
                                  group by  Slot_Type__c];
            System.debug('***groupedResults' + groupedResults);
            
            SlotGroupedData objTempSlotGroupedData=new SlotGroupedData();
            lstSlotGroupedData=new List<SlotGroupedData>();
            for (AggregateResult ar : groupedResults)  {
                System.debug('st' + ar.get('st'));
                System.debug('Aggr Recommended_w_Allowance' + ar.get('awa'));
                System.debug('Aggr Recommended_w_o_Allowance' + ar.get('awoa'));
                objTempSlotGroupedData=new SlotGroupedData();
                objTempSlotGroupedData.strSlotType=(ar.get('st')!=null )?String.valueOf(ar.get('st')):'';
                objTempSlotGroupedData.AggregateRecommendationWAllowance= (ar.get('awa')!=null )?String.valueOf(ar.get('awa')):'';    
                objTempSlotGroupedData.AggregateRecommendationWOAllowance=(ar.get('awoa')!=null) ?String.valueOf(ar.get('awoa')):''; 
                lstSlotGroupedData.add(objTempSlotGroupedData);
            }
       }catch(DMLException sqlExc){
          System.debug('SQLException in method deriveAggregateData'+sqlExc);
       }
       catch(Exception exc){
           System.debug('SQLException in method deriveAggregateData'+exc);
       }     
    }   
    
    
    public class SlotGroupedData{
                public String strSlotType{get;set;}
                Public String AggregateRecommendationWAllowance{get;set;}
                Public String AggregateRecommendationWOAllowance{get;set;}
    } 
     
    /* this method is no longer used*/  
   public void readSlotInformation(String p_strPrmAppId){
         System.debug('***p_strPrmAppId***'+p_strPrmAppId);
         if(p_strPrmAppId!=null && p_strPrmAppId!=''){
                System.debug('readslotinformation if prmappid !=null');
                lstSlot =[SELECT ID,NAME,Slot_Type__c,Award__c,Prime_Application__c,ApplicationId__c,Budget_Application__c,Requested_w_Allowance__c,Requested_w_o_Allowance__c,
                                 Recommended_w_Allowance__c, Recommended_w_o_Allowance__c, Aggregate_Recommendation_w_Allowance__c,Aggregate_Recommendation_w_o_Allowance__c,
                                 Enrollment_Start_Date__c,Enrollment_End_Date__c 
                          FROM SLOT__c  Where Prime_Application__c= :p_strPrmAppId];  //Where Prime_Application__c= :p_prmAppId
         }         
         System.debug('*** lstSlot ***'+lstSlot );
         deriveAggregateData( p_strPrmAppId);    
   
    }
    /* this method is no longer used*/ 
    public void readSlotInformation1(String p_strPrmAppId){
         System.debug('***p_strPrmAppId***'+p_strPrmAppId);
         if(p_strPrmAppId!=null && p_strPrmAppId!=''){
                System.debug('readslotinformation if prmappid !=null');
                lstSlot =[SELECT ID,NAME,Slot_Type__c,Award__c,Prime_Application__c,ApplicationId__c,Budget_Application__c,Requested_w_Allowance__c,Requested_w_o_Allowance__c,
                                 Recommended_w_Allowance__c, Recommended_w_o_Allowance__c, Aggregate_Recommendation_w_Allowance__c,Aggregate_Recommendation_w_o_Allowance__c,
                                 Enrollment_Start_Date__c,Enrollment_End_Date__c 
                          FROM SLOT__c  Where Prime_Application__c= :p_strPrmAppId];  //Where Prime_Application__c= :p_prmAppId
         }         
         System.debug('*** lstSlot ***'+lstSlot );    
    }
    
    
    /* this method is no longer used*/ 
     public PageReference updateSlotRecs(){
        try{
           System.debug('*** lstSlot ***'+lstSlot );
           if(lstSlot !=null && lstSlot.size()>0){
             Update lstSlot ;
           }
        }
        catch(DMLException dmlExc){
            System.debug('***PrimeApp lstSlot -dmlExc ***'+dmlExc);
        }
        catch(Exception exc){
            System.debug('***lstSlot ***'+exc );
        }
        return null;
    
    }  



}