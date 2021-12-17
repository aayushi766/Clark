import { LightningElement,api } from 'lwc';
import {createRecord} from 'lightning/uiRecordApi'
import NAME_FIELD from '@salesforce/schema/Car_Experience__c.Name';
import EXPERIENCE_FIELD from '@salesforce/schema/Car_Experience__c.Experience__c';
import CAR_FIELD from '@salesforce/schema/Car_Experience__c.Car__c';
import EXPERIENCE_OBJECT from '@salesforce/schema/Car_Experience__c';
import {ShowToastEvent} from 'lightning/platformShowToastEvent';
export default class AddCarExperience extends LightningElement {
    expTitle = '';
    expDescription = '';
    @api carId;
    handleTitleChangeHandler(event){
        this.expTitle = event.target.value;
    }
    handleDescriptionChangeHandler(event){
        this.expDescription = event.target.value;
    }
    addExperience(){
        const fields = {};
        fields[NAME_FIELD.fieldApiName] =  this.expTitle;
        fields[EXPERIENCE_FIELD.fieldApiName] = this.expDescription;
        fields[CAR_FIELD.fieldApiName] = this.carId;
        const rec =  {apiName : EXPERIENCE_OBJECT.objectApiName , fields};
        console.log('rec--',rec);
        createRecord(rec).then(carExperience => {
            this.showToast('Success','Experience record updated' , 'success');
            const expAdded = new CustomEvent('experienceadded');
            this.dispatchEvent(expAdded);
        }).catch(error=>{
            this.showToast('Error',error.body.message , 'error');
        });
    }

    showToast(title , message , variant ){
        const evt = new ShowToastEvent({
            title : title ,
            message : message ,
            variant : variant,
        });
        this.dispatchEvent(evt);
    }
}