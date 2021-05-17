import { Component, OnInit, Input } from '@angular/core';
import { CustomerManageService } from 'src/app/services/Customers/customerManage.service';
import { ActivatedRoute, Router } from '@angular/router';

@Component({
  selector: 'app-customer-infos',
  templateUrl: './customer-infos.component.html',
  styleUrls: ['./customer-infos.component.css']
})
export class CustomerInfosComponent implements OnInit {
  @Input()
  obj:any;
  constructor(private route:ActivatedRoute,private router:Router) { }

  ngOnInit(): void {
    if(this.obj.Avatar.objectURL!==undefined){
      this.obj.Avatar=this.obj.Avatar.objectURL.changingThisBreaksApplicationSecurity;
    }
    console.log(this.obj);
  }
  
  backtoList(){
    this.router.navigate(['/Pages/list']);//A changer
  }
  click(url:string){
    window.location.href=url;
  }
}
