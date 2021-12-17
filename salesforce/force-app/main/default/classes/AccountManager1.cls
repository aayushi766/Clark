public without sharing class AccountManager1 {
    @AuraEnabled(cacheable = true)
    public static List<Account> getAllAccount(integer numberOfRec){
        return [SELECT ID,Name,Website,Phone FROM Account LIMIT :numberOfRec];
            
    }
    
}