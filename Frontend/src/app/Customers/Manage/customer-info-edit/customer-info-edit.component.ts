import { Component, OnInit, Input } from '@angular/core';
import { FormGroup, FormBuilder, Validators } from '@angular/forms';
import { CustomerManageService } from 'src/app/services/Customers/customerManage.service';
import { Router, ActivatedRoute } from '@angular/router';

@Component({
  selector: 'app-customer-info-edit',
  templateUrl: './customer-info-edit.component.html',
  styleUrls: ['./customer-info-edit.component.css']
})
export class CustomerInfoEditComponent implements OnInit {
  val:string;
  obj:any;
  curentLang:string;
  form:FormGroup;
  constructor(private custom:CustomerManageService,
    private route:ActivatedRoute,private router:Router,private formBuilder:FormBuilder) { }

  ngOnInit(): void {
    this.val="03/21/2020";
    const id=this.route.snapshot.params['id'];
    this.obj=this.custom.getCustomerByID(+id);
    this.form=this.formBuilder.group({
      status:[this.obj.Status.validate,Validators.required],
      rating:[this.obj.Rating,Validators.required],
      prefedLang:[this.obj.Prefered_language,Validators.required],
      name:[this.obj.Name,Validators.required],
      gender:[this.obj.Gender,Validators.required],
      birthDay:['',Validators.required],
      nrm:[this.obj.Nrn,Validators.required],
      tel:[this.obj.Tel,Validators.required],
      isChild:[this.obj.IsChild],
      avatar:[this.obj.Avatar,Validators.required],
      parentFName:[this.obj.ParentFName],
      parentLName:[this.obj.ParentLName],
      companyName:[this.obj.CompanyInfo.name],
      legalForm:[this.obj.CompanyInfo.legalForm],
      adress:this.formBuilder.group({
        street:[this.obj.Adress.street],
        number:[this.obj.Adress.number],
        country:[this.obj.Adress.country]
      }),
      billingInfo:this.formBuilder.group({
        vat:[this.obj.BillingInfo.vat],
        iban:[this.obj.BillingInfo.iban],
        bic:[this.obj.BillingInfo.bic]
      })

    });
    console.log(this.obj.Status.validate);
  }
  onSubmit(){
    this.obj.Status.validate=this.form.get('status').value;
    this.obj.Status.dateVal=(new Date).getDate();
    this.obj.Rating=this.form.get('rating').value;
    this.obj.Avatar=this.form.get('avatar').value;
    this.obj.Prefered_language=this.form.get('prefedLang').value;
    this.obj.Name=this.form.get('name').value;
    this.obj.Gender=this.form.get('gender').value;
    this.obj.BirthDate=this.form.get('birthDay').value;
    this.obj.Nrn=this.form.get('nrm').value;
    this.obj.Tel=this.form.get('tel').value;
    this.obj.IsChild=this.form.get('isChild').value;
    this.obj.ParentFName=this.form.get('parentFName').value;
    this.obj.ParentLName=this.form.get('parentLName').value;

    this.obj.CompanyInfo.name=this.form.get('companyName').value;
    this.obj.CompanyInfo.legalForm=this.form.get('legalForm').value;
    this.obj.Adress.street=this.form.get('adress').get("street").value;
    this.obj.Adress.number=this.form.get('adress').get("number").value;
    this.obj.Adress.country=this.form.get('adress').get("country").value;
    this.obj.BillingInfo.vat=this.form.get('billingInfo').get('vat').value;
    this.obj.BillingInfo.iban=this.form.get('billingInfo').get('iban').value;
    this.obj.BillingInfo.bic=this.form.get('billingInfo').get('bic').value;

    console.log(this.obj);
    this.custom.updateCustomerInformationContent(this.obj);
    this.router.navigate(['Customer/view/'+this.obj.ID]);
  }
  setAvatar(event) {
    var files: FileList = event['files'];
    if (files.length <= 0) {
      return;
    }
    this.form.get('avatar').setValue(files[0]);
    console.log(this.form.get('avatar').value);
  }
}
