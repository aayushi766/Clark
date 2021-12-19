import { LightningElement,api } from 'lwc';
import getCaseConfigRecords from '@salesforce/apex/ConfigManagementController.getCaseConfigRecords';
import {ShowToastEvent} from 'lightning/platformShowToastEvent';
const columns = [
    { label: 'Label', fieldName: 'Label',sortable:true },
    { label: 'Type', fieldName: 'Type' },
    { label: 'Amount', fieldName: 'Amount' }, 
];
export default class CaseConfigs extends LightningElement { 
    caseConfigRecords = [];
    columns = columns;
    showSpinner = true;
    noConfigRecords = true; 
    @api recordId;
    connectedCallback(){
        getCaseConfigRecords({caseId : this.recordId}).then(response => {
            response.forEach(caseConfig=>{
                this.caseConfigRecords.push({Label :caseConfig.Label__c,
                                        Type :caseConfig.Type__c,
                                        Amount :caseConfig.Amount__c,
                                        Id : caseConfig.Id})
            })
            this.showSpinner = false;
            this.noConfigRecords = false; 
        }).catch(error =>{
            this.showToast('Error',error.description.message, 'error');
        })
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