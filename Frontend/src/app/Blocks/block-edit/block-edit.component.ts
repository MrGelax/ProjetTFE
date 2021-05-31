import { Component, OnInit } from '@angular/core';
import {FormBuilder, FormGroup, Validators} from "@angular/forms";
import {Block} from "../block.model";
import {BlockLocal} from "../blockLocal.modal";
import {ActivatedRoute, Router} from "@angular/router";
import {CreateService} from "../../services/Pages/create.service";
import {BlockService} from "../../services/Blocks/block.service";

@Component({
  selector: 'app-block-edit',
  templateUrl: './block-edit.component.html',
  styleUrls: ['./block-edit.component.css']
})
export class BlockEditComponent implements OnInit {
  languages:string[];
  user:any;
  curentLang:string;
  FR:FormGroup;
  EN:FormGroup;

  block:Block=new Block();
  blcFR:BlockLocal=new BlockLocal();
  blcEn:BlockLocal=new BlockLocal();
  constructor(private router:Router,private route:ActivatedRoute,
              private createService:CreateService,private formBuilder:FormBuilder,
              public blockService:BlockService) { }

  ngOnInit(): void {
    this.languages=this.createService.languages;
    this.user=this.createService.Users[0];
    this.curentLang=this.user.Culture;
    this.FR=this.initialiserFormulaire(this.FR,this.blcFR);
    this.EN=this.initialiserFormulaire(this.EN,this.blcEn);

    this.blockService.GetById(this.route.snapshot.params['id']).subscribe(result=>{
      this.initialiserBlock(result);
      this.blockService.GetByBlockId(this.route.snapshot.params['id']).subscribe(result => {
          this.blcFR=this.initialiserBlockLocal(result[1],this.blcFR);
          this.blcEn=this.initialiserBlockLocal(result[0],this.blcEn);
          this.FR.setValue({
              systemName:this.block.systemName,
              label:this.block.label,
              contentMain:this.blcFR.body
          });
          this.EN.setValue({
              systemName:this.block.systemName,
              label:this.block.label,
              contentMain:this.blcEn.body
          });
      }, error => {
        console.log(error);
      });
    }, error => {
      console.log(error);
    });

  }
  initialiserBlock(result:Block){
    this.block.id=result.id;
    this.block.systemName=result.systemName;
    this.block.body=result.body;
    this.block.label=result.label;
    this.block.createdDateTime=result.createdDateTime;
    this.block.lastModifiedDateTime=result.lastModifiedDateTime;
    this.block.deletedDateTime=result.deletedDateTime;
  }
  initialiserBlockLocal(result:BlockLocal,blc:BlockLocal):BlockLocal{
      blc.body=result.body;
      blc.languageCode=result.languageCode;
      blc.blockId=result.blockId;
      blc.id=result.id;
      blc.createdDateTime=result.createdDateTime;
      blc.lastModifiedDateTime=result.lastModifiedDateTime;
      return blc;
  }

  initialiserFormulaire(formu:FormGroup,blc:BlockLocal):FormGroup{
    formu=this.formBuilder.group({
      systemName:['',[Validators.required,Validators.maxLength(2)]],
      label:['',[Validators.requiredTrue,Validators.maxLength(10)]],
      contentMain:['',Validators.requiredTrue]
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
    this.block.systemName=this.FR.value.systemName;
    this.block.label=this.FR.value.label;
    this.block.body=this.FR.value.contentMain;
    this.blockService.UpdateBlock(this.block,this.block.id).subscribe(result=>{
          this.block=result;
          this.blcFR.body=this.FR.value.contentMain;
          this.blockService.UpdateBlockLocal(this.blcFR,this.blcFR.id).subscribe(resFR=>{
            console.log("Ajout blockLocal en Français");
            console.log(resFR);
          },e => {
            console.log(e);
          });
          this.blcEn.body=this.EN.value.contentMain;
          this.blockService.UpdateBlockLocal(this.blcEn,this.blcEn.id).subscribe(resEN=>{
            console.log("Ajout blockLocal en Englais");
            console.log(resEN);
          },e => {
            console.log(e);
          });
        },error => {
          console.log(error);
        }
    );
    this.router.navigate(["/Blocks/list"]);
  }
}
