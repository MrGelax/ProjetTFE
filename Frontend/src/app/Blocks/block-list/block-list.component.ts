import { Component, OnInit } from '@angular/core';
import { ConfirmationService } from 'primeng/api';
import {ActivatedRoute, Router} from '@angular/router';
import {BlockService} from "../../services/Blocks/block.service";
import {Block} from "../block.model";
import {KeycloakSecurityService} from "../../services/Keycloak/keycloak-security.service";

@Component({
  selector: 'app-block-list',
  templateUrl: './block-list.component.html',
  styleUrls: ['./block-list.component.css']
})
export class BlockListComponent implements OnInit {
  header:any[];
  rowData:Block[];
  listToDelete:number[];
  block:Block=new Block();

  constructor(private confirmationService:ConfirmationService,
              private route:ActivatedRoute,private router:Router,
              public blockService:BlockService,public securityService:KeycloakSecurityService){ }

  ngOnInit(): void {
    if (!this.securityService.kc.hasRealmRole('CMSManager'))
      this.router.navigate(['/not-found/'+'Access dinied']);
    this.blockService.GetAllBlocks().subscribe(result => {
      this.header=this.blockService.headers;
      this.rowData = result.blocks;
      this.listToDelete=[10,20,30,40];
      this.listToDelete.splice(0,this.listToDelete.length);
    }, error => {
      console.log(error);
    });
  }
  addToList(id:number){
    this.listToDelete.push(+id);
  }
  deleteBlock(){
    for(let id of this.listToDelete){
      this.blockService.deleteBlock(id).subscribe(result=>{
          this.blockService.GetAllBlocks().subscribe(result=>{
          this.rowData=result.blocks;
        },error => {
          console.log(error);
        });
      },error => {
        console.log(error);
      });
    }
  }
}
