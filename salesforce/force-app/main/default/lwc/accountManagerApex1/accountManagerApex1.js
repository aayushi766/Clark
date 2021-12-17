import { LightningElement ,track} from 'lwc';
import getAllAccount from '@salesforce/apex/AccountManager1.getAllAccount';
import {ShowToastEvent} from 'lightning/platformShowToastEvent'

export default class AccountManagerApex1 extends LightningElement {
    //@wire(getAllAccount) 
    @track accounts;
    numberOfRecords;
    get responseReceived(){
        //console.log('this error', this.accounts );
       if(this.accounts){
            return true;
        }else{
            return false;
        } 
    }

    numberOfAccHandler(event){
        this.numberOfRecords = event.target.value;

    }
    getaccounts(){
        getAllAccount({numberOfRec :this.numberOfRecords}).then(response => {
            console.log('this error 1', this.accounts );
            this.accounts = response;
            const toastEvent = new ShowToastEvent({
                title : 'Accounts loaded',
                message : this.numberOfRecords + 'Accounts fetched from server',
                variant : 'success',
            });
            this.dispatchEvent(toastEvent);
        }).catch(error => {
            console.error('Error in creating account',response);
            const toastEvent = new ShowToastEvent({
                title : 'Error in getting records',
                message : error.body.message,
                variant : 'error',
            });
            this.dispatchEvent(toastEvent);
        });

    }
}