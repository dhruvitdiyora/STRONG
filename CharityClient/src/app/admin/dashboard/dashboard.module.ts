import { CommonModule } from '@angular/common';
import { NgModule } from '@angular/core';
import { NgbDropdownModule } from '@ng-bootstrap/ng-bootstrap';
import { HeaderComponent } from './components/header/header.component';
import { SidebarComponent } from './components/sidebar/sidebar.component';
import { DashboardRoutingModule } from './dashboard-routing.module';
import { DashboardComponent } from './dashboard.component';
import { VerifiedPostsComponent } from './components/verified-posts/verified-posts.component';
import { UnverifiedPostsComponent } from './components/unverified-posts/unverified-posts.component';
import { StateComponent } from './components/state/state.component';
import { CityComponent } from './components/city/city.component';
import { PincodeComponent } from './components/pincode/pincode.component';
import { ClustersComponent } from './components/clusters/clusters.component';
import { RequirementTypeComponent } from './components/requirement-type/requirement-type.component';
import { EventsComponent } from './components/events/events.component';
import { EventPostComponent } from './components/event-post/event-post.component';
import { UsersComponent } from './components/users/users.component';
import { OrganisationsComponent } from './components/organisations/organisations.component';
import { UnverifiedOrgsComponent } from './components/unverified-orgs/unverified-orgs.component';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { NgxPaginationModule } from 'ngx-pagination';

@NgModule({
    imports: [CommonModule, DashboardRoutingModule, NgbDropdownModule, NgxPaginationModule, FormsModule, ReactiveFormsModule],
    declarations: [DashboardComponent, SidebarComponent, HeaderComponent, VerifiedPostsComponent, UnverifiedPostsComponent, StateComponent, CityComponent, PincodeComponent, ClustersComponent, RequirementTypeComponent, EventsComponent, EventPostComponent, UsersComponent, OrganisationsComponent, UnverifiedOrgsComponent]
})
export class DashboardModule { }
