trigger Assignment2 on Account (before Delete) {
List<sobject> sObjList=(List<sobject>)trigger.old;
TrackTriggerHandler.handleFunction(sobjList);

}