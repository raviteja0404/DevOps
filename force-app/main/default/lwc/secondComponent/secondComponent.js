import { LightningElement } from 'lwc';

export default class SecondComponent extends LightningElement {

    fullname = 'Nani'
    crashcourse = 'LWC';

    area={
        location: 'Srikakulam',
        State: 'Andhra Pradesh'
    }


    ChHandler(event){
     this.crashcourse = event.target.value;
    }

    UpdateHandler(event){
        //this.area.location = event.target.value;
        this.area = {...this.area, location: event.target.value};

    }
}