trigger BatchApexErrorTrigger on BatchApexErrorEvent (after insert) {

    if(trigger.isAfter && trigger.isInsert){

        List<BatchLeadConvertErrors__c> lstofInsertedRec = new List<BatchLeadConvertErrors__c>();

        for(BatchApexErrorEvent obj:trigger.new){

            BatchLeadConvertErrors__c newRec = new BatchLeadConvertErrors__c();

            newRec.AsyncApexJobId__c = obj.AsyncApexJobId;

            newRec.Records__c = obj.JobScope;

            newRec.StackTrace__c = obj.StackTrace;

            lstofInsertedRec.add(newRec);

        }

        if(!lstofInsertedRec.isEmpty()){

            insert lstofInsertedRec;

        }

    }

}