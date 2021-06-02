import {Injectable} from "@angular/core";
import {HttpClient} from "@angular/common/http";
import {Observable} from "rxjs";
import {Customer} from "../../Customers/customer.model";

@Injectable()
export class CustomerService {
    rootURL = "https://localhost:5001/api";
    constructor(private http: HttpClient) { }

    list:Observable<Customer[]>;
    headers=["ID","Name","Rôle","Email"];
    GetAllCustomers(): Observable<Customer>{
        return this.http.get<Customer>(this.rootURL+'/Customers');
    }
    GetAllCustomersValidation(): Observable<Customer[]>{
        return this.http.get<Customer[]>(this.rootURL+'/Customers/Validation');
    }
    GetById(id:number){
        return this.http.get<Customer>(this.rootURL+'/Customers/'+id);
    }
    UpdateCustomers(customer:Customer,id:number): Observable<Customer>{
        return this.http.put<Customer>(this.rootURL+'/Customers/'+id,customer);
    }
    deleteCustomers(id:number){
        return this.http.delete<Customer>(this.rootURL+'/Customers/'+id);
    }
}