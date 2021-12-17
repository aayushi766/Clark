import { LightningElement,api } from 'lwc';
import updateToDo from '@salesforce/apex/ToDoController.updateToDo';
import deleteToDo from '@salesforce/apex/ToDoController.deleteToDo';



export default class ToDoItem extends LightningElement {
    @api todoName;
    @api todoId;
    @api done = false;
    get iconName(){
        return this.done==true ? "utility:check" : "utility:add";
    }

    get containerClass(){
        return this.done == true ? "todo completed" : "todo upcoming";
    }

    updateToDoHandler(){
        const todo = {todoId : this.todoId,
            todoName : this.todoName,
            done : !this.done  } ;

        updateToDo({payload :  JSON.stringify(todo)}).then(response =>{
            console.log('record updated successfully');
            const updateEvt = new CustomEvent('update');
            this.dispatchEvent(updateEvt);
        }).catch(error => {
            console.log('error occurred during update', error);
        });
       
    }

    DeleteToDoHandler(){
        const todo = {todoId : this.todoId} ;
        deleteToDo( {payload :  JSON.stringify(todo)}).then(response =>{
            console.log('record deleted successfully');
            const deleteEvt = new CustomEvent('delete');
            this.dispatchEvent(deleteEvt);
        }).catch(error => {
            console.log('error occurred during delete', error);
        });


    }
}