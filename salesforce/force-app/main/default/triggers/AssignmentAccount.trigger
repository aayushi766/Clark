trigger AssignmentAccount on Account (before Delete) {

     Map<ID,Account> mapToContact=new Map<ID,Account>([SELECT ID,(SELECT Name FROM Contacts)FROM Account WHERE ID IN:trigger.old]);
     
     for(Account a:trigger.old)
     {
          //System.debug(mapToContact.get(a.ID).contacts.size());
     
          if(mapToContact.get(a.ID)!=NULL)
          {
          
          a.addError('Contacts assciated cant delete this object');
             
          }
          
     }
     
}