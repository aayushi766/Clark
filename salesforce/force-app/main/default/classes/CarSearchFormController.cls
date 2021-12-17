public with sharing class CarSearchFormController {
    @AuraEnabled(cacheable=true)
    public static List<Car_Type__c> getCarTypes(){
        return [SELECT ID,Name FROM Car_Type__c];
    }
    
}