import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { BsModalRef, BsModalService } from 'ngx-bootstrap/modal';
import { ToastrService } from 'ngx-toastr';
import { EventListDTO } from 'src/app/model/EventListDTO.model';
import { AuthService } from 'src/app/services/auth.service';
import { ImageService } from 'src/app/services/image.service';
import { host } from 'src/environments/environment';
import { CreatePostComponent } from '../../create-post/create-post.component';
import { CreateEventComponent } from '../create-event/create-event.component';

@Component({
  selector: 'app-event',
  templateUrl: './event.component.html',
  styleUrls: ['./event.component.css']
})
export class EventComponent implements OnInit {

  createPostModal!: BsModalRef;
  isOrg: boolean;
  openCreatEventeForm() {
    this.createPostModal = this.createPost.show(CreateEventComponent)
  };
  constructor(private activatedRoute: ActivatedRoute,
    private auth: AuthService,
    private image: ImageService,
    private createPost: BsModalService,
    private toastr: ToastrService) { }

  eventList: EventListDTO[];
  eventBannerUrl: string;
  displayDelete = "none";
  eventDeleteId: number;
  user = this.auth.getUsername();

  ngOnInit(): void {
    this.getEvents();
    this.eventBannerUrl = this.image.getEventBanner();
    this.isOrg = this.auth.isOrgReg();
  }

  getEvents() {
    this.activatedRoute.parent.paramMap.subscribe(params => {
      var id = params.get('orgid');
      this.auth.getEventByOrgId(id).subscribe((response) => {
        this.eventList = response;
      });
    });
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
          //this.posts = response;
        },
        (error: any) => {
          console.log(error);
          this.toastr.success(error.message);
          //this.notify.showSuccess("error", error);
        }
      );
    }
    else {
      this.toastr.error("Please Login to show Interest");
    }
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
          //this.posts = response;
        },
        (error: any) => {
          console.log(error);
          this.toastr.success(error.message);
          //this.notify.showSuccess("error", error);
        }
      );
    }
    else {
      this.toastr.error("Please Login to show Going");
    }
  }


  displayStyle = "none";
  
  openPopup(id:number) {
    this.activatedRoute.parent.paramMap.subscribe(params => {
      var orgid = params.get('orgid');
      document.getElementById('shareEvent').setAttribute('value', host+'organisation/'+orgid+'/event/'+id);
    })
    this.displayStyle = "block";
  }
  closePopup() {
    this.displayStyle = "none";
  }
  copyToClip() {
    var data = (<HTMLInputElement>document.getElementById("shareEvent")).value;
    navigator.clipboard.writeText(data);
    this.toastr.success("Link copied to Clipboard");
  }

  openDelete(id: number) {
    this.displayDelete = "block";
    this.auth.getEventById(id).subscribe(response => {
      this.eventDeleteId = response.eventId;
    })
    
  }
  closeDelete() {
    this.displayDelete = "none";
  }

  deleteCharityEvent(){
    this.auth.deleteCharityEvent(this.eventDeleteId).subscribe(response => {
      this.closeDelete();
      this.getEvents();
    },
      (error: any) => {
        console.log(error);
      }
    );
  }
}
