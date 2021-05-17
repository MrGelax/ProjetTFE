import { Component, OnInit, ComponentFactoryResolver } from '@angular/core';
import { FormGroup, FormBuilder, Validators} from '@angular/forms';
import { PromoCodesListService } from 'src/app/services/PromoCodes/list.service';
import { ActivatedRoute, Router } from '@angular/router';

@Component({
  selector: 'app-promocode-edit',
  templateUrl: './promocode-edit.component.html',
  styleUrls: ['./promocode-edit.component.css']
})
export class PromocodeEditComponent implements OnInit {
  type:any[];
  formulaire:FormGroup;
  obj:any;
  constructor(private promoCodeServ:PromoCodesListService,
    private route:ActivatedRoute,private router:Router,private formBuilder:FormBuilder) { }
  ngOnInit(): void {
    const id=this.route.snapshot.params['id'];
    this.obj=this.promoCodeServ.getpromoCodeByID(+id);
    this.type=this.promoCodeServ.type;
    console.log(this.obj);

    this.formulaire=this.formBuilder.group({
      name:[this.obj.Name,Validators.required],
      type:[this.obj.Type,Validators.required],
      reduc:[this.obj.Reduction,Validators.required],
      qtMax:[this.obj.qtMax,Validators.required],
      valid_from:[this.obj.Valid_from,Validators.required],
      valid_until:[this.obj.Valid_until,Validators.required],
      code:[this.obj.Code,Validators.required],
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

  }
}
