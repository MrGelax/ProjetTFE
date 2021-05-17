import { Component, OnInit } from '@angular/core';
import { CastingsService } from 'src/app/services/Validations/castingList.service';
import { ConfirmationService } from 'primeng/api';

@Component({
  selector: 'app-casting-tab',
  templateUrl: './casting-tab.component.html',
  styleUrls: ['./casting-tab.component.css']
})
export class CastingTabComponent implements OnInit {
  header:any[];
  castings:any[];
  actionList:any[];
  constructor(private castingsService:CastingsService,private confirmationService:ConfirmationService) { }

  ngOnInit(): void {
    this.header=this.castingsService.headers;
    this.castings=this.castingsService.CastingList;
    this.actionList=[10,20,30,40];
    this.actionList.splice(0,this.actionList.length);//peut-être supprimer
  }
  addToCastingList(item:any){
    console.log(item);
    this.actionList.push(+item);
    console.log(this.actionList)
  }
  castingListRejected(){
    this.confirmationService.confirm({
      message: 'Are you sure that you want to validate custumers?',
      accept: () => {
        if(this.actionList.length>=1){
          console.log(this.actionList);
          for(let item of this.actionList){
            let i:number=this.castings.findIndex(e=> e.ID===item);
            if (i !== -1) {
              this.castings.splice(i,1);
            }
            console.log(item);
          }
          console.log("Validation OK");
          this.actionList.splice(0,this.actionList.length);
        }
      },reject:()=>{
        console.log("Validation PAS OK");
      }
    });
  }
  castingListValidation(){
    this.confirmationService.confirm({
      message: 'Are you sure that you want to reject Customers?',
      accept: () => {
        if(this.actionList.length>=1){
          console.log(this.actionList);
          for(let item of this.actionList){
            let i:number=this.castings.findIndex(e=> e.ID===item);
            if (i !== -1) {
              this.castings.splice(i,1);
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
