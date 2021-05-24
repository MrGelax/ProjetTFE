import {Injectable} from "@angular/core";
import {HttpClient} from "@angular/common/http";
import {Observable} from "rxjs";
import {Event} from "../../Event/event.model";

@Injectable()
export class EventService {
    rootURL = "https://localhost:5001/api";
    constructor(private http: HttpClient) { }

    headers=["ID","System Name","Customer",];

    GetAllCastings(): Observable<Event[]>{
        return this.http.get<Event[]>(this.rootURL+'/Event');
    }
    GetAllCastingsValidation(): Observable<Event[]>{
        return this.http.get<Event[]>(this.rootURL+'/Event/Validation');
    }
    GetById(id:number){
        return this.http.get<Event>(this.rootURL+'/Event/'+id);
    }
    UpdateCasting(ev:Event,id:number): Observable<Event>{
        return this.http.put<Event>(this.rootURL+'/Event/'+id,ev);
    }
    deleteCasting(id:number){
        return this.http.delete<Event>(this.rootURL+'/Event/'+id);
    }
}