import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { AdminGuard } from './admin/shared/services/admin-guard.guard';
import { NotFoundComponent } from './not-found/not-found.component';
import { ServerErrorComponent } from './shared/component/server-error/server-error.component';
import { LoginComponent } from './shared/login/login.component';
import { ClusterComponent } from './user/cluster/cluster.component';
import { PostComponent } from './user/post/post.component';
import { ProfileComponent } from './user/profile/profile.component';
import { CreatePostComponent } from './user/create-post/create-post.component';

const routes: Routes = [
  //{ path: '', redirectTo: '/admin', pathMatch: 'full' },

 
  // { path: 'organisation/event', component: EventComponent,}
  { path: 'not-found', component: NotFoundComponent },
  { path: 'server-error', component: ServerErrorComponent },
  {
    path: 'admin',
    loadChildren: () => import('./admin/dashboard/dashboard.module').then((m) => m.DashboardModule),
    canActivate: [AdminGuard]
  },
  { path: 'adminLogin', loadChildren: () => import('./admin/shared/admin-login/admin-login.module').then((m) => m.AdminLoginModule) },
  { path: 'adminSignup', loadChildren: () => import('./admin/shared/admin-sign-up/admin-signup.module').then((m) => m.AdminSignupModule) },
  { path: '', loadChildren: () => import('./user/user.module').then(m => m.UserModule) },
  // { path: '**',   component: NotFoundComponent},

];

@NgModule({
  imports: [RouterModule.forRoot(routes, { enableTracing: false })],
  exports: [RouterModule]
})
export class AppRoutingModule { }
