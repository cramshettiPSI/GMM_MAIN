global class MuleNotifier {

    public MuleNotifier() {
    }
    
    @future (callout=true)
    public static void notifyMule(String objType, String objId) {
        System.debug('MKR in notifyMule with values ' + objType + ', ' + objId);
        String url = 'https://cncs-msgtest.cloudhub.io/update';
        String bdy = 'object=' + objType + '&id=' + objId;
        Http h = new Http();
        HttpRequest req = new HttpRequest();
        req.setEndpoint(url);
        req.setMethod('POST');
        req.setTimeout(60000);
        req.setCompressed(false);
        req.setHeader('Content-Type', 'application/x-www-form-urlencoded');
        req.setBody(bdy);
        try{
            HttpResponse res = h.send(req);
            System.debug('MKR ' + res.toString());
            System.debug('MKR STATUS: ' + res.getStatus());
            System.debug('MKR STATUS_CODE: ' + res.getStatusCode());
        }
        catch (System.CalloutException e){
            System.debug('MKR exception thrown');
        }
    }
    
}