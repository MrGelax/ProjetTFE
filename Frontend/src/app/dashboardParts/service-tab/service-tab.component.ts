import { Component, OnInit } from '@angular/core';
import { ConfirmationService } from 'primeng/api';
import { FormGroup, FormBuilder, Validators } from '@angular/forms';
import {CustomerServicesService} from "../../services/CustomerServices/customerServices.service";
import {CustomerService} from "../../Customers/customerService.model";

@Component({
  selector: 'app-service-tab',
  templateUrl: './service-tab.component.html',
  styleUrls: ['./service-tab.component.css']
})
export class ServiceTabComponent implements OnInit {
  header:any[];
  rowData:CustomerService[];
  actionList:any[];
  customerServ:CustomerService=new CustomerService();
  rejectForm:FormGroup;
  listLenght:number=0;

  constructor(private customerService:CustomerServicesService,private confirmationService:ConfirmationService
      ,private formBuilder:FormBuilder) { }

  ngOnInit(): void {
    this.actionList=[10,20,30,40];
    this.actionList.splice(0,this.actionList.length);//peut-être supprimer
    this.rejectForm=this.formBuilder.group({
      content:['',Validators.requiredTrue]
    });
    this.customerService.GetAllCustomerServicesValidation().subscribe(result => {
      this.header=this.customerService.headers;
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
      this.customerService.GetById(item).subscribe(result=>{
        this.customerServ=result;
      },error => {
        console.log(error);
      });
      console.log(this.actionList);
    }
  }

  listValidation(){
    this.confirmationService.confirm({
      message: 'Êtes vous sûr de vouloir valider ce(s) service(s)?',
      accept: () => {
        if(this.actionList.length>=1){
          console.log(this.actionList);
          for(let item of this.actionList){
            this.customerService.GetById(item).subscribe(result=>{
              this.customerServ=result;
              console.log(this.customerServ);
            },error => {
              console.log(error);
            });

            this.customerServ.statusId=2;
            this.customerService.UpdateCustomerServices(this.customerServ,item).subscribe(result=>{
              this.customerService.GetAllCustomerServicesValidation().subscribe(result=>{
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
        this.customerService.GetById(item).subscribe(result=>{
          this.customerServ=result;
          console.log(this.customerServ);
        },error => {
          console.log(error);
        });

        this.customerServ.statusId=3;
        this.customerService.UpdateCustomerServices(this.customerServ,item).subscribe(result=>{
          this.customerService.GetAllCustomerServicesValidation().subscribe(result=>{
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
// servicesList:any[];
// actionList:any[];
// rejectForm:FormGroup;
// constructor(private services:servicesService,private confirmationService:ConfirmationService,
//     private formBuilder:FormBuilder) { }
//
// ngOnInit(): void {
//   this.header=this.services.headers;
//   this.servicesList=this.services.ServicesList;
//   this.actionList=[10,20,30,40];
//   this.actionList.splice(0,this.actionList.length);//peut-être supprimer
//   this.rejectForm=this.formBuilder.group({
//     content:['',Validators.requiredTrue]
//   });
// }
// addToServicesList(item:any){
//   this.actionList.push(+item);
//   console.log(this.actionList)
// }
// onSubmit(){
//   console.log(this.rejectForm.get('content').value);
//   this.rejectForm.reset();
//   if(this.actionList.length>=1){
//     console.log(this.actionList);
//     for(let item of this.actionList){
//       let i:number=this.servicesList.findIndex(e=> e.ID===item);
//       if (i !== -1) {
//         this.servicesList.splice(i,1);
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
// servicesValidation(){
//   this.confirmationService.confirm({
//     message: 'Êtes vous sûr de vouloir valider ce service?',
//     accept: () => {
//       if(this.actionList.length>=1){
//         console.log(this.actionList);
//         for(let item of this.actionList){
//           let i:number=this.servicesList.findIndex(e=> e.ID===item);
//           if (i !== -1) {
//             this.servicesList.splice(i,1);
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