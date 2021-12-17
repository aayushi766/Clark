public with sharing class ToDoController {
    
    @AuraEnabled
    public static string addToDo(String payload){
        ToDo payloadObject = (ToDo)JSON.deserialize(payload, ToDo.class);
        Sobject tsk = (sObject) Type.forName('To_do__c').newInstance();
        tsk.put('Name', payloadObject.todoName);
        tsk.put('Done__c', payloadObject.done);
        insert tsk;
        return String.valueOf(tsk.Id);
    }
    
    @AuraEnabled
    public static void updateToDo(String payload){
        ToDo payloadObject = (ToDo)JSON.deserialize(payload, ToDo.class);
        Sobject tsk = (sObject) Type.forName('To_do__c').newInstance();
        tsk.put('Name', payloadObject.todoName);
        tsk.put('Done__c', payloadObject.done);
        tsk.put('Id', payloadObject.todoId);
        update tsk;
        
    }
    
    @AuraEnabled
    public static void deleteToDo(String payload){
        ToDo payloadObject = (ToDo)JSON.deserialize(payload, ToDo.class);
        
        SObject tsk = (SObject) Type.forName('To_do__c').newInstance();
        tsk.put('Id',payloadObject.todoId);
        delete tsk;
        

    }

    @AuraEnabled(cacheable = true)
    public static List<ToDo> getAllToDos(){
        List<SObject> tsks = [SELECT ID, Name, CreatedDate, Done__c FROM to_do__c WHERE CreatedDate = Last_N_Days:7 ORDER by createddate desc];
        return getToDos(tsks);
    }
    @AuraEnabled
    public static List<ToDo> getCurrentToDos(){
        List<SObject> tsks = [SELECT ID, Name, CreatedDate, Done__c FROM to_do__c WHERE CreatedDate = Today ORDER by createddate desc];
        return getToDos(tsks);
    }
    public static List<ToDo> getToDos(List<SObject> tsks){
        List<ToDo> todoList = new List<ToDo>();
        for(SObject sobj : tsks){
            ToDo todoTemp = new ToDo();
            todoTemp.todoId = sobj.Id;
            todoTemp.todoDate = Date.valueOf(sobj.get('CreatedDate'));
            todoTemp.done = Boolean.valueOf(sobj.get('Done__c'));
            todoTemp.todoName = String.valueOf(sobj.get('Name'));
            todoList.add(todoTemp);
        }
        return todoList;

    }
    class ToDo{
        @AuraEnabled
        public String todoId;
        @AuraEnabled
        public String todoName;
        @AuraEnabled
        public Date todoDate;
        @AuraEnabled
        public Boolean done;

       
    }
}