import { Component, OnInit } from '@angular/core';
import { ValCustomerListService} from 'src/app/services/Validations/customerList.service';
import { ConfirmationService } from 'primeng/api';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';

@Component({
  selector: 'app-customer-tab',
  templateUrl: './customer-tab.component.html',
  styleUrls: ['./customer-tab.component.css']
})
export class CustomerTabComponent implements OnInit {
  header:any[];
  customers:any[];
  actionList:any[];
  rejectForm:FormGroup;
  
  constructor(private customerService:ValCustomerListService,private confirmationService:ConfirmationService,
    private formBuilder:FormBuilder) { }

  ngOnInit(): void {
    this.header=this.customerService.headers;
    this.customers=this.customerService.costumers;
    this.actionList=[10,20,30,40];
    this.actionList.splice(0,this.actionList.length);//peut-être supprimer
    this.rejectForm=this.formBuilder.group({
      content:['',Validators.requiredTrue]
    });
  }
  addToList(item:any){
    this.actionList.push(+item);
    console.log(this.actionList)
  }
  onSubmit(){
    console.log(this.rejectForm.get('content').value);
    this.rejectForm.reset();
    if(this.actionList.length>=1){
      console.log(this.actionList);
      for(let item of this.actionList){
        let i:number=this.customers.findIndex(e=> e.ID===item);
        if (i !== -1) {
          this.customers.splice(i,1);
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
  listValidation(){
    this.confirmationService.confirm({
      message: 'Are you sure that you want to validate these items?',
      accept: () => {
        if(this.actionList.length>=1){
          console.log(this.actionList);
          for(let item of this.actionList){
            let i:number=this.customers.findIndex(e=> e.ID===item);
            if (i !== -1) {
              this.customers.splice(i,1);
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
