@isTest public class AssessmentTest {
    
    
    @isTest public static void TestAssessMent()
   {
       Account a=[SELECT id FROM Account ROW LIMIT 1];
        Contact c=new contact(marks__c=100,accountID=a.id);
       Contact c1=new contact(marks__c=200,accountID=a.id);
       insert c;
       insert c1;
     AssessmentClass.method1();
     
     
     
   }

}