import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { ToastrService } from 'ngx-toastr';
import { cities } from 'src/app/model/allcity.modal';
import { EventListDTO } from 'src/app/model/EventListDTO.model';
import { State } from 'src/app/model/State.model';
import { AuthService } from 'src/app/services/auth.service';
import { ImageService } from 'src/app/services/image.service';

@Component({
  selector: 'app-org-profile',
  templateUrl: './org-profile.component.html',
  styleUrls: ['./org-profile.component.css']
})
export class OrgProfileComponent implements OnInit {
  orgData: any;
  orgUrl: string;
  cities: cities[];
  states: State[];
  pincode: number;
  pinVal = false;
  imageURL: string = '';
  file: any;
  submitted = false;
  uid = 0;
  city: string;
  state: string;
  hide = false;
  show = true;
  posts: any;
  length: number;
  userCheck = false;
  postUrl: string;
  change() {
    this.hide = true;
    this.show = false;
  }


  constructor(private fb: FormBuilder,
    private auth: AuthService,
    private image: ImageService,
    private activatedRoute: ActivatedRoute,
    private toaster: ToastrService,
    private router: Router) { }
  orgDetailForm: FormGroup;

  ngOnInit(): void {
    if (this.auth.isOrganisation()) {

      this.getOrgDetails();
      this.orgUrl = this.image.getOrgProfile();
      this.orgDetailForm = this.fb.group({
        organisationUserId: ['', Validators.required],
        organisationUserName: ['', Validators.required],
        organisationName: ['', Validators.required],
        organisationAddress: ['', Validators.required],
        OrganisatioWebURL: ['', Validators.required],
        OrganisationLogoURL: [null],
        OrganisationContactNo: [null, Validators.required],
        OrganisationDetail: [null, Validators.required]
      })
    }
    else {
      this.toaster.error("you can not edit  organisation")
      this.router.navigate(['/']);
    }

  }



  setImage(event) {
    const file = (event.target as HTMLInputElement).files[0];
    this.file = event.target.files[0];

    this.orgDetailForm.patchValue({
      preview: file
    });

  }


  getOrgDetails() {
    this.auth.getOrgData().subscribe(
      (response) => {

        //console.log(this.userCheck);
         this.orgData = response;
        this.orgDetailForm.patchValue({
          OrganisationContactNo: response.mobileNo,
          organisationUserName: response.userName,
          organisationUserId: response.organisationId,
        })
        if (response.organisationData != null) {
          this.userCheck = true;
          // this.uid = response.userData.userId;
          this.orgDetailForm.patchValue({
            userId: response.userID,
            organisationName: response.organisationData[0].organisationName,
            OrganisationDetail: response.organisationData[0].organisationDetail,
            organisationAddress: response.organisationData[0].organisationAddress,
            OrganisatioWebURL: response.organisationData[0].organisatioWebUrl,
            OrganisationLogoURL: response.organisationData[0].organisationLogoUrl,
          })
          this.uid = response.organisationData[0].organisationDataId;
          this.length = (response.organisationData.length);
        }
      },
      (error: any) => {
        console.log(error);
      }
    );
  }
  editUser() {
    if (this.uid == 0) {
      const fd = new FormData();
      fd.append('orgData', JSON.stringify(this.orgDetailForm.value));
      if (this.file != null) {
        fd.append('file', this.file, this.file.name);
      }
      this.auth.addOrgData(fd).subscribe(
        (data) => {
          //this.getUserDetails();
          this.toaster.success(data.message)
        },
        (error: any) => {
          console.log(error);
        }
      );
      this.submitted = true;
    }
    else {

      const fd = new FormData();
      fd.append('orgData', JSON.stringify(this.orgDetailForm.value));
      if (this.file != null) {
        fd.append('file', this.file, this.file.name);
      }

      this.auth.updateOrgData(this.uid, fd).subscribe(
        (data) => {

          this.toaster.success(data.message)
          this.getOrgDetails();

        },
        (error: any) => {
          console.log(error);
        }
      );
      this.submitted = true;

    }

    // stop here if form is invalid
    if (this.orgDetailForm.invalid) {
      return;
    }
  }
}

