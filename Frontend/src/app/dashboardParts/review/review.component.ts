import { Component, OnInit } from '@angular/core';
import { reviewService } from 'src/app/services/Validations/review.service';
import { ConfirmationService } from 'primeng/api';
import { FormGroup, FormBuilder, Validators } from '@angular/forms';

@Component({
  selector: 'app-review',
  templateUrl: './review.component.html',
  styleUrls: ['./review.component.css']
})
export class ReviewComponent implements OnInit {
  header:any[];
  reviewList:any[];
  actionList:any[];
  rejectForm:FormGroup;
  constructor(private reviews:reviewService,private confirmationService:ConfirmationService,
    private formBuilder:FormBuilder) { }

  ngOnInit(): void {
    this.header=this.reviews.headers;
    this.reviewList=this.reviews.Reviews;
    this.actionList=[10,20,30,40];
    this.actionList.splice(0,this.actionList.length);//peut-être supprimer
    this.rejectForm=this.formBuilder.group({
      content:['',Validators.requiredTrue]
    });
  }
  addToReviewList(item:any){
    this.actionList.push(+item);
    console.log(this.actionList)
  }
  onSubmit(){
    console.log(this.rejectForm.get('content').value);
    this.rejectForm.reset();
    if(this.actionList.length>=1){
      console.log(this.actionList);
      for(let item of this.actionList){
        let i:number=this.reviewList.findIndex(e=> e.ID===item);
        if (i !== -1) {
          this.reviewList.splice(i,1);
        }
        console.log(item);
      }
      console.log("Validation OK");
      this.actionList.splice(0,this.actionList.length);
    }
  }
  close(){
    this.rejectForm.reset();
  }
  reviewListValidation(){
    this.confirmationService.confirm({
      message: 'Êtes vous sûr de vouloir valider cette review?',
      accept: () => {
        if(this.actionList.length>=1){
          console.log(this.actionList);
          for(let item of this.actionList){
            let i:number=this.reviewList.findIndex(e=> e.ID===item);
            if (i !== -1) {
              this.reviewList.splice(i,1);
            }
            console.log(item);
          }
          console.log("Rejet OK");
          this.actionList.splice(0,this.actionList.length);
        }
      },reject:()=>{
        console.log("Rejet PAS OK");
      }
    });
  }
}
