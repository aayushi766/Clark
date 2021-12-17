import { LightningElement,track } from 'lwc';

export default class LWCParentPublicMethod extends LightningElement {
    @track value = '';

    onChangeHAndler(){
        const childComponent = this.template.querySelector('c-lwc-public-method-child-component');
        const returnMessage = childComponent.selectCheckbox(this.value);
        console.log(returnMessage);

    }

    onInputChangeHandler(event){
        console.log('test');
        this.value = event.target.value;
        console.log('value'+this.value);
    }
}