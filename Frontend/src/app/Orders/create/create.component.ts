import { Component, OnInit } from '@angular/core';
import { FormGroup, FormBuilder, Validators } from '@angular/forms';
import { CreateService } from 'src/app/services/Pages/create.service';
import { OrderListService } from 'src/app/services/Orders/list.service';

@Component({
  selector: 'app-create',
  templateUrl: './create.component.html',
  styleUrls: ['./create.component.css']
})
export class OrderCreateComponent implements OnInit {
  
  payeMethod:any[];

  languages:any[];
  langdupli:any[];
  user:any;
  curentLang:string;
  form:FormGroup;
  local:any
  submited=false;
  date1:any;
  constructor(private createService:CreateService,private listTab:OrderListService,private formBuilder:FormBuilder) { }

  ngOnInit(): void {
    this.payeMethod=this.listTab.payementModeList;
    console.log(this.payeMethod);

    this.languages=this.createService.languages;
    this.user=this.createService.Users[0];
    this.curentLang=this.user.Culture;
    this.form=this.formBuilder.group({
      product:['',Validators.required],
      quanty:[1,Validators.required],
      promoCode:[''],
      status:[''],
      creationdate:[new Date(),Validators.required],
      payementdate:[new Date()],
      payeMethod:['',Validators.required],
      tvaCli:[''],
      tvaTaux:['21,00']
    });
  }
  currentLanng(lang:any){
    this.curentLang=lang;
  }
  onSubmit(){
    console.log('Données du formulaire',this.form.value);
    this.date1=this.form.get("creationdate").value;
    console.log(this.date1.getDate()+"/"+(this.date1.getMonth()+1)+"/"+this.date1.getFullYear());
    
  }
}
