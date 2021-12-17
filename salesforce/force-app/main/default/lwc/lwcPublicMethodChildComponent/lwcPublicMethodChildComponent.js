import { LightningElement,api,track } from 'lwc';

export default class lwcPublicMethodChildComponent extends LightningElement {

    @track value =['red'];
     options = [
         {label:'red',value: 'red'},
    {label:'blue',value:'blue'},
    {label:'yellow',value:'yellow'},
    {label:'green',value:'green'}];

    @api
    selectCheckbox(checkboxvalue){
        const selectedCheckboc = this.options.find( checkbox => {
            return checkboxvalue === checkbox.value;
        });

        if(selectedCheckboc){
            this.value = selectedCheckboc.value;
            return "successfully checked";
        }else{
            return "No checkbox found";
        }

    }
}