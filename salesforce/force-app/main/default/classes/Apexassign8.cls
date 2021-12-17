public class Apexassign8 {
    public void  function1(List<Opportunity> opportunityID)
    {
         
       Map<Opportunity,Id> mapOpp=new Map<Opportunity,Id>();
       List<Opportunity> lstToUpdate = new List<Opportunity>();
        for(Opportunity opp1:[SELECT Id, billToContact__c, billToContact__r.AccountId,Manager__c FROM Opportunity WHERE Id IN: opportunityID])
        {
            if(opp1.billToContact__c != null) {
                mapOpp.put(opp1, opp1.billToContact__r.AccountId);
            }
        }
        
        for(Opportunity oppty : mapOpp.keySet()) {
            if(mapOpp.containsKey(oppty)) {
                oppty.Manager__c = mapOpp.get(oppty);
                lstToUpdate.add(oppty);
            }
        }
        
       update lstToUpdate;
    }

}