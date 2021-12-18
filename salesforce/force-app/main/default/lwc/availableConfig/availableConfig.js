import { LightningElement,api,track } from 'lwc';
import getAvailableConfigRecords from '@salesforce/apex/AvailableConfigsController.getAvailableConfigRecords';
const columns = [
    { label: 'Label', fieldName: 'Label',sortable:true },
    { label: 'Type', fieldName: 'Type' },
    { label: 'Amount', fieldName: 'Amount' },
];
export default class AvailableConfig extends LightningElement {
    configData = [];
    columns = columns;
    showSpinner = true;
    noConfigRecords = true;

    @api showTable = false;
    @api records;
    @api recordsperpage;
    

    @track draftValues = [];
    @track recordsToDisplay;

    totalRecords;
    pageNo;
    totalPages;
    startRecord;
    endRecord;
    end = false;
    pagelinks = [];
    isLoading = false;
    defaultSortDirection = 'asc';
    sortDirection = 'asc';
    ortedBy;
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
                
            }
            this.showSpinner = false;
            
        }).catch(error => {

        });
        
    }
}