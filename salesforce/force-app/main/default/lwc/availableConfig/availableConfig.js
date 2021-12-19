import { LightningElement,track,api,wire } from 'lwc';
import {ShowToastEvent} from 'lightning/platformShowToastEvent';
import { refreshApex } from '@salesforce/apex';
import { getRecordNotifyChange } from 'lightning/uiRecordApi';
import getAvailableConfigRecords from '@salesforce/apex/ConfigManagementController.getAvailableConfigRecords';
import saveConfigRecords from '@salesforce/apex/ConfigManagementController.saveConfigRecords';
// Import message service features required for publishing and the message channel
import { publish, MessageContext } from 'lightning/messageService';
import CONFIG_SAVED from '@salesforce/messageChannel/Config_Saved__c';
const columns = [
    { label: 'Label', fieldName: 'Label',sortable:true },
    { label: 'Type', fieldName: 'Type' },
    { label: 'Amount', fieldName: 'Amount' }, 
];
export default class AvailableConfig extends LightningElement {
    @track configData = []; // variable to hold configs
    columns = columns;
    showSpinner = true;
    noConfigRecords = true;
    searchText;
    configDataBackup; //variable to hold config record in backup
    result;
    saveEvent = false;
    disableAddButton = false;
    @api recordId;
    @wire(MessageContext)
    showcheckboxcolumn = true;
    messageContext;

    //this method will be called on component load
    connectedCallback(){
        this.refreshPage(); //load the data
    }
    //a multi purpose method to refresh component
    refreshPage(){
        //apex call to get available config records.
        getAvailableConfigRecords({'caseId':this.recordId}).then(response => {
            if(response){
                if(response.caseConfigs && response.caseConfigs.length > 0){
                    this.configData = [];
                    response.caseConfigs.forEach(config => {
                        this.configData.push({'Label' : config.Label,
                                            'Type' : config.Type, 
                                            'Amount' : config.Amount,
                                            'id':config.recordId})
                    })
                    this.noConfigRecords = false; 
                    this.configDataBackup = this.configData;
                    this.configData = [...this.configData];
                    if(this.saveEvent){ //once data saved refresh child component
                        this.saveEvent = false;
                        this.template.querySelector('c-table-pagination-lwc').refreshComp(this.configData);
                    } 
                }
                if(response.status == 'Closed'){
                    this.disableAddButton = true;
                    this.showcheckboxcolumn = false;
                }
            }        
            this.showSpinner = false;
        }).catch(error => {
            this.showToast('Error',error.description.message, 'error');
        });
    }
    //to load search text field on input change
    onChangeSearchText(event){
        this.searchText = event.detail.value;
    }
    //search config records with search text where search text should be of minimum 2 length
    searchConfigs(){
        if(!this.searchText){ //a case to show all records back.. when search text is blank
            this.configData  = this.configDataBackup;
            this.template.querySelector('c-table-pagination-lwc').refreshComp(this.configData);
            return refreshApex(this.configData);
        }
        else if(this.searchText.length < 2){ //show error when search text has length < 2
            this.showToast('Error','Search text should be of minimum 2 character', 'error');
        }else{
            // find all strings in array containing 'search text'
            const match =  this.configDataBackup.filter(s => s.Label.includes(this.searchText));
            this.configData = match;
            this.configData = [...this.configData];
            this.searchText = undefined;
            this.template.querySelector('c-table-pagination-lwc').refreshComp(this.configData);
            return refreshApex(this.configData);
        }
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
    //save config records to database on click of save method
    saveConfigs(){
        var selectedRows = this.template.querySelector('c-table-pagination-lwc').getSelectedRows();
        if(selectedRows.length == 0){
            this.showToast('Error','Please select config from available config records', 'error');
        }else{
            selectedRows = [...selectedRows]; 
            const match =  this.configDataBackup.filter(s => selectedRows.includes(s.id));
            this.showSpinner = true;
            saveConfigRecords({payload : JSON.stringify(match), caseId:this.recordId}).then(response =>{
                this.saveEvent = true;
                // Notify LDS that you've changed the record outside its mechanisms.
                getRecordNotifyChange([{recordId: this.recordId}])
                this.showToast('Success','Case Configs created successfully', 'success');
                publish(this.messageContext,CONFIG_SAVED,null);
                return refreshApex(this.refreshPage());
                
            }).catch(error=>{
                console.log('error---',error);
                this.showToast('Error',error.description.message, 'error');
                this.showSpinner = false;
            })      
        }
    }//end of saveConfigs method

}//end of lwc component