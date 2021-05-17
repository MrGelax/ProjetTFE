import { Component, OnInit } from '@angular/core';
import { OdersService } from 'src/app/services/Validations/ordersList.service';
import { ConfirmationService } from 'primeng/api';
import { FormGroup, FormBuilder, Validators } from '@angular/forms';

@Component({
  selector: 'app-orders-tab',
  templateUrl: './orders-tab.component.html',
  styleUrls: ['./orders-tab.component.css']
})
export class OrdersTabComponent implements OnInit {
  header:any[];
  orders:any[];
  actionList:any[];
  rejectForm:FormGroup;
  constructor(private ordersService:OdersService,private confirmationService:ConfirmationService,
    private formBuilder:FormBuilder) { }

  ngOnInit(): void {
    this.header=this.ordersService.headers;
    this.orders=this.ordersService.OrdersList;
    this.actionList=[10,20,30,40];
    this.actionList.splice(0,this.actionList.length);//peut-être supprimer
    this.rejectForm=this.formBuilder.group({
      content:['',Validators.requiredTrue]
    });
  }
  addToOrdersList(item:any){
    this.actionList.push(+item);
    console.log(this.actionList)
  }
  
  onSubmit(){
    console.log(this.rejectForm.get('content').value);
    this.rejectForm.reset();
    if(this.actionList.length>=1){
      console.log(this.actionList);
      for(let item of this.actionList){
        let i:number=this.orders.findIndex(e=> e.ID===item);
        if (i !== -1) {
          this.orders.splice(i,1);
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
  ordersListValidation(){
    this.confirmationService.confirm({
      message: 'Êtes-vous sûr de vouloirs valider cette commande?',
      accept: () => {
        if(this.actionList.length>=1){
          console.log(this.actionList);
          for(let item of this.actionList){
            let i:number=this.orders.findIndex(e=> e.ID===item);
            if (i !== -1) {
              this.orders.splice(i,1);
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
