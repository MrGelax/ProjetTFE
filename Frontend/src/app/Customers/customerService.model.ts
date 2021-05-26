import {Customer,City} from "./customer.model";

export class CustomerService {
    id: number;
    customerId:number;
    serviceTypeId:number
    cityId:number;
    title:string;
    description:string;
    priceunit:number;
    startDate:Date;
    endDate:Date;
    createdDateTime:Date;
    lastModifiedDateTime:Date;
    manageComment:string;
    statusId:number;
    customer:Customer;
    serviceType:ServiceType;
    city:City;
}
export class CustomerServiceStatus {
    id: number;
    systemName:string;
    createdDateTime:Date;
    lastModifiedDateTime:Date;
}
export class ServiceType {
    id: number;
    systemName:string;
    createdDateTime:Date;
    lastModifiedDateTime:Date;
}


