import { Component, OnInit, Input } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { ConfirmationService } from 'primeng/api';
import { FormGroup, FormBuilder, Validators } from '@angular/forms';
import { CreateService } from 'src/app/services/create.service';

@Component({
  selector: 'app-comments',
  templateUrl: './comments.component.html',
  styleUrls: ['./comments.component.css']
})
export class CommentsComponent implements OnInit {
  @Input()
  obj:any;
  form:FormGroup;
  user:any;
  constructor(private route:ActivatedRoute,private router:Router,
    private confirmationService:ConfirmationService,private formBuilder:FormBuilder) { }

  ngOnInit(): void {
    this.form=this.formBuilder.group({
      content:['',Validators.required],
      user:['Marc',Validators.required],
    });
  }
  onSubmit(){
    this.obj.comments.push({
      id:750,
      created:(new Date).getDate(),
      content:this.form.get('content').value,
      userBO:this.form.get('user').value
    });
    console.log("Bonjour");
  }
}

