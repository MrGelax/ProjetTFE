import { Component, OnInit, Input } from '@angular/core';
import { CustomerManageService } from 'src/app/services/Customers/customerManage.service';
import { ActivatedRoute, Router } from '@angular/router';

@Component({
  selector: 'app-profile-information',
  templateUrl: './profile-information.component.html',
  styleUrls: ['./profile-information.component.css']
})
export class ProfileInformationComponent implements OnInit {
  @Input()
  obj:any;
  constructor(private route:ActivatedRoute,private router:Router) { }

  ngOnInit(): void {
  }
}

