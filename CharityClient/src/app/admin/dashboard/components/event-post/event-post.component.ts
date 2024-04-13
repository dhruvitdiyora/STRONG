import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { ToastrService } from 'ngx-toastr';
import { AdminAuthService } from 'src/app/admin/shared/services/admin-auth.service';
import { ImageService } from 'src/app/services/image.service';

@Component({
  selector: 'app-event-post',
  templateUrl: './event-post.component.html',
  styleUrls: ['./event-post.component.css']
})
export class EventPostComponent implements OnInit {

  eventPostsList: any;
  displayStyle = "none";
  deleteId:number;
  displayEdit = "none";
  editEventId: number;
  imageURL: string = ''; 
  file: any;

  eventDetailForm: FormGroup
  pinVal= false;

  constructor(private auth: AdminAuthService, private toastr: ToastrService, private fb: FormBuilder, private image: ImageService) { }

  ngOnInit(): void {
    this.getAllCharityEventPosts();

    this.eventDetailForm = this.fb.group({
      charityEventPostId: [null,Validators.required],
      eventId: [null,Validators.required],
      userId: [null,Validators.required],
      postUrl: [null],
      content: [null,Validators.required],
      preview: [null],
    });
  }

  getAllCharityEventPosts() {
    this.auth.getCharityEventPosts().subscribe(response => {
      this.eventPostsList = response;
    },
      (error: any) => {
        console.log(error);
      }
    );
  }

  deleteCharityEventPost(){
    this.auth.deleteCharityEventPost(this.deleteId).subscribe(response => {
      this.closePopup();
      this.getAllCharityEventPosts();
    },
      (error: any) => {
        console.log(error);
      }
    );
  }
  openPopup(id:number) {
    this.deleteId = id;
    this.displayStyle = "block";
  }
  closePopup() {
    this.displayStyle = "none";
  }

  openEditEvent(id: number) {
    this.displayEdit = "block";
    this.editEventId = id;
    this.auth.getEventPostById(id).subscribe(response => {
      this.eventDetailForm.patchValue({
        charityEventPostId: response.charityEventPostId,
        eventId: response.eventId,
        userId: response.userId,
        content: response.content,
      })
      this.imageURL =  response.postUrl;
    },
      (error: any) => {
        console.log(error);
      }
    );
  }

  closeEventPostModal() {
    this.displayEdit = "none";
    this.eventDetailForm.reset();
  }

  editEvent(){
    const fd = new FormData();
    fd.append('post', JSON.stringify(this.eventDetailForm.value));
    if (this.file != null) {
      fd.append('file', this.file, this.file.name);
    }
    this.auth.editEventPost(this.editEventId, fd).subscribe(
      (data) => {
        //this.toastr.success(error.message);
        this.closeEventPostModal();
        this.getAllCharityEventPosts();
      },
      (error: any) => {
        this.closeEventPostModal();
        console.log(error);
        this.toastr.error(error.errors);
        this.getAllCharityEventPosts();
        //this.toastr.success(error.message);
        //this.notify.showSuccess("error", error);
      }
    );

    // stop here if form is invalid
    if (this.eventDetailForm.invalid) {
      return;
    }
    this.getAllCharityEventPosts();
  }

  showPreview(event) {
    const file = (event.target as HTMLInputElement).files[0];
    this.file = event.target.files[0];

    this.eventDetailForm.patchValue({
      preview: file
    });
    this.eventDetailForm.get('preview').updateValueAndValidity();

    // File Preview
    const reader = new FileReader();
    reader.onload = () => {
      this.imageURL = reader.result as string;
    };
    reader.readAsDataURL(file);
  }
}
