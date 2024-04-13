import { Component, Input, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { ToastrService } from 'ngx-toastr';
import { AuthService } from 'src/app/services/auth.service';
import { ImageService } from 'src/app/services/image.service';
import { baseUrl, host } from 'src/environments/environment';

@Component({
  selector: 'app-profilepost',
  templateUrl: './profilepost.component.html',
  styleUrls: ['./profilepost.component.css']
})
export class ProfilepostComponent implements OnInit {

  @Input() post: any;
  @Input() userURL:string;
  //@Input() userName:any;
  cities: any;
  states: any;
  reqType: any;
  postCmnt:any;
  posturl: string;
  userurl: string;
  comment: string;
  allSpam:any;
  allUrgency:any;

  displayStyle = "none";
  urgencyDisplay="none";
  cmntDisplay ="none";
  spamDisplay="none";

  displayStyleDelete = "none";
  displayStyleClose = "none";
  deleteId: number;
  closeId: number;
  user = this.auth.getUsername();

  editPostForm: FormGroup;
  displayStyleEdit = "none";
  editPostId: number;
  pinVal=false;
  file: any;
  imageURL: string = '';
  latitude: number;
  longitude: number;
  submitted= false;
  

  constructor(private image: ImageService, private auth: AuthService, private toastr: ToastrService, private fb: FormBuilder) {

  }

  ngOnInit(): void {
    this.getCityList();
    this.getStateList();
    this.getReqList();
    this.posturl = this.image.getPost();
    this.userurl = this.image.getProfile();
    //this.auth.getSpam(1).subscribe(data=>{this.allSpam=data})
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
  
  openDeletePost(id:number) {
    this.deleteId = id;
    this.displayStyleDelete = "block";
  }
  closeDeletePost() {
    this.displayStyleDelete = "none";
  }
  openClosePost(id:number) {
    this.closeId = id;
    this.displayStyleClose = "block";
  }
  closeClosePost() {
    this.displayStyleClose = "none";
  }

  openUrgency(id,count:number) {
    if(count==0){
      this.toastr.error("There is no Urgency to show");
    }
    else{
    
    this.auth.getUrgency(id).subscribe(
      (response) => {
        this.urgencyDisplay = "block";
        this.allUrgency = response;
      },
      (error: any) => {
        console.log(error);
        //this.notify.showSuccess("error", error);
      }
    );
    }

  }
  closeUrgency() {
    this.urgencyDisplay = "none";
  }
  openSpam(id:number,count:number){
    if(count==0){
      this.toastr.error("There is no Spam to show");
    }
    else{
      
      this.auth.getSpam(id).subscribe(
        (response) => {
          this.spamDisplay="block";
          this.allSpam = response;
        },
        (error: any) => {
          console.log(error);
          //this.notify.showSuccess("error", error);
        }
      );
    }
  }
  closeSpam(){
    this.spamDisplay="none";
  }
  openComment(id:number,count: number){
    if(count==0){
      this.toastr.error("There is no comments to show");
    }
    else
      
      this.auth.getComment(id).subscribe(
        (response) => {
          this.cmntDisplay="block";
          
          this.postCmnt = response;
        },
        (error: any) => {
          console.log(error);
          //this.notify.showSuccess("error", error);
        }
      );
 
  }
  closeComment(){
    this.cmntDisplay="none"
  }
  bookmark: number;
  save: boolean;
  addBookmark(postId: number){
    if(this.auth.isUserReg()){
      this.auth.addBookmark({
        postId: postId,
        bookmarkId: this.bookmark,
      })
      .subscribe(
        (response) =>{
          this.toastr.success(response.message);
          console.log(this.save);
        },
        (error: any) =>{
          console.log(error);
          this.toastr.error(error.message);
        }
      );
    }
    else if(!this.auth.isUser()){
      this.toastr.error('Please Login as User to save post');
    }
    else {
      this.toastr.error('Please Create Profile properly to add comment');
    }
  }
  openPopup(id: number) {
    document.getElementById('sharepost').setAttribute('value', host+'post/'+id);
    this.displayStyle = "block";
  }

  copyToClip() {
    var data = (<HTMLInputElement>document.getElementById("sharepost")).value;
    navigator.clipboard.writeText(data);
    this.toastr.success("Link copied to Clipboard");
  }
  closePopup() {
    this.displayStyle = "none";
  }

  openEdit(id: number){
    this.displayStyleEdit = "block";
    this.editPostId = id;
    this.auth.getPostByIds(id).subscribe(response => {
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


  cityName(id: number) {
    if(this.cities != undefined)
      return this.cities.find(f => f.cityId === id)?.cityName;
    return null;
  }
  stateName(id: number) {
    if(this.states != undefined)
      return this.states.find(f => f.stateId === id)?.stateName;
    return null;
  }
  reqTypeName(id: number) {
    if(this.reqType != undefined)
      return this.reqType.find(f => f.requirementTypeId === id)?.requirementTypeName;
    return null;
  }
  goToLink(lat: number, long: number) {
    const url = "https://www.google.com/maps/search/?api=1&query=" + lat + "," + long;
    window.open(url, "_blank");
  }

  getReqList() {
    this.auth.getReqType().subscribe(
      (response) => {
        this.reqType = response;
      },
      (error: any) => {
        console.log(error);
        //this.notify.showSuccess("error", error);
      }
    )
  }
  getCityList() {
    this.auth.getCity().subscribe(
      (response) => {
        this.cities = response;
      },
      (error: any) => {
        console.log(error);
        //this.notify.showSuccess("error", error);
      }
    )
  }
  getStateList() {
    this.auth.getState().subscribe(
      (response) => {
        this.states = response;
      },
      (error: any) => {
        console.log(error);
        //this.notify.showSuccess("error", error);
      }
    );
  }
  addComment(post: number) {
    if (this.auth.isUserReg()) {
      this.auth.addComment(
        {
          postId: post,
          comment: this.comment

        }
      ).subscribe(
        (response) => {
          window.location.reload();
          this.toastr.success(response.message);

          //this.posts = response;
        },
        (error: any) => {
          console.log(error);
          this.toastr.success(error.message);
          //this.notify.showSuccess("error", error);
        }
      );



    }
    else if(this.auth.isUser()){
      this.toastr.error('Please Create Profile properly to add comment');
    }
    else {
      this.toastr.error('Please Login as user to add comment');
    }

  }
  addSpam(post: number) {
    if (this.auth.isUserReg()) {
      this.auth.addSpam(
        {
          postId: post,
          userId: 0,

        }
      ).subscribe(
        (response) => {
          this.toastr.success(response.message);

          //this.posts = response;
        },
        (error: any) => {
          console.log(error);
          this.toastr.success(error.message);
          //this.notify.showSuccess("error", error);
        }
      );


    }
    else if(this.auth.isUser()){
      this.toastr.error('Please Create Profile properly to add spam');
    }
    else {
      this.toastr.error('Please Login as user to add spam');
    }

  }
  addUrgency(post: number) {
    if (this.auth.isUserReg()) {
      this.auth.addUrgency(
        {
          postId: post,
          userId: 0,

        }
      ).subscribe(
        (response) => {
          this.toastr.success(response.message);

          //this.posts = response;
        },
        (error: any) => {
          console.log(error);
          this.toastr.success(error.message);
          //this.notify.showSuccess("error", error);
        }
      );


    }
    else if(this.auth.isUser()){
      this.toastr.error('Please Create Profile properly to add urgency');
    }
    else {
      this.toastr.error('Please Login as user to add urgency');
    }
  }

  checkPincode(e) {
    if (e.target.value.length === 6) {
      this.auth.checkPincode(e.target.value).subscribe(
        (res) => {
          if (res != null) {
            this.pinVal=true;
            this.editPostForm.patchValue({
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

  deletePost(){
    this.auth.deletePost(this.deleteId).subscribe(response => {
      this.closeDeletePost();
      window.location.reload();
    },
      (error: any) => {
        console.log(error);
      }
    );
  }

  closePost(){
    this.auth.closePost(this.closeId).subscribe(response => {
      this.closeClosePost();
      window.location.reload();
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
        this.closeEdit();
      },
      (error: any) => {
        this.closeEdit();
        console.log(error);
      }
    );
    this.submitted = true;

    // stop here if form is invalid
    if (this.editPostForm.invalid) {
      return;
    }
    window.location.reload();
  }

}

