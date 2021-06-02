import { Component, OnInit } from '@angular/core';
import { portfoliosService } from 'src/app/services/Validations/portfoliosList.service';
import { ConfirmationService } from 'primeng/api';
import { FormGroup, FormBuilder, Validators } from '@angular/forms';
import {Publication} from "../../Publication/publication.model";
import {PublicationService} from "../../services/Publication/publication.service";
import {Portfolios} from "../../Porfolios/portfolios.model";
import {PortfoliosService} from "../../services/Portfolios/portfolios.service";

@Component({
  selector: 'app-portfolios-tab',
  templateUrl: './portfolios-tab.component.html',
  styleUrls: ['./portfolios-tab.component.css']
})
export class PortfoliosTabComponent implements OnInit {
  header:any[];
  rowData:Portfolios[];
  actionList:any[];
  portfolios:Portfolios=new Portfolios();
  rejectForm:FormGroup;
  listlenght:number=0;

  constructor(private portfoliosService:PortfoliosService,private confirmationService:ConfirmationService
      ,private formBuilder:FormBuilder) { }

  ngOnInit(): void {
    this.actionList=[10,20,30,40];
    this.actionList.splice(0,this.actionList.length);//peut-être supprimer
    this.rejectForm=this.formBuilder.group({
      content:['',Validators.requiredTrue]
    });
    this.portfoliosService.GetAllPortfoliosValidation().subscribe(result => {
      this.header=this.portfoliosService.headers;
      this.rowData = result;
      this.listlenght=this.rowData.length;
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
      this.portfoliosService.GetById(item).subscribe(result=>{
        this.portfolios=result;
      },error => {
        console.log(error);
      });
      console.log(this.actionList);
    }
  }

  listValidation(){
    this.confirmationService.confirm({
      message: 'Êtes vous sûr de vouloir valider ce(s) portfolio(s)?',
      accept: () => {
        if(this.actionList.length>=1){
          console.log(this.actionList);
          for(let item of this.actionList){
            this.portfoliosService.GetById(item).subscribe(result=>{
              this.portfolios=result;
              console.log(this.portfolios);
            },error => {
              console.log(error);
            });

            this.portfolios.statusId=2;
            this.portfoliosService.UpdatePortfolios(this.portfolios,item).subscribe(result=>{
              this.portfoliosService.GetAllPortfoliosValidation().subscribe(result=>{
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
        this.portfoliosService.GetById(item).subscribe(result=>{
          this.portfolios=result;
          console.log(this.portfolios);
        },error => {
          console.log(error);
        });

        this.portfolios.statusId=3;
        this.portfoliosService.UpdatePortfolios(this.portfolios,item).subscribe(result=>{
          this.portfoliosService.GetAllPortfoliosValidation().subscribe(result=>{
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
// header:any[];
// portfoliosList:any[]
// actionList:any[];
// rejectForm:FormGroup;
// constructor(private portfoService:portfoliosService,private confirmationService:ConfirmationService,
//     private formBuilder:FormBuilder) { }
//
// ngOnInit(): void {
//   this.header=this.portfoService.headers;
//   this.portfoliosList=this.portfoService.PortfoliosList;
//   this.actionList=[10,20,30,40];
//   this.actionList.splice(0,this.actionList.length);//peut-être supprimer
//   this.rejectForm=this.formBuilder.group({
//     content:['',Validators.requiredTrue]
//   });
// }
// addToPortfoliosList(item:any){
//   this.actionList.push(+item);
//   console.log(this.actionList)
// }
//
// onSubmit(){
//   console.log(this.rejectForm.get('content').value);
//   this.rejectForm.reset();
//   if(this.actionList.length>=1){
//     console.log(this.actionList);
//     for(let item of this.actionList){
//       let i:number=this.portfoliosList.findIndex(e=> e.ID===item);
//       if (i !== -1) {
//         this.portfoliosList.splice(i,1);
//       }
//       console.log(item);
//     }
//     console.log("Validation OK");
//     this.actionList.splice(0,this.actionList.length);
//   }
// }
// close(){
//   this.rejectForm.reset();
// }
// portfoliosListValidation(){
//   this.confirmationService.confirm({
//     message: 'Êtes vous sûr de vouloir valider ce Portfolios?',
//     accept: () => {
//       if(this.actionList.length>=1){
//         console.log(this.actionList);
//         for(let item of this.actionList){
//           let i:number=this.portfoliosList.findIndex(e=> e.ID===item);
//           if (i !== -1) {
//             this.portfoliosList.splice(i,1);
//           }
//           console.log(item);
//         }
//         console.log("Rejet OK");
//         this.actionList.splice(0,this.actionList.length);
//       }
//     },reject:()=>{
//       console.log("Rejet PAS OK");
//     }
//   });
// }