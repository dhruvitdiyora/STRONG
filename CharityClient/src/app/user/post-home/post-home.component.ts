import { HttpParams } from '@angular/common/http';
import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup } from '@angular/forms';
import { Router } from '@angular/router';
import { BsModalRef, BsModalService } from 'ngx-bootstrap/modal';
import { ToastrService } from 'ngx-toastr';
import { cities } from 'src/app/model/allcity.modal';
import { PostsDTO } from 'src/app/model/PostsDTO.model';
import { RequirementType } from 'src/app/model/RequirementType.model';
import { State } from 'src/app/model/State.model';
import { AuthService } from 'src/app/services/auth.service';
import { ImageService } from 'src/app/services/image.service';
import { CreatePostComponent } from '../create-post/create-post.component';

@Component({
  selector: 'app-post-home',
  templateUrl: './post-home.component.html',
  styleUrls: ['./post-home.component.css']
})
export class PostHomeComponent implements OnInit {
  isCollapsedLeft = false;
  isCollapsedRight = false;
  createPostModal!: BsModalRef;
  cities: cities[];
  states: State[];
  requirment: RequirementType[];
  filterForm: FormGroup;
  show=false;
  sortshow=false;
  page=0;
  isFiltered=false;
  isScroll = true;

  changeSort(){
    this.show=false;
    this.sortshow=true;
  }
change(){
  this.show=true;
  this.sortshow=false;
  this.getCity();
  this.getState();
  this.getReqType();
}

  sortOptions = [
    { name: 'Latest Post', value: 'Latest' },
    { name: 'Oldest Post', value: 'Oldest' },
    { name: 'Highest Urgency: High to Low', value: 'UrgencyMost' },
    { name: 'Lowest Urgency', value: 'UrgencyLeast' },
    { name: 'Highest Spam: High to Low', value: 'SpamMost' },
    { name: 'Lowest Spam: Low to High', value: 'SpamLeast' },
  ];
  sort='Latest';
  onSortSelected(e) {
    this.sort = e.target.value;
    this.getPosts();
  }

  read: boolean;

  openCreateForm() {
    if(this.auth.getUserReg())
    {
      this.createPostModal = this.createPost.show(CreatePostComponent)

    }
    else{
      this.toastr.error('Please Create Profile properly to add post');
    }
    
  };
  //@Input() post: PostsDTO;
  posts: PostsDTO[];
  displayStyle = "none";

  postButtonShow:boolean;
  openPopup() {
    this.displayStyle = "block";
  }
  closePopup() {
    this.displayStyle = "none";
  }

  constructor(private auth: AuthService,
    private createPost: BsModalService,
    private toastr: ToastrService,
    private fb: FormBuilder,
    private router: Router
  ) { }

  ngOnInit(): void {
    
    this.posts=[];
    this.filterForm = this.fb.group({
      username: [''],
      pincod:[0],
      pincodeId:[0],
      stateId:[0],
      cityId: [0],
      requirementTypeId: [0],
      sort:['Latest']
    })
    this.page=0;
    this.getCity();
    this.getState();
    this.getReqType();
    this.getPosts();
    this.isScroll=true;
  }
  getReload(){
    this.getPosts();
  }
  scrollCheck(){
    this.isScroll=false;
  }
  getPosts(isfilt=false) {
    if(!isfilt)
    {
      this.posts =[];
      this.page=0;
      this.isScroll = true;
      this.isFiltered = true;
    }
    
    
      this.auth.getPostHome(
        this.filterForm.controls['username'].value,
        this.filterForm.controls['pincodeId'].value,
        this.filterForm.controls['cityId'].value,
        this.filterForm.controls['stateId'].value,
        this.filterForm.controls['requirementTypeId'].value,
        this.filterForm.controls['sort'].value,
        this.page
      ).subscribe(
        (response) => {
          console.log(response);
          this.posts = [...this.posts,...response];
        },
        (error: any) => {
          console.log(error);
          //this.notify.showSuccess("error", error);
        }
      );
  
    this.postButtonShow = this.auth.isUserReg();
  }
  getCity() {
    // this.auth.getCity().subscribe(data=>{console.log(data);
    // })
    this.auth.getCity().subscribe((data) => {
      this.cities = [{ cityId: 0, cityName: 'Select City' }, ...data];
    });
    console.log(this.cities);
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
  stateChange(sid: any) {
    this.auth.getCityByState(sid.target.value).subscribe((data) => {
      this.cities = [{ cityId: 0, cityName: 'Select City' }, ...data];
    });
  }
  checkPincode(e) {
    if (e.target.value.length === 6) {
      this.auth.checkPincode(e.target.value).subscribe(
        (res) => {
          console.log(res);
          // if (res == null) {
          //   this.postCreateForm.get('pincodeId').setErrors({ 'notavail': false });

          // }
          // else {
          if (res != null) {
            //this.postCreateForm.get('pincode').setErrors({ 'notavail': true });
            this.filterForm.patchValue({
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

  onScroll(){    
    this.page++;
      this.getPosts(true);
  
  }


  openProfile(){
    if(this.auth.isUser()){
      this.router.navigate(['/profile']);
    }
    else if(this.auth.isOrganisation())
      this.router.navigate(['/orgprofile']);
  }

  closeForm(){
    this.isScroll = true;
    this.show=false;
    this.page=0;
    this.posts=[];
    this.isFiltered=false;
    
    this.filterForm.patchValue({
      sort: 'Latest',
      pincodeId: 0,
      stateId: 0,
      cityId: 0,
      requirementTypeId:0,
      pincod:0,
      username: ''

    });
    this.getPosts();
  }

}
