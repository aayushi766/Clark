import { LightningElement } from 'lwc';

export default class HelloWorld1 extends LightningElement {
    dynamicGreeting = 'World';
    dynamicGreetingHandler(event){
        this.dynamicGreeting = event.target.value;
    }
}