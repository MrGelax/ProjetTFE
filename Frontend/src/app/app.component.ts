import { Component, OnInit } from '@angular/core';
import { AuthService } from './services/auth.service';

import * as $ from 'jquery';
import 'datatables.net';
import 'datatables.net-bs4';

@Component({
  selector: 'app-root',
  templateUrl: `./app.component.html`,
  styleUrls: ['./app.component.css']
})
export class AppComponent {
  constructor(private authService:AuthService) { }
}
