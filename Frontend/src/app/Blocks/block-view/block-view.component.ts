import { Component, OnInit } from '@angular/core';
import { ViewService } from 'src/app/services/view.service';
import { ActivatedRoute, Router } from '@angular/router';
import {BlockService} from "../../services/Blocks/block.service";
import {Block} from "../block.model";
import {KeycloakSecurityService} from "../../services/Keycloak/keycloak-security.service";

@Component({
  selector: 'app-block-view',
  templateUrl: './block-view.component.html',
  styleUrls: ['./block-view.component.css']
})
export class BlockViewComponent implements OnInit {
  obj:Block;
  constructor(private viewtService:ViewService,public securityService:KeycloakSecurityService,
    private route:ActivatedRoute,private router:Router,public blockService:BlockService) { }

  ngOnInit(): void {
    if (!this.securityService.kc.hasRealmRole('CMSManager'))
      this.router.navigate(['/not-found/'+'Access dinied']);

    const id=this.route.snapshot.params['id'];
    if(this.blockService.GetById(id)===undefined) {
      this.router.navigate(['/not-found/'+'Page not found']);
    }else{
      this.blockService.GetById(id).subscribe(result=>{
        this.obj=result;
      });
      //this.obj=this.viewtService.getBlockByID(+id);
      //console.log(this.obj.Title);
    }
  }
  backtoList(){
    this.router.navigate(['Blocks/list/'+this.obj.id]);
  }
}
