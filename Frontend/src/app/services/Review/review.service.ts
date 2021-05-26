import {Injectable} from "@angular/core";
import {HttpClient} from "@angular/common/http";
import {Observable} from "rxjs";
import {Review} from "../../Review/review.model";

@Injectable()
export class ReviewService {
    rootURL = "https://localhost:5001/api";
    constructor(private http: HttpClient) { }

    headers=["ID","Title","Sender's Name",'Recipient\'s Name','Rating','Message'];

    GetAllReviews(): Observable<Review[]>{
        return this.http.get<Review[]>(this.rootURL+'/Review');
    }
    GetAllReviewsValidation(): Observable<Review[]>{
        return this.http.get<Review[]>(this.rootURL+'/Review/Validation');
    }
    GetById(id:number){
        return this.http.get<Review>(this.rootURL+'/Review/'+id);
    }
    UpdateReview(review:Review,id:number): Observable<Review>{
        return this.http.put<Review>(this.rootURL+'/Review/'+id,review);
    }
    deleteReview(id:number){
        return this.http.delete<Review>(this.rootURL+'/Review/'+id);
    }
}