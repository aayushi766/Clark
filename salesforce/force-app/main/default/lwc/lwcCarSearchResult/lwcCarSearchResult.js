import { LightningElement,wire ,track,api} from 'lwc';
import getCars from '@salesforce/apex/CarSearchResultController.getCars';
import {ShowToastEvent} from 'lightning/platformShowToastEvent';

export default class LwcCarSearchResult extends LightningElement {
    @track cars;
    @api carTypeId; 
    @wire(getCars,{carTypeId: '$carTypeId'})
    wiredgetcars(data , error){
        if(data){
            this.cars = data;
        }else if (error){
            this.showToast('Error',error.body.message, 'error');
        }
    }
    showToast(title , mesage , variant){
        const evt = new CustomEvent({'title' : title,
                    'mesage': mesage,
                    'variant': variant});
                    this.ShowToastEvent(evt);

    }
    get carsFound(){
        return this.cars ? true : false;
    }
}