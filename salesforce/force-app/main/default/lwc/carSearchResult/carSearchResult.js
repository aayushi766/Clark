import { LightningElement,api,wire,track } from 'lwc';
import getCars from '@salesforce/apex/CarSearchResultController.getCars'
import {ShowToastEvent} from 'lightning/platformShowToastEvent'
export default class CarSearchResult extends LightningElement {
    @api carTypeId ;
    @track cars;
    @track selectedCarId;
    @wire(getCars,{carTypeId : '$carTypeId'})
    wiredCars({data,error}){

        if(data){
            this.cars = data;
           
        }else if(error){
            this.showToast('Error',error.body.message, 'error');
        }
    }

    showToast(title , message , variant){
        const evt = new CustomEvent({
            title : title,
            message : message ,
            variant : variant,
        });
        this.ShowToastEvent(evt);
    }
    get carFound(){
        if(this.cars)
        return true;
        else 
        return false;
    }
    handleCarSelectHAndler(event){
        const carId = event.detail;
        this.selectedCarId = carId;
    }

}