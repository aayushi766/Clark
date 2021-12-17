public class contactTriggerHandler {
    public static void onAfterUpdate(List<Contact> listContacts){
        Map<ID,String> mapAccName=new Map<ID,String>();
        for(Contact con:listContacts)
       {
         if(con.AccountId!=null)
        {
        if(!mapAccName.containsKey(con.AccountId))
        {
                mapAccName.put(con.AccountId,'');
        }
      
        }    
     
      }
      system.debug('hi----------------->');
  
        for(Contact c:[SELECT AccountId,FirstName FROM Contact WHERE AccountID IN:mapAccName.keySet()])
        {
        if(String.isNotBlank(c.FirstName))
        {
             mapAccName.put(c.AccountId,mapAccName.get(c.AccountID)+c.firstName.subString(0,1)); 
              
              
        }
        System.debug('Response---->'+mapAccName.get(c.AccountID));
        }
        List<Account> accToUpdate=new List<Account>();
       for(Account acc:[SELECT ID,Name 
                      FROM Account 
                      WHERE ID IN :mapAccName.KeySet()]){
             acc.Name+=mapAccName.get(acc.ID);
             accToUpdate.add(acc);        
//accToUpdate.add(new Account(Id=a.ID, Name= accIDs.get(a.ID)));

       }
       
       update accToUpdate;
 
        
    }
}