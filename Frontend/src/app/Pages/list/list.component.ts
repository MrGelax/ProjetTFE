import { Component, OnInit } from '@angular/core';
import { ConfirmationService } from 'primeng/api';
import {ActivatedRoute, Router} from '@angular/router';
import {Page} from "../page.model";
import {PagesService} from "../../services/Pages/pages.service";
import {KeycloakSecurityService} from "../../services/Keycloak/keycloak-security.service";

@Component({
  selector: 'app-list',
  templateUrl: './list.component.html',
  styleUrls: ['./list.component.css']
})
export class ListComponent implements OnInit {
  header:any[];
  rowData:Page[];
  listToDelete:number[];
  page:Page=new Page();

  constructor(private router:Router,private confirmationService:ConfirmationService,private route:ActivatedRoute,
              public pageService:PagesService,public securityService:KeycloakSecurityService) { }

  ngOnInit(): void {
    if (!this.securityService.kc.hasRealmRole('CMSManager'))
      this.router.navigate(['/not-found/'+'Access dinied']);

    this.pageService.GetAllPages().subscribe(result => {
      this.header=this.pageService.headers;
      console.log("Bonjour");
      this.rowData = result.pages;
      console.log("Nombre de page : "+result.totalCount);
      this.listToDelete=[10,20,30,40];
      this.listToDelete.splice(0,this.listToDelete.length); //peut-être supprimer
    }, error => {
      console.log(error);
    });
  }
  addToList(item:any){
    console.log(item);
    this.listToDelete.push(+item);
    console.log(this.listToDelete)
  }
  deletePage(){
    for(let id of this.listToDelete){
      this.pageService.deletePage(id).subscribe(result=>{
        this.pageService.GetAllPages().subscribe(result=>{
          this.rowData=result.pages;
        },error => {
          console.log(error);
        });
      },error => {
        console.log(error);
      });
    }
  }
}
