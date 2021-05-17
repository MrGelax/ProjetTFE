import { Component, OnInit } from '@angular/core';
import { PromoCodesListService } from 'src/app/services/PromoCodes/list.service';
import { ActivatedRoute, Router } from '@angular/router';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';

@Component({
  selector: 'app-promocodecreate',
  templateUrl: './promocodecreate.component.html',
  styleUrls: ['./promocodecreate.component.css']
})
export class PromocodecreateComponent implements OnInit {
  type:any[];
  form:FormGroup;
  constructor(private promoCodeServ:PromoCodesListService,
    private route:ActivatedRoute,private router:Router,private formBuilder:FormBuilder) { }
  ngOnInit(): void {
    this.type=this.promoCodeServ.type;
    this.form=this.formBuilder.group({
      name:['',Validators.required],
      type:['',Validators.required],
      reduc:['',Validators.required],
      qtMax:['',Validators.required],
      valid_from:['',Validators.required],
      valid_until:['',Validators.required],
      code:['',Validators.required],
      role:this.formBuilder.group({
        talent:this.formBuilder.array([]),
        pro:this.formBuilder.array([])
      }),
      product:this.formBuilder.group({
        belgique:this.formBuilder.array([]),
        belgium:this.formBuilder.array([]),
        fr:this.formBuilder.array([]),
        uk:this.formBuilder.array([]),
      })
    });
  }
  onSubmit(){
    console.log('Données du formulaire',this.form.value); 
  }
}