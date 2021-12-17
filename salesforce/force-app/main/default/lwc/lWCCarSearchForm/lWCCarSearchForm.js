import { LightningElement ,track,wire} from 'lwc';
import getCarTypes from '@salesforce/apex/CarSearchFormController.getCarTypes';
import {showToastEvent} from 'lightning/platformShowToastEvent';
import {NavigationMixin} from 'lightning/navigation'

export default class LWCCarSearchForm extends NavigationMixin(LightningElement) {
    @track carTypes;
     @wire(getCarTypes) 
    wiredCarTypes({data,error}){
        this.carTypes = [{label: 'All Types', value: ''}];
        if(data){
            data.forEach(element => {
                const carType = {label:element.Name , value :element.Id};
                
               this.carTypes.push(carType);
            });
        }else if (error){
            this.toastEvent('error', error.body.message , 'error');
        }
       

    };
    carTypeChangeHandler(event){
        const carTypeId = event.target.value;
        const carTypeSelection = new CustomEvent('cartypeselect',{detail : carTypeId});
        this.dispatchEvent(carTypeSelection);
    }
    createNewCarType(){
      
        this[NavigationMixin.Navigate]({
            type:'standard__objectPage',
            attributes :{
                objectApiName : 'Car_Type__c',
                actionName : 'new'
            }

        })
    }
    toastEvent(title , message , variant){
        const evt = new showToastEvent({'title' : title , 'message':message , 'variant' : variant});
        this.dispatchEvent(evt);

    }
}