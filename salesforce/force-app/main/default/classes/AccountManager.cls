public with sharing class AccountManager {
    /*@AuraEnabled(cacheable = true)
    public static list<Account> getAccount(){
        return [SELECT Id , Phone , Name , Website FROM Account LIMIT 10];
    }*/
    @AuraEnabled
    public static List<Account> getAccount(integer numberOfAccount){
        return [SELECT Id , Phone , Name , Website FROM Account LIMIT : numberOfAccount];
    }
    
}