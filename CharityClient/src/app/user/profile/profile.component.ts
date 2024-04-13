import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, NgForm, Validators } from '@angular/forms';
import { Router } from '@angular/router';
import { ToastrService } from 'ngx-toastr';
import { cities } from 'src/app/model/allcity.modal';
import { State } from 'src/app/model/State.model';
import { AuthService } from 'src/app/services/auth.service';
import { ImageService } from 'src/app/services/image.service';
@Component({
  selector: 'app-profile',
  templateUrl: './profile.component.html',
  styleUrls: ['./profile.component.css']
})
export class ProfileComponent implements OnInit {
  userData: any;
  userUrl: string;
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
  userID: number;
  userCheck = false;
  userReg = false;
  //userUrl: string;
  postUrl: string;
  change() {
    this.hide = true;
    this.show = false;
  }


  constructor(private fb: FormBuilder,
    private auth: AuthService,
    private image: ImageService,
    private toaster: ToastrService,
    private router: Router) { }
  userDetailForm: FormGroup;

  ngOnInit(): void {
    if(this.auth.isUser()){

      this.userDetailForm = this.fb.group({
        userId: [0, Validators.required],
        users: ['', Validators.required],
        userName: ['', Validators.required],
        firstName: ['', Validators.required],
        lastName: ['', Validators.required],
        gender: ['', Validators.required],
        profileImage: [null],
        mobileNo: [null, Validators.required],
        emailAddress: [null, Validators.required],
        cityId: [null, Validators.required],
        stateId: [null, Validators.required],
        pincodeId: [null, Validators.required],
        pincode1: [null, Validators.required],
        totalPostCount: [0, Validators.required],
        userDescription: [null, Validators.required]
      })
      this.getUserDetails();
      this.userUrl = this.image.getProfile();
      this.postUrl = this.image.getPost();
      this.getCity();
      this.getState();
      if (this.auth.isUserReg())
      {
        this.getUserPosts();
      }
        
    }
    else{
      this.toaster.error("you can not edit user")
      this.router.navigate(['/']);

    }


    
  }

  getUserDetails() {
    this.auth.getUserInfo().subscribe(
      (response) => {
        this.userData = response;
        console.log(response);
        

        //console.log(this.userCheck);


        this.userDetailForm.patchValue({
          mobileNo: response.mobileNo,
          emailAddress: response.emailAddress,
          userName: response.userName,
          users: response.userId,
        })
        if (response.userData != null) {
          this.userCheck = true;
          this.uid = response.userData.userId;
          
          this.getPincod(response.userData.pincodeId)
          this.userDetailForm.patchValue({
            userId: response.userID,
            firstName: response.userData.firstName,
            lastName: response.userData.lastName,
            gender: response.userData.gender,
            profileImage: response.userData.profileImage,
            cityId: response.userData.cityId,
            stateId: response.userData.stateId,
            pincodeId: response.userData.pincodeId,
            totalPostCount: response.userData.totalPostCount,
            userDescription: response.userData.userDescription
          })
        }

      },
      (error: any) => {
        console.log(error);
      }
    );
  }

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

  getPincod(id: number) {
    this.auth.getPincodeById(id).subscribe((data) => {
      this.pincode = data.pincode1;
      this.userDetailForm.patchValue({
        pincode1: this.pincode
      })
    })
  }

  checkPincode(e) {
    if (e.target.value.length === 6) {
      this.auth.checkPincode(e.target.value).subscribe(
        (res) => {
          if (res != null) {
            //this.postCreateForm.get('pincode').setErrors({ 'notavail': true });
            this.pinVal = true;
            this.userDetailForm.patchValue({
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

  setImage(event) {
    const file = (event.target as HTMLInputElement).files[0];
    this.file = event.target.files[0];

    this.userDetailForm.patchValue({
      preview: file
    });

  }


  editUser() {
    if (this.uid == 0) {
      const fd = new FormData();
      fd.append('userData', JSON.stringify(this.userDetailForm.value));
      if (this.file != null) {
        fd.append('file', this.file, this.file.name);
      }
        this.auth.addUserData(fd).subscribe(
          (data) => {
            //this.getUserDetails();
          },
          (error: any) => {
            console.log(error);
          }
        );
      this.submitted = true;

    }
    else {
      const fd = new FormData();
      fd.append('userData', JSON.stringify(this.userDetailForm.value));
      if (this.file != null) {
        fd.append('file', this.file, this.file.name);
      }
      if (this.uid>0)
        this.auth.updateUserData(this.uid, fd).subscribe(
          (data) => {
            this.getUserDetails();
          },
          (error: any) => {
            console.log(error);
          }
        );
      this.submitted = true;

    }



    // stop here if form is invalid
    if (this.userDetailForm.invalid) {
      return;
    }

  }

  getUserPosts() {
    this.auth.getPostByUserId().subscribe((data) => {
      this.posts = data
    })
  }
}
