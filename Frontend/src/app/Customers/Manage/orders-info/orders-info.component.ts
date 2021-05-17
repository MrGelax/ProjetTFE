import { Component, OnInit, Input } from '@angular/core';
import { ConfirmationService } from 'primeng/api';
import { ActivatedRoute, Router } from '@angular/router';

@Component({
  selector: 'app-orders-info',
  templateUrl: './orders-info.component.html',
  styleUrls: ['./orders-info.component.css']
})
export class OrdersInfoComponent implements OnInit {

  @Input()
  obj:any;
  listToDelete:number[];

  constructor(private route:ActivatedRoute,private router:Router,
    private confirmationService:ConfirmationService) { }

  ngOnInit(): void {
    this.listToDelete=[10,20,30,40];
    this.listToDelete.splice(0,this.listToDelete.length); 
  }
  deleteToList( id:any){
    this.confirmationService.confirm({
      message: 'Are you sure that you want to delete the item?',
      accept: () => {
        let i:number=this.obj.orders.findIndex(e=> e.id===+id);        
        this.obj.orders.splice(i,1);
        console.log("Supression OK");
      },reject:()=>{
        console.log("Suppression PAS OK");
      }
  });
  }
}
