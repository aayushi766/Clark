public class TrackTriggerHandler {
    public static void handleFunction(List<sobject> sobjList )
    {
       List<Track__c> trackList=new List<Track__c>();
        System.debug('--------------------------');
        Track__c t;
       for(sobject s:sobjList)
       {
           if(s.getSObjectType()==Schema.Account.getSObjectType())
           {
              t=new Track__c(object_type__c='Account',object_id__c=s.id,deleted_on__c=dateTime.now());
           }
           else if(s.getSObjectType()==Schema.Contact.getSObjectType())
           {
              t=new Track__c(object_type__c='Contact',object_id__c=s.id,deleted_on__c=dateTime.now());
           }
          else
           {
              t=new Track__c(object_type__c='Case',object_id__c=s.id,deleted_on__c=dateTime.now());
           }
           trackList.add(t);
           System.debug(t);
       }
        insert trackList;
    }

}