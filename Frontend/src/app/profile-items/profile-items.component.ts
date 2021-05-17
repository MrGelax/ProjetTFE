import { Component, OnInit } from '@angular/core';
import {SelectItem, ConfirmationService, MenuItem} from 'primeng/api';

interface Role {
  name: string;
  code: string;
}

interface Language {
  name: string;
  code: string;
}

interface Editor {
  name: string;
  code: string;
}

interface Subscription {
  name: string;
  code: string;
}

@Component({
  selector: 'app-profile-items',
  templateUrl: './profile-items.component.html',
  styleUrls: ['./profile-items.component.css']
})



export class ProfileItemsComponent {

  profileroles: Role[];
  selectedRole: Role;

  sections: Role[];
  selectedSection: Role;

  val1: string;
  value: boolean;

  text: string;
  translated: string;


  languageRoles: Language[];
  selectedLanguage: Language;

  editors: Editor[];
  selectedEditor: Editor;

  subscriptions: Subscription[];

  items: MenuItem[];

  constructor() { 
    
    this.profileroles = [
      {name: 'Model', code: 'M'},
      {name: 'Artiste', code: 'A'}
      ];

  this.sections = [
    {name: 'Experience', code: 'E'},
    {name: 'Hobbies', code: 'H'}

];

this.languageRoles = [
  {name: 'FR', code: 'F'},
  {name: 'NL', code: 'N'},
  {name: 'UK', code: 'U'}
];

this.editors = [
  {name: 'Image series', code: 'IS'}
];

  }
  
  

  ngOnInit(): void {
    this.items = [
      {
          label: 'Profiles',
          items: [{

            items: [

            ]
        },
          ]
      },
      {separator:true},

      {
          label: 'Customers',
      },
      {separator:true},

      {
          label: 'Configuration',
      }
    ]
  }
}

 