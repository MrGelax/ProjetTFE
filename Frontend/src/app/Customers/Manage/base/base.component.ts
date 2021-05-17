import { Component, OnInit } from '@angular/core';
import { CustomerManageService } from 'src/app/services/Customers/customerManage.service';
import { ActivatedRoute, Router } from '@angular/router';
import { MenuItem } from 'primeng/api';

@Component({
  selector: 'app-base',
  templateUrl: './base.component.html',
  styleUrls: ['./base.component.css']
})
export class BaseComponent implements OnInit {

  customerInfo:any;
  customerProfilInfo:any;
  customerBooks:any;
  customerPubliInfos:any;
  customerRevInfos:any;
  customerOrdInfos:any;
  customerComsInfos:any;
  customerServiceInfo:any;
  customerCreditUsesInfo:any;
  customerRecrutementInfo:any;
  customerComments:any;
  constructor(private custom:CustomerManageService,private route:ActivatedRoute,
    private router:Router) { }

  ngOnInit(): void {
    const id=this.route.snapshot.params['id'];
    if(this.custom.getCustomerByID(+id)===undefined){
      this.router.navigate(['/not-found']);
    }else{
      this.customerInfo=this.custom.getCustomerByID(+id);
      this.customerProfilInfo=this.custom.getProfileInfoID(+id);
      this.customerBooks=this.custom.getPortfoliosById(+id);
      this.customerPubliInfos=this.custom.getPubbliInfosById(+id);
      this.customerRevInfos=this.custom.getReviewsInfosById(+id);
      this.customerOrdInfos=this.custom.getOrdersInfosById(+id);
      this.customerComsInfos=this.custom.getComInfosById(+id);
      this.customerServiceInfo=this.custom.getServsInfosById(+id);
      this.customerCreditUsesInfo=this.custom.getCreditUsesInfosById(+id);
      this.customerRecrutementInfo=this.custom.getRecrutementInfoById(+id);
      this.customerComments=this.custom.getComments(+id);
    }
  }
}
