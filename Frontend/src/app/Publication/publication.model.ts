import {Customer} from "../Customers/customer.model";
export class Publication {
    id: number;
    systemName:string;
    description:string;
    customerId:number;
    publicationName:string;
    mediaTypeId:number;
    mediaValue:string;
    createdDateTime: Date;
    lastModifiedDateTime: Date;
    publicationDate: Date;
    manageComment:string;
    statusId:number;

    customer:Customer;
    mediaType:MediaType;
}
export class MediaType {
    Id: number;
    systemName: string;
    CreatedDateTime: Date;
    LastModifiedDateTime: Date;
}
export class PublicationStatus {
    Id: number;
    systemName: string;
    CreatedDateTime: Date;
    LastModifiedDateTime: Date;
}