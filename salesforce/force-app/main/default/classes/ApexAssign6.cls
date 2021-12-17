public class ApexAssign6{

    public ApexAssign6() {
       Map<String, Schema.SObjectType> allSobject = Schema.getGlobalDescribe();
 Set<String> objNames = allSobject.keySet();

        System.debug('Number of objects? ' + allSobject.size());

        for (String objName : objNames) {

            System.debug('Object Name=' + objName);
        }
        }
    
    
}