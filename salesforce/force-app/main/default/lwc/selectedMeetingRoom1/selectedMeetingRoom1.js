import { LightningElement,wire,track } from 'lwc';
import {registerListener,unregisterAllListeners} from 'c/pubsub';
import {CurrentPageReference} from 'lightning/navigation';

export default class SelectedMeetingRoom1 extends LightningElement {
    @track selectedMeetingRoomInfo = {};
    @wire(CurrentPageReference) pageRef;
    connectedCallback(){
        registerListener('pubsubtileclicked',this.onMeetingRoomSelectHandler,this);
    }
    disconnectedCallback(){
        unregisterAllListeners(this);
    }
    onMeetingRoomSelectHandler(payload){
        console.log('event fired'+payload);
        this.selectedMeetingRoomInfo = payload;
    }
    
}