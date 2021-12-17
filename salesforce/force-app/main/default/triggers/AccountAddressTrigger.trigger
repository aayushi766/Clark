trigger AccountAddressTrigger on Account (after update,after insert) {
Set<ID> idSet=new Set<ID>();
for(Account a:trigger.new)
{
    idSet.add(a.ID);
}
if(checkRecursive.runOnce())
{
List<Account> accList=[SELECT Match_Billing_Address__c,ShippingPostalCode,BillingPostalCode FROM Account WHERE ID IN:idSet];
for(Account a1:accList)
{
     if(a1.Match_Billing_Address__c==true&&a1.BillingPostalCode!=NULL)
     {
         a1.ShippingPostalCode=a1.BillingPostalCode;
     }
}
upsert accList;
}
}