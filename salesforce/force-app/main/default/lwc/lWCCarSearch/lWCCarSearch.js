import { LightningElement } from 'lwc';

export default class LWCCarSearch extends LightningElement {
    carTypeId;
    
    carTypeSelectHandler(event){
        this.carTypeId = event.detail;
    }
}