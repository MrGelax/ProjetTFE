import { Component, OnInit } from '@angular/core';
import { ConfirmationService } from 'primeng/api';
import {EventService} from "../../services/Event/event.service";
import {FormBuilder,FormGroup, Validators} from "@angular/forms";
import {Event} from "../../Event/event.model";

@Component({
  selector: 'app-casting-tab',
  templateUrl: './casting-tab.component.html',
  styleUrls: ['./casting-tab.component.css']
})
export class CastingTabComponent implements OnInit {
  header:any[];
  rowData:Event[];
  actionList:any[];
  casting:Event=new Event();
  rejectForm:FormGroup;
  constructor(private eventService:EventService,private confirmationService:ConfirmationService
  ,private formBuilder:FormBuilder) { }

  ngOnInit(): void {
    this.actionList=[10,20,30,40];
    this.actionList.splice(0,this.actionList.length);//peut-être supprimer
    this.rejectForm=this.formBuilder.group({
      content:['',Validators.requiredTrue]
    });
    this.eventService.GetAllCastingsValidation().subscribe(result => {
      this.header=this.eventService.headers;
      this.rowData = result;
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
      this.eventService.GetById(item).subscribe(result=>{
        this.casting=result;
      },error => {
        console.log(error);
      });
      console.log(this.actionList);
    }
  }

  listValidation(){
    this.confirmationService.confirm({
      message: 'Êtes vous sûr de vouloir valider ce(s) casting(s)?',
      accept: () => {
        if(this.actionList.length>=1){
          console.log(this.actionList);
          for(let item of this.actionList){
            this.eventService.GetById(item).subscribe(result=>{
              this.casting=result;
              console.log(this.casting);
            },error => {
              console.log(error);
            });

            this.casting.eventStatusId=3;
            this.eventService.UpdateCasting(this.casting,item).subscribe(result=>{
              this.eventService.GetAllCastingsValidation().subscribe(result=>{
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
        this.eventService.GetById(item).subscribe(result=>{
          this.casting=result;
          console.log(this.casting);
        },error => {
          console.log(error);
        });

        this.casting.eventStatusId=5;
        this.eventService.UpdateCasting(this.casting,item).subscribe(result=>{
          this.eventService.GetAllCastingsValidation().subscribe(result=>{
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
