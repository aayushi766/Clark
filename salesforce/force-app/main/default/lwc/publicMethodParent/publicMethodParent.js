import { LightningElement,track } from 'lwc';

export default class PublicMethodParent extends LightningElement {
    @track value;
    checkSelectedComponent(){
        const childComp = this.template.querySelector('c-public-method-exm-checkbox');
        const returnMsg = childComp.selectCheckBox(this.value);
        console.log(returnMsg);
    }
    valueHandler(event){
        this.value = event.target.value;
    }
}