import { Injectable } from '@angular/core';
import {HttpClient} from "@angular/common/http";
import {Observable} from "rxjs";
import {PagesModel} from "../../Pages/pages.model";
import {Page} from "../../Pages/page.model";
import {PageLocal} from "../../Pages/pageLocal.model";

@Injectable()
export class PagesService {
    rootURL = "https://localhost:5001/api";
    constructor(private http: HttpClient) { }

    headers=["ID","System Name","Label","URL","Is Protected"];


    GetAllPages(): Observable<PagesModel>{
        return this.http.get<PagesModel>(this.rootURL+'/Pages');
    }
    CreatePage(p:Page){
        return this.http.post<Page>(this.rootURL+'/Pages',p);
    }
    CreatePageLocal(p:PageLocal){
        return this.http.post<PageLocal>(this.rootURL+'/PagesLocal',p);
    }
    GetById(id:number){
        return this.http.get<Page>(this.rootURL+'/Pages/'+id);
    }
}