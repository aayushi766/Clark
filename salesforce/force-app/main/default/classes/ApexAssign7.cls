public class ApexAssign7 {
    public static void checkField(ID AccountID)
    {
        
        List<Account> accList=new List<Account>();
           accList=[SELECT Id,contactIDs__c,(SELECT ID FROM Contacts) FROM Account WHERE ID=:accountID];
        for(Account a:accList)
        { 
            
            
            if(a.ContactIDs__c==NULL)
            {
                for(Contact c:a.contacts)
                {
                    a.ContactIDs__c=a.ContactIDs__c+','+c.ID;
                }
            }
            
            else
            {
               List<String> IdList=new List<string>();
                for(Contact c:a.contacts)
                {
                    IdList.add(c.ID);
                   
                }
                 System.debug(IdList);
               for(String str:IdList)
               {
                   if(!a.ContactIDs__c.contains(str))
                   {
                       a.ContactIDs__c+=','+str;
                   }
               }
                 System.debug(a.ContactIDs__c);
                
            }
        }
        update accList;
        
    }

}