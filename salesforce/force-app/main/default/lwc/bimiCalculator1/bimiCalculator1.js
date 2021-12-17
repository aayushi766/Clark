import { LightningElement ,track} from 'lwc';

export default class BimiCalculator1 extends LightningElement {
    cardTitle = "BMI Calculator";
    
    
    
    @track bmiData = {
    weight: 0,
    height: 0,
    result1: 0
   } 
   
    weightHandler(event){
        this.bmiData.weight = parseFloat(event.target.value);
    }
    heightHandler(event){
        this.bmiData.height = parseFloat(event.target.value);
    }
    bmiCalculator(){
        try{
            this.bmiData.result1 = this.bmiData.weight/(this.bmiData.height*this.bmiData.height);
        }catch(error){
            this.bmiData.result1 = undefined;
        }
        
    }
}