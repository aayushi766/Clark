public class DependentPicklistController{
   public list<SelectOption> accountList{get;set;}
    public list<SelectOption> contList{get;set;}
   public String accountId{get;set;}
   public String contactId{get;set;}
   public boolean showCont{get;set;}
   public boolean showContDetail{get;set;}
   public contact Cont{get;set;}
   public map<ID,contact> mapIdToCont;
   public DependentPicklistController(){
   accountList=new list<SelectOption>();
   contList=new list<SelectOption>();
   cont=new contact();
   for(Account acc : [Select Name from Account LIMIT 10]){
            accountList.add(new SelectOption(acc.Id,acc.Name));
            
        }
        mapIdToCont=new map<ID,contact>();
        showContdetail=false;
    }
    public void showContacts()
    {
     System.debug('----------'+accountId);
     contList.clear();
     showCont=true;
     
     for(Contact c:[SELECT Name,id,phone,email,fax FROM contact WHERE accountId=:accountId])
     {
       contList.add(new SelectOption(c.id,c.name));
       mapIdToCont.put(c.id,c);
     }
      System.debug('---------'+contList);
    }
    public void showContactDetail()
    {
    system.debug('hi');
     showContDetail=true;
     cont=mapIdToCont.get(contactId);
      system.debug(cont);
     
    }

}