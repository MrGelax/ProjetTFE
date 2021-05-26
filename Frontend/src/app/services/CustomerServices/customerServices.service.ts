
import {Injectable} from "@angular/core";
import {HttpClient} from "@angular/common/http";
import {Observable} from "rxjs";
import {Event} from "../../Event/event.model";
import {Portfolios} from "../../Porfolios/portfolios.model";
import {CustomerService} from "../../Customers/customerService.model";

@Injectable()
export class CustomerServicesService {
    rootURL = "https://localhost:5001/api";
    constructor(private http: HttpClient) { }

    headers=["ID","Customer Name","Customer Rôle",'Title','Description','Start Date','End Date'];

    GetAllCustomerServices(): Observable<CustomerService[]>{
        return this.http.get<CustomerService[]>(this.rootURL+'/CustomerService');
    }
    GetAllCustomerServicesValidation(): Observable<CustomerService[]>{
        return this.http.get<CustomerService[]>(this.rootURL+'/CustomerService/Validation');
    }
    GetById(id:number){
        return this.http.get<CustomerService>(this.rootURL+'/CustomerService/'+id);
    }
    UpdateCustomerServices(service:CustomerService,id:number): Observable<CustomerService>{
        return this.http.put<CustomerService>(this.rootURL+'/CustomerService/'+id,service);
    }
    deleteCustomerServices(id:number){
        return this.http.delete<CustomerService>(this.rootURL+'/CustomerService/'+id);
    }
}