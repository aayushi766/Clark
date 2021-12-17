public class RandomContactFactory {
   public static List<contact> generateRandomContacts(Integer num,String lastNAme1){
       List<Contact> contList=new List<Contact>();
       for(Integer i=0;i<num;i++)
       {
           contList.add(new Contact(firstName='test'+i,lastName=lastName1));
       }
        return contList;
    }

}