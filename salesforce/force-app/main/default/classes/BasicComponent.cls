public class BasicComponent {
	@auraEnabled
    public static List<Account> getAccountMethod(){
        return [SELECT ID ,Name FROM Account LIMIT 10];
    }
}