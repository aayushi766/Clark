@isTest public class TestRestrictContactByName {
    @isTest static void TestMethod1()
    {
    Contact c=new Contact(FirstNAme='Aayushi',LastName='invalidName');
        test.startTest();
    Database.upsertResult r=Database.upsert(c);
        
        test.stopTest();
        System.assertEquals('The Last Name invalidName is not allowed for DML', r.getErrors()[0].getMessage());
    }
    

}