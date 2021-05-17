import { Component, OnInit } from '@angular/core';
import { FormGroup, FormBuilder, Validators } from '@angular/forms';
import { CreateService } from 'src/app/services/Pages/create.service';
import { OrderListService } from 'src/app/services/Orders/list.service';
import { ProductsListService } from 'src/app/services/Products/list.service';

@Component({
  selector: 'app-product-create',
  templateUrl: './product-create.component.html',
  styleUrls: ['./product-create.component.css']
})
export class ProductCreateComponent implements OnInit {

  status:any[];
  eitCulture:any[];
  payeType:any[];
  prodType:any[];

  form:FormGroup;
  date1:any;
  constructor(private listTab:ProductsListService,private formBuilder:FormBuilder) { }

  ngOnInit(): void {
    this.status=this.listTab.create_statusList;
    this.eitCulture=this.listTab.create_eitcultureList;
    this.payeType=this.listTab.payType;
    this.prodType=this.listTab.prodType;

    this.form=this.formBuilder.group({
      status:['',Validators.required],
      eitCultureId:['',Validators.required],
      title:['',Validators.required],
      displayOrder:[0,Validators.required],
      favorite:[false,Validators.required],
      descri:['',Validators.required],
      payeType:['',Validators.required],
      prodType:['',Validators.required],
      minqt:[0,Validators.required],
      price:[0.00,Validators.required],
      setupFee:['',Validators.required],
      numCredit:['',Validators.required],
      numPictures:['',Validators.required],
      numBooks:['',Validators.required],
      numImage:['',Validators.required]
    });
  }
  onSubmit(){
    console.log('Données du formulaire',this.form.value);
    this.date1=this.form.get("date").value;
    console.log("0"+this.date1.getDate()+"/0"+(this.date1.getMonth()+1)+"/"+this.date1.getFullYear()); 
  }
}
