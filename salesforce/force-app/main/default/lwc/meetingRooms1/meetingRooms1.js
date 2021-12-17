import { LightningElement} from 'lwc';

export default class MeetingRooms1 extends LightningElement {
  selectedMeetingRoomInfo;
  meetingRooms =[{roomName:'A1',roomCapacity:'12'},
                    {roomName:'B1',roomCapacity:'15'},
                    {roomName:'C1',roomCapacity:'16'},
                    {roomName:'D1',roomCapacity:'17'},
                    {roomName:'E1',roomCapacity:'18'}];
                    ontileselecthandler(event){
                     const meetingRoomInfo = event.detail;
                      this.selectedMeetingRoomInfo = meetingRoomInfo.roomName;
                    }
}