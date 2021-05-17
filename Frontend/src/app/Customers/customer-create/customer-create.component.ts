import { Component, OnInit } from '@angular/core';
import { FormGroup, FormBuilder, Validators, NgForm } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { CustomerListService } from 'src/app/services/Customers/customerList.service';

@Component({
  selector: 'app-customer-create',
  templateUrl: './customer-create.component.html',
  styleUrls: ['./customer-create.component.css']
})
export class CustomerCreateComponent implements OnInit {
  test:any;
  form:FormGroup; 
  types:string[];
  jobs:string[];
  countrys:string[];
  citys:string[];

  constructor(public customerService: CustomerListService, private route:ActivatedRoute,private router:Router,private formBuilder:FormBuilder) {
  }

  ngOnInit() {

    this.resetForm();

    this.form=this.formBuilder.group({
      id:Math.floor(Math.random()*100),
      type:['',Validators.required],
      job:['',Validators.required],
      entrepriseName:['',Validators.required],
      contactLName:['',Validators.required],
      contactFName:['',Validators.required],
      country:['',Validators.required],
      city:['',Validators.required],
      email:['',Validators.required],
      receive_mail:[false,Validators.required]
    });
    this.types=["Pro","Talent"];
    this.jobs=["Agent","Artist Agent","Assistant Director","Casting Assistant"];
    this.countrys=["Belgium","France","United Kingdom"];
    this.citys=["London","Paris","Bruxelles"];
  }
  onSubmit(form: NgForm){
    this.insertRecord(form)
  }

  resetForm(form?: NgForm)
  {
    if (form != null)
    form.resetForm();
    this.customerService.formData = {
      id: null,
      CountryId: null,
      organizationId: null,
      email: '',
      firstName: '',
      lastName: '',
      Country: null,
      organization: null
    }

    if (form != null)
    form.resetForm();
    this.customerService.formDataFK = {
      id: null,
      companyName: ''
    }
  }

  insertRecord(form: NgForm) 
  {
    this.customerService.postCustomer(form.value).subscribe(res => {
      this.resetForm(form)
    });
    this.customerService.postOrganization(form.value).subscribe(res => {
      this.resetForm(form)
    });
  }
}