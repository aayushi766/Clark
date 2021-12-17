/**
* Developer: Aayushi Agrawal
* Date:  27/02/2017
*
* Permission Set
*
* Purpose: Contains method to retrieve the object permissions.
*/
public with sharing class ObjectPermissionHandler {

    private static ObjectPermissionHandler instance = null;
    
    ObjectPermissions[] objectPermissionList;
    Map<String,SObject> objectsPermissionMap;

    Map<String, Schema.SObjectType> globalDescribe = Schema.getGlobalDescribe();

    
    final Map<String,String> PERMISSION_NAMES = new Map<String,String>{'create' =>  'PermissionsCreate',
                                                                'read'      =>  'PermissionsRead',
                                                                'edit'      =>  'PermissionsEdit',
                                                                'delete'    =>  'PermissionsDelete',
                                                                'view all'  =>  'PermissionsViewAllRecords',
                                                                'modify all'    =>  'PermissionsModifyAllRecords'
                                                                };
    
    private ObjectPermissionHandler(Id userId) {

        objectPermissionList = [SELECT Id, SobjectType, Parent.Id, Parent.isOwnedByProfile, Parent.Profile.Name,
                                            PermissionsCreate, PermissionsRead, PermissionsEdit, 
                                            PermissionsDelete, PermissionsViewAllRecords, PermissionsModifyAllRecords
                                        FROM ObjectPermissions
                                        WHERE ParentId IN 
                                            (SELECT PermissionSetId FROM PermissionSetAssignment WHERE AssigneeId =: userId )
                                    ];

        objectsPermissionMap = createMapOfObjects(objectPermissionList, 'SobjectType');

    }

    
     /*******************************************************************************************************
        * @return the instance of ObjectPermissionHandler
        */
    public static ObjectPermissionHandler getInstance(){
        
        if(instance == null){
            Id userId = UserInfo.getUserId();
            instance = getInstance(userId);
        }
        return instance;
    }

     /*******************************************************************************************************
        * @parameter userId user id of whom the permissions have to be retrieved
        * @return the instance of ObjectPermissionHandler
        */

    public static ObjectPermissionHandler getInstance(Id userId){
        
        if(userId == null){
            throw new customException('userId cannot be null');
        }

        if(instance == null){
            instance = new ObjectPermissionHandler(userId);
        }
        return instance;
    }

     /*******************************************************************************************************
        * @description Return the permission for the object
        * @param objectAPIName the API name of the object 
        * @param permission which kind of permission we are checking. Accepted values are 'create','read',
        *                   'edit','delete','view all','modify all'
        * @return return true if the specified user has the specified permission for that object
        */
    public Boolean getUserPermission(String objectAPIName, String permission){
        

        if(objectAPIName == null){
            throw new customException('objectAPIName cannot be null');
        }

        if(!globalDescribe.containsKey(objectAPIName)){
            throw new customException('There is no object with name: '+objectAPIName);
        }

        if(permission == null || !PERMISSION_NAMES.keyset().contains(permission)){
            throw new customException('Wrong parameter: '+permission+'. Accepted values are: '+PERMISSION_NAMES.keyset()+'. Case are sensitive!');
        }

        String permissionAPIname = PERMISSION_NAMES.get(permission);

        ObjectPermissions specOgbjPermission = (ObjectPermissions) objectsPermissionMap.get(objectAPIName);

        if(specOgbjPermission != null){
            return (Boolean) specOgbjPermission.get(permissionAPIname);
        }
        return false;
    }


    
    public Map<String,Map<String,Boolean>> getUserPermissionMap (Set<String> objectAPINameSet){
        Map<String,Map<String,Boolean>> res = new Map<String,Map<String,Boolean>>();

        for(String objectAPIName: objectAPINameSet){
            
            if(!globalDescribe.containsKey(objectAPIName)){
                throw new customException('There is no object with name: '+objectAPIName);
            }
             
            objectAPIName = globalDescribe.get(objectAPIName).getDescribe().getName();

            Map<String, Boolean> objectPermissionMap = new Map<String, Boolean>();

            for(String permission: PERMISSION_NAMES.keyset()){
                Boolean permissionRes;
                if(!objectsPermissionMap.containsKey(objectAPIName)){
                    permissionRes = false;
                } else {
                    permissionRes = getUserPermission(objectAPIName, permission);
                }
                
                objectPermissionMap.put(permission, permissionRes);
            }

            res.put(objectAPIName, objectPermissionMap);
        }
        return res;
    }

     /*******************************************************************************************************
        * @description Retrieve a map that contains all the infos about the user permissions on object.
        *               Usefull to be used in apex pages.
        * @return The map is intended to be used on two step: 1. Choose object 2. Choose permission type.
        *           Pay attention: both object name and permission type are case sensitive!
        *           accepted value for permission type ar: 'create','read',
        *                   'edit','delete','view all','modify all'
        * @example
        *   ObjectPermissionHandler objPermissionHandler = ObjectPermissionHandler.getInstance();
        *
        *   Map<String,Map<String,Boolean>> userPermissionMap = objPermissionHandler.getUserPermissionMap();
        *   System.assertEquals(false, userPermissionMap.get('Account').get('view all'));
        */
    public  Map<String,Map<String,Boolean>> getUserPermissionMap (){
        return getUserPermissionMap (globalDescribe.keyset());
    }

    /*******************************************************************************************************
        * @description create a map indexed by a field from a list of SObject
        * @param listOfObjects the list of SObject that will be used to generate the map 
        * @param fieldToBeIndexed the API Name of the SObject field that will be used for indexing
        * @return a map of type Map<String,SObject> which contains the indexed element of listOfObjects
        */
    public static Map<String,SObject> createMapOfObjects(SObject[] listOfObjects, String fieldToBeIndexed){
        

        Map<String,SObject> res = new Map<String, SObject>();

        if(listOfObjects == null || listOfObjects.size() == 0){
            return res;
        }

        if(String.isBlank(fieldToBeIndexed)){
            throw new customException('An index field API Name have to be provided');
        }


        for(SObject el: listOfObjects){
            
            String elStringToIndex = (String) el.get(fieldToBeIndexed);

            if(elStringToIndex == null){
                throw new customException('the index field '+ fieldToBeIndexed +' is null for the element: ' + el.Id);
            }
            res.put(elStringToIndex,el);
        }

        return res;
    }

}