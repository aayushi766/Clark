import { LightningElement,track ,wire} from 'lwc';
import {createRecord , getRecord} from 'lightning/uiRecordApi';
const fieldArray = ['Account.Name' , 'Account.Phone' , 'Account.Website'];
export default class AccountManager extends LightningElement {
    @track name;
    @track phone;
    @track website;

    @track recordId;

    @wire(getRecord, {recordId : '$recordId', fields:fieldArray})
    accountRecord;

    accountNameChangeHandler(event){
        this.name = event.target.value;
    }

    accountPhoneChangeHandler(event){
        this.phone = event.target.value;
    }

    accountWebsiteChangeHandler(event){
        this.website = event.target.value;
    }

    insertRecord(){
        const fields = {'Name':this.name , 'Phone' : this.phone , 'Website':this.website};
        const recordInput = {apiName : 'Account',fields};
        createRecord(recordInput).then(response =>{
            console.log('Account has been created ' + response.id);
            this.recordId = response.id;
        }).catch(error => {
            console.error('Error in creating account '+error.body.message);
        });
    }

    get retAccountName(){
        if(this.accountRecord.data){
            return this.accountRecord.data.fields.Name.value;
        }
        return undefined;
    }

    get retAccountPhone(){
        if(this.accountRecord.data){
            return this.accountRecord.data.fields.Phone.value;
        }
        return undefined;
    }

    get retAccountWebsite(){
        if(this.accountRecord.data){
            return this.accountRecord.data.fields.Website.value;
        }
        return undefined;
    }
}