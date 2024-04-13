import { Component, Input, OnInit } from '@angular/core';
import { ToastrService } from 'ngx-toastr';
import { AuthService } from 'src/app/services/auth.service';
import { ImageService } from 'src/app/services/image.service';
import { baseUrl, host } from 'src/environments/environment';
@Component({
  selector: 'app-user-post',
  templateUrl: './user-post.component.html',
  styleUrls: ['./user-post.component.css']
})
export class UserPostComponent implements OnInit {

  @Input() post: any;
  @Input() userURL:string;
  @Input() userName:any;
  cities: any;
  states: any;
  reqType: any;
  postCmnt:any;
  posturl: string;
  userurl: string;
  comment: string;
  allSpam:any;
  allUrgency:any;
  constructor(private image: ImageService, private auth: AuthService, private toastr: ToastrService) {

  }

  ngOnInit(): void {
    
    this.getCityList();
    this.getStateList();
    this.getReqList();
    this.posturl = this.image.getPost();
    this.userurl = this.image.getProfile();
    //this.auth.getSpam(1).subscribe(data=>{this.allSpam=data})
  }
  displayStyle = "none";
  urgencyDisplay="none";
  cmntDisplay ="none";
  spamDisplay="none";

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
    else if(!this.auth.isUser()){
      this.toastr.error('Please Login as user to add comment');
    }
    else {
      this.toastr.error('Please Create Profile properly to add comment');
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
    else if(!this.auth.isUser()){
      this.toastr.error('Please Login as user to add spam');
    }
    else {
      this.toastr.error('Please Create Profile properly to add spam');
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
    else if(!this.auth.isUser()){
      this.toastr.error('Please Login as user to add urgency');
    }
    else {
      this.toastr.error('Please Create Profile properly to add urgency');
    }
  }
}

