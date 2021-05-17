import { Component, OnInit } from '@angular/core';
import { portfoliosService } from 'src/app/services/Validations/portfoliosList.service';
import { ConfirmationService } from 'primeng/api';
import { FormGroup, FormBuilder, Validators } from '@angular/forms';

@Component({
  selector: 'app-portfolios-tab',
  templateUrl: './portfolios-tab.component.html',
  styleUrls: ['./portfolios-tab.component.css']
})
export class PortfoliosTabComponent implements OnInit {
  header:any[];
  portfoliosList:any[]
  actionList:any[];
  rejectForm:FormGroup;
  constructor(private portfoService:portfoliosService,private confirmationService:ConfirmationService,
    private formBuilder:FormBuilder) { }

  ngOnInit(): void {
    this.header=this.portfoService.headers;
    this.portfoliosList=this.portfoService.PortfoliosList;
    this.actionList=[10,20,30,40];
    this.actionList.splice(0,this.actionList.length);//peut-être supprimer
    this.rejectForm=this.formBuilder.group({
      content:['',Validators.requiredTrue]
    });
  }
  addToPortfoliosList(item:any){
    this.actionList.push(+item);
    console.log(this.actionList)
  }

  onSubmit(){
    console.log(this.rejectForm.get('content').value);
    this.rejectForm.reset();
    if(this.actionList.length>=1){
      console.log(this.actionList);
      for(let item of this.actionList){
        let i:number=this.portfoliosList.findIndex(e=> e.ID===item);
        if (i !== -1) {
          this.portfoliosList.splice(i,1);
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
  portfoliosListValidation(){
    this.confirmationService.confirm({
      message: 'Are you sure that you want to reject Customers?',
      accept: () => {
        if(this.actionList.length>=1){
          console.log(this.actionList);
          for(let item of this.actionList){
            let i:number=this.portfoliosList.findIndex(e=> e.ID===item);
            if (i !== -1) {
              this.portfoliosList.splice(i,1);
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