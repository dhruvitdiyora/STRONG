import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { ToastrService } from 'ngx-toastr';
import { AdminAuthService } from 'src/app/admin/shared/services/admin-auth.service';
import { ImageService } from 'src/app/services/image.service';

@Component({
  selector: 'app-unverified-orgs',
  templateUrl: './unverified-orgs.component.html',
  styleUrls: ['./unverified-orgs.component.css']
})
export class UnverifiedOrgsComponent implements OnInit {

  unverifiedOrgs: any;
  displayStyleVerify = "none";
  displayStyleDelete = "none";
  displayEdit = "none";
  deleteOrgId: number;
  verifyOrgId:number;
  editOrgId: number;
  imageURL: string = '';
  file: any;

  orgDetailForm: FormGroup

  constructor(private auth: AdminAuthService, private toastr: ToastrService, private fb: FormBuilder, private image: ImageService) { }

  ngOnInit(): void {
    this.getAllUnVerifiedOrgs();

    this.orgDetailForm = this.fb.group({
      organisationDataId: [null,Validators.required],
      organisationName: [null,Validators.required],
      organisationAddress: [null,Validators.required],
      organisationLogoUrl: [null],
      organisationDetail: [null],
      organisatioWebUrl: [null,Validators.required],
      organisationUserId: [null,Validators.required],
      organisationContactNo: [null,Validators.required],
      organisationUserName: [null,Validators.required],
      preview: [null],
    });
  }

  getAllUnVerifiedOrgs() {
    this.auth.getUnVerifiedOrgs().subscribe(response => {
      this.unverifiedOrgs = response;
    },
      (error: any) => {
        console.log(error);
      }
    );
  }

  verifyOrg(){
    this.auth.verifyOrg(this.verifyOrgId).subscribe(response => {
      this.closeVerify();
      this.getAllUnVerifiedOrgs();
    },
      (error: any) => {
        console.log(error);
      }
    );
  }

  deleteOrg(){
    this.auth.deleteOrganisationData(this.deleteOrgId).subscribe(response => {
      this.closeDelete();
      this.getAllUnVerifiedOrgs();
    },
      (error: any) => {
        console.log(error);
      }
    );
  }
  
  openVerify(id:number) {
    this.verifyOrgId = id;
    
    this.displayStyleVerify = "block";
  }
  closeVerify() { 
    this.displayStyleVerify = "none";
  }
  openDelete(id:number) {
    this.deleteOrgId = id;
    this.displayStyleDelete = "block";
  }
  closeDelete() {
    this.displayStyleDelete = "none";
  }

  openEditOrg(id: number) {
    this.displayEdit = "block";
    this.editOrgId = id;
    this.auth.getOrgById(id).subscribe(response => {
      this.orgDetailForm.patchValue({
        organisationDataId: response.model.organisationDataId,
        organisationName: response.model.organisationName,
      organisationAddress: response.model.organisationAddress,
      organisationDetail: response.model.organisationDetail,
      organisatioWebUrl: response.model.organisatioWebUrl,
      organisationUserId: response.model.organisationUserId,
      organisationContactNo: response.model.organisationContactNo,
      organisationUserName: response.model.organisationUserName,
      // organisationLogoUrl: response.model.organisationLogoUrl
      })
      this.imageURL =  response.model.organisationLogoUrl;
    },
      (error: any) => {
        console.log(error);
      }
    );
  }

  closeOrgModal() {
    this.displayEdit = "none";
    this.orgDetailForm.reset();
  }

  editOrg(){
    const fd = new FormData();
    fd.append('orgData', JSON.stringify(this.orgDetailForm.value));
    if (this.file != null) {
      fd.append('file', this.file, this.file.name);
    }
    this.auth.editOrg(this.editOrgId, fd).subscribe(
      (data) => {
        //this.toastr.success(error.message);
        this.closeOrgModal();
        this.getAllUnVerifiedOrgs();
      },
      (error: any) => {
        this.closeOrgModal();
        console.log(error);
        this.toastr.error(error.errors);
        this.getAllUnVerifiedOrgs();
        //this.toastr.success(error.message);
        //this.notify.showSuccess("error", error);
      }
    );

    // stop here if form is invalid
    if (this.orgDetailForm.invalid) {
      return;
    }
    this.getAllUnVerifiedOrgs();
  }

  showPreview(event) {
    const file = (event.target as HTMLInputElement).files[0];
    this.file = event.target.files[0];

    this.orgDetailForm.patchValue({
      preview: file
    });
    this.orgDetailForm.get('preview').updateValueAndValidity();

    // File Preview
    const reader = new FileReader();
    reader.onload = () => {
      this.imageURL = reader.result as string;
    };
    reader.readAsDataURL(file);
  }
}
