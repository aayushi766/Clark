import { LightningElement,api } from 'lwc';

export default class LWCPublicMethodExample extends LightningElement {

    value = 'red';
    options = [{'label':'red','value':'red'},
    {'label':'blue','value':'blue'},
    {'label':'yellow','value':'yellow'},
    {'label':'green','value':'green'}];

    @api
    selectCheckbox(chechboxvalue){
        const selectedCheckboc = this.options.find(checkbox => {
            return checkboxvalue === checkbox.value;
        });
        if(selectedCheckboc){
            this.value = selectedCheckboc;
            return "successfully checked";
        }else{
            return "No checkbox found";
        }

    }
}