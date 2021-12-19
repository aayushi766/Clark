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
    public static List<Config__c> getAvailableConfigRecords(String caseId){

        try {
            List<Available_Config__c> availableConfigList = [SELECT ID, Label__c FROM Available_Config__c WHERE case__c =: caseId];
            List<String> ignoreLabels = new List<String>();
            for(Available_Config__c availableConfig : availableConfigList){
                ignoreLabels.add(availableConfig.Label__c);
            }
            List<Config__c> configRecords = [SELECT ID,Label__c,Type__c,Amount__c
                                            FROM Config__c WHERE Label__c NOT IN : ignoreLabels]; //added label filter to show only records which case doesn't own.
            return configRecords;                                
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
        public String RecordId;
        public String Label;
        public String Type;
        public Integer Amount;
    }
    /*
    * @Purpose : method to show case config records
    */
    @AuraEnabled
    public static List<Available_Config__c> getCaseConfigRecords(String caseId){

        try {
            List<Available_Config__c> availableConfigList = [SELECT ID, Label__c,Amount__c,Type__c FROM Available_Config__c 
                                                            WHERE case__c =: caseId order by createdDate desc];
            return availableConfigList;                                
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}
