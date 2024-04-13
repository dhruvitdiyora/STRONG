import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, NgForm, Validators } from '@angular/forms';
import { Post } from 'src/app/model/Post.modal';
import { PostComment } from 'src/app/model/PostComment.model';
import { AuthService } from 'src/app/services/auth.service';
import { of } from 'rxjs';
import { State } from 'src/app/model/State.model';
import { RequirementType } from 'src/app/model/RequirementType.model';
import { cities } from 'src/app/model/allcity.modal';
import { Router } from '@angular/router';
import { BsModalRef } from 'ngx-bootstrap/modal';

@Component({
  selector: 'app-create-post',
  templateUrl: './create-post.component.html',
  styleUrls: ['./create-post.component.css'],
})
export class CreatePostComponent implements OnInit {
  cities: cities[];
  states: State[];
  requirment: RequirementType[];
  postCreateForm: FormGroup;
  submitted = false;
  img: File;
  imageURL: string = '';
  displayStyle = 'none';
  postCmnt: any;
  post1: Post;
  latitude: number;
  longitude: number;
  file: any;
  cityDropdown=false;
  stateDropdown=false;
  reqDropdown=false;
  pinVal=false;
  imagee=true;
  imagee1:boolean;

  openPopup() {
    this.displayStyle = 'block';
  }
  closePopup() {
    this.displayStyle = 'none';
  }

  constructor(private fb: FormBuilder, 
    private auth: AuthService,
    public bsLoginModal: BsModalRef,
    private router: Router) {}

  getCity() {
    this.auth.getCity().subscribe((data) => {
      this.cities = [{ cityId: 0, cityName: 'Select City' }, ...data];
    });
  }

  getState() {
    this.auth.getState().subscribe((data) => {
      this.states = [{ stateId: 0, stateName: 'Select State' }, ...data];
    });
  }

  getReqType() {
    this.auth.getReqType().subscribe((data) => {
      this.requirment = [
        { requirementTypeId: 0, requirementTypeName: 'Select Requirement Type' },
        ...data,
      ];
    });
  }

  formDisplay = 'none';
  ngOnInit(): void {
    this.getCity();
    this.getState();
    this.getReqType();
    this.formDisplay = 'block';
    this.postCreateForm = this.fb.group({
      userId: 3,
      postDescription: [null, Validators.required],
      requirementTypeId: [0, Validators.required],
      helpRequiredCount: [null, Validators.required],
      locationName: [null, Validators.required],
      longitude: [null, Validators.required],
      latitude: [null, Validators.required],
      pincod: [null, [Validators.required, Validators.minLength(6)]],
      pincodeId: [null, [Validators.required]],
      cityId: [0, Validators.required],
      stateId: [0, Validators.required],
      IsPublished: true,
      IsClosed: false,
      postImage: [null, Validators.required],
      preview: [null],
    });
  }

  closeForm() {
    this.bsLoginModal.hide()
  }
  showPreview(event) {
    const file = (event.target as HTMLInputElement).files[0];
    this.file = event.target.files;
    this.postCreateForm.patchValue({
      preview: file
    });
    this.postCreateForm.get('preview').updateValueAndValidity();

    // File Preview
    if(this.file.length!=0){
      const reader = new FileReader();
      reader.onload = () => {
        this.imageURL = reader.result as string;
      };
      reader.readAsDataURL(file);
      console.log(this.file.length);
    }

    
    if(this.file.length==0 ){
      this.imagee=true;
      this.imagee1=false;
    }
    else if(this.file.length<5 && this.file.length>0){
      this.imagee=false;
      this.imagee1=true;
    }
    else{
      this.imagee1=false;
      this.imagee=false;
    }
  }

  getLocation() {
    navigator.geolocation.getCurrentPosition((position) => {
      this.latitude = position.coords.latitude;
      this.longitude = position.coords.longitude;
      this.postCreateForm.patchValue({
        latitude: position.coords.latitude,
        longitude: position.coords.longitude,
      });
    });
  }

  checkPincode(e) {
    if (e.target.value.length === 6) {
      this.auth.checkPincode(e.target.value).subscribe(
        (res) => {
          if (res != null) {
            this.pinVal=true;
            this.postCreateForm.patchValue({
              pincodeId: res.pincodeId,
              stateId: res.stateId,
              cityId: res.cityId,
            });
          }
        },
        (error: any) => {
          console.log(error);
        }
      );
    }
  }

  cityVal(){
    const cityIdVal=this.postCreateForm.get('cityId').value;
    if(cityIdVal==0)
      {
        this.cityDropdown=true;
      }
      else
      {
        this.cityDropdown=false;
      }
    
  }
  stateVal(){
    const stateidVal=this.postCreateForm.get('stateId').value;
    if(stateidVal==0)
      {
        this.stateDropdown=true;
      }
      else
      {
        this.stateDropdown=false;
      }
  }
  reqVal(){
    const reqidVal=this.postCreateForm.get('requirementTypeId').value;
    if(reqidVal==0)
      {
        this.reqDropdown=true;
      }
      else
      {
        this.reqDropdown=false;
      }
    
  }


  stateChange(sid: any) {
    this.auth.getCityByState(sid.target.value).subscribe((data) => {
      this.cities = [{ cityId: 0, cityName: 'Select City' }, ...data];
    });
  }

  savePost() {
    const fd = new FormData();
    fd.append('post', JSON.stringify(this.postCreateForm.value));
      for (let i = 0; i < this.file.length; i++) {
        fd.append('file', this.file[i], this.file[i].name);
      }
      this.auth.createPost(fd).subscribe(
        (data) => {
          this.closeForm();
        },
        (error: any) => {
          this.closeForm();
          console.log(error);
          //this.toastr.success(error.message);
          //this.notify.showSuccess("error", error);
        }
      );
      this.submitted = true;
      // stop here if form is invalid
      if (this.postCreateForm.invalid) {
        return;
      }
      this.router.navigate(['/']);
}
}
