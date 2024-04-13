import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { AdminGuard } from '../shared/services/admin-guard.guard';
import { CityComponent } from './components/city/city.component';
import { ClustersComponent } from './components/clusters/clusters.component';
import { EventPostComponent } from './components/event-post/event-post.component';
import { EventsComponent } from './components/events/events.component';
import { OrganisationsComponent } from './components/organisations/organisations.component';
import { PincodeComponent } from './components/pincode/pincode.component';
import { RequirementTypeComponent } from './components/requirement-type/requirement-type.component';
import { StateComponent } from './components/state/state.component';
import { UnverifiedOrgsComponent } from './components/unverified-orgs/unverified-orgs.component';
import { UnverifiedPostsComponent } from './components/unverified-posts/unverified-posts.component';
import { UsersComponent } from './components/users/users.component';
import { VerifiedPostsComponent } from './components/verified-posts/verified-posts.component';
import { DashboardComponent } from './dashboard.component';

const routes: Routes = [
    {
        path: '',
        component: DashboardComponent,
        children: [
            { path: '', redirectTo: 'unverified-posts', pathMatch: 'prefix' },
            // {
            //     path: 'home',
            //     loadChildren: () => import('./admin-home/admin-home.module').then((m) => m.AdminHomeModule),
            //     canActivate: [AdminGuard]
            // },
            // {
            //     path: 'charts',
            //     loadChildren: () => import('./admin-home/admin-home.module').then((m) => m.AdminHomeModule),
            //     canActivate: [AdminGuard]
            // },
            { path: 'verified-posts', component: VerifiedPostsComponent, canActivate: [AdminGuard] },
            { path: 'unverified-posts', component: UnverifiedPostsComponent, canActivate: [AdminGuard] },
            { path: 'states', component: StateComponent, canActivate: [AdminGuard] },
            { path: 'city', component: CityComponent, canActivate: [AdminGuard] },
            { path: 'pincode', component: PincodeComponent, canActivate: [AdminGuard] },
            { path: 'clusters', component: ClustersComponent, canActivate: [AdminGuard] },
            { path: 'requirement-type', component: RequirementTypeComponent, canActivate: [AdminGuard] },
            { path: 'users', component: UsersComponent, canActivate: [AdminGuard] },
            { path: 'organisations', component: OrganisationsComponent, canActivate: [AdminGuard] },
            { path: 'unverified-orgs', component: UnverifiedOrgsComponent, canActivate: [AdminGuard] },
            { path: 'events', component: EventsComponent, canActivate: [AdminGuard] },
            { path: 'event-post', component: EventPostComponent, canActivate: [AdminGuard] },

            //{ path: 'not-found', component: NotFoundComponent },

        ]
        // children: [
        //     { path: '', redirectTo: 'dashboard', pathMatch: 'prefix' },
        //     {
        //         path: 'dashboard',
        //         loadChildren: () => import('./dashboard/dashboard.module').then((m) => m.DashboardModule)
        //     },
        //     { path: 'charts', loadChildren: () => import('./charts/charts.module').then((m) => m.ChartsModule) },
        //     { path: 'tables', loadChildren: () => import('./tables/tables.module').then((m) => m.TablesModule) },
        //     { path: 'forms', loadChildren: () => import('./form/form.module').then((m) => m.FormModule) },
        //     {
        //         path: 'bs-element',
        //         loadChildren: () => import('./bs-element/bs-element.module').then((m) => m.BsElementModule)
        //     },
        //     { path: 'grid', loadChildren: () => import('./grid/grid.module').then((m) => m.GridModule) },
        //     {
        //         path: 'components',
        //         loadChildren: () => import('./bs-component/bs-component.module').then((m) => m.BsComponentModule)
        //     },
        //     {
        //         path: 'blank-page',
        //         loadChildren: () => import('./blank-page/blank-page.module').then((m) => m.BlankPageModule)
        //     }
        // ]
    }
];

@NgModule({
    imports: [RouterModule.forChild(routes)],
    exports: [RouterModule]
})
export class DashboardRoutingModule { }
