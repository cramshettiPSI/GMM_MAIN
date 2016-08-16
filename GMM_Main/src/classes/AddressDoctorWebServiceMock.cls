@isTest
global class AddressDoctorWebServiceMock implements WebServiceMock{
    global void doInvoke(
        Object stub,
        Object request,
        Map<String, Object> response,
        String endpoint,
        String soapAction,
        String requestName,
        String responseNS,
        String responseName,
        String responseType)
    {
        AddressdoctorComWebservice5.Address add=new AddressdoctorComWebservice5.Address();
        String[] postalCode=new String[]{'22305'};
        AddressdoctorComWebservice5.ArrayOfString postalCode1=new AddressdoctorComWebservice5.ArrayOfString();
            postalCode1.string_x= postalCode; 
            add.PostalCode=postalCode1;
            
            String[] Province=new String[]{'Va'};
       AddressdoctorComWebservice5.ArrayOfString Province1=new AddressdoctorComWebservice5.ArrayOfString();
            Province1.string_x= Province; 
           add.Province=Province1;
       
        String[] Street=new String[]{'landover st'};
        AddressdoctorComWebservice5.ArrayOfString Street1=new AddressdoctorComWebservice5.ArrayOfString();
            Street1.string_x= Street; 
            add.Street=Street1;
            

        String[] Locality=new String[]{'alexandria'};
        AddressdoctorComWebservice5.ArrayOfString Locality1=new AddressdoctorComWebservice5.ArrayOfString();
            Locality1.string_x= Locality; 
            add.Locality=Locality1;
            add.AddressComplete='landover st, alexandria,va,22305';
        AddressdoctorComWebservice5.ResultData rd=new AddressdoctorComWebservice5.ResultData();
        rd.Address=add;
        
        AddressdoctorComWebservice5.ResultData[] resData=new AddressdoctorComWebservice5.ResultData[]{rd};
            
            AddressdoctorComWebservice5.ArrayOfResultData arResData=new AddressdoctorComWebservice5.ArrayOfResultData();
            arResData.resultData = resData;
            
        AddressdoctorComWebservice5.Enrichment enr=new AddressdoctorComWebservice5.Enrichment();
enr.PayloadXml='<GEOCODING><Status>EGC8</Status><COMPLETE>38.833050, -77.063650 WGS84</COMPLETE><LATITUDE>38.833050</LATITUDE><LONGITUDE>-77.063650</LONGITUDE><LAT_LONG_UNIT>WGS84</LAT_LONG_UNIT></GEOCODING>';
AddressdoctorComWebservice5.Enrichment[] enrArr=new AddressdoctorComWebservice5.Enrichment[]{enr};
AddressdoctorComWebservice5.ArrayOfEnrichment aoenr=new AddressdoctorComWebservice5.ArrayOfEnrichment();
aoenr.Enrichment=enrArr;
                
        AddressdoctorComWebservice5.Result adResult=new AddressdoctorComWebservice5.Result();
        adResult.ResultDataSet=arResData;
        adResult.Enrichments=aoenr;
        AddressdoctorComWebservice5.Result[] resData1=new AddressdoctorComWebservice5.Result[]{adResult};
        AddressdoctorComWebservice5.ArrayOfResult aores=new AddressdoctorComWebservice5.ArrayOfResult();
            aores.Result=resData1;
            
        

        AddressdoctorComWebservice5.Response res=new AddressdoctorComWebservice5.Response();
        res.Results=aores;
        AddressdoctorComWebservice5.ProcessResponse_element resElement= new AddressdoctorComWebservice5.ProcessResponse_element();
        resElement.ProcessResult = res;
        response.put('response_x',resElement );
    }
    
}