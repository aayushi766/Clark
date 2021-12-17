trigger ContactTrigger on Contact (after update) {
List<Account> accList=new List<Account>();

Map<ID,String> mapAccIdToContact=new Map<ID,String>();
if(trigger.isAfter && trigger.isUpdate)
{
  for(Contact con:Trigger.new)
  {
     if(con.AccountId!=null && con.FirstName!=null)
     {
        if(!mapAccIdToContact.containsKey(con.AccountId))
        {
        mapAccIdToContact.put(con.AccountId,'');
        }
      mapAccIdToContact.put(con.AccountId,mapAccIdToContact.get(con.AccountId) + con.FirstName.subString(0,1)); 
     }    
     
  }
  
  
  accList=[SELECT Name FROM Account WHERE Id IN:mapAccIdToContact.keySet()];
  
  for(Account a:accList)
  {
    a.Name+= mapAccIdToContact.get(a.ID);
  }
  upsert accList;
 
}

}