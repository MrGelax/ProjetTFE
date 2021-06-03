import { Component, OnInit } from '@angular/core';
import { NgForm, FormBuilder, FormGroup, Validators } from '@angular/forms';
import { CreateService } from 'src/app/services/Pages/create.service';
import {ActivatedRoute, Router} from "@angular/router";
import {BlockService} from "../../services/Blocks/block.service";
import {Block} from "../block.model";
import {BlockLocal} from "../blockLocal.modal";
import {ViewService} from "../../services/view.service";
import {KeycloakSecurityService} from "../../services/Keycloak/keycloak-security.service";

@Component({
  selector: 'app-block-create',
  templateUrl: './block-create.component.html',
  styleUrls: ['./block-create.component.css']
})
export class BlockCreateComponent implements OnInit {
  languages:string[];
  user:any;
  curentLang:string;
  FR:FormGroup;
  EN:FormGroup;

  block:Block=new  Block();
  blcLocal:BlockLocal=new BlockLocal();
  submited=false;
  constructor(private route:Router,private createService:CreateService,
              private formBuilder:FormBuilder,public blockService:BlockService,
              public securityService:KeycloakSecurityService) { }

  ngOnInit(): void {
      if (!this.securityService.kc.hasRealmRole('CMSManager'))
          this.route.navigate(['/not-found/'+'Access dinied']);
      this.languages=this.createService.languages;
      this.user=this.createService.Users[0];
      this.curentLang=this.user.Culture;
      this.FR=this.formBuilder.group({
          systemName:['',Validators.required],
          label:['',Validators.required],
          contentMain:['',Validators.required]
      });
      this.EN=this.formBuilder.group({
          systemName:['',Validators.required],
          label:['',Validators.required],
          contentMain:['',Validators.required]
      });
  }
  currentLang(lang:string){
      this.curentLang=lang;
      console.log("Langue : "+this.curentLang);
  }
  duplicatoTo(lang:any){
      if(lang==="EN"&&this.curentLang==="FR")
          this.EN=this.FR;
      if(lang==="FR"&&this.curentLang==="EN")
          this.FR=this.EN;
      this.curentLang=lang;
      console.log(this.curentLang)
  }
  get fr() { return this.FR.controls; }
  get en() { return this.EN.controls; }
  onSubmit(){
      this.submited=true;
      if(this.FR.invalid && this.EN.invalid){
          return;
      }
      this.block.systemName=this.FR.value.systemName;
      this.block.label=this.FR.value.label;
      this.block.body=this.FR.value.contentMain;
      this.blockService.CreateBlock(this.block).subscribe(result=>{
          this.block=result;
          this.blcLocal.blockId=result.id;
          this.blcLocal.body=this.FR.value.contentMain;
          this.blcLocal.languageCode="fr";
          this.blockService.CreateBlockLocal(this.blcLocal).subscribe(resFR=>{
            console.log("Ajout blockLocal en Français");
            console.log(resFR);
          },e => {
            console.log(e);
          });
          this.blcLocal.body=this.EN.value.contentMain;
          this.blcLocal.languageCode="en";
          this.blockService.CreateBlockLocal(this.blcLocal).subscribe(resEN=>{
              console.log("Ajout blockLocal en Englais");
              console.log(resEN);
          },e => {
              console.log(e);
          });
      },error => {
          console.log(error);
      });
    this.route.navigate(["/Blocks/list"]);
  }
  onReset() {
      this.submited = false;
      this.FR.reset();
      this.EN.reset();
      this.route.navigate(["/Blocks/list"]);
  }
}

