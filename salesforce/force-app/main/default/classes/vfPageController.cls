public class vfPageController{

       public User u{get;set;}
       public String uid;
       public list<selectOption> accountList{get;set;}
         public list<selectOption> notesList{get;set;}
         public boolean showNotes{get;set;}
          public boolean showDetail{get;set;}
             public boolean showOutput{get;set;}
       public string accountId{get;set;}
         public string NotesId{get;set;}
         public map<id,Note> mapIdToNotes{get;set;}
         public note obj{get;set;}
       
       public String message{get;set;}
       
       public vfPageController(){
       U=new User();
       accountList=new List<selectOption>();
        notesList=new List<selectOption>();
        mapIdToNotes=new map<id,note>();
       uid=ApexPages.currentPage().getParameters().get('aid');
       if(uid==null)
       {
         uid=UserInfo.getUserId();
       }
       u=[SELECT name,email,phone FROM user WHERE id=:uid];
       accountList.add(new SelectOption('','None'));
       
       for(Account a:[SELECT id,name FROM Account WHERE OwnerId=:u.id])
       {
          accountList.add(new SelectOption(a.id,a.name));
       }
        
       }
       
       public void showNotesFnctn(){
       if(accountId!=NULL)
       {
       notesList.clear();
       notesList.add(new selectOption('','None'));
       showDetail=false;
       showOutput=false;
      
        
        for(Note n:[SELECT title,parentId,isPrivate,body FROM note WHERE parentId=:accountId ])
        {
          notesList.add(new SelectOption(n.id,n.title));
          mapIdToNotes.put(n.id,n);
       
        }
       
       System.debug('--------------'+notesList);
       showNotes=true;
       }
       else
       {
       String errorMsg = 'Please select values from Dropdown';
       ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR, errorMsg);
       ApexPages.addMessage(myMsg);
       showNotes=false;
       }
       
       
       
       }
       
       
      
       public void showNotesDetail(){
      
       if(notesId!=NULL)
       {
       showDetail=true;
       obj=mapIdToNotes.get(notesId);
       System.debug('----------'+obj);
       }
       else{
       String errorMsg = 'Please select values from Dropdown';
       ApexPages.Message myMsg1 = new ApexPages.Message(ApexPages.Severity.ERROR, errorMsg);
       ApexPages.addMessage(myMsg1);
       showOutput=false;
       
        showDetail=false;
        }
       
       }
       public void showOutputDetail(){
           
           showOutput=true;
           showDetail=false;
            
       }
        public void showInputDetail(){
       
           if(obj.title==NULL)
           {
             String ErrorMsg = 'Title cant be null';
       ApexPages.Message myMsg1 = new ApexPages.Message(ApexPages.Severity.Info, ErrorMsg);
       ApexPages.addMessage(myMsg1);
           }
           else
           {
           
           showOutput=false;
           showDetail=true;
           upsert obj;
           notesList.clear();
           notesList.add(new selectOption('','None'));
           for(Note n:[SELECT title,parentId,isPrivate,body FROM note WHERE parentId=:accountId ])
           {
          notesList.add(new SelectOption(n.id,n.title));
          mapIdToNotes.put(n.id,n);
       
            }
            String InfoMsg = 'Record Edited successfully';
       ApexPages.Message myMsg1 = new ApexPages.Message(ApexPages.Severity.Info, InfoMsg);
       ApexPages.addMessage(myMsg1);
       }
            
       }

}