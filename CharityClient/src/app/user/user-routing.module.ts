import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { NotFoundComponent } from '../not-found/not-found.component';
import { AuthGuardGuard } from '../services/auth-guard.guard';
import { AboutUsComponent } from './about-us/about-us.component';
import { ClusterComponent } from './cluster/cluster.component';
import { CreatePostComponent } from './create-post/create-post.component';
import { PostDetailComponent } from './post-detail/post-detail.component';
import { PostHomeComponent } from './post-home/post-home.component';
import { PostComponent } from './post/post.component';
import { ProfileDetailComponent } from './profile-detail/profile-detail.component';
import { ProfileComponent } from './profile/profile.component';
import { CreateEventComponent } from './user-org/create-event/create-event.component';
import { EventIdComponent } from './user-org/event-id/event-id.component';
import { EventComponent } from './user-org/event/event.component';
import { OrgInfoComponent } from './user-org/org-info/org-info.component';
import { OrgMainComponent } from './user-org/org-main/org-main.component';
import { OrgProfileComponent } from './user-org/org-profile/org-profile.component';
import { OrganisationComponent } from './user-org/organisation/organisation.component';
import { VolunteerComponent } from './user-org/volunteer/volunteer.component';
import { UserComponent } from './user.component';

const routes: Routes = [
  
  {
    path: '', component: UserComponent,
    
    
    children: [
      { path: '', redirectTo: '/home', pathMatch: 'full' },
      { path: 'orgprofile', component: OrgProfileComponent,canActivate: [AuthGuardGuard]},
      { path: 'detail', component: PostDetailComponent},
      { path: 'post', component: PostHomeComponent, },
      { path: 'post/:postid', component: PostDetailComponent, },
      { path: 'home', component: PostHomeComponent },
      { path: 'organisation', component: OrgMainComponent },
      { path: 'profile', component: ProfileComponent,canActivate: [AuthGuardGuard] },
      { path: 'profile/:profileid', component: ProfileDetailComponent, canActivate: [AuthGuardGuard]},
      {path:'cluster',component:ClusterComponent, canActivate: [AuthGuardGuard],},
      { path: 'about-us', component: AboutUsComponent},
      { path: 'organisation/:orgid', component: OrganisationComponent, canActivate: [AuthGuardGuard],
      children: [
              // { path: '', component: EventComponent },
              {
                path: 'event', component: EventComponent,canActivate: [AuthGuardGuard],
                // children: [
                //   { path: ':eventid', component: EventIdComponent, },
                // ]
              },
              { path: 'event/:eventid', component: EventIdComponent, canActivate: [AuthGuardGuard],},
              { path: 'volunteer', component: VolunteerComponent, canActivate: [AuthGuardGuard], },
              ///{ path: '**',   component: NotFoundComponent},
              
            ]
      },
      //{ path: '**',   component: NotFoundComponent},
    ]
  },


];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class UserRoutingModule { }
