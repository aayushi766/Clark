trigger ClosedOpportunityTrigger on Opportunity (before update,after insert) {
List<Task> taskList=new List<Task>();
for(Opportunity opp:[SELECT ID FROM Opportunity WHERE ID IN: trigger.new AND Stagename='closed Won'])
{
taskList.add(new Task(whatID=opp.ID,subject='Follow Up Test Task'));
}
insert taskList;

}