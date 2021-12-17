import { LightningElement,wire } from 'lwc';
import {getRecord} from 'lightning/uiRecordApi';
import {registerListener,unregisterAllListeners} from 'c/pubsub';
import {CurrentPageReference} from 'lightning/navigation';
import carId from '@salesforce/schema/Car__c.Id';
import carName from '@salesforce/schema/Car__c.Name';
import carMileage from '@salesforce/schema/Car__c.Mileage__c';
import car_Per_DAY_RENT from '@salesforce/schema/Car__c.Per_Day_Rent__c';
import car_BUILD_YEAR from '@salesforce/schema/Car__c.Build_Year__c';
import car_PICTURE from '@salesforce/schema/Car__c.Picture__c';
import car_CONTACT_NAME from '@salesforce/schema/Car__c.Contact__r.Name';
import car_CONTACT_EMAIL from '@salesforce/schema/Car__c.Contact__r.Email';
import car_CONTACT_HOMEPHONE from '@salesforce/schema/Car__c.Contact__r.HomePhone';
import car_CARTYPE from '@salesforce/schema/Car__c.Car_Type__r.Name';
const fields = [
    carId,
    carName,
    carMileage,
    car_Per_DAY_RENT,
    car_BUILD_YEAR,
    car_PICTURE,
    car_CONTACT_NAME,
    car_CONTACT_EMAIL,
    car_CONTACT_HOMEPHONE,
    car_CARTYPE
];
export default class CarDetails extends LightningElement {
    carId;
    @wire(getRecord,{ recordId : '$carId' , fields})
    car;
    @wire(CurrentPageReference) pageRef;
    
    selectedTab;
    tabchangehandler(event){
        this.selectedTab = event.target.value;
    }
    connectedCallback(){
        registerListener('carselect', this.callbackMethod, this);
    }
    callbackMethod(payload){
            this.carId = payload.id;
    }
    disconnectedCallback(){
        unregisterAllListeners(this);
    }

    get isCarAvailable(){
        if(this.car.data){
            return true;
        }
        return false;
    }

    experienceAddedHandler(){
        const comp = this.template.querySelector('c-view-experiences');
        if(comp){
            comp.getCarExperiences();
        }
        this.selectedTab  = 'viewexperience';
    }
}