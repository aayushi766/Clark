import { LightningElement,track } from 'lwc';
import {ShowToastEvent} from 'lightning/platformShowToastEvent';
import { refreshApex } from '@salesforce/apex';
import getAvailableConfigRecords from '@salesforce/apex/AvailableConfigsController.getAvailableConfigRecords';
const columns = [
    { label: 'Label', fieldName: 'Label',sortable:true },
    { label: 'Type', fieldName: 'Type' },
    { label: 'Amount', fieldName: 'Amount' },
];
export default class AvailableConfig extends LightningElement {
    @track configData = [];
    columns = columns;
    showSpinner = true;
    noConfigRecords = true;
    searchText;
    configDataBackup;
    result;
    
    connectedCallback(){
        
        getAvailableConfigRecords().then(response => {
            console.log('response===',response);
            if(response.length > 0){
              
                this.configData = [];
                response.forEach(config => {
                    this.configData.push({'Label' : config.Label__c,
                                    'Type' : config.Type__c, 
                                    'Amount' : config.Amount__c,
                                   'id':config.Id})
                })
                console.log('this.configData----',this.configData);
                this.noConfigRecords = false; 
                this.configDataBackup = this.configData;
                
            }
            this.showSpinner = false;
            
        }).catch(error => {

        });
        
    }
    onChangeSearchText(event){
        this.searchText = event.detail.value;
    }
    searchConfigs(){
        console.log('this.searchText---',this.searchText);
        if(!this.searchText){
            this.configData  = this.configDataBackup;
            this.template.querySelector('c-table-pagination-lwc').refreshComp(this.configData);
            return refreshApex(this.configData);
        }
        else if(this.searchText.length < 2){
            this.showToast('Error','Search text should be of minimum 2 character', 'error');
        }else{
            // find all strings in array containing 'search text'
            const match =  this.configDataBackup.filter(s => s.Label.includes(this.searchText));
            this.configData = match;
            this.configData = [...this.configData];
            console.log('here',match);
            console.log('here size',match.length);
            this.searchText = undefined;
            this.template.querySelector('c-table-pagination-lwc').refreshComp(this.configData);
            return refreshApex(this.configData);
        }
    }
    showToast(title,message,variant){
        const toastEvent = new ShowToastEvent({
            title: title,
            message : message,
            variant:variant
        });
        this.dispatchEvent(toastEvent);
    }

}