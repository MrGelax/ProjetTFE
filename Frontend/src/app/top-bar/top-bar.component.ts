import { Component, OnInit } from '@angular/core';
import { CreateService } from '../services/Pages/create.service';
import {SelectItem} from 'primeng/api';
import { KeycloakSecurityService } from '../services/Keycloak/keycloak-security.service';

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
  constructor(private createService:CreateService,public securityService:KeycloakSecurityService) { }
  ngOnInit(): void {
    this.langs = [
      {label:'Selected Language', value:null},
      {label:'France', value:{name: 'France', code: 'FR'}},
      {label:'Belgium', value:{name: 'Belgium', code: 'BE'}},
      {label:'Austria', value:{name: 'Austria', code: 'AS'}},
  ];
  }
  onLogout(){
    this.securityService.kc.logout();
  }
  onLogin(){
    this.securityService.kc.login();
  }
  onMyAccount() {
    this.securityService.kc.accountManagement()
  }
}