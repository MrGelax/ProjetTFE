import { Component, OnInit, Input } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { ConfirmationService } from 'primeng/api';

@Component({
  selector: 'app-communication-info',
  templateUrl: './communication-info.component.html',
  styleUrls: ['./communication-info.component.css']
})
export class CommunicationInfoComponent implements OnInit {

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
        let i:number=this.obj.communications.findIndex(e=> e.id===+id);
        this.obj.communications.splice(i,1);
        console.log("Supression OK"); 
      },reject:()=>{
        console.log("Suppression PAS OK");
      }
  });
  }
}

