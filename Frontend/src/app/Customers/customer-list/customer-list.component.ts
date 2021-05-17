import { Component, OnInit } from '@angular/core';

import { CustomerListService } from 'src/app/services/Customers/customerList.service';
import { MenuItem } from 'primeng/api/menuitem';
import { SelectItem } from 'primeng/api/selectitem';
import {CalendarModule} from 'primeng/calendar';
import { ConfirmationService } from 'primeng/api';
import { ActivatedRoute } from '@angular/router';

@Component({
  selector: 'app-customer-list',
  templateUrl: './customer-list.component.html',
  styleUrls: ['./customer-list.component.css']
})
export class CustomerListComponent implements OnInit {

  header:any[];
  customers:any[];
  items: MenuItem[];

  items1: MenuItem[];

  roles: SelectItem[];
  status: SelectItem[];
  rating: SelectItem[];
  newsletter: SelectItem[];
  subscription: SelectItem[];

  date12: Date;

  list:any[];
  listToDelete:number[];

  val3: string;

  constructor(public customerService:CustomerListService, private confirmationService:ConfirmationService,
    private route:ActivatedRoute) { }

  ngOnInit(): void {

    /* multiselect */ 
    this.listToDelete=[1,2,3,4];
    this.listToDelete.splice(0,this.listToDelete.length); //peut-être supprimer
    if(this.route.snapshot.params['ID']){
      let i:number=this.list.findIndex(e=> e.ID===(+this.route.snapshot.params['ID']));
      if (i !== -1) {
        this.list.splice(i,1);
      }
    }

    this.roles = [
      { label: 'Casting Assistance', value: 'Casting Assistance' },
      { label: 'Casting Director', value: 'Casting Director' },
      { label: 'Musician', value: 'Musician' },
  ];

this.status = [
      { label: 'WAITING', value: 'WAITING' },
      { label: 'VALIDATION', value: 'VALIDATION' },
  ];

  this.rating = [
    { label: '1', value: '1' },
    { label: '2', value: '2' },
    { label: '3', value: '3' },
    { label: '4', value: '4' },
    { label: '5', value: '5' },

];

this.newsletter = [
  { label: 'yes', value: 'yes' },
  { label: 'no', value: 'no' },
];

this.subscription = [
  { label: 'Ristretto', value: 'Ristretto' },
  { label: 'Test', value: 'test' },
];


  /* tabs */ 
    this.items1 = [
      {label: 'Infos', icon: 'pi pi-fw pi-chart-bar', routerLink:'/Customer/basics'},
      {label: 'Basics', icon: 'pi pi-fw pi-file', routerLink:'/Customer/basics'}
  ];
    this.header=this.customerService.headers;
    this.customers=this.customerService.customers;


    /* Splitbutton */
    this.items = [
      {label: 'Customer dashboard', command: () => {
          this.update();
      }},
      {separator: true},
      {label: 'View on website', url: 'http://www.kastingkafe.com/[id]'},
      {separator: true},

      {label: 'Orders list', command: () => {
          this.delete();
      }},
      {separator: true},
      {label: 'Castings list', routerLink: ['/setup']},
      {separator: true},
      {label: 'Portfolio list' , routerLink: ['/setup']},
      {separator: true},
      {label: 'Services list' , routerLink: ['/setup']},
      {separator: true},
      {label: 'Publications list', routerLink: ['/setup']},
      {separator: true},
      {label: 'Messages', routerLink: ['/setup']}
  ];
  }

   save(severity: string) {
        this.customerService.add({severity:severity, summary:'Success', detail:'Data Saved'});
    }

    update() {
        this.customerService.add({severity:'success', summary:'Success', detail:'Data Updated'});
    }

    delete() {
        this.customerService.add({severity:'success', summary:'Success', detail:'Data Deleted'});
    }


    /* CSV data*/
  jsonData =  [
    {
      ID:"1",
      Name:'Alice Zune',
      Role:'Acteur',
      Email:'jackBrad.yopmail.com',
      Status: "WAITING",
      "Created on": "18/03/2000",
      "Last modified" : "11/03/2020",
      Rating: "5",
      Newsletter: "yes",
      Subscription: "Ristretto"
  },
  {
      ID:2,
      Name:'Pedro Da Silva',
      Role:'Mannequin',
      Email:'pedro_dasilva.yopmail.com',
      Status: "WAITING",
      "Created on": "5/06/2012",
      "Last modified": "19/02/2020",
      Rating: "5",
      Newsletter: "no",
      Subscription: "Ristretto"
  },
  {
      ID:3,
      Name:'Reda ',
      Role:'Acteur',
      Email:'reda.yopmail.com',
      Status: "VALIDATION",
      "Created on": "07/08/2005",
      "Last modified": "11/03/2020",
      Rating: "5",
      Newsletter: "yes",
      Subscription: "test"
  },
  {
      ID:4,
      Name:'Betty',
      Role:'Actrice',
      Email:'betty9.yopmail.com',
      Status: "VALIDATION",
      "Created on": "28/02/1995",
      "Last modified": "11/04/2020",
      Rating: "5",
      Newsletter: "no",
      Subscription: "test"
  },
   
  ];

  download(){
    this.customerService.downloadFile(this.jsonData, 'CustomerListCSV');
  }

  addToList(item:any){
    console.log(item);
    this.listToDelete.push(+item);
    console.log(this.listToDelete)
  }
  
  deleteToList(){
    this.confirmationService.confirm({
      message: 'Are you sure that you want to delete Customer?',
      accept: () => {
        if(this.listToDelete.length>=1){
              console.log(this.listToDelete);
              for(let item of this.listToDelete){
                let i:number=this.list.findIndex(e=> e.ID===item);
                if (i !== -1) {
                  this.list.splice(i,1);
                }
                console.log(item);
              }
              console.log("Supression OK");
      }

      },reject:()=>{
        console.log("Suppression PAS OK");
      }
  });
  }

}

 /* check in */