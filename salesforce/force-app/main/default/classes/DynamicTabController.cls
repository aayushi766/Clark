public with sharing class DynamicTabController 
{
    public List<Account> lstAccount{get;set;}
    
    public DynamicTabController()
    {
    lstAccount=new List<Account>();
    for(Account a:[SELECT NAme FROM Account LIMIT 10])
    {
    lstAccount.add(a);
    }
       
    }

  

}