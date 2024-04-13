import { Component, Input, OnInit, ViewChild, ElementRef } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { NgxGalleryImage, NgxGalleryOptions, NgxGalleryAnimation } from '@kolkov/ngx-gallery';
import { ToastrService } from 'ngx-toastr';
import { count } from 'rxjs';
import { PostsDTO } from 'src/app/model/PostsDTO.model';
import { RequirementType } from 'src/app/model/RequirementType.model';
import { AuthService } from 'src/app/services/auth.service';
import { ImageService } from 'src/app/services/image.service';
import { host } from 'src/environments/environment';
@Component({
  selector: 'app-post-detail',
  templateUrl: './post-detail.component.html',
  styleUrls: ['./post-detail.component.css']
})
export class PostDetailComponent implements OnInit {
  @ViewChild('target') private cmntDetail: any;



  galleryOptions: NgxGalleryOptions[];
  galleryImages: NgxGalleryImage[];
  show = false;
  lng: any;
  lat: any;
  bookmark: number;
  cmntShow(id: number, count: number) {

    if (count == 0) {
      this.toastr.error("There is no comments to show");
    }
    else

      this.auth.getComment(id).subscribe(
        (response) => {
          this.show = true;
          this.postCmnt = response;
        },
        (error: any) => {
          console.log(error);
          //this.notify.showSuccess("error", error);
        }
      );
  }

  constructor(private activatedRoute: ActivatedRoute,
    private auth: AuthService, private toastr: ToastrService,
    private image: ImageService,) { }

  postDetail: any;
  postImages: any;
  postUrl: string;
  userUrl: string;
  comment: string;
  postCmnt: any;
  allSpam: any;
  allUrgency: any;
  userurl: string;
  reqType: RequirementType[];




  ngOnInit(): void {
    this.galleryOptions = [
      {
        width: '100%',
        height: '500px',
        thumbnailsColumns: 4,
        imageAnimation: NgxGalleryAnimation.Slide,
        preview: true
      }
    ];

    this.galleryImages = [];
    this.getPost();
    this.postUrl = this.image.getPost();
    this.userUrl = this.image.getProfile();


    if (navigator) {
      navigator.geolocation.getCurrentPosition(location => {
        this.lng = this.postDetail.longitude;
        this.lat = this.postDetail.latitude;
      });
    }
  }

  getPost() {
    this.activatedRoute.paramMap.subscribe(params => {
      var id = params.get('postid');
      this.auth.getPostById(id).subscribe((response) => {
        this.postDetail = response;
        var img =  this.postDetail.postImages[0].imageUrl1;
        var img2 = this.postDetail.postImages[0].imageUrl2;
        var img3 = this.postDetail.postImages[0].imageUrl4;
        var img4 = this.postDetail.postImages[0].imageUrl4;
        this.galleryImages = [
          {
            small: img,
            medium: img,
            big: img
          },
          {
            small: img2,
            medium: img2,
            big: img2
          }, {
            small: img3,
            medium: img3,
            big: img3
          },
          {
            small: img4,
            medium: img4,
            big: img4
          }
        ];
        //console.log(this.postDetail.postImage);
      });
    });
  }

  addComment(post: number) {
    if (this.auth.getUserReg()) {
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
    if (this.auth.getUserReg()) {
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
    if (this.auth.getUserReg()) {
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

  displayStyle = "none";
  urgencyDisplay = "none";
  spamDisplay = "none";

  openUrgency(id, count: number) {
    if (count == 0) {
      this.toastr.error("There is no Urgency to show");
    }
    else {

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
  openSpam(id: number, count: number) {
    if (count == 0) {
      this.toastr.error("There is no Spam to show");
    }
    else {

      this.auth.getSpam(id).subscribe(
        (response) => {
          this.spamDisplay = "block";
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
    this.spamDisplay = "none";
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
  reqTypeName(id: number) {
    if (this.reqType != undefined)
      return this.reqType.find(f => f.requirementTypeId === id)?.requirementTypeName;
    return null;
  }
  goToLink(lat: number, long: number) {
    const url = "https://www.google.com/maps/search/?api=1&query=" + lat + "," + long;
    window.open(url, "_blank");
  }

}

