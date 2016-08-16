public class AppSlotInformation{
    SlotInformation objSlotInformation{get;set;}
    List<SlotInformation> lstSlotInformation{get;set;}
    
    public AppSlotInformation(){
        objSlotInformation=new SlotInformation();
        lstSlotInformation=new List<SlotInformation>();
    
    }
    
    public void spawnInformation(List<cb3__BudgetLine__c> p_OldlstBdgLns,List<cb3__BudgetLine__c> p_NewlstBdgLns,Map<Id,cb3__BudgetLine__c> p_OldMap,Map<Id,cb3__BudgetLine__c> p_NewMap){
    
        System.debug('***spawnInformation***');
        Map<Id,cb3__Account_class__c> mpAcctClassIDToAccountclass=
                                        new Map<Id,cb3__Account_class__c>([  SELECT id,name,cb3__Ident__c,cb3__Active__c,cb3__Balance__c,cb3__CRM_Accounts__c,cb3__Default__c,
                                                                                    cb3__Depreciation__c,cb3__Description__c,cb3__FName__c,cb3__GLA__c,cb3__GLA_Info__c,cb3__GLA_Name__c,
                                                                                    cb3__Global_Account__c,cb3__Inserted__c,cb3__Intacct__c,cb3__Location__c,cb3__Number__c,
                                                                                    cb3__Organization__c,cb3__Other__c,cb3__Required__c,cb3__Subtype__c,cb3__Type__c,cb3__Units__c
                                                                              FROM cb3__Account_class__c    ]);
                                                   
        System.debug('***mpAcctClassIDToAccountclass***'+mpAcctClassIDToAccountclass);
        Set<String> setMembersData = new Set<String>();

        for (AccountClassForMembers__c  objAccountClassForMembers : AccountClassForMembers__c.getAll().values()){
            setMembersData.add(objAccountClassForMembers.classname__c);
        }
        
        set<String> setBdgLnId =new Set<String>(); 
        String strAcctClassId;
        String strAcctClassName;
        Map<Id,cb3__BASection3Level__c> mpIdToSec3Lvl=new Map<Id,cb3__BASection3Level__c>([Select id,name,acctClass__c,cb3__isMembers__c,cb3__SectionName__c 
                                                                                           FROM cb3__BASection3Level__c]);
        ///
        set<String> setAppId=new Set<String>();
        // Map<Id,ID> mpBdgLineIdToAppId=new Map<Id,ID>();
        for(cb3__BudgetLine__c itrBdgLine :p_NewlstBdgLns){
             setAppId.add(itrBdgLine.ApplicationId__c);
              //mpBdgLineIdToAppId.put(itrBdgLine.id,itrBdgLine.Application__c);
        }
        System.debug('***setAppId.'+setAppId);
        Map<Id,id> mpAppIdToAwardId=new Map<Id,Id>(); 
        List<application3__C> lstAppWithAward;
        if(setAppId!=null && setAppId.size()>0){
           lstAppWithAward= [select id,name,(select id,name from Award__r) from application3__C where id in :setAppId];
        }
        System.debug('***lstAppWithAward.'+lstAppWithAward);
            
        for(application3__C itrApp :lstAppWithAward){
            for(Award__c itAward:itrApp.Award__r){
                  mpAppIdToAwardId.put(itrApp.id,itAward.id);
                  break;
            }
        }
        System.debug('***mpAppIdToAwardId.'+mpAppIdToAwardId);
        ///
        
        for(cb3__BudgetLine__c itrBdgLine :p_NewlstBdgLns){
            setBdgLnId.add(itrBdgLine.id);
            cb3__BASection3Level__c objBASection3Level =mpIdToSec3Lvl.get(itrBdgLine.cb3__BudgetSection__c);
            strAcctClassId=itrBdgLine.cb3__Account__c;
            if(mpAcctClassIDToAccountclass!=null && mpAcctClassIDToAccountclass.containsKey(strAcctClassId)){
                strAcctClassName=mpAcctClassIDToAccountclass.get(strAcctClassId).Name;
            }
            System.debug('*** strAcctClassName ***'+strAcctClassName);
            System.debug('***objBASection3Level.cb3__SectionName__c***'+objBASection3Level.cb3__SectionName__c);
            System.debug('***objBASection3Level.cb3__isMembers__c***'+objBASection3Level.cb3__isMembers__c);
            
           /* if(objBASection3Level.cb3__SectionName__c!=null && objBASection3Level.cb3__SectionName__c!='' && objBASection3Level.cb3__SectionName__c.equalsIgnoreCase('Members')
                                                            && (objBASection3Level.cb3__isMembers__c==true) && setMembersData.contains(strAcctClassName)){
          */                                               
            if(objBASection3Level.cb3__SectionName__c!=null && objBASection3Level.cb3__SectionName__c!='' 
                                                            && (objBASection3Level.cb3__isMembers__c==true) && setMembersData.contains(strAcctClassName)){                                                
               objSlotInformation=new SlotInformation();
               objSlotInformation.bdglineId=itrBdgLine.id;
               objSlotInformation.acctClassId=itrBdgLine.cb3__Account__c;
            
               System.debug('*** strAcctClassName ***'+strAcctClassName);
               objSlotInformation.slotType= strAcctClassName;
               
               objSlotInformation.quantity_Rate=itrBdgLine.cb3__TotalAmount__c;
               objSlotInformation.livingAllowanceStipendAmountUnits_TotalAmount   =itrBdgLine.cb3__TotalAmount__c ;
                 
               if(itrBdgLine.cb3__TotalAmount__c > 0){
                     objSlotInformation.reqWAllowance=itrBdgLine.cb3__TotalAmount__c;}
               else {
                    objSlotInformation.reqWOAllowance= itrBdgLine.cb3__TotalAmount__c;
               }
                 
               objSlotInformation.recWAllowance=objSlotInformation.reqWAllowance;
               objSlotInformation.recWOAllowance=objSlotInformation.reqWOAllowance;
                 
               objSlotInformation.apprvdWAllowance=objSlotInformation.recWAllowance;
               objSlotInformation.apprvdWOAllowance=objSlotInformation.recWOAllowance;
               
               
               objSlotInformation.bdgAppId=itrBdgLine.cb3__BudgetApplication__c;
               objSlotInformation.appId=itrBdgLine.ApplicationId__c;
              ///// objSlotInformation.primeAppId=itrBdgLine.PrimeApplicationId__c;
              objSlotInformation.primeAppId=itrBdgLine.Prime_Application_Id__c;
                
               
               if(itrBdgLine.ApplicationId__c!=null && mpAppIdToAwardId.get(itrBdgLine.ApplicationId__c)!=null){
                objSlotInformation.awardId=mpAppIdToAwardId.get(itrBdgLine.ApplicationId__c);
               }
             
               lstSlotInformation.add(objSlotInformation);
            }
        }
        
        System.debug('*** lstSlotInformation***'+lstSlotInformation);
        System.debug('*** setBdgLnId***'+setBdgLnId);
        Map<Id,Slot__c> mpExistingIdToSlot=new Map<Id,Slot__c>();
        List<Slot__c> lstUpsSlot=new List<Slot__c>(); 
        Slot__c objSlot=new Slot__c();
        
        for(SlotInformation itrSlotInformation :lstSlotInformation){
            objSlot=new Slot__c();
            objSlot.Slot_Type__c=itrSlotInformation.slotType;
            objSlot.BudgetLine__c=itrSlotInformation .bdglineId;
            System.debug('*** itrSlotInformation.bdglineId;***'+itrSlotInformation .bdglineId);
            System.debug('*** objSlot.BudgetLine__c***'+objSlot.BudgetLine__c);
            objSlot.Budget_Application__c= itrSlotInformation.bdgAppId;
            objSlot.Application__c= itrSlotInformation.appId;
            objSlot.Recommended_w_Allowance__c=itrSlotInformation.recWAllowance;
            objSlot.Recommended_w_o_Allowance__c=itrSlotInformation.reqWOAllowance;
            objSlot.Requested_w_Allowance__c=itrSlotInformation.reqWAllowance;
            objSlot.Requested_w_o_Allowance__c= itrSlotInformation.recWOAllowance;
            objSlot.Prime_Application__c=itrSlotInformation.primeAppId;
            objSlot.Award__c     = itrSlotInformation.awardId;
            lstUpsSlot.add(objSlot);
        }
        System.debug('*** lstUpsSlot***'+lstUpsSlot);
                
        Map<String,Slot__c> mapBdgLineIdToExistingSlotRecs=new Map<String,Slot__c>();
        Map<String,Slot__c> mapBdgLineIdToUpsSlotRecs =new Map<String,Slot__c>();
        mapBdgLineIdToExistingSlotRecs=generateMapBdgLineIdToExistingSlotRecs(setBdgLnId);
        System.debug('*** mapBdgLineIdToExistingSlotRecs***'+mapBdgLineIdToExistingSlotRecs);
        mapBdgLineIdToUpsSlotRecs=manipulateSlotRecs(lstUpsSlot,mapBdgLineIdToExistingSlotRecs);
        System.debug('*** mapBdgLineIdToUpsSlotRecs***'+mapBdgLineIdToUpsSlotRecs);
        List<Slot__c> lstUpdNewSlotRecs=new List<Slot__c>();
        if(mapBdgLineIdToUpsSlotRecs!=null){
            lstUpdNewSlotRecs.addAll(mapBdgLineIdToUpsSlotRecs.values());
        }
        System.debug('*** lstUpdNewSlotRecs***'+lstUpdNewSlotRecs);
        if(lstUpdNewSlotRecs!=null && lstUpdNewSlotRecs.size()>0){
             upsertSlot(lstUpdNewSlotRecs);
        }
    }
    
    public Map<String,Slot__c> generateMapBdgLineIdToExistingSlotRecs(Set<String> p_SetBudgetLineId){
        System.debug('***p_SetBudgetLineIdp_SetBudgetLineId***'+p_SetBudgetLineId);
        List<Slot__c> lstExistingSlotRecs;
        
        if(p_SetBudgetLineId!=null && p_SetBudgetLineId.size()>0){
        lstExistingSlotRecs=[select id,name,Slot_Type__c,Application__c,Aggregate_Recommendation_w_Allowance__c,
                                                                    Aggregate_Recommendation_w_o_Allowance__c,Approved_With_Allowance__c,Approved_WithOut_Allowance__c,
                                                                    Award__c,BdgLineIdExtId__c,Budget_Application__c,BudgetLine__c,Enrollment_End_Date__c,Enrollment_Start_Date__c,
                                                                    Prime_Application__c,Recommended_w_Allowance__c,Recommended_w_o_Allowance__c,
                                                                    Requested_w_Allowance__c,Requested_w_o_Allowance__c
                                                                 from slot__c where BudgetLine__c       in  :p_SetBudgetLineId ];    // :lstTempBdgLineIds];
         }
       ///  List<Slot__c> lstExistingdupSlotRecs=[select id,name,BudgetLine__c       from slot__c ];                                                         
                                                                 
        System.debug('***lstExistingSlotRecs***'+lstExistingSlotRecs);    
                                                                  
        Map<String,Slot__c> mapBdgLineIdToExistingSlotRecs=new Map<String,Slot__c>();                                                        
        for(Slot__c itrExistingSlotRec: lstExistingSlotRecs){
            if(mapBdgLineIdToExistingSlotRecs!=null && !mapBdgLineIdToExistingSlotRecs.containsKey(itrExistingSlotRec.BudgetLine__c)){
                    mapBdgLineIdToExistingSlotRecs.put(itrExistingSlotRec.BudgetLine__c,itrExistingSlotRec);
            }
        }
        return mapBdgLineIdToExistingSlotRecs;
    }
    
    public Map<String,Slot__c> manipulateSlotRecs(List<Slot__c> p_lstUpsSlot,Map<String,Slot__c> p_mapBdgLineIdToExistingSlotRecs){
         Slot__c tempObjSlot=new Slot__c();
         List<Slot__c> lstUpdNewSlotRecs=new List<Slot__c>();
         Map<String,Slot__c> mapBdgLineIdToUpsSlotRecs =new Map<String,Slot__c>();
         for(Slot__c itrUpsSlotRec :p_lstUpsSlot){
                if(p_mapBdgLineIdToExistingSlotRecs!=null && p_mapBdgLineIdToExistingSlotRecs.containsKey(itrUpsSlotRec.BudgetLine__c)){
                    tempObjSlot=p_mapBdgLineIdToExistingSlotRecs.get(itrUpsSlotRec.BudgetLine__c);
                    tempObjSlot.Recommended_w_Allowance__c      =itrUpsSlotRec.Recommended_w_Allowance__c;
                    tempObjSlot.Recommended_w_o_Allowance__c      =itrUpsSlotRec.Recommended_w_o_Allowance__c;
                    tempObjSlot.Requested_w_Allowance__c    =itrUpsSlotRec.Requested_w_Allowance__c;
                    tempObjSlot.Requested_w_o_Allowance__c    =itrUpsSlotRec.Requested_w_o_Allowance__c;
                    tempObjSlot.Award__c=itrUpsSlotRec.Award__c;
                    tempObjSlot.Prime_Application__c=itrUpsSlotRec.Prime_Application__c;
                    System.debug('if part');
                    System.debug('***tempObjSlot***'+tempObjSlot);
                    System.debug('***itrUpsSlotRec***'+itrUpsSlotRec);
                    p_mapBdgLineIdToExistingSlotRecs.put(itrUpsSlotRec.BudgetLine__c,tempObjSlot);
                    mapBdgLineIdToUpsSlotRecs.put(itrUpsSlotRec.BudgetLine__c,tempObjSlot);
                    lstUpdNewSlotRecs.add(tempObjSlot);
                }
                else{
                    System.debug('else part');
                    System.debug('***itrUpsSlotRec***'+itrUpsSlotRec);
                    mapBdgLineIdToUpsSlotRecs.put(itrUpsSlotRec.BudgetLine__c,itrUpsSlotRec);
                    lstUpdNewSlotRecs.add(tempObjSlot);
                }
        }
        System.debug('***mapBdgLineIdToUpsSlotRecs***'+mapBdgLineIdToUpsSlotRecs);
        return mapBdgLineIdToUpsSlotRecs;
    }
    
    public void upsertSlot(List<Slot__c > p_lstSlot){
     try{
           if(p_lstSlot!=null && p_lstSlot.size()>0){
                upsert  p_lstSlot;
           }
         
         }catch(Exception exc){
             System.debug('AppSlot Information upsert error***'+exc.getMessage());
         }  
    }
}