import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, NgForm, Validators } from '@angular/forms';
import { ToastrService } from 'ngx-toastr';
import { org } from 'src/app/model/orglist.modal';
import { Pincode } from 'src/app/model/Pincode.model';
import { pin } from 'src/app/model/pincodeid.modal';
import { AuthService } from 'src/app/services/auth.service';

@Component({
  selector: 'app-create-event',
  templateUrl: './create-event.component.html',
  styleUrls: ['./create-event.component.css']
})
export class CreateEventComponent implements OnInit {
  formDisplay = 'none';
  file: any;
  img: File;
  imageURL: string = '';
  submitted = false;
  pincodes: pin[];
  orgList: org[];
  pinVal=false;
  constructor(private fb: FormBuilder, private auth: AuthService, private toastr: ToastrService) { }
  createEventForm: FormGroup;

  getPincodes() {
    this.auth.getPincode().subscribe((data) => {
      //console.log(data);
      this.pincodes = [{ pincodeId: 0, postOfficeName: 'Select your pincode' }, ...data];

    });
  }

  getOrg() {
    this.auth.getOrgList().subscribe((data) => {
      this.orgList = [{ organisationUserId: 0, organisationName: 'Select your Organization' }, ...data];
    })
  }
  ngOnInit(): void {
    this.getPincodes();
    this.getOrg();
    this.formDisplay = 'block';
    this.createEventForm = this.fb.group({
      eventName: [null, Validators.required],
      eventDescription: [null, Validators.required],
      eventOrganizerId: [0, Validators.required],
      pincod: [null, [Validators.required, Validators.minLength(6)]],
      pincodeId: [null, [Validators.required]],
      locationName:[null,Validators.required],
      eventStartDate: [null, Validators.required],
      eventEndDate: [null, Validators.required],
      eventType: [null, Validators.required, Validators.min(1)],
      eventBanner: [null, Validators.required],
      preview: [null]
    })
  }
  closeForm() {
    this.formDisplay = 'none';
    // window.open("https://localhost:4200/organisation", "_self");
  }
  
    showPreview(event) {
    const file = (event.target as HTMLInputElement).files[0];
    this.file = event.target.files;

    this.createEventForm.patchValue({
      preview: file
    });
    this.createEventForm.get('preview').updateValueAndValidity();

    // File Preview
    const reader = new FileReader();
    reader.onload = () => {
      this.imageURL = reader.result as string;
    };
    reader.readAsDataURL(file);
  }
  saveEvent() {
    const fd = new FormData();
    fd.append('charityEvent', JSON.stringify(this.createEventForm.value));
    fd.append('file', this.file[0], this.file[0].name);

    this.auth.createEvent(fd).subscribe(
      (data) => {
        //this.toastr.success(data.message);
        this.formDisplay = 'none';
        window.location.reload();
      },
      (error: any) => {
        console.log(error);
      }
    );
    this.submitted = true;
    // stop here if form is invalid
    if (this.createEventForm.invalid) {
      return;
    }
    // window.open("https://localhost:4200/organisation", "_self");
  }

  checkPincode(e) {
    if (e.target.value.length === 6) {
      this.auth.checkPincode(e.target.value).subscribe(
        (res) => {
          if (res != null) {
            this.pinVal=true;
            this.createEventForm.patchValue({
              pincodeId: res.pincodeId
            });
          }
        },
        (error: any) => {
          console.log(error);;
        }
      );
    }
  }

}
