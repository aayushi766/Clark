@isTest
private class ConfigManagementController_IsTest {
    @TestSetup
    static void makeData(){
        List<Case> caseRecordsToInsert = new List<Case>();
        for(integer i = 0; i< 10; i++){
            caseRecordsToInsert.add(new Case(status = 'new'));
        }
        insert caseRecordsToInsert;
        List<Config__c> configToInsert = new List<Config__c>();
        for(integer i = 0; i< 200; i++){
            configToInsert.add(new Config__c(Label__c = 'Test'+i, Type__c='Test' , Amount__c = i));
        }
        insert configToInsert;
    }
    static testMethod void getAvailableConfigRecords(){
        List<Case> caseList = [SELECT ID FROM Case LIMIT 1];
        ConfigManagementController.CaseWrapper response = ConfigManagementController.getAvailableConfigRecords(caseList[0].Id);
        System.assertEquals(response.caseConfigs.size(), 200);
    }
    static testMethod void saveConfigRecords(){
        List<Case> caseList = [SELECT ID FROM Case LIMIT 1];
        List<Config__c> configsSelected = [SELECT ID,Label__c,Type__c,Amount__C FROM Config__c LIMIT 90]; // select 100 records to save
        List<ConfigManagementController.ConfigWrapper> request = new List<ConfigManagementController.ConfigWrapper>();
        for(Config__c config : configsSelected){
            ConfigManagementController.ConfigWrapper configWrap = new ConfigManagementController.ConfigWrapper();
            configWrap.Label = config.Label__c;
            configWrap.Type = config.Type__c;
            configWrap.Amount = config.Amount__c;
            configWrap.RecordId = config.Id;
            request.add(configWrap);
        }
        ConfigManagementController.saveConfigRecords(Json.serialize(request),caseList[0].Id);
        ConfigManagementController.CaseWrapper response = ConfigManagementController.getAvailableConfigRecords(caseList[0].Id);
        
        System.assertEquals(response.caseConfigs.size(), 110); // new response will have 110 records as 90 saved in case config out of 200
        ConfigManagementController.CaseWrapper response1 =  ConfigManagementController.getCaseConfigRecords(caseList[0].Id);
        System.assertEquals(response1.caseConfigs.size(), 90); // this will have 90 case config records saved in previous step
        
    }
    static testMethod void updateCaseRecord(){
        List<Case> caseList = [SELECT ID FROM Case LIMIT 1];
        ConfigManagementController.updateCaseRecord(caseList[0].Id);
        Case c = [SELECT Id,Status FROM Case WHERe Id =: caseList[0].Id];
        System.assertEquals(c.Status, 'Closed'); // Status updated to closed
        
    }
    static testMethod void sendCaseConfigDetailToExternalService(){
        Test.setMock(HttpCalloutMock.class, new ConfigManagementController_IsMock());
        Test.startTest();
        List<Case> caseList = [SELECT ID FROM Case LIMIT 1];
        List<Config__c> configsSelected = [SELECT ID,Label__c,Type__c,Amount__C FROM Config__c LIMIT 90]; // select 100 records to save
        ConfigManagementController.CaseWrapper request = new ConfigManagementController.CaseWrapper();
        request.caseId = caseList[0].Id;
        request.status = 'New';
        request.caseConfigs = new List<ConfigManagementController.ConfigWrapper>();
        for(Config__c config : configsSelected){
            ConfigManagementController.ConfigWrapper configWrap = new ConfigManagementController.ConfigWrapper();
            configWrap.Label = config.Label__c;
            configWrap.Type = config.Type__c;
            configWrap.Amount = config.Amount__c;
            configWrap.RecordId = config.Id;
            request.caseConfigs.add(configWrap);
        }
        
        ConfigManagementController.sendCaseConfigDetailToExternalService(Json.serialize(request));
        Test.stopTest();
        
    }
}
