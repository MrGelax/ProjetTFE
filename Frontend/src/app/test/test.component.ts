import { Component, OnInit } from '@angular/core';
import { FormGroup, FormBuilder, Validators } from '@angular/forms';

@Component({
  selector: 'app-test',
  templateUrl: './test.component.html',
  styleUrls: ['./test.component.css']
})
export class TestComponent implements OnInit {

  registerForm:FormGroup;
  submited=false;
  constructor(private formBuilder:FormBuilder) { }

  ngOnInit(): void {
    this.registerForm=this.formBuilder.group({
      protected:[false,Validators.requiredTrue],
      systemName:['',Validators.required],
      label:['',Validators.required],
      active:[false,Validators.requiredTrue],
      title:['',Validators.required],
      contentMain:['',Validators.required],
      metaTitle:[],
      metaUrl:[],
      metaDescription:[],
      metaContent:[]
    });
  }
  onSubmit(){
    console.log('Données du formulaire',this.registerForm.value);
  }

}
