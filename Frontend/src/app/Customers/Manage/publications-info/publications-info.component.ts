import { Component, OnInit, Input } from '@angular/core';
import { Router, ActivatedRoute } from '@angular/router';
import { ConfirmationService } from 'primeng/api';

@Component({
  selector: 'app-publications-info',
  templateUrl: './publications-info.component.html',
  styleUrls: ['./publications-info.component.css']
})
export class PublicationsInfoComponent implements OnInit {

  @Input()
  obj:any;
  listToDelete:number[];

  constructor(private route:ActivatedRoute,private router:Router,
    private confirmationService:ConfirmationService) { }

  ngOnInit(): void {
    this.listToDelete=[10,20,30,40];
    this.listToDelete.splice(0,this.listToDelete.length); 
  }
  deleteToList(id:any){
    this.confirmationService.confirm({
      message: 'Are you sure that you want to delete the item?',
      accept: () => {
        let i:number=this.obj.publis.findIndex(e=> e.id===+id);
        this.obj.publis.splice(i,1);
        console.log("Supression OK");
      },reject:()=>{
        console.log("Suppression PAS OK");
      }
  });
  }
}
