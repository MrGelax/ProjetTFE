import {Injectable} from "@angular/core";
import {HttpClient} from "@angular/common/http";
import {Observable} from "rxjs";
import {Publication} from "../../Publication/publication.model";

@Injectable()
export class PublicationService {
    rootURL = "https://localhost:5001/api";
    constructor(private http: HttpClient) { }

    headers=["ID","System Name","Customer Name",'Title','Description'];

    GetAllPublications(): Observable<Publication[]>{
        return this.http.get<Publication[]>(this.rootURL+'/Publication');
    }
    GetAllPublicationsValidation(): Observable<Publication[]>{
        return this.http.get<Publication[]>(this.rootURL+'/Publication/Validation');
    }
    GetById(id:number){
        return this.http.get<Publication>(this.rootURL+'/Publication/'+id);
    }
    UpdatePublication(ev:Publication,id:number): Observable<Publication>{
        return this.http.put<Publication>(this.rootURL+'/Publication/'+id,ev);
    }
    deletePublication(id:number){
        return this.http.delete<Publication>(this.rootURL+'/Publication/'+id);
    }
}