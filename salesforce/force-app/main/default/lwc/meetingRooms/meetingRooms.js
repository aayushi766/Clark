import { LightningElement,track } from 'lwc';


export default class MeetingRooms extends LightningElement {
    meetingRoomsInfo =[
        {roomName:'A101' , roomCapacity:'100'},
        {roomName:'A102' , roomCapacity:'100'},
        {roomName:'A103' , roomCapacity:'500'},
        {roomName:'A104' , roomCapacity:'200'},
        {roomName:'A105' , roomCapacity:'100'}
    ];
    @track selectedMeetingInfo ;

    onTileSelectHandler(event){
        const meetingRoomInfo = event.detail;
        this.selectedMeetingInfo = meetingRoomInfo;
    }

    /*constructor(){
        super();
        this.template.addEventListener('tileclick',this.onTileSelectHandler.bind(this));
    }*/
}