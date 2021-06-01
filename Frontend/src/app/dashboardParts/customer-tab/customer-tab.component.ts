import { Component, OnInit } from '@angular/core';
import { ConfirmationService } from 'primeng/api';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import {Customer} from "../../Customers/customer.model";
import {CustomerService} from "../../services/Customers/customer.service";

@Component({
  selector: 'app-customer-tab',
  templateUrl: './customer-tab.component.html',
  styleUrls: ['./customer-tab.component.css']
})
export class CustomerTabComponent implements OnInit {
  // header:any[];
  // customers:any[];
  // actionList:any[];
  // rejectForm:FormGroup;
  //
  // constructor(private customerService:ValCustomerListService,private confirmationService:ConfirmationService,
  //   private formBuilder:FormBuilder) { }
  //
  // ngOnInit(): void {
  //   this.header=this.customerService.headers;
  //   this.customers=this.customerService.costumers;
  //   this.actionList=[10,20,30,40];
  //   this.actionList.splice(0,this.actionList.length);//peut-être supprimer
  //   this.rejectForm=this.formBuilder.group({
  //     content:['',Validators.requiredTrue]
  //   });
  // }

  header:any[];
  rowData:Customer[];
  actionList:any[];
  rejectForm:FormGroup;
  customer:Customer=new Customer();

  constructor(private customerService:CustomerService,private confirmationService:ConfirmationService,
              private formBuilder:FormBuilder) { }

  ngOnInit(): void {
    this.actionList=[10,20,30,40];
    this.actionList.splice(0,this.actionList.length);//peut-être supprimer
    this.rejectForm=this.formBuilder.group({
      content:['',Validators.requiredTrue]
    });
    this.customerService.GetAllCustomersValidation().subscribe(result => {
      this.header=this.customerService.headers;
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
    this.customerService.GetById(item).subscribe(result=>{
      this.customer=result;
    },error => {
      console.log(error);
    });
    console.log(this.actionList);
    }
  }

  listValidation(){
    this.confirmationService.confirm({
      message: 'Êtes vous sûr de vouloir valider ce client?',
      accept: () => {
        if(this.actionList.length>=1){
          console.log(this.actionList);
          for(let item of this.actionList){
            this.customerService.GetById(item).subscribe(result=>{
              this.customer=result;
              console.log(this.customer);
            },error => {
              console.log(error);
            });

            this.customer.customerStatus=5;
            this.customerService.UpdateCustomers(this.customer,item).subscribe(result=>{
              this.customerService.GetAllCustomersValidation().subscribe(result=>{
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
          this.customer=result;
          console.log(this.customer);
        },error => {
          console.log(error);
        });

        this.customer.customerStatus=4;
        this.customerService.UpdateCustomers(this.customer,item).subscribe(result=>{
          this.customerService.GetAllCustomersValidation().subscribe(result=>{
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
  // onSubmit(){
  //   console.log(this.rejectForm.get('content').value);
  //   this.rejectForm.reset();
  //   this.customerService.GetById(this.customerReject).subscribe(result=>{
  //     this.customer=result;
  //     console.log(this.customer);
  //   },error => {
  //     console.log(error);
  //   });
  //   this.customer.customerStatus=4;
  //   this.customerService.UpdateCustomers(this.customer,this.customer.id).subscribe(result=>{
  //     this.customerService.GetAllCustomersValidation().subscribe(result=>{
  //       this.rowData=result;
  //     },error => {
  //       console.log(error);
  //     });
  //   },error => {
  //     console.log(error);
  //   });
  //   this.customerReject=null;
  // }
  // close(){
  //   this.rejectForm.reset();
  // }
}
