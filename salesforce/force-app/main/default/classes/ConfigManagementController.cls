
public with sharing class ConfigManagementController {
    @AuraEnabled
    public static List<Config__c> getAvailableConfigRecords(){
        try {
            List<Config__c> configRecords = [SELECT ID,Label__c,Type__c,Amount__c
                                            FROM Config__c ];
            return configRecords;                                
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}
