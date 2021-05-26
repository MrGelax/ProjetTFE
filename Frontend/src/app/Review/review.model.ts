import {Customer} from "../Customers/customer.model";
export class Review {
    id: number;
    title:string;
    senderCustomerId:string;
    recipientCustomerId:number;
    createdDateTime: Date;
    lastModdifiedDateTime: Date;
    rating:string;
    comment:string;
    reviewStatusId:number;

    senderCustomer:Customer;
    recipientCustomer:Customer;
    reviewStatus:ReviewStatus;
}
export class ReviewStatus {
    Id: number;
    systemName: string;
    CreatedDateTime: Date;
    LastModdifiedDateTime: Date;
}