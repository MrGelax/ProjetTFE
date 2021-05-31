import { Injectable } from '@angular/core';
import {HttpClient} from "@angular/common/http";
import {Observable} from "rxjs";
import {PagesModel} from "../../Pages/pages.model";
import {Page} from "../../Pages/page.model";
import {PageLocal} from "../../Pages/pageLocal.model";
import {Block} from "../../Blocks/block.model";
import {BlockLocal} from "../../Blocks/blockLocal.modal";

@Injectable()
export class PagesService {
    rootURL = "https://localhost:5001/api";
    constructor(private http: HttpClient) { }

    headers=["ID","System Name","Label","URL","Is Protected"];


    GetAllPages(): Observable<PagesModel>{
        console.log("Page List");
        return this.http.get<PagesModel>(this.rootURL+'/Page');
    }
    CreatePage(p:Page){
        return this.http.post<Page>(this.rootURL+'/Page',p);
    }
    CreatePageLocal(p:PageLocal){
        return this.http.post<PageLocal>(this.rootURL+'/PageLocal',p);
    }
    GetById(id:number){
        return this.http.get<Page>(this.rootURL+'/Page/'+id);
    }
    GetByPageId(id:number){
        return this.http.get<PageLocal[]>(this.rootURL+'/PageLocal/Page/'+id);
    }
    UpdatePage(p:Page,id:number): Observable<Page>{
        return this.http.put<Page>(this.rootURL+'/Page/'+id,p);
    }
    UpdatePageLocal(plc:PageLocal,id:number): Observable<PageLocal>{
        return this.http.put<PageLocal>(this.rootURL+'/PageLocal/'+id,plc);
    }
    deletePage(id:number){
        return this.http.delete<Page>(this.rootURL+'/Page/'+id);
    }

}