public with sharing class CarSearchResultController {
    @AuraEnabled(cacheable = true)
    public static List<Car__c> getCars(String carTypeId){
        if(String.isEmpty(carTypeId)){
            return [select Id,Name , picture__c, contact__r.name,geolocation__latitude__s,geolocation__longitude__s
            FROM Car__c
            WHERE available_for_rent__c = true];
        }else{
            return [select Id,Name , picture__c, contact__r.name,geolocation__latitude__s,geolocation__longitude__s
            FROM Car__c
            WHERE available_for_rent__c = true AND car_type__c =: carTypeId ];
        }
        
    }
    
}