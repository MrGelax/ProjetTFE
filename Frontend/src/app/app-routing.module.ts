import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
//import {BlocksCreateComponent} from './blocks-create/blocks-create.component';

const routes: Routes = [
  //{path: 'blocks', component: BlocksCreateComponent}
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
//export const routingComponents = [BlocksCreateComponent]
