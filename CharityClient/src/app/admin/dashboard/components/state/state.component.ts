import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { ToastrService } from 'ngx-toastr';
import { AdminAuthService } from 'src/app/admin/shared/services/admin-auth.service';
import { NgxPaginationModule } from 'ngx-pagination';


@Component({
  selector: 'app-state',
  templateUrl: './state.component.html',
  styleUrls: ['./state.component.css']
})
export class StateComponent implements OnInit {

  stateList: any;
  displayStyle = "none";
  displayAdd = "none";
  deleteId: number;
  isAdd = false;
  isEdit= false;
  editStateId: number;
  stateDetailForm: FormGroup;
  p: number = 1;
  count: number = 10;

  constructor(private auth: AdminAuthService, private toastr: ToastrService, private fb: FormBuilder
  ) { }

  ngOnInit(): void {
    this.getAllStates();

    this.stateDetailForm = this.fb.group({
      stateName: [null, Validators.required]
    });
  }

  getAllStates() {
    this.auth.getStates().subscribe(response => {
      this.stateList = response;
    },
      (error: any) => {
        console.log(error);
      }
    );
  }

  deleteState() {
    this.auth.deleteState(this.deleteId).subscribe(response => {
      this.closePopup();
      this.getAllStates();
    },
      (error: any) => {
        this.closePopup();
        this.toastr.error(error.error.message);

      }
    );
  }
  openPopup(id: number) {
    this.deleteId = id;
    this.displayStyle = "block";
  }
  closePopup() {
    this.displayStyle = "none";
  }

  openAddState() {
    this.isAdd = true;
    this.displayAdd = "block";
  }

  openEditState(id: number) {
    this.isEdit = true;
    this.displayAdd = "block";

    this.editStateId = id;
    this.auth.getStateById(id).subscribe(response => {
      this.stateDetailForm.patchValue({
        stateName: response.stateName
      })
    },
      (error: any) => {
        console.log(error);
      }
    );
  }
  closeStateModal() {
    this.isAdd = false;
    this.isEdit = false;
    this.displayAdd = "none";
    this.stateDetailForm.reset();
  }

  addState() {
    if (this.auth.isAdmin()) {
      this.auth.createState(this.stateDetailForm.value).subscribe(data => {
        //this.toastr.success(error.message);
        this.closeStateModal();
        this.getAllStates();
      },
        (error: any) => {
          this.closeStateModal();
          console.log(error);
          this.toastr.error(error.errors);
          this.getAllStates();
          //this.toastr.success(error.message);
          //this.notify.showSuccess("error", error);
        }
      );
    }
  }

  editState(){
    if (this.auth.isAdmin()) {
    this.auth.editState(this.editStateId, this.stateDetailForm.value).subscribe(
      (data) => {
        //this.toastr.success(error.message);
        this.closeStateModal();
        this.getAllStates();
      },
      (error: any) => {
        this.closeStateModal();
        console.log(error);
        this.toastr.error(error.errors);
        //this.notify.showSuccess("error", error);
      }
    );
    }
  }
}
