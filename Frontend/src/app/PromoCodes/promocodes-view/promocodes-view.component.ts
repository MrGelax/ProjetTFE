import { Component, OnInit } from '@angular/core';
import { PromoCodesListService } from 'src/app/services/PromoCodes/list.service';
import { ActivatedRoute, Router } from '@angular/router';

@Component({
  selector: 'app-promocodes-view',
  templateUrl: './promocodes-view.component.html',
  styleUrls: ['./promocodes-view.component.css']
})
export class PromocodesViewComponent implements OnInit {

  obj:any;
  views:any[];
  constructor(private promoCodeServ:PromoCodesListService,
    private route:ActivatedRoute,private router:Router) { }

  ngOnInit(): void {
    const id=this.route.snapshot.params['id'];
    if(this.promoCodeServ.getpromoCodeByID(+id)===undefined) {
      this.router.navigate(['/not-found']);  
    }
    this.obj=this.promoCodeServ.getpromoCodeByID(+id);
    console.log(this.obj.Title);
    console.log(id);
  }
  backtoList(){
    this.router.navigate(['/list/'+this.obj.ID]);
  }
  click(url:string){
    window.location.href=url;
  }
}