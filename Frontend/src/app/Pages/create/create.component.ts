import { Component, OnInit } from '@angular/core';
import{NgForm, FormControl, FormBuilder, FormGroup, Validators}from '@angular/forms';
import { CreateService } from '../../services/Pages/create.service';
import {Block} from "../../Blocks/block.model";
import {BlockLocal} from "../../Blocks/blockLocal.modal";
import {BlockService} from "../../services/Blocks/block.service";
import {Router} from "@angular/router";
import {PagesService} from "../../services/Pages/pages.service";
import {PageLocal} from "../pageLocal.model";
import {Page} from "../page.model";
  

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

  page:Page=new  Page();
  pl:PageLocal=new PageLocal();
  submited=false;
  constructor(private route:Router,private createService:CreateService,
              private formBuilder:FormBuilder,public pageService:PagesService) { }

  ngOnInit(): void {
    this.languages=this.createService.languages;
    this.user=this.createService.Users[0];
    this.curentLang=this.user.Culture;
    this.FR=this.formBuilder.group({
      protected:[false],
      systemName:['',Validators.required],
      label:['',Validators.required],
      title:['',Validators.required],
      contentMain:['',Validators.required],
      active:[false],
      metaTitle:[],
      metaUrl:[],
      metaDescription:[],
      metaContent:[]
    });
    this.EN=this.formBuilder.group({
      protected:[false],
      systemName:['',Validators.required],
      label:['',Validators.required],
      active:[false],
      title:['',Validators.required],
      contentMain:['',Validators.required],
      metaTitle:[],
      metaUrl:[],
      metaDescription:[],
      metaContent:[]
    });
  }
  currentLang(lang:any){
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
  get fr() { return this.FR.controls; }
  get en() { return this.EN.controls; }

  onSubmit(){
    this.submited=true;
    if(this.FR.invalid && this.EN.invalid){
      return;
    }
    this.page.systemName=this.FR.value.systemName;
    this.page.label=this.FR.value.label;
    this.page.mainContent=this.FR.value.contentMain;
    this.page.isProtected=this.FR.value.isProtected;
    this.page.title=this.FR.value.title;
    this.page.pageTitle=this.FR.value.metaTitle;
    this.page.pageURL=this.FR.value.metaUrl;
    this.page.pageDescription=this.FR.value.metaDescription;
    this.page.pageAdditionalMeta=this.FR.value.metaContent;

    this.pageService.CreatePage(this.page).subscribe(result=>{
      this.page=result;
      this.pl.pageId=result.id;
      this.pl.mainContent=this.FR.value.contentMain;
      this.pl.languageCode="fr";
      this.pl.isActive=this.FR.value.isActive;
      this.pl.pageURL=this.FR.value.metaUrl;
      this.pl.pageTitle=this.FR.value.title;
      this.pl.pageDescription=this.FR.value.metaDescription;
      this.pl.pageAdditionalMeta=this.FR.value.metaContent;
      this.pl.pageOGTitle=this.FR.value.metaTitle;
      this.pageService.CreatePageLocal(this.pl).subscribe(resFR=>{
        console.log("Ajout pageLocal en Français");
        console.log(resFR);
      },e => {
        console.log(e);
      });

      this.pl.pageId=result.id;
      this.pl.mainContent=this.EN.value.contentMain;
      this.pl.languageCode="en";
      this.pl.isActive=this.EN.value.isActive;
      this.pl.pageURL=this.EN.value.metaUrl;
      this.pl.pageTitle=this.EN.value.title;
      this.pl.pageDescription=this.EN.value.metaDescription;
      this.pl.pageAdditionalMeta=this.EN.value.metaContent;
      this.pl.pageOGTitle=this.EN.value.metaTitle;
          this.pageService.CreatePageLocal(this.pl).subscribe(resEN=>{
            console.log("Ajout pageLocal en Anglais");
            console.log(resEN);
          },e => {
            console.log(e);
          });
        },error => {
          console.log(error);
        }
    );
    this.route.navigate(["/Pages/list"]);
  }
  onReset() {
    this.submited = false;
    this.FR.reset();
    this.EN.reset();
    this.route.navigate(["/Pages/list"]);
  }
}