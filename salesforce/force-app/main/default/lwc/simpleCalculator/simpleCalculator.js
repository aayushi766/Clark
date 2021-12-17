import { LightningElement,track } from 'lwc';

export default class SimpleCalculator extends LightningElement {
    @track resultValue;
    firstNumber;
    secondNumber;
    @track previousResult = [];
    @track showResult = false;
    numberHandler(event){
        const inputBoxName = event.target.name;
        if(inputBoxName == 'firstNumber'){
            this.firstNumber = event.target.value;
        }else{
            this.secondNumber = event.target.value;
        }
    }

    addHandler(){
        const firstN = parseInt(this.firstNumber);
        const secondN = parseInt(this.secondNumber);
        this.resultValue = 'Result of ' + firstN + '+' +secondN + ' is '+(firstN+secondN);
        this.previousResult.push(this.resultValue);
    }

    subHandler(){
        const firstN = parseInt(this.firstNumber);
        const secondN = parseInt(this.secondNumber);
        this.resultValue = 'Result of ' + firstN + '-' +secondN + ' is '+(firstN-secondN);
        this.previousResult.push(this.resultValue);
    }

    mulHandler(){
        const firstN = parseInt(this.firstNumber);
        const secondN = parseInt(this.secondNumber);
        this.resultValue = 'Result of ' + firstN + '*' +secondN + ' is '+(firstN*secondN);
        this.previousResult.push(this.resultValue);
    }

    divHandler(){
        const firstN = parseInt(this.firstNumber);
        const secondN = parseInt(this.secondNumber);
        this.resultValue = 'Result of ' + firstN + '/' +secondN + ' is '+(firstN/secondN);
        this.previousResult.push(this.resultValue);
    }

    showPreviousResult(event){
        this.showResult = event.target.checked;
    }
}