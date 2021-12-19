import { LightningElement,api,wire } from 'lwc';
import getCaseConfigRecords from '@salesforce/apex/ConfigManagementController.getCaseConfigRecords';
import {ShowToastEvent} from 'lightning/platformShowToastEvent';
import CONFIG_SAVED from '@salesforce/messageChannel/Config_Saved__c';

// Import message service features required for subscribing and the message channel
import {
    subscribe,
    unsubscribe,
    APPLICATION_SCOPE,
    MessageContext,
} from 'lightning/messageService';

const columns = [
    { label: 'Label', fieldName: 'Label',sortable:true },
    { label: 'Type', fieldName: 'Type' },
    { label: 'Amount', fieldName: 'Amount' }, 
];
export default class CaseConfigs extends LightningElement { 
    caseConfigRecords = [];
    subscription;
    columns = columns;
    showSpinner = true;
    noConfigRecords = true; 
    @api recordId;
    @wire(MessageContext)
    messageContext; 
    // Encapsulate logic for Lightning message service subscribe and unsubsubscribe
    subscribeToMessageChannel() {

        this.subscription = subscribe(
        this.messageContext,
        CONFIG_SAVED,
        (message) => this.refreshPage(true)
        
        );
        
    } 

    unsubscribeToMessageChannel() {
        unsubscribe(this.subscription);
        this.subscription = null;
    }
    connectedCallback(){
        this.subscribeToMessageChannel();
        this.refreshPage(false);
    }
    refreshPage(saveEvent){
        getCaseConfigRecords({caseId : this.recordId}).then(response => {
            this.caseConfigRecords = [];
            response.forEach(caseConfig=>{ 
                this.caseConfigRecords.push({Label :caseConfig.Label__c,
                                        Type :caseConfig.Type__c,
                                        Amount :caseConfig.Amount__c,
                                        Id : caseConfig.Id})
            })
            this.showSpinner = false;
            this.noConfigRecords = false; 
            if(saveEvent){ //once data saved refresh child component
                this.template.querySelector('c-table-pagination-lwc').refreshComp(this.caseConfigRecords); 
            }  
        }).catch(error =>{
            this.showToast('Error',error.description.message, 'error');
        })
    }
    disconnectedCallback() {
        this.unsubscribeToMessageChannel();
    }
     //a generic method to show toast of success/info/error
     showToast(title,message,variant){
        const toastEvent = new ShowToastEvent({
            title: title,
            message : message,
            variant:variant
        });
        this.dispatchEvent(toastEvent);
    }
}