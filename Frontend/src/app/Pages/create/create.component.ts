import { Component, OnInit } from '@angular/core';
import{NgForm, FormControl, FormBuilder, FormGroup, Validators}from '@angular/forms';
import { CreateService } from '../../services/Pages/create.service';
  

@Component({
  selector: 'app-create',
  templateUrl: './create.component.html',
  styleUrls: ['./create.component.css']
})
export class CreateComponent implements OnInit {
  languages:any[];
  langdupli:any[];
  user:any;
  curentLang:string;
  FR:FormGroup;
  EN:FormGroup;
  submited=false;
  constructor(private createService:CreateService,private formBuilder:FormBuilder) { }

  ngOnInit(): void {
    this.languages=this.createService.languages;
    this.user=this.createService.Users[0];
    this.curentLang=this.user.Culture;
    this.FR=this.formBuilder.group({
      protected:[false,Validators.requiredTrue],
      systemName:['',Validators.required],
      label:['',Validators.required],
      active:[false,Validators.requiredTrue],
      title:['',Validators.required],
      contentMain:['',Validators.required],
      metaTitle:[],
      metaUrl:[],
      metaDescription:[],
      metaContent:[]
    });
    this.EN=this.formBuilder.group({
      protected:[false,Validators.requiredTrue],
      systemName:['',Validators.required],
      label:['',Validators.required],
      active:[false,Validators.requiredTrue],
      title:['',Validators.required],
      contentMain:['',Validators.required],
      metaTitle:[],
      metaUrl:[],
      metaDescription:[],
      metaContent:[]
    });
  }
  currentLanng(lang:any){
    this.curentLang=lang;
  }
  duplicatoTo(lang:any){
    if(lang==="EN"&&this.curentLang==="FR"){
      this.EN=this.FR;
    }
    if(lang==="FR"&&this.curentLang==="EN"){
      this.FR=this.EN;
    }
    this.curentLang=lang;
  }
  onSubmit(){
    console.log('Données du formulaire',this.FR.value);
    console.log('Données du formulaire',this.EN.value);
  }
}