trigger OpportunityTrigger on Opportunity (After update) {
if(checkrecursive.runOnce())
{
if(trigger.isAfter&&trigger.isUpdate)
{
       ApexAssign8 a=new ApexAssign8();
       
     a.function1(trigger.new);
      
}
}

}