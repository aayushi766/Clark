trigger contactHandler on Contact (after update) {
if(trigger.isAfter && trigger.isUpdate){
contactTriggerHandler.onAfterUpdate(Trigger.new);
}


}