import { Component, OnInit, Input } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { ConfirmationService } from 'primeng/api';

@Component({
  selector: 'app-recrutements-info',
  templateUrl: './recrutements-info.component.html',
  styleUrls: ['./recrutements-info.component.css']
})
export class RecrutementsInfoComponent implements OnInit {

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
      message: 'Are you sure that you want to delete those Publications?',
      accept: () => {
        let i:number=this.obj.recruts.findIndex(e=> e.id===+id);
        this.obj.recruts.splice(i,1);
        console.log("Supression OK");
      },reject:()=>{
        console.log("Suppression PAS OK");
      }
  });
  }
}
