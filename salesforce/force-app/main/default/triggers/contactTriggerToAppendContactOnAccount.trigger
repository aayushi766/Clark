trigger contactTriggerToAppendContactOnAccount on Contact (after update,after insert) {
Map<ID,String> mapConToAcc=new map<ID,String>();
for(Contact c:[SELECT AccountID FROM Contact WHERE ID IN: trigger.new])
{
   if(!mapConToAcc.containsKey(c.ID))
   {
   mapConToAcc.put(c.AccountID,'');
   }
   
}
for(Contact c:[SELECT AccountID,FirstName FROM Contact WHERE AccountID IN:mapConToAcc.keySet()])
{
       if(!String.isBlank(mapConToAcc.get(c.AccountID)))
       {
       mapConToAcc.put(c.AccountID,mapConToAcc.get(c.AccountID)+','+c.FirstName);
       }
       else
       {
       mapConToAcc.put(c.AccountID,c.FirstName);
       }
       
      
}
System.debug('------------------------------------hi2');
List<Account> accList=new List<Account>();
accList=[SELECT contactIDs__c FROM Account WHERE ID IN:mapConToAcc.keySet()];
for(Account a:accList)
{
    a.contactIDs__c=mapConToAcc.get(a.ID);
    System.debug(a.contactIDs__c);
}
System.debug('---------------------hi3');
upsert accList;
}