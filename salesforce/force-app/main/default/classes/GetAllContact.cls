public class GetAllContact {
    public static List<Contact> contList;
    @AuraEnabled
    public List<Contact> GetAllContactRecords(){
        contList = [SELECT ID , Name,Email from Contact];
        return contList;
    }
}