@isTest
public class ContactTriggerHandler1Test {
        @isTest
        public static void contactTriggerMethod()
        {
                  Account acc=new Account(name='xyz');
                  insert acc;
                Contact con=new Contact(FirstNAme='zzz',LastName='pqr',accountID=acc.ID);
                 insert con;
                con.LastName='aaa';
               update con;
               acc=[SELECT NAme FROM Account WHERE ID =:acc.ID];
            System.assertEquals('xyzz',acc.Name);
             
            
             //ContactTriggerHandler con=new ContactTriggerHandler();
                   //con.onafterUpdate(new Contact());
            
        }

}