import { BrowserModule } from '@angular/platform-browser';
import{BrowserAnimationsModule}from '@angular/platform-browser/animations';
import { APP_INITIALIZER, NgModule } from '@angular/core';

import {CKEditorModule} from "ckeditor4-angular";
import { KeycloakSecurityService } from './services/Keycloak/keycloak-security.service';
 
import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { NavbarComponent } from './navbar/navbar.component';
import { TopBarComponent } from './top-bar/top-bar.component';
import { ListComponent } from './Pages/list/list.component';
import { CreateComponent } from './Pages/create/create.component';
import { ViewComponent } from './Pages/view/view.component';
import { DashboardComponent } from './dashboard/dashboard.component';
import { RejectModalComponent } from './Pages/reject-modal/reject-modal.component';
import {RatingModule} from 'primeng/rating';
import{AuthService}from './services/auth.service';
import { CustomerTabComponent } from './dashboardParts/customer-tab/customer-tab.component';
import { PortfoliosTabComponent } from './dashboardParts/portfolios-tab/portfolios-tab.component';
import { ReviewComponent } from './dashboardParts/review/review.component';
import { OrdersListComponent } from './Orders/orders-list/orders-list.component';
import { PublicationsTabComponent } from './dashboardParts/publications-tab/publications-tab.component';
import { CastingTabComponent } from './dashboardParts/casting-tab/casting-tab.component';
import { ServiceTabComponent } from './dashboardParts/service-tab/service-tab.component';
import { CastingsService } from './services/Validations/castingList.service';
import { CustomerListService } from './services/Customers/customerList.service';
import { ValCustomerListService } from './services/Validations/customerList.service';
import {CustomerService} from "./services/Customers/customer.service";
import {EventService} from "./services/Event/event.service";
import {PublicationService} from "./services/Publication/publication.service";
import {ReviewService} from "./services/Review/review.service";
import {CustomerServicesService} from "./services/CustomerServices/customerServices.service";
import {PortfoliosService} from "./services/Portfolios/portfolios.service";

import { CustomerBasicService} from './services/Customers/customerBasic.service';
import { OdersService } from './services/Validations/ordersList.service';
import { portfoliosService } from './services/Validations/portfoliosList.service';
import { publicationservice } from './services/Validations/publicationList.service';
import { reviewService } from './services/Validations/review.service';
import { servicesService } from './services/Validations/servicesList.service';
import { AuthComponent } from './auth/auth.component';
import {AccordionModule} from 'node_modules/primeng/accordion';
import {TableModule} from 'node_modules/primeng/table';
import { CreateService } from './services/Pages/create.service';
import { ListService } from './services/list.service';
import { ViewService } from './services/view.service';
import { ConfirmationService } from 'primeng/api';
import {ConfirmDialogModule} from 'primeng/confirmdialog';
import { EditComponent } from './Pages/edit/edit.component';
import { BlockCreateComponent } from './Blocks/block-create/block-create.component';
import { BlockEditComponent } from './Blocks/block-edit/block-edit.component';
import { BlockListComponent } from './Blocks/block-list/block-list.component';
import { BlockViewComponent } from './Blocks/block-view/block-view.component';
import { OrdersManageComponent } from './Orders/orders-manage/orders-manage.component';
import { OrderListService } from './services/Orders/list.service';
import { BlockService } from './services/Blocks/block.service';
import { PagesService } from './services/Pages/pages.service';
import { OrdersTabComponent } from './dashboardParts/orders-tab/orders-tab.component';
import { TestComponent } from './test/test.component';
import { FormulaireComponent } from './Pages/create/formulaire/formulaire.component';
import { BaseComponent } from './Customers/Manage/base/base.component';
import { CustomerInfosComponent } from './Customers/Manage/customer-infos/customer-infos.component';

import {DropdownModule} from 'primeng/dropdown';
import { CustomerManageService } from './services/Customers/customerManage.service';
import { ProfileInformationComponent } from './Customers/Manage/profile-information/profile-information.component';
import { CustomerInfoEditComponent } from './Customers/Manage/customer-info-edit/customer-info-edit.component';
import { FourOhFourComponent } from './Error/four-oh-four/four-oh-four.component';
import {CalendarModule} from 'primeng/calendar';
import { ProfileInfoEditComponent } from './Customers/Manage/profile-info-edit/profile-info-edit.component';
import { PublicationsInfoComponent } from './Customers/Manage/publications-info/publications-info.component';
import { ReviewInfoComponent } from './Customers/Manage/review-info/review-info.component';
import { CommunicationInfoComponent } from './Customers/Manage/communication-info/communication-info.component';
import { OrdersInfoComponent } from './Customers/Manage/orders-info/orders-info.component';
import { BooksInfoComponent } from './Customers/Manage/books-info/books-info.component';
import { ServiceInfoComponent } from './Customers/Manage/service-info/service-info.component';
import { RecrutementsInfoComponent } from './Customers/Manage/recrutements-info/recrutements-info.component';
import { CreditsUsesInfoComponent } from './Customers/Manage/credits-uses-info/credits-uses-info.component';
import { CommentsComponent } from './Customers/Manage/comments/comments.component';
import { Routes, RouterModule } from '@angular/router';
import { ReactiveFormsModule, FormsModule } from '@angular/forms';
import { BasicComponent } from './Customers/basic/basic.component';
import { CustomerListComponent } from './Customers/customer-list/customer-list.component';
import {FileUploadModule} from 'primeng/fileupload';
import {HTTP_INTERCEPTORS,HttpClientModule} from '@angular/common/http';
import {InputMaskModule} from 'primeng/inputmask';

import {MultiSelectModule} from 'primeng/multiselect';
import {SliderModule} from 'primeng/slider';
import {SplitButtonModule} from 'primeng/splitbutton';
import {TabMenuModule} from 'primeng/tabmenu';
import {MenuItem} from 'primeng/api';
import { from } from 'rxjs';

import {SidebarModule} from 'primeng/sidebar';
import { OrderCreateComponent } from './Orders/create/create.component';
import { ProductsListComponent } from './Products/products-list/products-list.component';
import { ProductCreateComponent } from './Products/product-create/product-create.component';
import { ProductsListService } from './services/Products/list.service';
import { ProductViewComponent } from './Products/product-view/product-view.component';
import { PromocodesListComponent } from './PromoCodes/promocodes-list/promocodes-list.component';
import { PromocodecreateComponent } from './PromoCodes/promocodecreate/promocodecreate.component';
import { PromocodesViewComponent } from './PromoCodes/promocodes-view/promocodes-view.component';
import { PromoCodesListService } from './services/PromoCodes/list.service';
import { CustomerCreateComponent } from './Customers/customer-create/customer-create.component'; 
import { ProductEditComponent } from './Products/product-edit/product-edit.component';
// import { PromocodeEditComponent } from './PromoCodes/promocode-edit/promocode-edit.component';

import { ProfileItemsComponent } from './profile-items/profile-items.component';
import {RadioButtonModule} from 'primeng/radiobutton';
import {ButtonModule} from 'primeng/button';
import {DragDropModule} from 'primeng/dragdrop';
import {CheckboxModule} from 'primeng/checkbox';
import {InputTextModule} from 'primeng/inputtext';
import {TieredMenuModule} from 'primeng/tieredmenu';


export function kcFactory(kcSecurity:KeycloakSecurityService){
  return()=>kcSecurity.init();
}

const appRoutes:Routes=[
  {path:'Pages/create',component:CreateComponent},
  {path:'Pages/view/:id',component:ViewComponent},
  {path:'Pages/list',component:ListComponent},
  {path:'Pages/list/:id',component:ListComponent},
  {path:'Pages/edit',component:EditComponent}, 
  
  {path:'Blocks/create',component:BlockCreateComponent},
  {path:'Blocks/edit/:id',component:BlockEditComponent},
  {path:'Blocks/view/:id',component:BlockViewComponent},
  {path:'Blocks/list',component:BlockListComponent},
  {path:'Blocks/list/:id',component:BlockListComponent},

  {path:'Orders/list',component:OrdersListComponent},
  {path:'Orders/view/:id',component:OrdersManageComponent},
  {path:'Orders/create',component:OrderCreateComponent},
  {path:'validation',component:DashboardComponent},

  {path:'Customer/basics',component:BasicComponent},
  {path:'Customer/list',component:CustomerListComponent},
  {path:'Customer/create',component:CustomerCreateComponent},
  {path:'Customer/view/:id',component:BaseComponent},
  {path:'Customer/edit/:id',component:CustomerInfoEditComponent},
  {path:"CustomerProfilInfo/edit/:id",component:ProfileInfoEditComponent},

  {path:"Product/list",component:ProductsListComponent},
  {path:"Product/create",component:ProductCreateComponent},
  {path:"Product/view/:id",component:ProductViewComponent},
  {path:"Product/edit/:id",component:ProductEditComponent},

  {path:"PromoCodes/list",component:PromocodesListComponent},
  {path:"PromoCodes/create",component:PromocodecreateComponent},
  {path:"PromoCodes/view/:id",component:PromocodesViewComponent},
  //{path:"PromoCodes/edit/:id",component:PromocodeEditComponent},

  {path:'ProfileItems', component:ProfileItemsComponent},

  
  {path:'not-found',component:FourOhFourComponent},
  {path:'',component:DashboardComponent}
];

@NgModule({
  declarations: [
    AppComponent,
    NavbarComponent,
    TopBarComponent,
    ListComponent,
    CreateComponent,
    ViewComponent,
    DashboardComponent,
    RejectModalComponent,
    CustomerTabComponent,
    PortfoliosTabComponent,
    ReviewComponent,
    OrdersListComponent,
    PublicationsTabComponent,
    CastingTabComponent,
    ServiceTabComponent,
    AuthComponent,
    EditComponent,
    BlockCreateComponent,
    BlockEditComponent,
    BlockListComponent,
    BlockViewComponent,
    OrdersManageComponent,
    OrdersTabComponent,
    TestComponent,
    FormulaireComponent,
    BaseComponent,
    CustomerInfosComponent,
    ProfileInformationComponent,
    CustomerInfoEditComponent,
    FourOhFourComponent,
    ProfileInfoEditComponent,
    PublicationsInfoComponent,
    ReviewInfoComponent,
    CommunicationInfoComponent,
    OrdersInfoComponent,
    OrderCreateComponent,
    BooksInfoComponent,
    ServiceInfoComponent,
    RecrutementsInfoComponent,
    CreditsUsesInfoComponent,
    CommentsComponent,
    BasicComponent,
    CustomerListComponent,
    ProductsListComponent,
    ProductCreateComponent,
    ProductViewComponent,
    PromocodesListComponent,
    PromocodecreateComponent,
    PromocodesViewComponent,
    CustomerCreateComponent,
    ProductEditComponent,
    // PromocodeEditComponent, 
    ProfileItemsComponent
    
  ],
  imports: [
    ConfirmDialogModule,
    BrowserModule,
    BrowserAnimationsModule,
    AppRoutingModule,
    FormsModule,
    CKEditorModule,   
    AccordionModule,
    TableModule,
    ReactiveFormsModule,
    DropdownModule,
    RatingModule,
    SplitButtonModule,
    MultiSelectModule,
    SliderModule,
    CalendarModule,
    TabMenuModule,
    FileUploadModule,
    HttpClientModule,
    InputMaskModule,
    SidebarModule,
    RadioButtonModule,
    ButtonModule,
    DragDropModule,
    CheckboxModule,
    InputTextModule,
    TieredMenuModule,
    RouterModule.forRoot(appRoutes,{
      anchorScrolling: 'enabled'
    })
  ],
  providers: [
    {provide: APP_INITIALIZER,deps:[KeycloakSecurityService],useFactory:kcFactory,multi:true},
    //{provide: HTTP_INTERCEPTORS,useClass:KeycloakHttpInterceptorService,multi:true},
    PromoCodesListService,
    ValCustomerListService,
    AuthService,
    CastingsService,
    CustomerListService,
    CustomerBasicService,
    OdersService,
    portfoliosService,
    publicationservice,
    reviewService,
    servicesService,
    CreateService,
    CustomerService,
    ListService,
    ViewService,
    ConfirmationService,
    OrderListService,
    BlockService,
    PagesService,
    EventService,
    PublicationService,
    CustomerServicesService,
    PortfoliosService,
    ReviewService,
    CustomerManageService,
    ProductsListService,
    HttpClientModule
  ],
  bootstrap: [AppComponent]
})
export class AppModule { }