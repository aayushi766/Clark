import { LightningElement ,track} from 'lwc';
import addToDo from '@salesforce/apex/ToDoController.addToDo';
import getCurrentToDos from '@salesforce/apex/ToDoController.getCurrentToDos';


export default class ToDoManager extends LightningElement {
    time = "8:15 PM";
    greeting ="Good Evening";
    @track toDos = [];

    
    connectedCallback(){ // as soon as component is initialized
        this.getTime();
        setInterval(() =>{
            this.getTime();
            //console.log("set interval called");
        },1000*60);
        this.fetchToDos();
        //this.populateToDos();

    }
    fetchToDos(){
        getCurrentToDos().then(response => {
            if(response){
                console.log('Retrieved todos from server'+response.length);
                this.toDos = response;
            }
            
        }).catch(error => {
            error.log('Error in fetching'+error);
        });
    }

    getTime(){
        const date = new Date(); 
        const hour = date.getHours();
        const minute = date.getMinutes();
        this.time = `${this.getHour(hour)}:${this.getDoubleDigit(minute)} ${this.getMidDay(hour)}`
        this.setGreeting(hour);
    }

    getHour(hour){
        if(hour == 0){
            return 12;
        }else if(hour > 12){
            return hour-12;
        }else{
            return hour;
        }
    }
    
    setGreeting(hour){
        if(hour < 12){
            this.greeting = "Good Morning";
        }
        else if(hour >= 12 && hour < 17){
            this.greeting = "Good Afternoon";
        }else{
            this.greeting = "Good Evening";
        }

    }

 
    getMidDay(hour){
        return hour >=12 ? "PM" : "AM";
    }

    getDoubleDigit(digit){
        return digit<10 ? "0"+digit : digit;
    }

    addToDoHandler(){
        const inputBox = this.template.querySelector("lightning-input");
        const toDo ={
            todoName : inputBox.value,
            done: false,
            
        }
        addToDo({payload : JSON.stringify(toDo)}).then(response =>{
            console.log('Item inserted successfully');
            this.fetchToDos();
        }).catch(error => {
            console.error('error in inserting iterm', error.description.message);
        })
        
        inputBox.value = "";
        

    }

    get upcomingTasks(){
        return this.toDos && this.toDos.length  ? this.toDos.filter(todo => !todo.done) : [];
    }

    get completedTasks(){
        return this.toDos && this.toDos.length  ? this.toDos.filter(todo => todo.done) : [];
    }

    /*populateToDos(){
        const todo = [
            {
                toDoId : 0,
                toDoValue : 'Have water',
                done: false,
                toDoDate: new Date()
            },
            {
                toDoId : 1,
                toDoValue : 'Wash car',
                done: false,
                toDoDate: new Date()

            },
            {
                toDoId : 2,
                toDoValue : 'feed cat',
                done: true,
                toDoDate: new Date()

            },
            {
                toDoId : 3,
                toDoValue : 'Go for shopping',
                done: true,
                toDoDate: new Date()
            }
        ];
        this.toDos =  todo;

    }*/
    

    updateHandler(){
        this.fetchToDos();
    }
    deleteHandler(){
        this.fetchToDos();
    }
}