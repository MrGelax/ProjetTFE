import { Component, OnInit } from '@angular/core';
import {KeycloakSecurityService} from "../services/Keycloak/keycloak-security.service";
import {Router} from "@angular/router";

@Component({
  selector: 'app-dashboard',
  templateUrl: './dashboard.component.html',
  styleUrls: ['./dashboard.component.css']
})
export class DashboardComponent implements OnInit {
  //
  // CustumerList:any[];
  // PortfoliosList:any[];
  // Publications:any[];
  // Review:any[];
  // OrdersList:any[];
  // CastingList:any[];
  // ServicesList:any[];
  // Headers:any[];
  constructor(protected securityService:KeycloakSecurityService,protected route:Router) { }

  ngOnInit(): void {
    if (!this.securityService.kc.hasRealmRole('CMSManager'))
      this.route.navigate(['/not-found/'+'Access dinied']);
  }

}
