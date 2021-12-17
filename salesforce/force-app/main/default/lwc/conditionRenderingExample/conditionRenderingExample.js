import { LightningElement,track } from 'lwc';

export default class ConditionRenderingExample extends LightningElement {
    @track divShow = false;
    @track cityList = ['Jaipur' , 'Bangalore' , 'Hyderabas'];
    showDiv(event){
        this.divShow = event.target.checked;
    }
}