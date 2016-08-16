public class SampleCntrl{

    public void sampleAction(){
       String strHost=URL.getSalesforceBaseUrl().getHost();
       System.debug('Host: ' + strHost);
    
    
    }


}