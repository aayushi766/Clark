public class AccountHandler {
          public static Account insertNewAccount(String name)
          {
              Account a=new Account(Name= name);
              try
              {
                  
              insert a;
              return a;
              }
              catch(DMLException e)
              {
                  System.debug(e.getMessage());
                  return null;
              }
              
              
          }
}