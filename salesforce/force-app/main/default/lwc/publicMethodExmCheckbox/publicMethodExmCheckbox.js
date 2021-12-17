import { LightningElement,track , api } from 'lwc';

export default class PublicMethodExmCheckbox extends LightningElement {
    @track value = ['Red'];

    options= [
            { label: 'Red Marker', value: 'Red' },
            { label: 'Green Marker', value: 'Green' },
            { label: 'Yellow Marker', value: 'Yellow' },
            { label: 'Black Marker', value: 'Black' },
        ];
    

    @api selectCheckBox(checkBoxValue){
        const selectedCheckBox = this.options.find(checkBox =>{
            return checkBoxValue === checkBox.value;
        });
        if(selectedCheckBox){
            this.value = selectedCheckBox.value;
            return 'successfully checked';
        }
            return 'no checkbox found';
        
    }
}