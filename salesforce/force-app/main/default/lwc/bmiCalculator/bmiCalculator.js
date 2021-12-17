import { LightningElement,track } from 'lwc';

import {getBMI} from 'c/bmi';

export default class BmiCalculator extends LightningElement {
    cartTitle = 'BMI Calculator'; // private property
    weight;
    height;
    @track bmiResult;
    weightHandler(event){
        this.weight = parseFloat(event.target.value);
    }
    heightHandler(event){
        this.height = parseFloat(event.target.value);
    }
    calculateBMI(){
        /*try{
            this.bmiResult = this.weight/(this.height*this.height);
   
        }catch(Exception){
            this.bmiResult = undefined;
        }*/
        this.bmiResult = getBMI(this.weight , this.height);
     }
    get bmiValue(){
        if(this.bmiResult == undefined){
            return '';
        }
        return 'Your result is'+ this.bmiResult;
    }
}