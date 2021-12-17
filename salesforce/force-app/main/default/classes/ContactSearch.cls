public class ContactSearch {
    public static List<Contact> searchForContacts(String str1,String str2)
    {
        List<Contact> contList=new List<Contact>();
        contList=[SELECT ID,Name FROM Contact WHERE lastName=:str1 AND mailingpostalcode=:str2];
            return contList;
    }

}