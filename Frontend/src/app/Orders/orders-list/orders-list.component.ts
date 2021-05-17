import { Component, OnInit, ViewChild } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { ConfirmationService } from 'primeng/api';
import { ListService } from 'src/app/services/list.service';
import { OrderListService } from 'src/app/services/Orders/list.service';
import { Table } from 'primeng/table/table';

@Component({
  selector: 'app-orders-list',
  templateUrl: './orders-list.component.html',
  styleUrls: ['./orders-list.component.css']
})
export class OrdersListComponent implements OnInit {
  header:any[];
  list:any[];
  status:any[];
  payeMode:any[];
  listToDelete:number[];
  productList:any[];
  constructor(private listTab:OrderListService,private confirmationService:ConfirmationService,
    private route:ActivatedRoute) { }

  ngOnInit(): void {
    this.header=this.listTab.headers;
    this.status=this.listTab.statusList;
    console.log(this.status);
    this.payeMode=this.listTab.payementModeList;
    console.log(this.payeMode);
    this.list=this.listTab.orders;
    this.listToDelete=[10,20,30,40];
    this.listToDelete.splice(0,this.listToDelete.length); //peut-être supprimer
    if(this.route.snapshot.params['id']){
      let i:number=this.list.findIndex(e=> e.ID===(+this.route.snapshot.params['id']));
      if (i !== -1) {
        this.list.splice(i,1);
      }
    }
  }
  addToList(item:any){
    console.log(item);
    this.listToDelete.push(+item);
    console.log(this.listToDelete)
  }
  deleteToList(){
    this.confirmationService.confirm({
      message: 'Are you sure that you want to delete Pages?',
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
  download(){
    this.listTab.downloadFile(this.list, 'OrderListCSV');
  }
}

