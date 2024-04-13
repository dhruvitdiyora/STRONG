import { Component, OnInit } from '@angular/core';
import { Router, ActivatedRoute } from '@angular/router';
import { ToastrService } from 'ngx-toastr';
import { OrgListDTO } from 'src/app/model/OrgListDTO.model';
import { AuthService } from 'src/app/services/auth.service';
import { ImageService } from 'src/app/services/image.service';


@Component({
  selector: 'app-org-info',
  templateUrl: './org-info.component.html',
  styleUrls: ['./org-info.component.css']
})
export class OrgInfoComponent implements OnInit {

  constructor(private router: Router,
    private activatedRoute: ActivatedRoute,
    private auth: AuthService,
    private image: ImageService,
    private toastr: ToastrService) {
  }

  orgList: OrgListDTO;
  orgsurl: string;
  id: string;
  ids: string[];
  joined: boolean;

  ngOnInit(): void {
    this.getOrg();
    this.orgsurl = this.image.getOrgProfile();
  }

  getOrg() {
    this.activatedRoute.paramMap.subscribe(params => {
      var id = params.get('orgid');
      this.auth.getOrgById(id).subscribe((response) => {
        this.orgList = response.model;
      });
      if(this.auth.getUserReg()){
        this.auth.isJoined(id).subscribe((res) => {

          if (res)
            this.joined = res.message;
        });
      }
    });
  }

  hasRoute() {
    this.id = this.activatedRoute.snapshot.paramMap.get('eventid');
    // this.activatedRoute.queryParams.subscribe(params => {
    // //  this.id = params.get('eventid');
    // //  console.log(this.id);
    // this.id = params['eventid'];
    // console.log(this.id);
    // })
    return this.router.url.includes(this.id);
  }

  addVolunteer(organisation: number) {
    if (this.auth.isUserReg()) {
      this.auth.addVolunteer(
        {
          organisationId: organisation,
          volunteerUserId: 0,
        }
      ).subscribe(
        (response) => {
          this.getOrg();
          this.toastr.success(response.message);
          //this.posts = response;
        },
        (error: any) => {
          console.log(error);
          this.getOrg();
          this.toastr.success(error.message);
          //this.notify.showSuccess("error", error);
        }
      );
    }
    else {
      this.toastr.error("Please Login as User or Create profile properly");
    }
    window.location.reload();

  }
  
}
