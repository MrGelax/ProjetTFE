import {City, Customer} from "../../Customers/customer.model";

import {Injectable} from "@angular/core";
import {HttpClient} from "@angular/common/http";
import {Observable} from "rxjs";
import {Event} from "../../Event/event.model";
import {Portfolios} from "../../Porfolios/portfolios.model";

@Injectable()
export class PortfoliosService {
    rootURL = "https://localhost:5001/api";
    constructor(private http: HttpClient) { }

    headers=["ID","Customer Name","Customer Rôle",'Title','Number of Items','Preview'];

    GetAllPortfolios(): Observable<Portfolios[]>{
        return this.http.get<Portfolios[]>(this.rootURL+'/Portfolios');
    }
    GetAllPortfoliosValidation(): Observable<Portfolios[]>{
        return this.http.get<Portfolios[]>(this.rootURL+'/Portfolios/Validation');
    }
    GetById(id:number){
        return this.http.get<Portfolios>(this.rootURL+'/Portfolios/'+id);
    }
    UpdatePortfolios(portfolios:Portfolios,id:number): Observable<Portfolios>{
        return this.http.put<Portfolios>(this.rootURL+'/Portfolios/'+id,portfolios);
    }
    deletePortfolios(id:number){
        return this.http.delete<Portfolios>(this.rootURL+'/Portfolios/'+id);
    }
}