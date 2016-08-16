Public class AddressDoctorResponse{
   public Integer statusCode;
   public String statusMessage;
   public String jobToken;
   public String campaignId;//data not set 
   public String reservedXML;//data not set 
   public AdditionalInformation []arrayOfAdditionalInformation;//data not set 
   public List<Result> lstResult;
   
      
   public class AdditionalInformation{
      public String name;
      public String value;
   
   }
   
   public class Result{
      public String processStatus;
      public String errorMessage;
      public String countryISO3;
      //public ResultData[] arrResultData;
      //ResultData
      public String resultNumber;
      public String mailabilityScore;
      public String resultPercentage;
      public String elementInputStatus;
      public String elementResultStatus;
      public String elementRelevance;
      public String extElementStatus;
      public String addressResolutionCode;
      public String addressType;
      public String languageISO3;
      //ResultData.Address
        public String[]   organization;
        public String[]  department;
        public String[]  contact;
        public String[]  email;
        public String[]  building;
        public String[]  subBuilding;
        public String[]  street;
        public String[]  houseNumber;
        public String[]  deliveryService;
        public String[]  locality;
        public String[]  preferredLocality;
        public String[]  postalCode;
        public String[]  province;
        public String[]  country;
        public String[]  residue;
        public String[]  receiptLines;
        public String[]  deliveryAddressLines;
        public String[]  countrySpecificLocalityLine;
        public String[]  formattedAddress;
        public String  addressComplete;
        public AdditionalInformation[]  AddressInformation; 
        //end of Address
        
      public Enrichment[] arrEnrichment;
   }
   
   public class ResultData{
      public String resultNumber;
      public String mailabilityScore;
      public String resultPercentage;
      public String elementInputStatus;
      public String elementResultStatus;
      public String elementRelevance;
      public String extElementStatus;
      public String addressResolutionCode;
      public String addressType;
      public String languageISO3;
      public Address objAddress;
      
  }

  public class Address{
    public String[]   organization;
    public String[]  department;
    public String[]  contact;
    public String[]  email;
    public String[]  building;
    public String[]  subBuilding;
    public String[]  street;
    public String[]  houseNumber;
    public String[]  deliveryService;
    public String[]  locality;
    public String[]  preferredLocality;
    public String[]  postalCode;
    public String[]  province;
    public String[]  country;
    public String[]  residue;
    public String[]  receiptLines;
    public String[]  deliveryAddressLines;
    public String[]  countrySpecificLocalityLine;
    public String[]  formattedAddress;
    public String addressComplete;
    public AdditionalInformation[]  AddressInformation;  
      
  
  }
  
  public class Enrichment{
      public String Type_x;
      public String PayloadXml;
  
  }
  
  public static AddressDoctorResponse parseAddressDoctorWSStubResponse(AddressDoctorWSStub.Response p_objAddressDoctorWSStubResponse){
      AddressDoctorResponse objAddressDoctorResponse =new AddressDoctorResponse();
      try{
           if(p_objAddressDoctorWSStubResponse !=null && 
                       p_objAddressDoctorWSStubResponse.results !=null && 
                       p_objAddressDoctorWSStubResponse.results.result[0] !=null  && 
                       p_objAddressDoctorWSStubResponse.results.result[0].ResultDataSet !=null &&
                       p_objAddressDoctorWSStubResponse.results.result[0].ResultDataSet.ResultData!=null){
               AddressDoctorWSStub.ResultData[] objAddressDoctorWSStubResultData=p_objAddressDoctorWSStubResponse.results.result[0].ResultDataSet.ResultData;
               System.debug('***objAddressDoctorWSStubResultData***'+objAddressDoctorWSStubResultData);
               System.debug('*** p_objAddressDoctorWSStubResponse.StatusCode***'+ p_objAddressDoctorWSStubResponse.StatusCode);
               System.debug('*** p_objAddressDoctorWSStubResponse.StatusMessage***'+ p_objAddressDoctorWSStubResponse.StatusMessage);
               System.debug('*** p_objAddressDoctorWSStubResponse.JobToken***'+ p_objAddressDoctorWSStubResponse.JobToken);
               System.debug('*** p_objAddressDoctorWSStubResponse.results.result[0].ProcessStatus***'+ p_objAddressDoctorWSStubResponse.results.result[0].ProcessStatus);
               System.debug('*** p_objAddressDoctorWSStubResponse.results.result[0].CountryISO3***'+ p_objAddressDoctorWSStubResponse.results.result[0].CountryISO3);
               System.debug('*** p_objAddressDoctorWSStubResponse.results.result[0].ResultDataSet***'+ p_objAddressDoctorWSStubResponse.results.result[0].ResultDataSet);
               System.debug('*** p_objAddressDoctorWSStubResponse.results.result[0].ResultDataSet.ResultData.size()***'+ p_objAddressDoctorWSStubResponse.results.result[0].ResultDataSet.ResultData.size());
               
               
               objAddressDoctorResponse.statusCode=p_objAddressDoctorWSStubResponse.StatusCode;
               objAddressDoctorResponse.statusMessage=p_objAddressDoctorWSStubResponse.StatusMessage;
               objAddressDoctorResponse.jobToken=p_objAddressDoctorWSStubResponse.JobToken;
               
               AddressDoctorResponse.Result objTempAddressDoctorResponseResult= new AddressDoctorResponse.Result();
               objAddressDoctorResponse.lstResult= new List<AddressDoctorResponse.Result>();
               
               //AddressDoctorWSStub.ResultData [] objAddressDoctorWSStubResultData= p_objAddressDoctorWSStubResponse.results.result[0].ResultDataSet.ResultData();
               for(AddressDoctorWSStub.ResultData itrResultData:  p_objAddressDoctorWSStubResponse.results.result[0].ResultDataSet.ResultData ){
                  System.debug('Hello');    
                  objTempAddressDoctorResponseResult= new AddressDoctorResponse.Result();
                  objTempAddressDoctorResponseResult.processStatus   =p_objAddressDoctorWSStubResponse.results.result[0].ProcessStatus;
                  objTempAddressDoctorResponseResult.errorMessage=p_objAddressDoctorWSStubResponse.results.result[0].ErrorMessage;
                  objTempAddressDoctorResponseResult.countryISO3   =p_objAddressDoctorWSStubResponse.results.result[0].CountryISO3;
               
                  //Resultdata           
                  objTempAddressDoctorResponseResult.resultNumber=itrResultData.ResultNumber;
                  objTempAddressDoctorResponseResult.mailabilityScore=itrResultData.MailabilityScore;
                  objTempAddressDoctorResponseResult.resultPercentage=itrResultData.ResultPercentage;
                  objTempAddressDoctorResponseResult.elementInputStatus=itrResultData.ElementInputStatus;
                  objTempAddressDoctorResponseResult.elementResultStatus=itrResultData.ElementResultStatus;
                  objTempAddressDoctorResponseResult.elementRelevance=itrResultData.ElementRelevance;
                  objTempAddressDoctorResponseResult.extElementStatus=itrResultData.ExtElementStatus;
                  objTempAddressDoctorResponseResult.addressResolutionCode=itrResultData.AddressResolutionCode;
                  objTempAddressDoctorResponseResult.addressType=itrResultData.AddressType;
                  objTempAddressDoctorResponseResult.languageISO3=itrResultData.LanguageISO3;
                  
                  
                /// System.debug('*** itrResultData.Address.HouseNumber ***'+itrResultData.Address.HouseNumber.string_x);
                  //Address
                 /*  objTempAddressDoctorResponseResult.organization=itrResultData.Address.Organization.string_x;
                    objTempAddressDoctorResponseResult.department=itrResultData.Address.Department.string_x;
                objTempAddressDoctorResponseResult.contact=itrResultData.Address.Contact.string_x;
                objTempAddressDoctorResponseResult.email=itrResultData.Address.Email.string_x;
                objTempAddressDoctorResponseResult.building=itrResultData.Address.Building.string_x;
                objTempAddressDoctorResponseResult.subBuilding=itrResultData.Address.SubBuilding.string_x;
                objTempAddressDoctorResponseResult.street=itrResultData.Address.Street.string_x;
                objTempAddressDoctorResponseResult.houseNumber=itrResultData.Address.HouseNumber.string_x;
                objTempAddressDoctorResponseResult.deliveryService=itrResultData.Address.DeliveryService.string_x;
                objTempAddressDoctorResponseResult.locality=itrResultData.Address.Locality.string_x;
                objTempAddressDoctorResponseResult.preferredLocality=itrResultData.Address.PreferredLocality.string_x;
                objTempAddressDoctorResponseResult.postalCode=itrResultData.Address.PostalCode.string_x;
                objTempAddressDoctorResponseResult.province=itrResultData.Address.Province.string_x;
                objTempAddressDoctorResponseResult.country=itrResultData.Address.Country.string_x;
                objTempAddressDoctorResponseResult.residue=itrResultData.Address.Residue.string_x;
               /// objTempAddressDoctorResponseResult.receiptLines=itrResultData.Address.ReceiptLines.string_x;
                objTempAddressDoctorResponseResult.deliveryAddressLines=itrResultData.Address.DeliveryAddressLines.string_x;
                objTempAddressDoctorResponseResult.countrySpecificLocalityLine=itrResultData.Address.CountrySpecificLocalityLine.string_x;
                objTempAddressDoctorResponseResult.formattedAddress=itrResultData.Address.FormattedAddress.string_x;
                */
                System.debug('***itrResultData.Address***'+itrResultData.Address);
                
                    if(itrResultData.Address!=null){
                        if(itrResultData.Address.HouseNumber!=null && itrResultData.Address.HouseNumber.string_x!=null){
                                objTempAddressDoctorResponseResult.houseNumber=itrResultData.Address.HouseNumber.string_x;
                        } 
                        System.debug('### objTempAddressDoctorResponseResult.houseNumber'+objTempAddressDoctorResponseResult.houseNumber); 
                        
                        if(itrResultData.Address.Street!=null && itrResultData.Address.Street.string_x!=null){
                                objTempAddressDoctorResponseResult.street=itrResultData.Address.Street.string_x;
                        } 
                        System.debug('### objTempAddressDoctorResponseResult.street'+objTempAddressDoctorResponseResult.street); 
                        
                        if(itrResultData.Address.Locality!=null && itrResultData.Address.Locality.string_x!=null){
                                objTempAddressDoctorResponseResult.locality=itrResultData.Address.Locality.string_x;
                        } 
                        System.debug('### objTempAddressDoctorResponseResult.locality'+objTempAddressDoctorResponseResult.locality); 
                        
                        if(itrResultData.Address.Province!=null && itrResultData.Address.Province.string_x!=null){
                                objTempAddressDoctorResponseResult.province=itrResultData.Address.Province.string_x;
                        } 
                        System.debug('### objTempAddressDoctorResponseResult.province'+objTempAddressDoctorResponseResult.province); 
                    
                        if(itrResultData.Address.PostalCode!=null && itrResultData.Address.PostalCode.string_x!=null){
                                objTempAddressDoctorResponseResult.postalCode=itrResultData.Address.PostalCode.string_x;
                        } 
                        System.debug('### objTempAddressDoctorResponseResult.postalCode'+objTempAddressDoctorResponseResult.postalCode); 
                        
                        if(itrResultData.Address.FormattedAddress!=null && itrResultData.Address.FormattedAddress.string_x!=null){
                                objTempAddressDoctorResponseResult.formattedAddress=itrResultData.Address.FormattedAddress.string_x;
                        }  
                        System.debug('### objTempAddressDoctorResponseResult.formattedAddress'+objTempAddressDoctorResponseResult.formattedAddress); 
                        
                        if(itrResultData.Address!=null &&itrResultData.Address.AddressComplete!=null){
                            objTempAddressDoctorResponseResult.addressComplete=itrResultData.Address.AddressComplete;
                        }
                        System.debug('*** itrResultData.Address.AddressComplete***'+itrResultData.Address.AddressComplete);
                       
                } 
                
                      
             /*   if(itrResultData.Address!=null &&itrResultData.Address.AddressComplete!=null){
                    objTempAddressDoctorResponseResult.addressComplete=itrResultData.Address.AddressComplete;
                    System.debug('*** itrResultData.Address.AddressComplete***'+itrResultData.Address.AddressComplete);
                }*/
                
                if(objTempAddressDoctorResponseResult!=null){
                        objAddressDoctorResponse.lstResult.add(objTempAddressDoctorResponseResult); 
                 } 
               }
               
               System.debug('*** objAddressDoctorResponse.lstResult***'+objAddressDoctorResponse.lstResult);
         }
      }
      catch(NullPointerException nullPtrExc){
          System.debug('***nullPtrExc in method-parseAddressDoctorWSStubResponse***'+nullPtrExc);
      }
      catch(Exception exc){
          System.debug('***exc***'+exc);
      }
  
  
     return objAddressDoctorResponse ;
  
  }
  
  
  public static String evaluateMailabilityScore(String p_MailabilityScore){
     String strMailabilityScoreMsg='';
     
     if(p_MailabilityScore!=null && p_MailabilityScore!=''){
         if(p_MailabilityScore=='5'){
             strMailabilityScoreMsg='Completely confident of delivery';
         }
         else if(p_MailabilityScore=='4'){
             strMailabilityScoreMsg='Almost certain';
         }
         else if(p_MailabilityScore=='3'){
         strMailabilityScoreMsg='A good chance of delivery';
         }
         else if(p_MailabilityScore=='2'){
             strMailabilityScoreMsg='A fair chance of delivery';
         }
         else if(p_MailabilityScore=='1'){
             strMailabilityScoreMsg='Very low chance of delivery';
         }
         else if(p_MailabilityScore=='0'){
             strMailabilityScoreMsg='No chance of delivery';
         }
     }
     return strMailabilityScoreMsg;
  
  }
  
  public static String evaluateProcessStatus(String p_strProcessStatus){
       string strProcessStatusMsg='';
       strProcessStatusMsg=(p_strProcessStatus!=null && p_strProcessStatus.equalsIgnoreCase('V4'))?' ': '';
       
       if(p_strProcessStatus!=null){
           if(  p_strProcessStatus.equalsIgnoreCase('V4')){
               strProcessStatusMsg='Verified - Input data correct - all (postally relevant) elements were checked and input matched perfectly';
           }
           else if(p_strProcessStatus.equalsIgnoreCase('V3')){
               strProcessStatusMsg='Verified - Input data correct on input but some or all elements were standardized or input contains outdated names or exonyms';
           }
           else if(p_strProcessStatus.equalsIgnoreCase('V2')){
               strProcessStatusMsg='Verified - Input data correct but some elements could not be verified because of incomplete reference data';
           }
           else if(p_strProcessStatus.equalsIgnoreCase('V1')){
               strProcessStatusMsg='Verified - Input data correct but the user standardization has deteriorated deliverability (wrong element user';
               strProcessStatusMsg+=' standardization - for example, postcode length chosen is too short). Not set by validation';
           }
           else if(p_strProcessStatus.equalsIgnoreCase('C4')){
               strProcessStatusMsg='Corrected- All (postally relevant) elements have been checked';
           }
           else if(p_strProcessStatus.equalsIgnoreCase('C3')){
               strProcessStatusMsg='Corrected- Some elements could not be checked';
           }
           else if(p_strProcessStatus.equalsIgnoreCase('C2')){
               strProcessStatusMsg='Corrected- Delivery status unclear (lack of reference data))';
           }
           else if(p_strProcessStatus.equalsIgnoreCase('C1')){
               strProcessStatusMsg='Corrected- Delivery status unclear because user standardization was wrong. Not set by validation';
           }
           else if(p_strProcessStatus.equalsIgnoreCase('I4')){
               strProcessStatusMsg='InCorrect- Data could not be corrected completely, but is very likely to be deliverable - single match (for example, HNO is wrong but only 1 HNO is found in reference data)';
           }
           else if(p_strProcessStatus.equalsIgnoreCase('I3')){
               strProcessStatusMsg='InCorrect- Data could not be corrected completely, but is very likely to be deliverable - multiple matches (e.g. HNO is wrong but more than 1 HNO is found in reference data)';
           }
           else if(p_strProcessStatus.equalsIgnoreCase('I2')){
               strProcessStatusMsg='InCorrect- Data could not be corrected, but there is a slim chance that the address is deliverable';
           }
           else if(p_strProcessStatus.equalsIgnoreCase('I1')){
               strProcessStatusMsg='InCorrect- Data could not be corrected and is pretty unlikely to be delivered';
           }
           else if(p_strProcessStatus.equalsIgnoreCase('Q3')){
               strProcessStatusMsg='Fast Completion- Suggestions are available - complete address';
           }
           else if(p_strProcessStatus.equalsIgnoreCase('Q2')){
               strProcessStatusMsg='Fast Completion- Suggested address is complete but combined with elements from the input (added or deleted)';
           }
           else if(p_strProcessStatus.equalsIgnoreCase('Q1')){
               strProcessStatusMsg='Fast Completion- Suggested address is not complete (enter more information)';
           }
           else if(p_strProcessStatus.equalsIgnoreCase('Q0')){
               strProcessStatusMsg='Fast Completion- Insufficient information provided to generate suggestions';
           }
           else if(p_strProcessStatus.equalsIgnoreCase('N1')){
               strProcessStatusMsg='Not Processed- Country was not recognized';
           }
           else if(p_strProcessStatus.equalsIgnoreCase('N2')){
               strProcessStatusMsg='Not Processed- Required reference database is not available';
           }
           else if(p_strProcessStatus.equalsIgnoreCase('W1')){
               strProcessStatusMsg='Web Service- Not allowed - No transactions for this country';
           }
           else if(p_strProcessStatus.equalsIgnoreCase('W7')){
               strProcessStatusMsg='Web Service- Input error - Engine has rejected Parameters or Input Data';
           }
           else if(p_strProcessStatus.equalsIgnoreCase('W7')){
               strProcessStatusMsg='Web Service- Timeout - Address was not processed';
           }
           else if(p_strProcessStatus.equalsIgnoreCase('W7')){
               strProcessStatusMsg='Web Service- Error - Address was not processedJobToken';
           }
           
       }
       return strProcessStatusMsg;
  
  }
}