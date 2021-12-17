public class insertOpportunity {
	@AuraEnabled
    public static Opportunity saveRecord(Opportunity opp){
        opp.stageName = 'new';
        opp.closeDate = System.today();
        Database.insert( opp);
        return opp;
        
    }
}