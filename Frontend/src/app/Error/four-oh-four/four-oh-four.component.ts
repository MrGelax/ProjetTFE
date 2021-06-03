import { Component, OnInit } from '@angular/core';
import {ActivatedRoute} from "@angular/router";

@Component({
  selector: 'app-four-oh-four',
  templateUrl: './four-oh-four.component.html',
  styleUrls: ['./four-oh-four.component.css']
})
export class FourOhFourComponent implements OnInit {

  message:string;

  constructor(private route:ActivatedRoute) { }

  ngOnInit(): void {
    this.message=this.route.snapshot.params['message'];
  }

}
