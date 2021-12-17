/**=====================================================================
 * Name: ProfileAnalysisControllerTest 
 * Description: Test class for the controller class ProfileAnalysisController
 * Created Date: [06/26/2015]
 * Created By: [Rajeev Arya] (Appirio)
======================================================================**/
@isTest
private class ProfileAnalysisControllerTest {

    static testMethod void noSelectionTest(){
        ProfileAnalysisController controller = new ProfileAnalysisController();
       
        ApexPages.Message msgNoObjectNoProfile = new ApexPages.Message(ApexPages.Severity.ERROR,'Please select an object and at least one profile from the displayed lists');
        
        List<SelectOption> ObjectList = controller.getName();
        List<SelectOption> ProfileList = controller.getItems();
        
        controller.val = null;
        controller.RetrieveSelected();
        ApexPages.Message[] pageMessages = ApexPages.getMessages();
        System.assertEquals(1, pageMessages.size());
        System.assertEquals (msgNoObjectNoProfile.getSummary(), pageMessages[0].getSummary());
    }
    
    static testMethod void noObjectOnlyProfilesSelectionTest(){
        ProfileAnalysisController controller = new ProfileAnalysisController();
        ApexPages.Message msgNoObjectOnlyProfile = new ApexPages.Message(ApexPages.Severity.ERROR,'Please select an object from the displayed list');
        
        List<SelectOption> ObjectList = controller.getName();
        List<SelectOption> ProfileList = controller.getItems();
        
        controller.val = null;
        controller.profiles = new String[]{'System Administrator'};
        controller.RetrieveSelected();
        ApexPages.Message[] pageMessages = ApexPages.getMessages();
        System.assertEquals(1, pageMessages.size());
        System.assertEquals (msgNoObjectOnlyProfile.getSummary(), pageMessages[0].getSummary());
    }
    
    static testMethod void onlyObjectNoProfilesSelectionTest(){
        ProfileAnalysisController controller = new ProfileAnalysisController();
        ApexPages.Message msgOnlyObjectNoProfile = new ApexPages.Message(ApexPages.Severity.ERROR,'Please select at least one profile from the displayed list');
        
        List<SelectOption> ObjectList = controller.getName();
        List<SelectOption> ProfileList = controller.getItems();
        
        controller.val = 'Account';
        controller.RetrieveSelected();
        ApexPages.Message[] pageMessages = ApexPages.getMessages();
        System.assertEquals(1, pageMessages.size());
        System.assertEquals (msgOnlyObjectNoProfile .getSummary(), pageMessages[0].getSummary());
    }
    
    static testMethod void ObjectAndProfilesSelectionTest(){
        ProfileAnalysisController controller = new ProfileAnalysisController();
        
        List<SelectOption> ObjectList = controller.getName();
        List<SelectOption> ProfileList = controller.getItems();
        
        controller.val = 'Account';
        controller.profiles = new String[]{'System Administrator'};
        controller.GenerateExcelReport();
    }
}