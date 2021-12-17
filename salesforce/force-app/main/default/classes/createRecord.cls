public class createRecord {
    
    Map<String,Schema.DisplayType> fieldToDatatype = new Map<String,Schema.DisplayType>();
       
    public static  void CreateRecord1(String objType){
    
        Schema.SObjectType targetType = Schema.getGlobalDescribe().get(objType);
        SObject newSobject = targetType.newSObject(); // creating new instance of objType
        Map<String,Schema.DisplayType> fieldToDatatype = new Map<String,Schema.DisplayType>();
       
        Map<String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();
        Schema.SObjectType objSchema = schemaMap.get(objType);
        Map<String, Schema.SObjectField> fieldMap = objSchema.getDescribe().fields.getMap();
     
        for (String fieldName: fieldMap.keySet()) {
 
            //It provides to get the object fields label.
            String fieldLabel = fieldMap.get(fieldName).getDescribe().getLabel();
     
           //It provides to get the object fields data type.
            Schema.DisplayType fielddataType = fieldMap.get(fieldName).getDescribe().getType();
           
            Schema.SObjectField field = fieldMap.get(fieldName);
            Schema.DescribeFieldResult F = field.getDescribe();
            Boolean isFieldreq  = f.isNillable() ;
                      if(F .isCreateable()
                      && !F.isNillable()
                      && !F.isDefaultedOnCreate()
                      && F.isUpdateable()){
                           if (fielddataType == Schema.DisplayType.Date)
                            newSObject.put(fieldName,System.today());
                           else if(fielddataType == Schema.DisplayType.DateTime)
                            newSObject.put(fieldName,System.now());
                           else if (fielddataType == Schema.DisplayType.Integer)
                            newSobject.put(fieldName, 0);
                           else if (fielddataType == Schema.DisplayType.double)
                            newSobject.put(fieldName, 0.0);
                           else if (fielddataType == Schema.DisplayType.Base64)
                            newSobject.put(fieldName, Blob.valueOf(fieldLabel));
                           else if(fielddataType == Schema.DisplayType.Picklist){
                                 List<Schema.Picklistentry>fld =fieldmap.get(fieldname).getDescribe().getpicklistValues();
                                 newSobject.put(fieldName, fld[0].getvalue());
                           }
                           else if (fielddataType == Schema.DisplayType.String){
                                Integer maxLength = fieldmap.get(fieldname).getDescribe().getLength();
                                if(fieldLabel.length()<maxLength)
                                newSObject.put(fieldName,fieldLabel);
                                else
                                newSObject.put(fieldName,fieldLabel.subString(0,maxLength-1));
                           }
                           
    
                           fieldToDatatype.put(fieldName,fielddataType);
                      }
                 
                                
         }
      
   System.debug(newSobject);
   insert newSobject;
    
 
  }
 
}