import { Component, Input, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import * as events from 'events';
import { BsModalRef, BsModalService } from 'ngx-bootstrap/modal';
import { ToastrService } from 'ngx-toastr';
import { EventListDTO } from 'src/app/model/EventListDTO.model';
import { EventPostsDTO } from 'src/app/model/EventPostsDTO.model';
import { AuthService } from 'src/app/services/auth.service';
import { ImageService } from 'src/app/services/image.service';
import { host } from 'src/environments/environment';
import { CreateEventComponent } from '../create-event/create-event.component';

@Component({
  selector: 'app-event-id',
  templateUrl: './event-id.component.html',
  styleUrls: ['./event-id.component.css']
})
export class EventIdComponent implements OnInit {

  // isCollapsedLeft = false;
  // isCollapsedRight = false;
  events: EventListDTO;
  eventBannerUrl: string;
  evePostsList: any;
  evePosturl: string;
  getUserProfile: string;
  createPostModal!: BsModalRef;
  eid: any;
  formDisplay = 'none';
  file: any;
  img: File;
  imageURL: string = '';
  submitted = false;
  EventList: events[];
  username: string;
  createEventPost: FormGroup;
  
  constructor(
    private activatedRoute: ActivatedRoute,
    private auth: AuthService,
    private image: ImageService,
    private createPost: BsModalService,
    private fb: FormBuilder,
    private router: Router,
    private toastr: ToastrService) { }

  displayStyle = "none";
  displayDelete = "none";
  postUsername: string;
  postDeleteId: number;
  isSameUser = false;
  displayDeleteEvent = "none";
  eventDeleteId: number;
  user = this.auth.getUsername();
  isUser: boolean;
  
  openPopup(id: number) {
    
    this.activatedRoute.parent.paramMap.subscribe(params => {
      var orgid = params.get('orgid');
      document.getElementById('shareEvent').setAttribute('value', host + 'organisation/' + orgid + '/event/' + id);
      this.displayStyle = "block";
      
    });
  }
  closePopup() {
    this.displayStyle = "none";
  }

  openDelete(id: number) {
    this.displayDelete = "block";
    this.auth.getEvePostById(id).subscribe(response => {
      this.postDeleteId = response.charityEventPostId;
    })
    
  }
  closeDelete() {
    this.displayDelete = "none";
  }

  openDeleteEvent(id: number) {
    this.displayDelete = "block";
    this.auth.getEventById(id).subscribe(response => {
      this.eventDeleteId = response.eventId;
    })
    
  }
  closeDeleteEvent() {
    this.displayDelete = "none";
  }

  deleteCharityEvent(){
    this.auth.deleteCharityEvent(this.eventDeleteId).subscribe(response => {
      this.closeDeleteEvent();
      this.getEvent();
    },
      (error: any) => {
        console.log(error);
      }
    );
  }
  
  openCreatEventePostForm() {
    //this.createPostModal=this.createPost.show(CreateEventPostComponent);
    this.formDisplay = 'block';
  };

  

  ngOnInit(): void {
    this.getEvent();
    this.eventBannerUrl = this.image.getEventBanner();
    this.getEventPost();
    this.evePosturl = this.image.getEventPost();
    this.getUserProfile = this.image.getProfile();
    this.isUser = this.auth.isUserReg();

    this.createEventPost = this.fb.group({
      eventId: [this.eid, Validators.required],
      //userId:[this.username,Validators.required],
      postUrl: [null, Validators.required],
      Content: [null, Validators.required],
      preview: [null]

    })

  }

  getEvent() {
    this.activatedRoute.paramMap.subscribe(params => {
      var id = params.get('eventid');
      this.eid = id;
      this.auth.getEventById(id).subscribe((response) => {
        this.events = response;
      });
    });
  }

  getEventPost() {
    this.activatedRoute.paramMap.subscribe(params => {
      var id = params.get('eventid');
      // console.log(id);
      this.auth.getEvePostByEveId(id).subscribe((response) => {
        this.evePostsList = response;
      });
    });
  }

  closeForm() {
    this.formDisplay = 'none';
    //this.router.navigate(['event/:eventid'])
    //window.open("https://localhost:4200/home", "_self");
  }

  showPreview(event) {
    const file = (event.target as HTMLInputElement).files[0];
    this.file = event.target.files[0];

    this.createEventPost.patchValue({
      preview: file
    });
    this.createEventPost.get('preview').updateValueAndValidity();

    // File Preview
    const reader = new FileReader();
    reader.onload = () => {
      this.imageURL = reader.result as string;
    };
    reader.readAsDataURL(file);
  }
  saveEventPost() {
    const fd = new FormData();
    fd.append('post', JSON.stringify(this.createEventPost.value));
    fd.append('file', this.file, this.file.name);

    this.auth.createEventPost(fd).subscribe(
      (data) => {
        //this.toastr.success(error.message);
        this.getEvent();
      this.getEventPost();
      },
      (error: any) => {
        console.log(error);
        this.getEvent();
        this.getEventPost();
      }
    );
    this.submitted = true;
    // stop here if form is invalid
    if (this.createEventPost.invalid) {
      return;
    }

    // display form values on success
    this.formDisplay = 'none';
    this.createEventPost.reset();
    this.imageURL='';
  }

  addInterested(charityEvent: number) {
    if (this.auth.isUser()) {
      this.auth.addInterested(
        {
          eventId: charityEvent,
          userId: 0,
        }
      ).subscribe(
        (response) => {
          this.toastr.success(response.message);
          this.getEventPost();
        },
        (error: any) => {
          console.log(error);
          this.toastr.error(error.message);
          //this.notify.showSuccess("error", error);
        }
      );
    }
    else {
      this.toastr.error("Please Login to show Interest");
    }
  }
  copyToClip() {
    var data = (<HTMLInputElement>document.getElementById("shareEvent")).value;
    navigator.clipboard.writeText(data);
    this.toastr.success("Link copied to Clipboard");
  }

  addGoing(charityEvent: number) {
    if (this.auth.isUser()) {
      this.auth.addGoing(
        {
          eventId: charityEvent,
          userId: 0,
        }
      ).subscribe(
        (response) => {
          this.toastr.success(response.message);
          this.getEvent();
          //this.posts = response;
        },
        (error: any) => {
          console.log(error);
          this.toastr.error(error.message);
          //this.notify.showSuccess("error", error);
        }
      );
    }
    else {
      this.toastr.error("Please Login to show Going");
    }
  }

  addLike(charityEventPost: number) {
    if (this.auth.isUser()) {
      this.auth.addLike(
        {
          charityEventPostId: charityEventPost,
          userId: 0,
        }
      ).subscribe(
        (response) => {
          this.toastr.success(response.message);
          this.getEventPost();
          //this.posts = response;
        },
        (error: any) => {
          console.log(error);
          this.toastr.error(error.message);
          //this.notify.showSuccess("error", error);
        }
      );
    }
    else {
      this.toastr.error("Please Login to Like this post");
    }
  }

  addDislike(charityEventPost: number) {
    if (this.auth.isUser()) {
      this.auth.addDislike(
        {
          charityEventPostId: charityEventPost,
          userId: 0,
        }
      ).subscribe(
        (response) => {
          this.toastr.success(response.message);
          this.getEventPost();
          //this.posts = response;
        },
        (error: any) => {
          console.log(error);
          this.toastr.error(error.message);
          //this.notify.showSuccess("error", error);
        }
      );
    }
    else {
      this.toastr.error("Please Login to Dislike this post");
    }
  }

  deleteEventPost() {
    this.auth.deleteCharityEventPost(this.postDeleteId).subscribe(response => {
      this.closeDelete();
      this.getEvent();
      this.getEventPost();
    },
      (error: any) => {
        console.log(error);
        this.closeDelete();
        this.getEvent();
      this.getEventPost();
      }
    );
   }
}
