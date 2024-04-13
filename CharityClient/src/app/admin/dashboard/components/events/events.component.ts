import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { ToastrService } from 'ngx-toastr';
import { AdminAuthService } from 'src/app/admin/shared/services/admin-auth.service';
import { ImageService } from 'src/app/services/image.service';

@Component({
  selector: 'app-events',
  templateUrl: './events.component.html',
  styleUrls: ['./events.component.css']
})
export class EventsComponent implements OnInit {

  eventsList: any;
  displayStyle = "none";
  displayEdit = "none";
  deleteId:number;
  editEventId: number;
  imageURL: string = '';
  file: any;

  eventDetailForm: FormGroup
  pinVal= false;

  constructor(private auth: AdminAuthService, private toastr: ToastrService, private fb: FormBuilder, private image: ImageService) { }

  ngOnInit(): void {
    this.getAllCharityEvents();

    this.eventDetailForm = this.fb.group({
      eventId: [null,Validators.required],
      eventName: [null,Validators.required],
      eventDescription: [null,Validators.required],
      eventOrganiserId: [null],
      eventStartDate: [null,Validators.required],
      eventEndDate:[null,Validators.required],
      eventBannerUrl: [null],
      eventType: [null,Validators.required],
      pincod: [null, [Validators.required, Validators.minLength(6)]],
      pincodeId: [0,Validators.required],
      locationName: [null],
      preview: [null],
    });
  }

  getAllCharityEvents() {
    this.auth.getCharityEvents().subscribe(response => {
      this.eventsList = response;
      
    },
      (error: any) => {
        console.log(error);
      }
    );
  }

  deleteCharityEvent(){
    this.auth.deleteCharityEvent(this.deleteId).subscribe(response => {
      this.closePopup();
      this.getAllCharityEvents();
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
    this.auth.getEventById(id).subscribe(response => {
      this.eventDetailForm.patchValue({
        eventId: response.eventId,
        eventName: response.eventName,
        eventDescription: response.eventDescription,
        eventOrganiserId: response.eventOrganiserId,
        eventStartDate: response.eventStartDate,
        eventEndDate:response.eventEndDate,
        // eventBannerUrl: [null],
        eventType: response.eventType,
        pincod: response.pincode.pincode1,
        pincodeId: response.pincodeId,
        locationName: response.locationName,
      })
      this.imageURL = response.eventBannerUrl;
    },
      (error: any) => {
        console.log(error);
      }
    );
  }

  closeEventModal() {
    this.displayEdit = "none";
    this.eventDetailForm.reset();
  }

  editEvent(){
    const fd = new FormData();
    fd.append('charityEvent', JSON.stringify(this.eventDetailForm.value));
    if (this.file != null) {
      fd.append('file', this.file, this.file.name);
    }
    this.auth.editEvent(this.editEventId, fd).subscribe(
      (data) => {
        //this.toastr.success(error.message);
        this.closeEventModal();
        this.getAllCharityEvents();
      },
      (error: any) => {
        this.closeEventModal();
        console.log(error);
        this.toastr.error(error.errors);
        this.getAllCharityEvents();
        //this.toastr.success(error.message);
        //this.notify.showSuccess("error", error);
      }
    );

    // stop here if form is invalid
    if (this.eventDetailForm.invalid) {
      return;
    }
    this.getAllCharityEvents();
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

  checkPincode(e) {
    if (e.target.value.length === 6) {
      this.auth.checkPincode(e.target.value).subscribe(
        (res) => {
          if (res != null) {
            this.pinVal=true;
            this.eventDetailForm.patchValue({
              pincodeId: res.pincodeId,
            });
          }
        },
        (error: any) => {
          console.log(error);
        }
      );
    }
  }
}
