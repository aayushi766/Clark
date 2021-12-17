import { LightningElement,track } from 'lwc';

export default class ConditionRenderingExample1 extends LightningElement {
    @track displayDiv = false;
   @track cityList = ['Jaipur','Kota','KAtni'];
    showDivHandler(event){
        this.displayDiv = event.target.checked;

    }

}