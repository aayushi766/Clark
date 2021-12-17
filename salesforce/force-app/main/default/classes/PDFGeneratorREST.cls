@RestResource(urlMapping='/PDF/*')
global with sharing class PDFGeneratorREST {
 
  @HttpGet
  global static void doGet() {
        RestRequest req = RestContext.request;

    RestResponse res = RestContext.response;

        // Receives ID of the record to generate as a parameter
        Id pifId =  req.params.get('Id');
        system.debug('inRestClass');
        
        // Find the record to generate
        PIF__c pif = [select Name, PDFs_Ready_for_ECM__c from PIF__c  where id=:pifId ];
        
        // This is the Visual Force page that renders the body of our PDF
        PageReference pdf = Page.testingRest;
 
        // add parent id to the parameters for standardcontroller
        pdf.getParameters().put('id',pifId);
     
        // create the new attachment
        Attachment attach = new Attachment();
 
        // the contents of the attachment from the pdf
        Blob body;
 
        body = pdf.getContentAsPDF(); 
   
        attach.Body = body;
        attach.Name = 'FileName.pdf';
        attach.Description = 'This is the description';
        
        attach.IsPrivate = false;
        // attach PDF to the record
        attach.ParentId = pifId;
        
        insert attach;
  }
}