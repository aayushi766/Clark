import { LightningElement ,api,track} from 'lwc';
import getCarExp from '@salesforce/apex/CarExperience.getCarExp';
import {ShowToastEvent} from 'lightning/platformShowToastEvent';
import {NavigationMixin} from 'lightning/navigation';

export default class ViewExperiences extends NavigationMixin(LightningElement) {
    //@api carId;
    privateCarId;
    @track carExperiences = [];
    @api
    get carId(){
        return this.privateCarId;
    }
    set carId(value){
         this.privateCarId = value;
         this.getCarExperiences();
    }
    connectedCallback(){
        this.getCarExperiences();
    }
    @api
    getCarExperiences(){
        getCarExp({carId : this.privateCarId}).then((response) =>{
            this.carExperiences = response;
        }).catch((error) => {
            this.showToast('Error',error.body.message, 'error');
        });
    }
    showToast(title, message , variant){
        const evt = new ShowToastEvent({
            title : title,
            message : message ,
            variant : variant,
        });
        this.dispatchEvent(evt);
    }
    get hasExperiences(){
        if(this.carExperiences.length > 0){
            return true;
        }
        return false;
    }

    userClickHandler(event){
        const userId = event.target.getAttribute('data-userid');

        this[NavigationMixin.Navigate]({
            type : "standard__recordPage",
            attributes:{
                recordId : userId,
                objectApiName : "User",
                actionName: "view",
            }
        });
    }
}