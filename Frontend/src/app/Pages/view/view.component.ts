import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { ListService } from '../../services/list.service';
import { ViewService } from '../../services/view.service';
import {PagesService} from "../../services/Pages/pages.service";
import {Page} from "../page.model";
import {KeycloakSecurityService} from "../../services/Keycloak/keycloak-security.service";

@Component({
  selector: 'app-view',
  templateUrl: './view.component.html',
  styleUrls: ['./view.component.css']
})
export class ViewComponent implements OnInit {

  obj:Page;
  constructor(private viewtService:ViewService,
    private route:ActivatedRoute,private router:Router,public pagesService:PagesService,
              public securityService:KeycloakSecurityService) { }

  ngOnInit(): void {
    if (!this.securityService.kc.hasRealmRole('CMSManager'))
      this.router.navigate(['/not-found/'+'Access dinied']);
    const id=this.route.snapshot.params['id'];
    if(this.viewtService.getPageByID(+id)===undefined) {
      this.router.navigate(['/not-found/'+'Page not found']);
    }else{
      this.pagesService.GetById(id).subscribe(result=>{
        this.obj=result;
      });
      //this.obj=this.viewtService.getBlockByID(+id);
      //console.log(this.obj.Title);
    }
  }
  backtoList(){
    this.router.navigate(['/list/'+this.obj.id]);
  }
  click(url:string){
    window.location.href=url;
  }
}
