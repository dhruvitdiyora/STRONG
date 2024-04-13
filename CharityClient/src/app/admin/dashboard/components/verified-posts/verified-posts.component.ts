import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { AdminAuthService } from 'src/app/admin/shared/services/admin-auth.service';
import { cities } from 'src/app/model/allcity.modal';
import { RequirementType } from 'src/app/model/RequirementType.model';
import { State } from 'src/app/model/State.model';
import { ImageService } from 'src/app/services/image.service';

@Component({
  selector: 'app-verified-posts',
  templateUrl: './verified-posts.component.html',
  styleUrls: ['./verified-posts.component.css']
})
export class VerifiedPostsComponent implements OnInit {

  verifiedPosts: any;
  displayStyle = "none";
  deleteId:number;
///////////////////
  displayStyleEdit = "none";
  editPostId: number;

  editPostForm: FormGroup;
  cities: cities[];
  states: State[];
  requirment: RequirementType[];
  reqDropdown=false;
  pinVal=false;
  cityDropdown=false;
  stateDropdown=false;
  file: any;
  imageURL: string = '';
  latitude: number;
  longitude: number;
  submitted= false;

  constructor(
    private auth: AdminAuthService,
    private fb: FormBuilder,
    private image: ImageService) { }

  ngOnInit(): void {
    this.getAllVerifiedPosts();

    this.editPostForm = this.fb.group({
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
      postImage: [null],
      //postImage1;[null],
      preview: [null],
    });
  }

  getAllVerifiedPosts() {
    this.auth.getVerifiedPosts().subscribe(response => {
      this.verifiedPosts = response;
    },
      (error: any) => {
        console.log(error);
      }
    );
  }

  editPost(){
    const fd = new FormData();
    fd.append('post', JSON.stringify(this.editPostForm.value));
    for (let i = 0; i < this.file.length; i++) {
      fd.append('file', this.file[i], this.file[i].name);
    }
    this.auth.editPost(this.editPostId, fd).subscribe(
      (data) => {
        //this.toastr.success(error.message);
        this.closeEdit();
      },
      (error: any) => {
        this.closeEdit();
        console.log(error);
        //this.toastr.success(error.message);
        //this.notify.showSuccess("error", error);
      }
    );

    this.submitted = true;

    // stop here if form is invalid
    if (this.editPostForm.invalid) {
      return;
    }
    this.getAllVerifiedPosts();
  }

  deletePost(){
    this.auth.deletePost(this.deleteId).subscribe(response => {
      this.closePopup();
      this.getAllVerifiedPosts();
    },
      (error: any) => {
        console.log(error);
      }
    );
  }

  openEdit(id: number){
    this.getCity();
    this.getState();
    this.getReqType();
    this.displayStyleEdit = "block";
    this.editPostId = id;
    this.auth.getPostById(id).subscribe(response => {
      this.editPostForm.patchValue({
        userId: response.userId,
        postDescription: response.postDescription,
        requirementTypeId: response.requirementTypeId,
        helpRequiredCount: response.helpRequiredCount,
        locationName: response.locationName,
        longitude: response.longitude,
        latitude: response.latitude,
        pincod: response.pincode.pincode1,
        pincodeId: response.pincodeId,
        cityId: response.cityId,
        stateId: response.stateId,
      })
      this.imageURL =  response.imageUrl
    },
      (error: any) => {
        console.log(error);
      }
    );
  }
  closeEdit() {
    this.displayStyleEdit = "none";
  }

  openPopup(id:number) {
    this.deleteId = id;
    this.displayStyle = "block";
  }
  closePopup() {
    this.displayStyle = "none";
  }

  getReqType() {
    this.auth.getRequirementTypes().subscribe((data) => {
      this.requirment = [
        { requirementTypeId: 0, requirementTypeName: 'Select Requirement Type' },
        ...data,
      ];
    });
  }

  getState() {
    this.auth.getStates().subscribe((data) => {
      this.states = [{ stateId: 0, stateName: 'Select State' }, ...data];
    });
  }

  getCity() {
    // this.auth.getCity().subscribe(data=>{console.log(data);
    // })
    this.auth.getCities().subscribe((data) => {
      this.cities = [{ cityId: 0, cityName: 'Select City' }, ...data];
    });
  }

  reqVal(){
    const reqidVal=this.editPostForm.get('requirementTypeId').value;
    if(reqidVal==0)
      {
        this.reqDropdown=true;
      }
      else
      {
        this.reqDropdown=false;
      }
    // console.log(this.editPostForm.get('cityId').value); 
  }
  cityVal(){
    const cityIdVal=this.editPostForm.get('cityId').value;
    if(cityIdVal==0)
      {
        this.cityDropdown=true;
      }
      else
      {
        this.cityDropdown=false;
      }
    // console.log(this.editPostForm.get('cityId').value); 
  }

  checkPincode(e) {
    if (e.target.value.length === 6) {
      this.auth.checkPincode(e.target.value).subscribe(
        (res) => {
          // if (res == null) {
          //   this.editPostForm.get('pincodeId').setErrors({ 'notavail': false });

          // }
          // else {
          if (res != null) {
            //this.editPostForm.get('pincode').setErrors({ 'notavail': true });
            this.pinVal=true;
            this.editPostForm.patchValue({
              pincodeId: res.pincodeId,
              stateId: res.stateId,
              cityId: res.cityId,
            });
          }

          //this.posts = response;
        },
        (error: any) => {
          console.log(error);
          //this.toastr.success(error.message);
          //this.notify.showSuccess("error", error);
        }
      );
    }
  }

  getLocation() {
    navigator.geolocation.getCurrentPosition((position) => {
      this.latitude = position.coords.latitude;
      this.longitude = position.coords.longitude;
      this.editPostForm.patchValue({
        latitude: position.coords.latitude,
        longitude: position.coords.longitude,
      });
    });
  }

  stateVal(){
    const stateidVal=this.editPostForm.get('stateId').value;
    if(stateidVal==0)
      {
        this.stateDropdown=true;
      }
      else
      {
        this.stateDropdown=false;
      }
    // console.log(this.editPostForm.get('cityId').value); 
  }

  showPreview(event) {
    const file = (event.target as HTMLInputElement).files[0];
    this.file = event.target.files;

    this.editPostForm.patchValue({
      preview: file
    });
    this.editPostForm.get('preview').updateValueAndValidity();

    // File Preview
    const reader = new FileReader();
    reader.onload = () => {
      this.imageURL = reader.result as string;
    };
    reader.readAsDataURL(file);
  }
}
