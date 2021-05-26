import { Component, OnInit } from '@angular/core';
import { reviewService } from 'src/app/services/Validations/review.service';
import { ConfirmationService } from 'primeng/api';
import { FormGroup, FormBuilder, Validators } from '@angular/forms';
import {Publication} from "../../Publication/publication.model";
import {PublicationService} from "../../services/Publication/publication.service";
import {ReviewService} from "../../services/Review/review.service";
import {Review} from "../../Review/review.model";

@Component({
  selector: 'app-review',
  templateUrl: './review.component.html',
  styleUrls: ['./review.component.css']
})

export class ReviewComponent implements OnInit {
  header:any[];
  rowData:Review[];
  actionList:any[];
  review:Review=new Review();
  rejectForm:FormGroup;

  constructor(private reviewService:ReviewService,private confirmationService:ConfirmationService
      ,private formBuilder:FormBuilder) { }

  ngOnInit(): void {
    this.actionList=[10,20,30,40];
    this.actionList.splice(0,this.actionList.length);//peut-être supprimer
    this.rejectForm=this.formBuilder.group({
      content:['',Validators.requiredTrue]
    });
    this.reviewService.GetAllReviewsValidation().subscribe(result => {
      this.header=this.reviewService.headers;
      this.rowData = result;
      console.log(this.rowData);
    }, error => {
      console.log(error);
    });
  }

  addToList(item:any){
    if(this.actionList.find(x=> x===item)){
      console.log('item Déà présent');
      this.actionList.forEach((element,index)=>{
        if(element==item)
          this.actionList.splice(index,1);
      });
    }else {
      this.actionList.push(+item);
      this.reviewService.GetById(item).subscribe(result=>{
        this.review=result;
      },error => {
        console.log(error);
      });
      console.log(this.actionList);
      console.log(this.review);
    }
  }

  listValidation(){
    this.confirmationService.confirm({
      message: 'Êtes vous sûr de vouloir valider ce(s) review(s)?',
      accept: () => {
        if(this.actionList.length>=1){
          console.log(this.actionList);
          for(let item of this.actionList){
            this.reviewService.GetById(item).subscribe(result=>{
              this.review=result;
              console.log(this.review);
            },error => {
              console.log(error);
            });

            this.review.reviewStatusId=3;
            this.reviewService.UpdateReview(this.review,item).subscribe(result=>{
              this.reviewService.GetAllReviewsValidation().subscribe(result=>{
                this.rowData=result;
              },error => {
                console.log(error);
              });
            },error => {
              console.log(error);
            });
          }
          console.log("Validation OK");
          this.actionList.splice(0,this.actionList.length);
        }
      },reject:()=>{
        console.log("Validation PAS OK");
      }
    });
  }

  onSubmit(){
    console.log(this.rejectForm.get('content').value);
    this.rejectForm.reset();
    if(this.actionList.length>=1){
      console.log(this.actionList);
      for(let item of this.actionList){
        this.reviewService.GetById(item).subscribe(result=>{
          this.review=result;
          console.log(this.review);
        },error => {
          console.log(error);
        });

        this.review.reviewStatusId=4;
        this.reviewService.UpdateReview(this.review,item).subscribe(result=>{
          this.reviewService.GetAllReviewsValidation().subscribe(result=>{
            this.rowData=result;
          },error => {
            console.log(error);
          });
        },error => {
          console.log(error);
        });
      }
      console.log("Reject OK");
      this.actionList.splice(0,this.actionList.length);
    }
  }
  close(){
    this.rejectForm.reset();
  }
}
// export class ReviewComponent implements OnInit {
//   header:any[];
//   reviewList:any[];
//   actionList:any[];
//   rejectForm:FormGroup;
//   constructor(private reviews:reviewService,private confirmationService:ConfirmationService,
//     private formBuilder:FormBuilder) { }
//
//   ngOnInit(): void {
//     this.header=this.reviews.headers;
//     this.reviewList=this.reviews.Reviews;
//     this.actionList=[10,20,30,40];
//     this.actionList.splice(0,this.actionList.length);//peut-être supprimer
//     this.rejectForm=this.formBuilder.group({
//       content:['',Validators.requiredTrue]
//     });
//   }
//   addToReviewList(item:any){
//     this.actionList.push(+item);
//     console.log(this.actionList)
//   }
//   onSubmit(){
//     console.log(this.rejectForm.get('content').value);
//     this.rejectForm.reset();
//     if(this.actionList.length>=1){
//       console.log(this.actionList);
//       for(let item of this.actionList){
//         let i:number=this.reviewList.findIndex(e=> e.ID===item);
//         if (i !== -1) {
//           this.reviewList.splice(i,1);
//         }
//         console.log(item);
//       }
//       console.log("Validation OK");
//       this.actionList.splice(0,this.actionList.length);
//     }
//   }
//   close(){
//     this.rejectForm.reset();
//   }
//   reviewListValidation(){
//     this.confirmationService.confirm({
//       message: 'Êtes vous sûr de vouloir valider cette review?',
//       accept: () => {
//         if(this.actionList.length>=1){
//           console.log(this.actionList);
//           for(let item of this.actionList){
//             let i:number=this.reviewList.findIndex(e=> e.ID===item);
//             if (i !== -1) {
//               this.reviewList.splice(i,1);
//             }
//             console.log(item);
//           }
//           console.log("Rejet OK");
//           this.actionList.splice(0,this.actionList.length);
//         }
//       },reject:()=>{
//         console.log("Rejet PAS OK");
//       }
//     });
//   }
// }
