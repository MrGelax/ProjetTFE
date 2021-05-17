import { Component, OnInit } from '@angular/core';
import { PromoCodesListService } from 'src/app/services/PromoCodes/list.service';
import { ConfirmationService } from 'primeng/api';
import { ActivatedRoute } from '@angular/router';

@Component({
  selector: 'app-promocodes-list',
  templateUrl: './promocodes-list.component.html',
  styleUrls: ['./promocodes-list.component.css']
})
export class PromocodesListComponent implements OnInit {
  header:any[];
  list:any[];
  type:any[];
  listToDelete:number[];

  constructor(private listTab:PromoCodesListService,private confirmationService:ConfirmationService,
    private route:ActivatedRoute) { }
  ngOnInit(): void {
    this.header=this.listTab.headers;
    this.list=this.listTab.promoCodeList;
    this.type=this.listTab.type;
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
    this.listTab.downloadFile(this.list, 'PromoCodeCSV');
  }
}
