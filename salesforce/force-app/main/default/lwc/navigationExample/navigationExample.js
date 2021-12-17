import { LightningElement } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
export default class NavigationExample extends NavigationMixin(LightningElement) {
    openSfdcFatcs(){
        this[NavigationMixin.Navigate]({
            type : 'standard__webPage',
            attributes : {
                url : 'https://sfdcfacts.com'
            }    
        });
    }

    openAccountHome(){
        this[NavigationMixin.Navigate]({
            type : 'standard__objectPage',
            attributes : {
                objectApiName : 'Account',
                actionName : 'home'
            }    
        });
    }

    createContact(){
        this[NavigationMixin.Navigate]({
            type : 'standard__objectPage',
            attributes : {
                objectApiName : 'Contact',
                actionName : 'new'
            }    
        });
    }

    openOppList(){
        this[NavigationMixin.Navigate]({
            type : 'standard__objectPage',
            attributes : {
                objectApiName : 'Opportunity',
                actionName : 'list'
            }    
        });
    }

    openCaseRecord(){
        this[NavigationMixin.Navigate]({
            type : 'standard__recordPage',
            attributes : {
                recordId : "5000I00001aHNYbQAO",
                objectApiName : 'Case',
                actionName : 'view'
            }    
        });
    }
    openMeetingRoom(){
        this[NavigationMixin.Navigate]({
            type : 'standard__navItemPage',
            attributes : {
                apiName : 'Meeting_Room'
                
            }    
        });
    }

    previewFile(){
        this[NavigationMixin.Navigate]({
            type : 'standard__namedPage',
            attributes : {
                pageName : 'filePreview'
                
            }   ,
            state : {
                recordIds : '',
                selectedRecordId :''
            } 
        });

    }
}