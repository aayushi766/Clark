trigger uniqueness on Contact (before insert,before update) {
              Set<String> firstNAmeSet=new Set<String>();
               Set<String> lastNAmeSet=new Set<String>();
                Set<String> EmailSet=new Set<String>();
                Set<String> UniqueSet=new Set<String>();
                Set<String> ExistingSet=new Set<String>();
                for(Contact con:trigger.new)
                {
                   if(uniqueSet.contains(con.FirstName+','+con.lastName+','+con.Email))
                   {
                     con.addError('cant insert or update data loader');
                   }
                   else
                   {
                      uniqueSet.add(con.FirstName+','+con.lastName+','+con.Email);
                      firstNameSet.add(con.firstname);
                      lastNameSet.add(con.lastname);
                      EmailSet.add(con.Email);
                   }
                }
                for(Contact con:[SELECT ID,firstname,lastname,email FROM Contact WHERE firstname IN:firstNameSet AND lastName IN:lastnameSet AND email IN:emailSet])
                {
                     ExistingSet.add(con.FirstName+','+con.lastName+','+con.Email);
                }
                for(Contact con:trigger.new)
                {
                  if(ExistingSet.contains(con.FirstName+','+con.lastName+','+con.Email))
                  {
                    con.addError('cant insert or update');
                  }
                }

}