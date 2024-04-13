import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { ToastrService } from 'ngx-toastr';
import { AdminAuthService } from 'src/app/admin/shared/services/admin-auth.service';
import { ImageService } from 'src/app/services/image.service';

@Component({
  selector: 'app-organisations',
  templateUrl: './organisations.component.html',
  styleUrls: ['./organisations.component.css']
})
export class OrganisationsComponent implements OnInit {

  organisationsList: any;
  displayStyle = "none";
  displayEdit = "none";
  deleteId:number;
  editOrgId: number;
  imageURL: string = '';
  file: any;

  orgDetailForm: FormGroup

  constructor(private auth: AdminAuthService, private toastr: ToastrService, private fb: FormBuilder, private image: ImageService) { }

  ngOnInit(): void {
    this.getAllOrgDatas();

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

  getAllOrgDatas() {
    this.auth.getVerifiedOrgs().subscribe(response => {
      this.organisationsList = response;
    },
      (error: any) => {
        console.log(error);
      }
    );
  }

  deleteOrgData(){
    this.auth.deleteOrganisationData(this.deleteId).subscribe(response => {
      this.closePopup();
      this.getAllOrgDatas();
    },
      (error: any) => {
        console.log(error);
      }
    );
  }
  openPopup(id:number) {
    this.deleteId = id;
    this.displayStyle = "block";
  }
  closePopup() {
    this.displayStyle = "none";
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
        this.getAllOrgDatas();
      },
      (error: any) => {
        this.closeOrgModal();
        console.log(error);
        this.toastr.error(error.errors);
        this.getAllOrgDatas();
        //this.toastr.success(error.message);
        //this.notify.showSuccess("error", error);
      }
    );

    // stop here if form is invalid
    if (this.orgDetailForm.invalid) {
      return;
    }
    this.getAllOrgDatas();
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
