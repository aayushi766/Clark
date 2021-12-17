import { LightningElement ,api} from 'lwc';
import getAllAccount from '@salesforce/apex/AccountManager1.getAllAccount'
export default class AccountRecordForm1 extends LightningElement {
    @api recordId;
    @api objectApiName;
    fieldArray = ['Name', 'Phone' , 'Website'];
    handleSuccess(event){
        this.recordId = event.detail.id;
    }
}