import { Component, OnInit } from '@angular/core';
import { OrderListService } from 'src/app/services/Orders/list.service';
import { FormGroup, FormBuilder, Validators } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';

@Component({
  selector: 'app-orders-edit',
  templateUrl: './orders-edit.component.html',
  styleUrls: ['./orders-edit.component.css']
})
export class OrdersEditComponent implements OnInit {

  obj:any;
  form:FormGroup;

  status:any[];
  eitCulture:any[];
  payeType:any[];
  prodType:any[];

  constructor(private listTab:OrderListService,
    private route:ActivatedRoute,private router:Router,private formBuilder:FormBuilder) { }

  ngOnInit(): void {
    
    const id=this.route.snapshot.params['id'];
    this.obj=this.listTab.getOrdersByID(+id);
    this.status=this.listTab.statusList;
    this.form=this.formBuilder.group({
      bill:[this.obj.Status,Validators.required],
      orderStatus:[this.obj.EitCultureId.id,Validators.required],
      PaidOn:[this.obj.DisplayOrder,Validators.required],
      PaiementMethod:[this.obj.IsFavorite,Validators.required],
      PromoCodeUsed:[this.obj.Description,Validators.required]
    });
    console.log(this.obj);
    console.log(this.obj.Title);
  }


  onSubmit(){

  }

}
