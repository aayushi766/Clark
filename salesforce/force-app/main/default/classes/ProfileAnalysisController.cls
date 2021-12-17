/**=====================================================================
 * Name: ProfileAnalysisController 
 * Description: To be used by the Apex Page FLSProfileAnalysis, so as to retrieve the required FLS settings for the selected object
 * Created Date: [06/26/2015]
 * Created By: [Rajeev Arya] (Appirio)
======================================================================**/
public with sharing class ProfileAnalysisController {
    
    public list<ProfileWrapper> ProfileWrapperList {get; set;}
    public list<String> setProfiles;
    public String[] profiles = new String[]{};
    public boolean disableProfileDropDown{get;set;}
    public boolean disableObjectDropDown{get;set;}
    public String val {get;set;}
    public String selectedObjectLabel {get;set;}
    map<String, String> mapObjectNameToLabel = new map<String, String>();
    
        public ProfileAnalysisController(){
            val = '';
            ProfileWrapperList = new list<ProfileWrapper>();
        }
        public List<SelectOption> getName()
        {
            List<Schema.SObjectType> gd = Schema.getGlobalDescribe().Values();    
        
            List<SelectOption> options = new List<SelectOption>();
            for(Schema.SObjectType f : gd)
            {
               if(f.getDescribe().isQueryable() && f.getDescribe().isSearchable() && f.getDescribe().isUpdateable() 
               && !f.getDescribe().isCustomSetting()){
                   options.add(new SelectOption(f.getDescribe().getName(),f.getDescribe().getLabel()));
                   mapObjectNameToLabel.put(f.getDescribe().getName(),f.getDescribe().getLabel());
               }
            }
            options.sort();
            return options;
        }
        
        public List<SelectOption> getItems() {
            List<SelectOption> options = new List<SelectOption>();
            
            for(profile p:[select name from profile order by name asc]){
                options.add(new SelectOption(p.name,p.name));
               
            }
            return options;
        }
            
        public String[] getprofiles() {
            return profiles;
        }
            
        public void setprofiles(String[] profiles) {
            this.profiles = profiles;
        }
    
        public PageReference RetrieveSelected() {
            selectedObjectLabel = mapObjectNameToLabel.get(val);
            if(profiles.isEmpty() && val == null){
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Please select an object and at least one profile from the displayed lists'));
            }
            else if(val == null && !profiles.isEmpty()){
                disableProfileDropDown = true;
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Please select an object from the displayed list'));
            }
            else if(profiles.isEmpty() && val != null){
                disableObjectDropDown = true;
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Please select at least one profile from the displayed list'));
            }
            else if(!profiles.isEmpty() && val != null){
                disableObjectDropDown = true;
                disableProfileDropDown = true;
            }
           
            return null;
        }
  
        public void CreateFLSReport(){
        map<String, FieldPermissions> mapper = new map<String, FieldPermissions>();
        
        for(FieldPermissions fp : [SELECT Field, PermissionsRead, PermissionsEdit,
                        Parent.Profile.Name FROM FieldPermissions
                        WHERE (ParentId
                        IN (SELECT PermissionSetId
                        FROM PermissionSetAssignment
                        WHERE PermissionSet.Profile.Name IN: profiles))
                        AND
                        (SobjectType =: val)
                        AND
                        Parent.IsOwnedByProfile = true]){
            mapper.put(fp.Field.replace(val + '.','') + '/' + fp.Parent.Profile.Name, fp);
         
        }
        Map <String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();
        Map <String, Schema.SObjectField> fieldMap = schemaMap.get(val).getDescribe().fields.getMap();
        list<String> lstFieldNames = new list<String>();
        list<Schema.DisplayType> lstFieldDataType = new list<Schema.DisplayType>();
        
        String fieldAPI;
        String fieldLabel;
        Integer count=0;
        String check;
        map<String,String> mper;
        List<String> keyValues;
        for(Schema.SObjectField sfield : fieldMap.Values())
        {
        String permi;
        mper = new map<String,String>();
        keyValues = new list<String>();
            count++;
            schema.describefieldresult dfield = sfield.getDescribe();
            fieldAPI = dfield.getname().replace(val+'.','');
          
            if(String.valueOf(dfield.getType()) == 'REFERENCE'){
                fieldAPI = fieldAPI.replace('Id','');
            }
            for(integer i=0; i<profiles.size(); i++){
                check = fieldAPI + '/' + profiles[i];
               
                if(mapper.containsKey(check)){
                   
                    if(mapper.get(check).PermissionsRead == true && mapper.get(check).PermissionsEdit == true)
                        {    
                            if(dfield.isUpdateable()== false){
                                permi = 'RO';
                            }
                            else{
                                permi = 'Edit';
                            }
                            
                        }
                    else if(mapper.get(check).PermissionsRead == true && mapper.get(check).PermissionsEdit == false){
                        permi = 'RO';
                    }
                 }
                else if(dfield.isPermissionable()== false && dfield.isUpdateable()== true){
                    permi = 'Edit';
                    
                }
                else if(dfield.isPermissionable()== true && dfield.isUpdateable()== false && !mapper.containsKey(check)){
                    permi = 'Hidden';
                }
                else if(dfield.isPermissionable()== true && dfield.isUpdateable()== false){
                    permi = 'RO';
                }
                else if(dfield.isPermissionable()== true && !mapper.containsKey(check)){
                    permi = 'Hidden';
                }
                else if(dfield.isPermissionable()== false && dfield.isUpdateable()== false){
                    permi = 'RO';
                }
                else{
                    permi = 'N/A';
                }
               
                mper.put(profiles[i],permi);
            }
           
            keyValues.addAll(mper.keySet());
            fieldLabel = dfield.getLabel();
            if(String.valueOf(dfield.getType()) == 'REFERENCE'){
                fieldLabel = fieldLabel.replace(' ID','');
            }
            ProfileWrapper mwrap = new ProfileWrapper(fieldLabel, fieldAPI, 
                            String.valueOf(dfield.getType()), mper, keyValues );
            
            ProfileWrapperList.add(mwrap);
        }
        ProfileWrapperList.sort();
        }
        
    public class ProfileWrapper implements Comparable{
        public String FieldLabel {get;set;}
        public String APIName {get;set;}
        public String DataType {get;set;}
        public map<String,String> mapPer {get;set;} 
        public list<String> keys{get;set;}       
        
        public ProfileWrapper(String FieldLabel,
                                        String APIName,
                                        String DataType,
                                        map<String,String> mapPer,
                                        list<String> keys ){
            
            this.FieldLabel=FieldLabel;
            this.APIName=APIName;
            this.DataType=DataType;
            this.mapPer = mapPer ;
            this.keys = keys;
           
            }
            public Integer compareTo(Object objToCompare) {
                return FieldLabel.compareTo(((ProfileWrapper)objToCompare).FieldLabel);
        }
    }
    
    public PageReference GenerateExcelReport(){
            CreateFLSReport();
            return Page.profileanalysis; 
    }
}