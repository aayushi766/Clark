public class Apexassign10 {
    public void function1(List<Opportunity> opportunityID)
    {
        Set<ID> idSet=new Set<ID>();
        for(Opportunity opp1:opportunityID)
        {
            idSet.add(opp1.Id);
        }
        List<Opportunity> oppList=new List<Opportunity>();
        oppList=[SELECT Manager__c,BillToContact__c FROM Opportunity WHERE Id=:idSet];
       
        List<ID> IDList=new List<ID>();
        for(opportunity opp1:oppList)
        {
                IDlist.add(opp1.BillToContact__c);            
        }
        List<contact> contactList=new List<contact>(); 
        
        contactList=[SELECT accountId,account.name From Contact WHERE ID IN:IDlist];
        Integer i=0;
        for(Opportunity opp:oppList)
        {
            
                if(opp.BilltoContact__c!=NULL)
                {
                   if(opp.Manager__c==NULL)
                   {
                       opp.Manager__c=contactList[i].account.ID;
                       System.debug('response----->'+opp.Manager__c);
                   }
                }
            i++;
        }
       
       upsert oppList; 
    }

}