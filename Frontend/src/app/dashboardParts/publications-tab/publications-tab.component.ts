import { Component, OnInit } from '@angular/core';
import { publicationservice } from 'src/app/services/Validations/publicationList.service';
import { ConfirmationService } from 'primeng/api';
import { FormGroup, FormBuilder, Validators } from '@angular/forms';
import {Event} from "../../Event/event.model";
import {EventService} from "../../services/Event/event.service";
import {Publication} from "../../Publication/publication.model";
import {PublicationService} from "../../services/Publication/publication.service";

@Component({
  selector: 'app-publications-tab',
  templateUrl: './publications-tab.component.html',
  styleUrls: ['./publications-tab.component.css']
})
export class PublicationsTabComponent implements OnInit {
  header:any[];
  rowData:Publication[];
  actionList:any[];
  publication:Publication=new Publication();
  rejectForm:FormGroup;
  listLenght:number=0;
  constructor(private publicationService:PublicationService,private confirmationService:ConfirmationService
      ,private formBuilder:FormBuilder) { }

  ngOnInit(): void {
    this.actionList=[10,20,30,40];
    this.actionList.splice(0,this.actionList.length);//peut-être supprimer
    this.rejectForm=this.formBuilder.group({
      content:['',Validators.requiredTrue]
    });
    this.publicationService.GetAllPublicationsValidation().subscribe(result => {
      this.header=this.publicationService.headers;
      this.rowData = result;
      this.listLenght=this.rowData.length;
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
      this.publicationService.GetById(item).subscribe(result=>{
        this.publication=result;
      },error => {
        console.log(error);
      });
      console.log(this.actionList);
    }
  }

  listValidation(){
    this.confirmationService.confirm({
      message: 'Êtes vous sûr de vouloir valider ce(s) publication(s)?',
      accept: () => {
        if(this.actionList.length>=1){
          console.log(this.actionList);
          for(let item of this.actionList){
            this.publicationService.GetById(item).subscribe(result=>{
              this.publication=result;
              console.log(this.publication);
            },error => {
              console.log(error);
            });

            this.publication.statusId=3;
            this.publicationService.UpdatePublication(this.publication,item).subscribe(result=>{
              this.publicationService.GetAllPublicationsValidation().subscribe(result=>{
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
        this.publicationService.GetById(item).subscribe(result=>{
          this.publication=result;
          console.log(this.publication);
        },error => {
          console.log(error);
        });

        this.publication.statusId=4;
        this.publicationService.UpdatePublication(this.publication,item).subscribe(result=>{
          this.publicationService.GetAllPublicationsValidation().subscribe(result=>{
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
// export class PublicationsTabComponent implements OnInit {
//   header:any[];
//   publicationList:any[];
//   actionList:any[];
//   rejectForm:FormGroup;
//   constructor(private publiService:publicationservice,private confirmationService:ConfirmationService,
//     private formBuilder:FormBuilder) {
//   }
//
//   ngOnInit(): void {
//     this.header=this.publiService.headers;
//     this.publicationList=this.publiService.Publications;
//     this.actionList=[10,20,30,40];
//     this.actionList.splice(0,this.actionList.length);//peut-être supprimer
//     this.rejectForm=this.formBuilder.group({
//       content:['',Validators.requiredTrue]
//     });
//   }
//   addToPublicationList(item:any){
//     this.actionList.push(+item);
//     console.log(this.actionList)
//   }
//   onSubmit(){
//     console.log(this.rejectForm.get('content').value);
//     this.rejectForm.reset();
//     if(this.actionList.length>=1){
//       console.log(this.actionList);
//       for(let item of this.actionList){
//         let i:number=this.publicationList.findIndex(e=> e.ID===item);
//         if (i !== -1) {
//           this.publicationList.splice(i,1);
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
//   publicationListValidation(){
//     this.confirmationService.confirm({
//       message: 'Êtes vous sûr de vouloir valider cette publication?',
//       accept: () => {
//         if(this.actionList.length>=1){
//           console.log(this.actionList);
//           for(let item of this.actionList){
//             let i:number=this.publicationList.findIndex(e=> e.ID===item);
//             if (i !== -1) {
//               this.publicationList.splice(i,1);
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
