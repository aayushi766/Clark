import { LightningElement,wire} from 'lwc';
import {createRecord,getRecord} from 'lightning/uiRecordApi';
const fieldArray =['Account.Name','Account.Phone','Account.Website'];
export default class AccountManagerLDS extends LightningElement {
    name;
    website;
    phone;
    recordId;
    @wire(getRecord,{recordId : '$recordId', fields:fieldArray})
    accountRecord;
    accountNameChangeHandler(event){
        this.name = event.target.value;
    }
    accountWebsiteChangeHandler(event){
        this.website = event.target.value;
    }
    accountPhoneChangeHandler(event){
        this.phone = event.target.value;
    }
    createAccount(){
        const fields = {'Name':this.name ,'Website': this.website , 'Phone' : this.phone};
        const recordInput = {apiName:'Account', fields};
        createRecord(recordInput).then(response =>{
            this.recordId = response.id;
            console.log('Account has been created');
        }).catch(error=>{
            console.error('error in creating account', error.body.message);
        });
    }
    get retAccountName(){
        if(this.accountRecord.data){
            return this.accountRecord.data.fields.Name.value;

        }
        return undefined;
    }
    get retWebsiteName(){
        if(this.accountRecord.data){
            return this.accountRecord.data.fields.Website.value;

        }
        return undefined;
    }
    get retPhoneName(){
        if(this.accountRecord.data){
            return this.accountRecord.data.fields.Phone.value;

        }
        return undefined;
    }
}