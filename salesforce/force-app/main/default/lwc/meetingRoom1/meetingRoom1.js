import { LightningElement,api,wire } from 'lwc';
import {fireEvent} from 'c/pubsub';
import {CurrentPageReference} from 'lightning/navigation';

export default class MeetingRoom1 extends LightningElement {
    @api meetingRoomInfo ;
    @wire(CurrentPageReference) pageReference;
    tileClickHandler(){
        const tileclicked = new CustomEvent('tileclick',{detail : this.meetingRoomInfo});
        this.dispatchEvent(tileclicked);
        console.log('tile clicked');
        fireEvent(this.pageReference,'pubsubtileclicked',this.meetingRoomInfo);
    }

}