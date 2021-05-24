import {Customer} from "../Customers/customer.model";
export class Event {
    id: number;
    systemName:string;
    createdDateTime: Date;
    lastModifiedDateTime: Date;
    customerId:number;
    customer:Customer;
    eventStatusId:number;
    eventStatus:EventStatus;
}
export class EventStatus {
    Id: number;
    systemName: string;
    CreatedDateTime: Date;
    LastModifiedDateTime: Date;
}