import { Component, OnInit } from '@angular/core';
import { CreateService } from '../services/Pages/create.service';
import {SelectItem} from 'primeng/api';
import { KeycloakSecurityService } from '../services/Keycloak/keycloak-security.service';
import {CustomerService} from "../services/Customers/customer.service";
import {EventService} from "../services/Event/event.service";
import {PortfoliosService} from "../services/Portfolios/portfolios.service";
import {PublicationService} from "../services/Publication/publication.service";
import {ReviewService} from "../services/Review/review.service";
import {CustomerServicesService} from "../services/CustomerServices/customerServices.service";

@Component({
  selector: 'app-top-bar',
  templateUrl: './top-bar.component.html',
  styleUrls: ['./top-bar.component.css']
})
export class TopBarComponent implements OnInit {
  display;
  langs:SelectItem[];
  selectedLang:string;
  username;

  customernotif:number=0;
  portfonotif:number=0;
  publinotif:number=0;
  castnotif:number=0;
  reviewnotif:number=0;
  customerServNotif:number=0;
  constructor(private createService:CreateService,public securityService:KeycloakSecurityService,public cust:CustomerService,
              public cast:EventService,public portfolios:PortfoliosService,
              public publi:PublicationService,public review:ReviewService,public serv:CustomerServicesService) { }
  ngOnInit(): void {
    this.langs = [
      {label:'Selected Language', value:null},
      {label:'France', value:{name: 'France', code: 'FR'}},
      {label:'Belgium', value:{name: 'Belgium', code: 'BE'}},
      {label:'Austria', value:{name: 'Austria', code: 'AS'}},
  ];
    this.cust.GetAllCustomersValidation().subscribe(result=>{
      if (result!=undefined)
        this.customernotif=result.length;
    });
    this.portfolios.GetAllPortfoliosValidation().subscribe(result=>{
      if (result!=undefined)
        this.portfonotif=result.length;
    });
    this.cast.GetAllCastingsValidation().subscribe(result=>{
      if (result!=undefined)
        this.castnotif=result.length;
    });
    this.publi.GetAllPublicationsValidation().subscribe(result=>{
      if (result!=undefined)
        this.publinotif=result.length;
    });
    this.review.GetAllReviewsValidation().subscribe(result=>{
      if (result!=undefined)
        this.reviewnotif=result.length;
    });
    this.serv.GetAllCustomerServicesValidation().subscribe(result=>{
      if (result!=undefined)
        this.customerServNotif=result.length;
    });
  }
  onLogout(){
    this.securityService.kc.logout();
    console.log("LogOut");
  }
  onLogin(){
    this.securityService.kc.login();
  }
  onMyAccount() {
    this.securityService.kc.accountManagement()
  }
  isAllowed(role:string):boolean{
    return this.securityService.kc.hasRealmRole(role);
  }
}