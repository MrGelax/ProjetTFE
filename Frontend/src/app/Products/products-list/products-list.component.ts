import { Component, OnInit } from '@angular/core';
import { ConfirmationService } from 'primeng/api';
import { ActivatedRoute } from '@angular/router';
import { ProductsListService } from 'src/app/services/Products/list.service';
@Component({
  selector: 'app-products-list',
  templateUrl: './products-list.component.html',
  styleUrls: ['./products-list.component.css']
})
export class ProductsListComponent implements OnInit {
  header:any[];
  list:any[];
  status:any[];
  payType:any[];
  prodType:any[];
  listToDelete:number[];
  constructor(private listTab:ProductsListService,private confirmationService:ConfirmationService,
    private route:ActivatedRoute) { }

  ngOnInit(): void {
    
    this.header=this.listTab.headers;
    this.status=this.listTab.statusList;
    this.payType=this.listTab.payType;
    this.prodType=this.listTab.prodType;

    this.list=this.listTab.productList;
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
  download(){}
}
