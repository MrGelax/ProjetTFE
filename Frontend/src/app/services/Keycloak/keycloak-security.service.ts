import { Injectable } from '@angular/core';
import {KeycloakInstance} from 'keycloak-js';

declare var Keycloak:any;

@Injectable({
  providedIn: 'root'
})
export class KeycloakSecurityService {
  public kc:KeycloakInstance;
  
  constructor() { }
  async init(){
    this.kc=new Keycloak({
      url:'http://localhost:8080/auth',
      realm:'kastingKafeProject',
      clientId:'bokk-app'
    });
    await this.kc.init({
      onLoad:'login-required'
    });
    //console.log(this.kc.tokenParsed['name']);
  }
  //constructor() { }
  //init(){
    //console.log("Secutiry Initialisation...")
  //}
  // public isManager():boolean{return this.kc.hasResourceRole("data-manager");}
  public isManager():boolean{
    return this.kc.hasRealmRole('MANAGER');
  }
  public isAdmin():boolean{
    return this.kc.hasRealmRole('ADMIN');
  }

}
