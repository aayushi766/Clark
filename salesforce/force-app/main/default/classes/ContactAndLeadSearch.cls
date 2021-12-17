public class ContactAndLeadSearch {
    public static List<List<SObject>> searchContactsAndLeads(String str)
    {
        List<List<sObject>> searchList = [FIND :str IN NAME FIELDS RETURNING Contact(FirstName,LastName),Lead(FirstName,LastName)];
       
       
       
        return searchList;
        
    }
}