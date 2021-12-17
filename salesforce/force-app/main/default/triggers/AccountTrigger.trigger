trigger AccountTrigger on Account (before update) {
/*if(trigger.isInsert)
{
for(Account acc:trigger.new)
{
acc.name=acc.name+'test';

}*/

if(trigger.isUpdate)
{
insert new Task(whatId = trigger.new[0].id , subject='test');
//trigger.new[0].addError('failed');
}
}