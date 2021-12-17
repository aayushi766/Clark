import { LightningElement ,api} from 'lwc';
import {NavigationMixin} from 'lightning/navigation';

export default class CarDetail extends NavigationMixin(LightningElement) {
    @api car;
    fullDetails(){
        this[NavigationMixin.Navigate]({
            type:"standard__recordPage",
            attributes : {
                recordId : this.car.data.fields.Id.value,
                objectApiName : "Car__c",
                actionName : "view",

            }
        })

        
    }
    get carName(){
        try{
            return this.car.data.fields.Name.value;
        }catch(error){
            //console.error('error',error.body.message);
            return 'NA';
        }
    }
    get carMileage(){
        try{
            return this.car.data.fields.Mileage__c.value;
        }catch(error){
            console.error('error',error);
            return 'NA';
        }
    }
    get carPerDay(){
        try{
            return this.car.data.fields.Per_Day_Rent__c.value;
        }catch(error){
            return 'NA';
        }
    }
    get carBuildYear(){
        try{
            console.log('this.car.data.fields.Build_Year__c.value',this.car.data.fields.Build_Year__c.value);
            return this.car.data.fields.Build_Year__c.value;
        }catch(error){
            return 'NA';
        }
    }
    get carPicture(){
        try{
            return this.car.data.fields.Picture__c.value;
        }catch(error){
            return 'NA';
        }
    }

    get carContactName(){
        try{
            return this.car.data.fields.Contact__r.value.fields.Name.value;
        }catch(error){
            console.error('error',error);
            console.log(this.car);
            return 'NA';
        }
    }
    get carContactEmail(){
        try{
            return this.car.data.fields.Contact__r.value.fields.Email.value;
        }catch(error){
            return 'NA';
        }
    }
    get carContactTel(){
        try{
            return this.car.data.fields.Contact__r.value.fields.HomePhone.value;
        }catch(error){
            return 'NA';
        }
    }
    get carCarTypeName(){
        try{
            return this.car.data.fields.Car_Type__r.value.fields.Name.value;
        }catch(error){
            return 'NA';
        }
    }

    

}