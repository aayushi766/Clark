import { LightningElement,track } from 'lwc';

export default class SimpleCalculator1 extends LightningElement {
    firstNumber;
    secondNumber;
    @track currentResult;
    @track previousResults =[];
    @track displayDiv =false;
    numberChangeHandler(event){
        const inputBoxName = event.target.name;
        if(inputBoxName == 'firstNumber'){
            this.firstNumber = event.target.value;
        }
        if(inputBoxName == 'secondNumber'){
            this.secondNumber = event.target.value;
        }
    }
    addHandler(){
        const tempFirstNumber = parseInt(this.firstNumber);
        const tempSecondNumber = parseInt(this.secondNumber);
        this.currentResult = 'Result of'+tempFirstNumber+'+'+tempSecondNumber+'is'+(tempFirstNumber+tempSecondNumber);
        this.previousResults.push(this.currentResult );
    }
    subHandler(){
        const tempFirstNumber = parseInt(this.firstNumber);
        const tempSecondNumber = parseInt(this.secondNumber);
        this.currentResult = 'Result of'+tempFirstNumber+'-'+tempSecondNumber+'is'+(tempFirstNumber-tempSecondNumber);
        this.previousResults.push(this.currentResult );
    }
    mulHandler(){
        const tempFirstNumber = parseInt(this.firstNumber);
        const tempSecondNumber = parseInt(this.secondNumber);
        this.currentResult = 'Result of'+tempFirstNumber+'X'+tempSecondNumber+'is'+(tempFirstNumber*tempSecondNumber);
        this.previousResults.push(this.currentResult );

    }
    divHandler(){
        const tempFirstNumber = parseInt(this.firstNumber);
        const tempSecondNumber = parseInt(this.secondNumber);
        this.currentResult = 'Result of'+tempFirstNumber+'/'+tempSecondNumber+'is'+(tempFirstNumber/tempSecondNumber);
        this.previousResults.push(this.currentResult );
    }

    checkboxHandler(event){
        this.displayDiv = event.target.checked;
    }
}