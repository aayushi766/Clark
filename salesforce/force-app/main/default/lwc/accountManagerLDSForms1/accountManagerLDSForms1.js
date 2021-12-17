import { LightningElement ,track} from 'lwc';

export default class AccountManagerLDSForms1 extends LightningElement {
    @track recordId;
    successHandler(event){
        console.log('record id ');
        this.recordId = event.detail.id;
        console.log('record id :',this.recordId);
    }
}