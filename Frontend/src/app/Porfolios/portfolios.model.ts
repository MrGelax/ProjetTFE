import {Customer} from "../Customers/customer.model";
import {MediaType} from "../Publication/publication.model";
export class Portfolios {
    id: number;
    title:string;
    description:string;
    customerId:number;
    customer:Customer;
    statusId:number;
    orderId:number;
    manageComment:string;
    portfoliosItems:PortfoliosItem[];
    //portfoliosStatus:Portfoliostatus;
}
export class Portfoliostatus {
    id: number;
    systemName: string;
    CreatedDateTime: Date;
    LastModifiedDateTime: Date;
}
export class PortfoliosItem {
    id: number;
    portfoliosId: number;
    description:string
    mediaTypeId:number;
    CreatedDateTime: Date;
    LastModifiedDateTime: Date;
    mediaValue:string;
    mediaType:MediaType;
}