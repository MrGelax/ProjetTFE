import { Component, OnInit } from '@angular/core';
import { ProductsListService } from 'src/app/services/Products/list.service';
import { ActivatedRoute, Router } from '@angular/router';

@Component({
  selector: 'app-product-view',
  templateUrl: './product-view.component.html',
  styleUrls: ['./product-view.component.css']
})
export class ProductViewComponent implements OnInit {
  obj:any;
  constructor(private prodService:ProductsListService,
    private route:ActivatedRoute,private router:Router) { }

  ngOnInit(): void {
    const id=this.route.snapshot.params['id'];
    if(this.prodService.getProducsByID(+id)===undefined) {
      this.router.navigate(['/not-found']);  
    }
    this.obj=this.prodService.getProducsByID(+id);
    console.log(this.obj.Title);
    console.log(id);
  }
  delete(){
    this.router.navigate(['Product/list']);
  }
  click(url:string){
    window.location.href=url;
  }
}
