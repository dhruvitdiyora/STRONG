import {
  NgModule,
  NO_ERRORS_SCHEMA,
  CUSTOM_ELEMENTS_SCHEMA,
} from "@angular/core";
import { CommonModule } from "@angular/common";

import { UserRoutingModule } from "./user-routing.module";
import { UserComponent } from "./user.component";
import { EventsComponent } from "./events/events.component";
import { PostComponent } from "./post/post.component";
import { ProfileComponent } from "./profile/profile.component";
import { PostHomeComponent } from "./post-home/post-home.component";
import { NavbarComponent } from "./navbar/navbar.component";
import { NgbModule } from "@ng-bootstrap/ng-bootstrap";
import { RightbarComponent } from "./rightbar/rightbar.component";
import { LeftbarComponent } from "./leftbar/leftbar.component";
import { PostInfoComponent } from "./post-info/post-info.component";
import { DateAgoPipe } from "../pipes/date-ago.pipe";
import { OrganisationComponent } from "./user-org/organisation/organisation.component";
import { EventComponent } from "./user-org/event/event.component";
import { VolunteerComponent } from "./user-org/volunteer/volunteer.component";
import { EventIdComponent } from "./user-org/event-id/event-id.component";
import { OrgLeftbarComponent } from "./user-org/org-leftbar/org-leftbar.component";
import { OrgInfoComponent } from "./user-org/org-info/org-info.component";
import { FormsModule, ReactiveFormsModule } from "@angular/forms";
import { CreatePostComponent } from "./create-post/create-post.component";
import { NgxGalleryModule } from "@kolkov/ngx-gallery";
import { TabsModule } from "ngx-bootstrap/tabs";
import { PostDetailComponent } from "./post-detail/post-detail.component";
import { OrgMainComponent } from "./user-org/org-main/org-main.component";
import { OrgListComponent } from "./user-org/org-list/org-list.component";
import { ClusterInfoComponent } from "./cluster-info/cluster-info.component";
import { ClusterComponent } from "./cluster/cluster.component";
import { AgmCoreModule } from "@agm/core";
import { ProfileDetailComponent } from "./profile-detail/profile-detail.component";
import { UserPostComponent } from "./user-post/user-post.component";
import { AboutUsComponent } from "./about-us/about-us.component";
import { CreateEventComponent } from "./user-org/create-event/create-event.component";
import { ProfilepostComponent } from "./profilepost/profilepost.component";
import { OrgProfileComponent } from "./user-org/org-profile/org-profile.component";
import { NoDataComponent } from "./no-data/no-data.component";
import { InfiniteScrollModule } from "ngx-infinite-scroll";

@NgModule({
  declarations: [
    UserComponent,
    OrganisationComponent,
    EventsComponent,
    PostComponent,
    ProfileComponent,
    PostHomeComponent,
    NavbarComponent,
    RightbarComponent,
    LeftbarComponent,
    PostInfoComponent,
    DateAgoPipe,
    OrganisationComponent,
    EventComponent,
    VolunteerComponent,
    EventIdComponent,
    OrgLeftbarComponent,
    OrgInfoComponent,
    CreatePostComponent,
    PostDetailComponent,
    OrgMainComponent,
    OrgListComponent,
    ClusterInfoComponent,
    ClusterComponent,
    ProfileDetailComponent,
    UserPostComponent,
    AboutUsComponent,
    CreateEventComponent,
    ProfilepostComponent,
    OrgProfileComponent,
    NoDataComponent,
  ],
  imports: [
    CommonModule,
    UserRoutingModule,
    NgbModule,
    FormsModule,
    ReactiveFormsModule,
    NgxGalleryModule,
    TabsModule,
    InfiniteScrollModule,
    AgmCoreModule.forRoot({
      apiKey: "token",
    }),
  ],
  schemas: [CUSTOM_ELEMENTS_SCHEMA, NO_ERRORS_SCHEMA],
})
export class UserModule {}
