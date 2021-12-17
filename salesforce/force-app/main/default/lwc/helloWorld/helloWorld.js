import { LightningElement,track,wire } from 'lwc'; // import lwc module --- we will be using lightning elements not html elements

export default class HelloWorld extends LightningElement { // to write any of client side logic
   @track dynamicGreeting = "world";
   greetingChangeHandler(event){
        this.dynamicGreeting = event.target.value;
   }
}