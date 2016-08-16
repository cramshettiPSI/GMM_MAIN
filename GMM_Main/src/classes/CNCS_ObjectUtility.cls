public class CNCS_ObjectUtility{
    //usage of below method - String recordTypeId = ObjectUtil.getObjectRecordTypeId(Lead.SObjectType, 'RECORDTYPE_NAME');
    public static String getObjectRecordTypeId(SObjectType sObjectType, String recordTypeName)
    {
        //Generate a map of tokens for all the Record Types for the desired object
        Map<string, schema.recordtypeinfo> mpRrecordTypeInfo = sObjectType.getDescribe().getRecordTypeInfosByName();
        System.debug('***RecordTypeInfo***'+mpRrecordTypeInfo);
        if(!mpRrecordTypeInfo.containsKey(recordTypeName))
            throw new RecordTypeException('Record type "'+ recordTypeName +'" does not exist.');

        //Retrieve the record type id by name
        return mpRrecordTypeInfo.get(recordTypeName).getRecordTypeId();
    }

    public class RecordTypeException extends Exception{
    
    }
    
    public class  CustomException extends Exception{
       
    }
    
    
    public static Intgr_MuleSoft__c retrieveWSDetails(String strWSname){
        String strHost=URL.getSalesforceBaseUrl().getHost();
        System.debug('Host: ' + strHost);
        Intgr_MuleSoft__c objIntgr_MuleSoftMatched;
        Map<String, Intgr_MuleSoft__c> mapStatusCodeCustomSetting = Intgr_MuleSoft__c.getAll();
        for(Intgr_MuleSoft__c objIntgr_MuleSoft : mapStatusCodeCustomSetting.values()){
            System.debug(' objIntgr_MuleSoft.sandbox__c: ' +  objIntgr_MuleSoft.sandbox__c);
            System.debug(' objIntgr_MuleSoft.name: ' +  objIntgr_MuleSoft.name);
            /* if(objIntgr_MuleSoft.name!=null && objIntgr_MuleSoft.name!='' && objIntgr_MuleSoft.sandbox__c!=null && objIntgr_MuleSoft.sandbox__c!='' 
                                                && objIntgr_MuleSoft.name.equalsIgnoreCase(strWSname) && objIntgr_MuleSoft.sandbox__c.equals(strHost)){
                System.debug('CNCS_ObjectUtility.retrieveWSDetails()-found');
                objIntgr_MuleSoftMatched=objIntgr_MuleSoft;
                break;
             }  */
             
             if(objIntgr_MuleSoft.name!=null && objIntgr_MuleSoft.name!='' && objIntgr_MuleSoft.name.equalsIgnoreCase(strWSname)){
                System.debug('CNCS_ObjectUtility.retrieveWSDetails()-found');
                objIntgr_MuleSoftMatched=objIntgr_MuleSoft;
                break;
             }  
        }
        return objIntgr_MuleSoftMatched;
   
     }
     
    public static String convertStringFormatOfDateFromHyphenToSlash(String strDate){
       String strWithSlash;
       try{
           if(strDate!=null && strDate!=''){
              if( strDate.contains('-')){
                 String []strSplittedData=strDate.split('-');
                 strWithSlash= strSplittedData[1]+'/'+strSplittedData[2]+'/'+strSplittedData[0];
              }
              else{
                  strWithSlash=strDate;
              }
           }
       }    
       catch(Exception exc){
          System.debug('***method convertStringFormatOfDateFromHyphenToSlash exception***'+exc.getMessage());
       }
       return strWithSlash;

    }


}