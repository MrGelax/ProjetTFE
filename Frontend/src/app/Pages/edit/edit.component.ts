import { Component, OnInit } from '@angular/core';
import {FormBuilder, FormGroup, NgForm, Validators} from '@angular/forms';
import {Block} from "../../Blocks/block.model";
import {BlockLocal} from "../../Blocks/blockLocal.modal";
import {ActivatedRoute, Router} from "@angular/router";
import {CreateService} from "../../services/Pages/create.service";
import {BlockService} from "../../services/Blocks/block.service";
import {Page} from "../page.model";
import {PageLocal} from "../pageLocal.model";
import {PagesService} from "../../services/Pages/pages.service";

@Component({
  selector: 'app-edit',
  templateUrl: './edit.component.html',
  styleUrls: ['./edit.component.css']
})
export class EditComponent implements OnInit {
  languages:string[];
  user:any;
  curentLang:string;
  FR:FormGroup;
  EN:FormGroup;

  page:Page=new Page();
  plcFR:PageLocal=new PageLocal();
  plcEn:PageLocal=new PageLocal();
  constructor(private router:Router,private route:ActivatedRoute,
              private createService:CreateService,private formBuilder:FormBuilder,
              public pageService:PagesService) { }

  ngOnInit(): void {
    this.languages=this.createService.languages;
    this.user=this.createService.Users[0];
    this.curentLang=this.user.Culture;
    this.FR=this.initialiserFormulaire(this.FR);
    this.EN=this.initialiserFormulaire(this.EN);

    this.pageService.GetById(this.route.snapshot.params['id']).subscribe(result=>{
      this.page=result;
      this.initialiserPage(result);
      this.pageService.GetByPageId(this.route.snapshot.params['id']).subscribe(result => {
        this.plcFR=this.initialiserPageLocal(result[0],this.plcFR);
        this.plcEn=this.initialiserPageLocal(result[1],this.plcEn);
        this.FR.setValue({
          systemName:this.page.systemName,
          label:this.page.label,
          contentMain:this.plcFR.mainContent,
          protected:this.page.isProtected,
          title:this.plcFR.title,
          active:this.plcFR.isActive,
          metaTitle:this.plcFR.pageTitle,
          metaUrl:this.plcFR.pageURL,
          metaDescription:this.plcFR.pageDescription,
          metaContent:this.plcFR.pageAdditionalMeta
        });
        this.EN.setValue({
          systemName:this.page.systemName,
          label:this.page.label,
          contentMain:this.plcEn.mainContent,
          protected:this.page.isProtected,
          title:this.plcEn.title,
          active:this.plcEn.isActive,
          metaTitle:this.plcEn.pageTitle,
          metaUrl:this.plcEn.pageURL,
          metaDescription:this.plcEn.pageDescription,
          metaContent:this.plcEn.pageAdditionalMeta
        });
        console.log('---- PageLocal FR ----');
        console.log(this.plcFR);
        console.log('---- PageLocal EN ----');
        console.log(this.plcEn);
      }, error => {
        console.log(error);
      });
    }, error => {
      console.log(error);
    });

  }
  initialiserPage(result:Page){
    this.page.id=result.id;
    this.page.isProtected=result.isProtected;
    this.page.systemName=result.systemName;
    this.page.label=result.label;
    this.page.title=result.title;
    this.page.mainContent=result.mainContent;

    //metaDonnées
    this.page.pageTitle=result.pageTitle;
    this.page.pageURL=result.pageURL;
    this.page.pageDescription=result.pageDescription;
    this.page.pageAdditionalMeta=result.pageAdditionalMeta;

    this.page.createdDateTime=result.createdDateTime;
    this.page.lastModifiedDateTime=result.lastModifiedDateTime;
    this.page.deletedDateTime=result.deletedDateTime;

  }

  initialiserPageLocal(result:PageLocal,plc:PageLocal):PageLocal{
    plc.id=result.id;
    plc.pageId=result.pageId;
    plc.languageCode=result.languageCode;
    plc.createdDateTime=result.createdDateTime;
    plc.lastModifiedDateTime=result.lastModifiedDateTime;
    plc.title=result.title;
    plc.mainContent=result.mainContent;
    plc.isActive=result.isActive;
    plc.pageURL=result.pageURL;
    plc.pageTitle=result.pageTitle;
    plc.pageDescription=result.pageDescription;
    plc.pageAdditionalMeta=result.pageAdditionalMeta;
    plc.pageOGImage=result.pageOGImage;
    plc.pageOGTitle=result.pageOGTitle;
    return plc;
  }

  initialiserFormulaire(formu:FormGroup):FormGroup{
    formu=this.formBuilder.group({
      protected:[false,Validators.requiredTrue],
      systemName:['',Validators.required],
      label:['',Validators.required],
      title:['',Validators.required],
      contentMain:['',Validators.required],
      active:[false,Validators.requiredTrue],
      metaTitle:[],
      metaUrl:[],
      metaDescription:[],
      metaContent:[]
    });
    return formu;
  }

  currentLang(lang:string){
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
    //modification de l'objet page
    this.page.systemName=this.FR.value.systemName;
    this.page.label=this.FR.value.label;
    this.page.mainContent=this.FR.value.contentMain;
    this.page.isProtected=this.FR.value.isProtected;
    this.page.title=this.FR.value.title;
    this.page.pageTitle=this.FR.value.metaTitle;
    this.page.pageURL=this.FR.value.metaUrl;
    this.page.pageDescription=this.FR.value.metaDescription;
    this.page.pageAdditionalMeta=this.FR.value.metaContent;

    this.pageService.UpdatePage(this.page,this.page.id).subscribe(result=>{
      this.page=result;
      this.plcFR.mainContent=this.FR.value.contentMain;
      this.plcFR.isActive=this.FR.value.isActive;
      this.plcFR.pageURL=this.FR.value.metaUrl;
      this.plcFR.pageTitle=this.FR.value.title;
      this.plcFR.pageDescription=this.FR.value.metaDescription;
      this.plcFR.pageAdditionalMeta=this.FR.value.metaContent;
      this.plcFR.pageOGTitle=this.FR.value.metaTitle;
      this.pageService.UpdatePageLocal(this.plcFR,this.plcFR.id).subscribe(resFR=>{
        console.log('---- Page local FR après modification ----');
        console.log(resFR);
        },e => {
        console.log(e);
      });
      this.plcEn.mainContent=this.EN.value.contentMain;
      this.plcEn.isActive=this.EN.value.isActive;
      this.plcEn.pageURL=this.EN.value.metaUrl;
      this.plcEn.pageTitle=this.EN.value.title;
      this.plcEn.pageDescription=this.EN.value.metaDescription;
      this.plcEn.pageAdditionalMeta=this.EN.value.metaContent;
      this.plcEn.pageOGTitle=this.EN.value.metaTitle;
      this.pageService.UpdatePageLocal(this.plcEn,this.plcEn.id).subscribe(resEN=>{
        console.log('---- Page local EN après modification ----');
        console.log(resEN);
        },e => {
        console.log(e);
      });
      },error => {
        console.log(error);
      }
    );
    this.router.navigate(["/Pages/list"]);
  }
}