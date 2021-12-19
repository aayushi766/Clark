import { LightningElement,api,wire } from 'lwc';
import getCaseConfigRecords from '@salesforce/apex/ConfigManagementController.getCaseConfigRecords';
import {ShowToastEvent} from 'lightning/platformShowToastEvent';
import CONFIG_SAVED from '@salesforce/messageChannel/Config_Saved__c';
import updateCaseRecord from '@salesforce/apex/ConfigManagementController.updateCaseRecord'
import sendCaseConfigDetailToExternalService from '@salesforce/apex/ConfigManagementController.sendCaseConfigDetailToExternalService'
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
    initialResponse;
    sendButtonDisabled = false;
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
            if(response){
                this.initialResponse = response;
                if(response.caseConfigs && response.caseConfigs.length > 0){
                    this.caseConfigRecords = [];
                    response.caseConfigs.forEach(caseConfig=>{ 
                        this.caseConfigRecords.push({Label :caseConfig.Label,
                                                Type :caseConfig.Type,
                                                Amount :caseConfig.Amount,
                                                Id : caseConfig.RecordId})
                    })
                    this.showSpinner = false;
                    this.noConfigRecords = false; 
                    if(saveEvent){ //once data saved refresh child component
                        this.template.querySelector('c-table-pagination-lwc').refreshComp(this.caseConfigRecords); 
                    }  
                }
                if(response.status == 'Closed'){
                    this.sendButtonDisabled = true;
                }
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
    sendApiRequest(){
        this.sendButtonDisabled = true;
        this.showSpinner = true;
        updateCaseRecord({caseId : this.recordId}).then(response => {
            sendCaseConfigDetailToExternalService({payload :  JSON.stringify(this.initialResponse)}).then(response =>{
                this.showSpinner = false;    
                if(response == true){
                    this.showToast('Success','Case closed and sent successfully', 'success');
                }else{
                    this.showToast('Error','Some issue occured while closing case, please retry again', 'error');
                }
                
            }).catch(error=>{
                this.sendButtonDisabled = false;
                this.showSpinner = false;
                console.log('errpr..',error);
                this.showToast('Error',error.description.message, 'error');
            })
        }).catch(error => {
            this.sendButtonDisabled = false;
            this.showSpinner = false;
            console.log('errpr..',error);
            this.showToast('Error',error.description.message, 'error');
        })
    }
}