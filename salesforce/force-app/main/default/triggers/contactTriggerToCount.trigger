trigger contactTriggerToCount on Contact (After insert,after update,after delete) {
map<ID,Integer> idmap=new map<ID,Integer>();
if(trigger.isInsert)
{
    for(Contact c:trigger.new){
    if(c.AccountID!=NULL)
    {
    idmap.put(c.AccountID,0);
    }
    
    }
}
if(trigger.isUpdate)
{
   
   for(Contact c:trigger.old){
   if(trigger.oldMap.get(c.ID).accountID!=trigger.newMap.get(c.ID).accountID)
   {
    if(c.AccountID!=NULL)
    {
    idmap.put(c.AccountID,0);
    }
    }
    
    }
     for(Contact c:trigger.new){
    if(trigger.oldMap.get(c.ID).accountID!=trigger.newMap.get(c.ID).accountID)
    {
    if(c.AccountID!=NULL)
    {
    idmap.put(c.AccountID,0);
    }
    }
    
    }
}
if(trigger.isDelete)
{
    for(Contact c:trigger.old){
    if(c.AccountID!=NULL)
    {
    idmap.put(c.AccountID,0);
    }
    
    }

}
for(Account a:[SELECT Name,count__c,(SELECT Name FROM Contacts) From Account WHERE ID IN:idmap.keySet()])
{
  
  
     
     idMap.put(a.ID,a.contacts.size());
    
     
}
List<Account> accList=new List<Account>();
for(ID id1:idMap.keySet())
{
   Account a=new Account();
   a.Id=id1;
   a.count__c=idMAp.get(a.ID);
   accList.add(a);
}
upsert accList;

}