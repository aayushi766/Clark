trigger CreatePIFPDFTrigger on PIF__c (before update) {

    for(PIF__c pif : trigger.new){
        if(pif.Generate_PDF__c && !trigger.oldMap.get(pif.Id).Generate_PDF__c){
            System.debug(pif.Id);
            System.debug(UserInfo.getSessionId());
            Utility.generatePIFPDFAttachment(pif.Id, UserInfo.getSessionId());
        }
    }
 
}