public class myRelatedNotesController{
public User u{get;set;}
public List<selectOption> accountList{get;set;}
public List<selectOption> opportunityList{get;set;}
public List<selectOption> caseList{get;set;}
public List<selectOption> typeList{get;set;}
public notes__c obj{get;set;}
public boolean showNotes{get;set;}
public boolean ownerEditable{get;set;}
public boolean ownernonEditable{get;set;}

public String accountId{get;set;}
public String opportunityId{get;set;}
public String caseId{get;set;}
public String type{get;set;}
public String uid;
public boolean showAccountList{get;set;}
public boolean showOpportunityList{get;set;}
public boolean showCasesList{get;set;}
  public myRelatedNotesController(){
  
      U=new User();
       accountList=new List<selectOption>();
        opportunityList=new List<selectOption>();
        caseList=new List<selectOption>();
        typeList=new List<selectOption>();
        typeList.add(new SelectOption('','None'));
        typeList.add(new SelectOption('Accounts','Accounts'));
        typeList.add(new SelectOption('Opportunity','Opportunity'));
        typeList.add(new SelectOption('Cases','Cases'));
        showAccountList=false;
        showOpportunityList=false;
        showCasesList=false;
        
       uid=ApexPages.currentPage().getParameters().get('userid');
       if(uid==null)
       {
         uid=UserInfo.getUserId();
       }
       u=[SELECT name,email,phone FROM user WHERE id=:uid];
       accountList.add(new SelectOption('','None'));
       opportunityList.add(new SelectOption('','None'));
       caseList.add(new SelectOption('','None'));
       type=ApexPages.currentPage().getParameters().get('type');
       obj=new notes__c();
       
       
  
  }
  public void showRelatedItems()
  {
   showNotes=false;
    if(type=='Accounts'){
      showAccount();
    }
    if(type=='Cases'){
   showCases();
    }
    
    if(type=='Opportunity'){
    
     showOpportunity();
    }
    if(type=='')
    {
      String ErrorMsg='Please select from dropdown';
     ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error, errorMsg);
     ApexPages.addMessage(myMsg);
    }
   obj.id=NULL;
  }
  public void showAccount()
  {
     accountList.clear();
     accountList.add(new SelectOption('','None'));
    
     for(account a: [Select name,id from Account Limit 10])
     {
       accountList.add(new selectOption(a.id,a.name));
     }
     showAccountList=true;
       showCasesList=false;
      showOpportunityList=false;
      opportunityId='';
      caseId='';
  }
   public void showCases()
  {
     CaseList.clear();
     caseList.add(new SelectOption('','None'));
      for(case c: [Select caseNumber,id from case WHERE ownerId=:uid])
     {
       caseList.add(new selectOption(c.id,c.caseNumber));
     }
     showCasesList=true;
      showOpportunityList=false;
     showAccountList=false;
     accountId='';
     opportunityId='';
  }
  
   public void showOpportunity()
  {
     opportunityList.clear();
     opportunityList.add(new SelectOption('','None'));
     for(Opportunity o: [Select name,id from opportunity limit 10])
     {
       opportunityList.add(new selectOption(o.id,o.name));
     }
     showOpportunityList=true;
     showCasesList=false;
     showAccountList=false;
     accountId='';
     caseId='';
  }

  public void enterNotes()
  {
   obj.id=NULL;
   obj.description__c=NULL;
   obj.date__c=NULL;
   obj.owner__c=NULL;
   
    showNotes=true;
    ownerEditable=false;
     ownernonEditable=true;
     obj.owner__c=uid;
     if(caseid!='')
     {
       obj.case__c=caseid;
     }
     if(opportunityid!='')
     {
       obj.opportunity__c=opportunityid;
     }
     if(accountid!='')
     {
       obj.account__c=accountid;
     }
     if(accountId==''&&caseId==''&&opportunityid=='')
     {
       String ErrorMsg='Please select from dropdown';
     ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error, errorMsg);
     ApexPages.addMessage(myMsg);
     }
  }
  public void saveMe()
  { 
    if(!validateData())
    {
      try{
      insert obj;
       
      String infoMsg='Record inserted successfully';
     ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Info, infoMsg);
     ApexPages.addMessage(myMsg);
      }
      catch(Exception e)
      {
         String errorMsg='Record insertion Failed';
     ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error, errorMsg);
     ApexPages.addMessage(myMsg);
       
      }
      
    }
  
  }
  public void resetMe()
  { 
   obj.description__c='';
  
   obj.date__c=null;
   obj.owner__c=null;
  
   ownerEditable=true;
    ownernonEditable=false;
  }
  public boolean validateData(){
         String errorMsg='';
         boolean isValidationFailedForInitializeData=false;
         if(obj.description__c== ''){
            errorMsg = 'Description is a required field';
            isValidationFailedForInitializeData = true;
             ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR, errorMsg);
          ApexPages.addMessage(myMsg);
            
         }
          if(obj.date__c==null){
            errorMsg = 'Date is a required field';
            isValidationFailedForInitializeData = true;
             ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR, errorMsg);
          ApexPages.addMessage(myMsg);
           
         }
        
         
        return isValidationFailedForInitializeData;
    }

}