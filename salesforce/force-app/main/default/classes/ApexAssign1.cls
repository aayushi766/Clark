public class ApexAssign1
{
     public static List<Student__c> classToStudent(ID classID)
     {
         List<Student__c> stuList=new List<Student__c>();
         stuList=[SELECT Name,class__r.Name FROM Student__c WHERE Student__c.class__c=:classID];
        
         return stuList;
     }
}