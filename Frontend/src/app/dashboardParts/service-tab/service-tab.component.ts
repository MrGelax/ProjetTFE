import { Component, OnInit } from '@angular/core';
import { servicesService } from 'src/app/services/Validations/servicesList.service';
import { ConfirmationService } from 'primeng/api';
import { FormGroup, FormBuilder, Validators } from '@angular/forms';

@Component({
  selector: 'app-service-tab',
  templateUrl: './service-tab.component.html',
  styleUrls: ['./service-tab.component.css']
})
export class ServiceTabComponent implements OnInit {
  header:any[];
  servicesList:any[];
  actionList:any[];
  rejectForm:FormGroup;
  constructor(private services:servicesService,private confirmationService:ConfirmationService,
    private formBuilder:FormBuilder) { }

  ngOnInit(): void {
    this.header=this.services.headers;
    this.servicesList=this.services.ServicesList;
    this.actionList=[10,20,30,40];
    this.actionList.splice(0,this.actionList.length);//peut-être supprimer
    this.rejectForm=this.formBuilder.group({
      content:['',Validators.requiredTrue]
    });
  }
  addToServicesList(item:any){
    this.actionList.push(+item);
    console.log(this.actionList)
  }
  onSubmit(){
    console.log(this.rejectForm.get('content').value);
    this.rejectForm.reset();
    if(this.actionList.length>=1){
      console.log(this.actionList);
      for(let item of this.actionList){
        let i:number=this.servicesList.findIndex(e=> e.ID===item);
        if (i !== -1) {
          this.servicesList.splice(i,1);
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
  servicesValidation(){
    this.confirmationService.confirm({
      message: 'Are you sure that you want to reject Customers?',
      accept: () => {
        if(this.actionList.length>=1){
          console.log(this.actionList);
          for(let item of this.actionList){
            let i:number=this.servicesList.findIndex(e=> e.ID===item);
            if (i !== -1) {
              this.servicesList.splice(i,1);
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
