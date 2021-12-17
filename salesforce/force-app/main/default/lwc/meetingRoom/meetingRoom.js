import { LightningElement,api,wire } from 'lwc';
import { fireEvent} from 'c/pubsub';
import { CurrentPageReference} from 'lightning/navigation';
export default class MeetingRoom extends LightningElement {
    @api meetingRoomInfo;
    @wire(CurrentPageReference) pageReference;
    tileClickHandler(){
        const tileClicked = new CustomEvent('tileclick', {detail : this.meetingRoomInfo.roomName});
        //const tileClicked = new CustomEvent('tileclick', {detail : this.meetingRoomInfo.roomName},bubble:true);
       
        this.dispatchEvent(tileClicked);
        fireEvent(this.pageReference , 'pubsubtileclick' , this.meetingRoomInfo);
    }
}