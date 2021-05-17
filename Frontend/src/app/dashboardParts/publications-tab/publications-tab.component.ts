import { Component, OnInit } from '@angular/core';
import { publicationservice } from 'src/app/services/Validations/publicationList.service';
import { ConfirmationService } from 'primeng/api';
import { FormGroup, FormBuilder, Validators } from '@angular/forms';

@Component({
  selector: 'app-publications-tab',
  templateUrl: './publications-tab.component.html',
  styleUrls: ['./publications-tab.component.css']
})
export class PublicationsTabComponent implements OnInit {
  header:any[];
  publicationList:any[];
  actionList:any[];
  rejectForm:FormGroup;
  constructor(private publiService:publicationservice,private confirmationService:ConfirmationService,
    private formBuilder:FormBuilder) {
  }

  ngOnInit(): void {
    this.header=this.publiService.headers;
    this.publicationList=this.publiService.Publications;
    this.actionList=[10,20,30,40];
    this.actionList.splice(0,this.actionList.length);//peut-être supprimer
    this.rejectForm=this.formBuilder.group({
      content:['',Validators.requiredTrue]
    });
  }
  addToPublicationList(item:any){
    this.actionList.push(+item);
    console.log(this.actionList)
  }
  onSubmit(){
    console.log(this.rejectForm.get('content').value);
    this.rejectForm.reset();
    if(this.actionList.length>=1){
      console.log(this.actionList);
      for(let item of this.actionList){
        let i:number=this.publicationList.findIndex(e=> e.ID===item);
        if (i !== -1) {
          this.publicationList.splice(i,1);
        }
        console.log(item);
      }
      console.log("Validation OK");
      this.actionList.splice(0,this.actionList.length);
    }
  }
  close(){
    this.rejectForm.reset();
  }
  publicationListValidation(){
    this.confirmationService.confirm({
      message: 'Are you sure that you want to reject Customers?',
      accept: () => {
        if(this.actionList.length>=1){
          console.log(this.actionList);
          for(let item of this.actionList){
            let i:number=this.publicationList.findIndex(e=> e.ID===item);
            if (i !== -1) {
              this.publicationList.splice(i,1);
            }
            console.log(item);
          }
          console.log("Rejet OK");
          this.actionList.splice(0,this.actionList.length);
        }
      },reject:()=>{
        console.log("Rejet PAS OK");
      }
    });
  }
}
