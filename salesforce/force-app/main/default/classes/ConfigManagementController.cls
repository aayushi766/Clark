/**
 * @Created By : Aayushi Agrawal
 * @Created Date : 18 December, 2021
 * @Purpose : To manage configs on case page
 */
public with sharing class ConfigManagementController {
    /*
    * @Purpose : To show available config records on Case Page
    */
    @AuraEnabled
    public static CaseWrapper getAvailableConfigRecords(String caseId){

        try {
            List<Case> caseRecord = [SELECT ID,Status FROM Case WHERE ID =: caseId];
            List<Available_Config__c> availableConfigList = [SELECT ID, Label__c FROM Available_Config__c WHERE case__c =: caseId];
            List<String> ignoreLabels = new List<String>();
            for(Available_Config__c availableConfig : availableConfigList){
                ignoreLabels.add(availableConfig.Label__c);
            }
            List<Config__c> configRecords = [SELECT ID,Label__c,Type__c,Amount__c
                                            FROM Config__c WHERE Label__c NOT IN : ignoreLabels]; //added label filter to show only records which case doesn't own.
            CaseWrapper responseWrap = new CaseWrapper();
            responseWrap.caseId = caseId;
            responseWrap.status = caseRecord[0].status;
            responseWrap.caseConfigs = new List<ConfigWrapper>();
            for(Config__c config : configRecords){
                ConfigWrapper configWrap = new ConfigWrapper();
                configWrap.Label = config.Label__c;
                configWrap.Type = config.Type__c;
                configWrap.Amount = config.Amount__c;
                configWrap.RecordId = config.Id;
                responseWrap.caseConfigs.add(configWrap);
            }
            return responseWrap;                                
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
    /*
    * @Purpose : To save config records with Case
    */
    @AuraEnabled
    public static void saveConfigRecords(String payload, String caseId){
        try {
            List<ConfigWrapper> payloadObject = (List<ConfigWrapper>)JSON.deserialize(payload, List<ConfigWrapper>.class);
            List<Available_Config__c> caseConfigToInsert = new List<Available_Config__c>();
            for(ConfigWrapper config : payloadObject){
                caseConfigToInsert.add(new Available_Config__c(case__c = caseId, label__c = config.label, 
                type__c = config.type, amount__c = config.amount));
            }
            Database.insert(caseConfigToInsert,false);
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
    /*
    * @Purpose : Wrapper class to get payload from lwc component
    */
    public class ConfigWrapper{
        @AuraEnabled
        public String RecordId;
        @AuraEnabled
        public String Label;
        @AuraEnabled
        public String Type;
        @AuraEnabled
        public Decimal Amount;
    }
    /*
    * @Purpose : method to show case config records
    */
    @AuraEnabled
    public static CaseWrapper getCaseConfigRecords(String caseId){

        try {
            List<Available_Config__c> availableConfigList = [SELECT ID,case__r.status, Label__c,Amount__c,Type__c FROM Available_Config__c 
                                                            WHERE case__c =: caseId order by createdDate desc];
            CaseWrapper responseWrap = new CaseWrapper();
            responseWrap.caseId = caseId;
            responseWrap.caseConfigs = new List<ConfigWrapper>();
            for(Available_Config__c config : availableConfigList){
                ConfigWrapper configWrap = new ConfigWrapper();
                configWrap.Label = config.Label__c;
                configWrap.Type = config.Type__c;
                configWrap.Amount = config.Amount__c;
                configWrap.RecordId = config.Id;
                responseWrap.status = config.case__r.status;
                responseWrap.caseConfigs.add(configWrap);
            }
            return responseWrap;                                
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
    @AuraEnabled
    public static void updateCaseRecord(String caseId){
        try {
            Case caseRec = new Case(id=caseId, status='closed');
            update caseRec;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
    @AuraEnabled
    public static Boolean sendCaseConfigDetailToExternalService(String payload){
        try {
            CaseWrapper payloadObject = (CaseWrapper)JSON.deserialize(payload, CaseWrapper.class);
            HttpRequest req = new HttpRequest();
            req.setEndpoint('https://requestcatcher.com/');
            req.setMethod('POST');
            req.setBody(payload);
            Http http = new Http();
            HTTPResponse res = http.send(req);
            if(res.getStatusCode() == 200){
                return true;
            }else{
                return false;
            }
            
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
    /*
    * @Purpose : Wrapper class to get payload from lwc component
    */
    public class CaseWrapper{
        @AuraEnabled
        public String caseId;
        @AuraEnabled
        public String status;
        @AuraEnabled
        public List<ConfigWrapper> caseConfigs;
        
    }

} 
