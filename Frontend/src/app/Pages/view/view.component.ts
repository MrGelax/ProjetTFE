import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { ListService } from '../../services/list.service';
import { ViewService } from '../../services/view.service';

@Component({
  selector: 'app-view',
  templateUrl: './view.component.html',
  styleUrls: ['./view.component.css']
})
export class ViewComponent implements OnInit {

  obj:any;
  views:any[];
  constructor(private viewtService:ViewService,
    private route:ActivatedRoute,private router:Router) { }

  ngOnInit(): void {
    const id=this.route.snapshot.params['id'];
    if(this.viewtService.getPageByID(+id)===undefined) {
      this.router.navigate(['/not-found']);  
    }
    this.obj=this.viewtService.getPageByID(+id);
    this.views=this.viewtService.views;
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
