public class ContactTriggerHandler1 {
   
   public static void onAfterUpdate(List<Contact> mContacts){
       
       Map<ID,String> accIDs=new Map<ID,String>();
       
       for(Contact con:mContacts){
         
           if(con.AccountID != null){
           
               if(!accIDs.containsKey(con.AccountID)){
                   accIDs.put(con.AccountID,'');    
               }
               //accIDs.get(con.AccountID).add(con);
               
           }
       }
       
       for(Contact con: [SELECT Id, FirstName , AccountID
                         FROM Contact 
                         WHERE AccountID IN : accIDs.keySet()]){
           System.debug('>>>'+con.FirstName);
           if(String.isNotBlank(con.FirstName)){
            accIDs.put(con.AccountId, accIDs.get(con.AccountID) + con.FirstName.substring(0,1));
           }
       }
       
       System.debug(accIDs);
       
       List<Account> accToUpdate=new List<Account>();
       for(Account acc:[SELECT ID,Name 
                      FROM Account 
                      WHERE ID IN :accIDs.KeySet()]){
             acc.Name+=accIDs.get(acc.ID);
             accToUpdate.add(acc);        
//accToUpdate.add(new Account(Id=a.ID, Name= accIDs.get(a.ID)));

       }
       
       update accToUpdate;
   }
}