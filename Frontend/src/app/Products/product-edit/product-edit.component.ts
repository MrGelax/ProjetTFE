import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { ProductsListService } from 'src/app/services/Products/list.service';

@Component({
  selector: 'app-product-edit',
  templateUrl: './product-edit.component.html',
  styleUrls: ['./product-edit.component.css']
})
export class ProductEditComponent implements OnInit {

  obj:any;
  form:FormGroup;

  status:any[];
  eitCulture:any[];
  payeType:any[];
  prodType:any[];

  constructor(private listTab:ProductsListService,
    private route:ActivatedRoute,private router:Router,private formBuilder:FormBuilder) { }

  ngOnInit(): void {
    
    const id=this.route.snapshot.params['id'];
    this.obj=this.listTab.getProducsByID(+id);
    
    this.status=this.listTab.create_statusList;
    this.eitCulture=this.listTab.create_eitcultureList;
    this.payeType=this.listTab.payType;
    this.prodType=this.listTab.prodType;

    this.form=this.formBuilder.group({
      status:[this.obj.Status,Validators.required],
      eitCultureId:[this.obj.EitCultureId.id,Validators.required],
      title:[this.obj.Title,Validators.required],
      displayOrder:[this.obj.DisplayOrder,Validators.required],
      favorite:[this.obj.IsFavorite,Validators.required],
      descri:[this.obj.Description,Validators.required],
      payeType:[this.obj.PayementType,Validators.required],
      prodType:[this.obj.ProductType,Validators.required],
      minqt:[this.obj.minQt,Validators.required],
      price:[this.obj.Price,Validators.required],
      setupFee:[this.obj.Setupfee,Validators.required],
      numCredit:[this.obj.Numcredit,Validators.required],
      numPictures:['',Validators.required],
      numBooks:['',Validators.required],
      numImage:['',Validators.required]
    });
    console.log(this.obj);
    console.log(this.obj.Title);
  }


  onSubmit(){

  }

}
