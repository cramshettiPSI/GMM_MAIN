public class PrimitiveApplicationHelper{


    public static void calcBdgLineTotal(String strPrimeAppId){
        //get all subApplicants belonging to this PrimeApplication
        String strNofoId='';
        String strOrgId='';
        List<Prime_Application__c> lstPrimeApp=[SELECT id,name,CNCS_Status__c,NOFO_RFP__c ,PrmAppOrgId__c,(SELECT id,name FROM Applications__r)  
                                                       FROM prime_application__c WHERE id = :strPrimeAppId];
        
        set<Application3__c> setApp =new set<Application3__c>();
        set<String> setAppId =new set<String>();
        if(lstPrimeApp!=null && lstPrimeApp.size()>0){
        
            for(Prime_Application__c objPrimeApp :  lstPrimeApp){
                //strNofoId=objPrimeApp.NOFO_RFP__c;
                strOrgId=objPrimeApp.PrmAppOrgId__c;
                for(Application3__c objApp :objPrimeApp.Applications__r){
                    setAppId.add( objApp.id);
                }
            } 
            
           /* if(strNofoId!=null ||strNofoId!=''){
                NOFA__c objNOFA__c=[select id,name,Organizations__c.name from NOFA__c where id = :strNofoId];
                
            //strOrgId
            }*/
             
            //set<CB3__Budget__c> setBdgApp = new set<CB3__Budget__c>();
            set<String> setBdgAppId = new set<String>();
            List<Application3__c> lstApp=new List<Application3__c>();
            if(setApp!=null && setApp.size() > 0){
                lstApp=[SELECT id,name, (select id,name FROM Budget_Applications__r) 
                        FROM Application3__c WHERE id in :setApp];
                     
                    
                if(lstApp!=null && lstApp.size() >0) {
                    for(Application3__c objApp: lstApp){
                        for(CB3__Budget__c objBdgApp: objApp.Budget_Applications__r){
                              //setBdgApp.add(objBdgApp.id);
                              setBdgAppId.add(objBdgApp.id);
                        }
                    }                                           
        
                    /*  List<CB3_Budget__c>   lstBdgApp= new List<CB3_Budget__c>();
                        lstBdgApp=[SELECT id,name,(SELECT id,name,CQ1__c FROM BudgetApplicationBudgetLines__r) FROM CB3_Budget__c where id in :setBdgApp];
                        decimal sumQ1=0;
                    
                        for(CB3_Budget__c objBdgApp : lstBdgApp){
                            for(CB3_BudgetLine__c objBdgLine:objBdgApp.BudgetApplicationBudgetLines__r){
                                sumQ1+=sumQ1;
                            }
                        }
                                    
                    */
                    List<AggregateResult> aRes= new List<AggregateResult>();
                    Decimal Q1;
                    if(setBdgAppId!=null && setBdgAppId.size() >0){
                        aRes = [SELECT SUM(cb3__CQ1__c) Q1 FROM cb3__BudgetLine__c where cb3__BudgetApplication__c  in :setBdgAppId]; 
                    
                        System.debug('res1'+aRes);   
                      
                        if(aRes !=null && aRes.size()>0){
                          Q1 = (Decimal)aRes.get(0).get('Q1'); 
                        }
      
                        Prime_Application__c objPrimeApp=new Prime_Application__c();
                        if(lstPrimeApp!=null && lstPrimeApp.size()>0){
                            objPrimeApp=lstPrimeApp[0];
                            objPrimeApp.SumOfBudgetLines__c    = Q1;
         
                            try{
                                Database.SaveResult updRes=Database.Update(objPrimeApp,false);
                            }
                            catch(DMLException dexc){
                                System.debug('Dml Exception'+dexc.getMessage());
                            }
                        }
      
                        //validation Rule
                    } //end of if -setBdgAppId  
                }//end of if - lstApp
            }//end of if - setApp  
        }// end of if for lstprimApp
      
    
    }// end of method



}