global class Utility{

  @future(callout=true)
public static void generatePIFPDFAttachment(String pifId, String sid){
Http h = new Http();
HttpRequest req = new HttpRequest();
 
FaxGenerateEndpoint__c endpoint = [select url__c from FaxGenerateEndpoint__c limit 1];
 System.debug(endpoint.url__c + '?Id=' + pifId);
req.setEndpoint(endpoint.url__c + '?Id=' + pifId); 
req.setMethod('GET');
 
req.setHeader('Authorization', 'OAuth ' + sid);
 
HttpResponse res = h.send(req);
String response = res.getBody();
 
System.debug(response);
 
}
}