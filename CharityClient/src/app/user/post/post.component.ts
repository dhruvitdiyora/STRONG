import { Component, EventEmitter, Input, OnInit, Output } from '@angular/core';
import { BsModalService } from 'ngx-bootstrap/modal';
import { ToastrService } from 'ngx-toastr';
import { count } from 'rxjs';
import { Bookmark } from 'src/app/model/Bookmark.model';
import { City } from 'src/app/model/City.model';
import { PostComment } from 'src/app/model/PostComment.model';
import { PostsDTO } from 'src/app/model/PostsDTO.model';
import { RequirementType } from 'src/app/model/RequirementType.model';
import { State } from 'src/app/model/State.model';
import { AuthService } from 'src/app/services/auth.service';
import { ImageService } from 'src/app/services/image.service';
import { baseUrl, host } from 'src/environments/environment';
import { PostInfoComponent } from '../post-info/post-info.component';

@Component({
  selector: 'app-post',
  templateUrl: './post.component.html',
  styleUrls: ['./post.component.css'],
})
export class PostComponent implements OnInit {
  @Input() post: PostsDTO;
  @Output()
  getPostToChild: EventEmitter<any> = new EventEmitter<any>(); 
  cities: City[];
  states: State[];
  reqType: RequirementType[];
  postCmnt: any;
  posturl: string;
  userurl: string;
  comment: string;
  allSpam: any;
  isSpam: boolean;
  isUrgent: boolean;
  isBookmark: boolean;
  totSpam: number;
  totUrgency: number;
  totComment: number;
  allUrgency: any;
  bookList: Bookmark;
  constructor(
    private image: ImageService,
    private auth: AuthService,
    private createPost: BsModalService,
    private toastr: ToastrService
  ) {}

  // postComp = new PostInfoComponent(this.auth,this.createPost,this.toastr);
  userReg :boolean;
  orgReg :boolean
  ngOnInit(): void {
    this.getCityList();
    this.getStateList();
    this.getReqList();
    this.posturl = this.image.getPost();
    this.userurl = this.image.getProfile();
    this.isSpam = this.post.isSpam;
    this.isUrgent = this.post.isUrgency;
    this.isBookmark = this.post.isBookmark;
    this.setTotals();

    
    //this.auth.getSpam(1).subscribe(data=>{this.allSpam=data})
  }
  setTotals() {
    //this.totSpam = this.isSpam ? this.post.urgencyCount:1;
    this.totSpam = this.post.spamCount;
    this.totComment = this.post.commentsCount;
    this.totUrgency = this.post.urgencyCount;
  }
  ngOnChanges(): void{
    this.ngOnInit();
  }
  displayStyle = 'none';
  urgencyDisplay = 'none';
  cmntDisplay = 'none';
  spamDisplay = 'none';

  openUrgency(id, count: number) {
    if (count == 0) {
      this.toastr.error('There is no Urgency to show');
    } else {
      this.auth.getUrgency(id).subscribe(
        (response) => {
          this.urgencyDisplay = 'block';
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
    this.urgencyDisplay = 'none';
  }
  openSpam(id: number, count: number) {
    if (count == 0) {
      this.toastr.error('There is no Spam to show');
    } else {
      this.auth.getSpam(id).subscribe(
        (response) => {
          this.spamDisplay = 'block';
          this.allSpam = response;
        },
        (error: any) => {
          console.log(error);
          //this.notify.showSuccess("error", error);
        }
      );
    }
  }
  closeSpam() {
    this.spamDisplay = 'none';
  }
  openComment(id: number, count: number) {
    if (count == 0) {
      this.toastr.error('There is no comments to show');
    } else
      this.auth.getComment(id).subscribe(
        (response) => {
          this.cmntDisplay = 'block';

          this.postCmnt = response;
        },
        (error: any) => {
          console.log(error);
          //this.notify.showSuccess("error", error);
        }
      );
  }
  closeComment() {
    this.cmntDisplay = 'none';
  }
  openPopup(id:number) {
    document.getElementById('sharepost').setAttribute('value', host+'post/'+id);
    this.displayStyle = 'block';
  }
  closePopup() {
    this.displayStyle = 'none';
  }
  copyToClip() {
    var data = (<HTMLInputElement>document.getElementById("sharepost")).value;
    navigator.clipboard.writeText(data);
    this.toastr.success("Link copied to Clipboard");
  }
  cityName(id: number) {
    if (this.cities != undefined)
      return this.cities.find((f) => f.cityId === id)?.cityName;
    return null;
  }
  stateName(id: number) {
    if (this.states != undefined)
      return this.states.find((f) => f.stateId === id)?.stateName;
    return null;
  }
  reqTypeName(id: number) {
    if (this.reqType != undefined)
      return this.reqType.find((f) => f.requirementTypeId === id)
        ?.requirementTypeName;
    return null;
  }
  goToLink(lat: number, long: number) {
    const url =
      'https://www.google.com/maps/search/?api=1&query=' + lat + ',' + long;
    window.open(url, '_blank');
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
    );
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
    );
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
          if (this.isBookmark)
            this.isBookmark = false;
          else
            this.isBookmark = true;
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
  addComment(post: number) {
    if (this.auth.isUserReg()) {
      this.auth
        .addComment({
          postId: post,
          comment: this.comment,
        })
        .subscribe(
          (response) => {
            // window.location.reload();
            this.toastr.success(response.message);
            this.comment = "";
            this.totComment++;

            //this.getPostToChild.emit(); 
            //this.posts = response;
          },
          (error: any) => {
            console.log(error);
            this.toastr.error(error.message);
            //this.notify.showSuccess("error", error);
          }
        );
    } else if(!this.auth.isUser()){
      this.toastr.error('Please Login as user to add comment');
    }
    else {
      this.toastr.error('Please Create Profile properly to add comment');
    }
    
  }
  addSpam(post: number) {
    if (this.auth.isUserReg()) {
      this.auth
        .addSpam({
          postId: post,
          userId: 0,
        })
        .subscribe(
          (response) => {
            this.toastr.success(response.message);
            // this.postComp.getPosts();
            //this.getPostToChild.emit(); 
            if (this.isSpam) {
              this.totSpam--;
              this.isSpam = false;
            }
              
            else {
              this.totSpam++;
              this.isSpam = true;
            }
             

            //this.posts = response;
          },
          (error: any) => {
            console.log(error);
            this.toastr.error(error.message);
            //this.notify.showSuccess("error", error);
          }
        );
    } else if(!this.auth.isUser()){
      this.toastr.error('Please Login as user to add spam');
    }
    else {
      this.toastr.error('Please Create Profile properly to add spam');
    }
  }
  checkUser() {
    this.auth.getUserByUserName().subscribe(
      (res) => {
        
        if (res) {
          localStorage.setItem('isUser', JSON.stringify(res.message))
        }
          },
      (error: any) => {
        console.log(error);
      }
    );
  }
  checkOrg() {
    this.auth.getOrgByUserName().subscribe(
      (res) => {
        
        if (res) {
          localStorage.setItem('isOrg', JSON.stringify(res.message))
        }
          },
      (error: any) => {
        console.log(error);
      }
    );
  }
  addUrgency(post: number) {
    if (this.auth.isUserReg()) {
      this.auth
        .addUrgency({
          postId: post,
          userId: 0,
        })
        .subscribe(
          (response) => {
            this.toastr.success(response.message);
            //this.getPostToChild.emit(); 
            if (this.isUrgent) {
              this.totUrgency--;
              this.isUrgent = false;
            }
              
            else {
              this.totUrgency++;
              this.isUrgent = true;
            }

            //this.posts = response;
          },
          (error: any) => {
            console.log(error);
            this.toastr.error(error.message);
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
