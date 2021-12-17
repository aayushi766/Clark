public class NewCaseListController{
public Case case1{get;set;}
   public List<Case> getNewCases(){
   List<Case> caseList=[SELECT Id,CaseNumber FROM Case WHERE Status='New'];
   return caseList;
   }
}