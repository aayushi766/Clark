public class ApexAssign2 {
    public static Map<ID,Set<ID>> mapClassToStudent()
    {
        Map<ID,Set<ID>> mapclsIdToStudent=new Map<ID,Set<ID>>();
          List<class__c> clsList=new List<class__c>();
          clsList=[SELECT ID FROM class__c ROW LIMIT 10];
          Set<ID> clsIdSet=new Set<ID>();
         for(class__c c:clsList)
         {
             clsIdSet.add(c.ID);
         }
         for(Student__c s:[SELECT ID,class__c FROM Student__c WHERE class__c IN : clsIdSet])
         {
             if(!mapclsIdToStudent.containsKey(s.class__c))
             {
                 mapclsIdToStudent.put(s.class__c,new Set<ID>());
             }
             mapclsIdToStudent.get(s.class__c).add(s.ID);
         }
        return mapclsIdToStudent;
          
    }

}