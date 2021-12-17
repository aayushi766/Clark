import { LightningElement,track } from 'lwc';
import getAllAccounts from '@salesforce/apex/AccountManager.getAccount';
import {ShowToastEvent} from 'lightning/platformShowToastEvent';

export default class accountManagerApex extends LightningElement {
    //@wire(getAllAccounts)
    //accountRecords;
    
    @track numberOfAccount;
    @track accountRecords;

    get responseReceived(){
        if(this.accountRecords){
            return true;
        }else{
            return false;
        }
    }

    numberHandler(event){
        this.numberOfAccount = event.target.value;
    }

    onClickHandler(){
        getAllAccounts({numberOfAccount : this.numberOfAccount}).then(response=>{
            this.accountRecords = response;
            const toastEvent = new ShowToastEvent({
                title:'Account loaded',
                message : this.numberOfAccount + ' Accounts loaded',
                variant:'success'
            });
            this.dispatchEvent(toastEvent);
        }).catch(error=>{
            console.error('Error in getting account '+error.body.message);
            const toastEvent = new ShowToastEvent({
                title:'Error in getting Accounts',
                message : error.body.message,
                variant:'error'
            });
            this.dispatchEvent(toastEvent);
        });
    }
}