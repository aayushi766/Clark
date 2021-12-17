public class AssessMentClass {
    public static void Method1()
    {
    Map<ID,ID> accMap=new map<ID,ID>();
                    MAp<Id,Integer> accMarks=new map<Id,Integer>();
                   
                   for(Contact con:[Select AccountID,marks__c FROM contact])
                   {
                      if(!accMap.containsKey(con.AccountID))
                      { 
                        accMap.put(con.AccountID,null);
                        accMarks.put(con.AccountID,0);
                      }
                      if(accMarks.get(con.AccountID)<con.marks__C)
                      {
                      
                       accMarks.put(con.AccountId,con.marks__c.intValue());
                       accMap.put(con.AccountId,con.id);
                      }
                   }
                   List<Account> accList=new List<Account>();
                   for(Account a:[Select ID,topper__C from account WHERE id IN:accMap.keySet()])
                   {
                       a.topper__c=accMap.get(a.ID);
                        accList.add(a);
                   }
                  upsert accList;
    }
                   


}