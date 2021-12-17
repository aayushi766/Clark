trigger contactTriggerToCheckUniqueness on Contact (after insert,after update) {
     Map<ID,String> mapFirstName=new Map<ID,String>();  
     Map<ID,String> mapLastName=new Map<ID,String>();  
     Map<ID,String> mapEmail=new Map<ID,String>();   
     Map<String,Integer> mapCount=new Map<String,Integer>();
     if(checkrecursive.runOnce())
     {
     for(Contact c:trigger.new)
     {
         mapFirstName.put(c.ID,c.FirstName);
         
         mapLastName.put(c.ID,c.LastName);
          
         mapEmail.put(c.ID,c.Email);
          
         
     }
     List<Contact> contList=new List<Contact>();
     for(Contact c:[SELECT FirstName,LastName,Email FROM Contact WHERE (FirstNAme IN:mapFirstName.values() OR LastNAme IN:mapLastName.values()  OR EMAIL IN:mapEMAIL.values()) AND ID NOT IN:mapFirstNAme.keySet() ])
     {
         
         for(ID id1:mapFirstName.keySet())
         {
        
         if(mapFirstName.get(ID1)==c.FirstName&&mapLastName.get(ID1)==c.LastName&&mapEmail.get(ID1)==c.Email)
         {
         
         System.debug(c.firstName);
         System.debug(c.LastName);
         System.debug(c.Email);
           c=trigger.newMap.get(ID1);
            c.addError('Use a unique combination of firtsname,lastname,email where firstname='+c.firstName);
            
      
          
         }
         }
       
       }
          
      
       } 
       
       }