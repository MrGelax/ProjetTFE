import { Component, OnInit } from '@angular/core';
import { ViewService } from 'src/app/services/view.service';
import { ActivatedRoute, Router } from '@angular/router';
import { OrderListService } from 'src/app/services/Orders/list.service';

@Component({
  selector: 'app-orders-manage',
  templateUrl: './orders-manage.component.html',
  styleUrls: ['./orders-manage.component.css']
})
export class OrdersManageComponent implements OnInit {
  obj:any;
  views:any[];
  constructor(private viewtService:ViewService,private orderlist:OrderListService,
    private route:ActivatedRoute,private router:Router) { }

    ngOnInit(): void {
      const id=this.route.snapshot.params['id'];
      if(this.orderlist.getOrdersByID(+id)===undefined) {
        this.router.navigate(['/not-found']);  
      }
      this.obj=this.orderlist.getOrdersByID(+id);
      this.views=this.viewtService.views;
      console.log(this.obj.Title);
      console.log(id);
    }
    backtoList(){
      this.router.navigate(['/Orders/list/'+this.obj.ID]);
    }
    click(url:string){
      window.location.href=url;
    }
    infocustom(){
      return "Manage Order for customer - "+this.obj.Name+ " - "+this.obj.Role;
    }
}
