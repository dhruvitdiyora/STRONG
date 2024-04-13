import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { ToastrService } from 'ngx-toastr';
import { AdminAuthService } from 'src/app/admin/shared/services/admin-auth.service';

@Component({
  selector: 'app-requirement-type',
  templateUrl: './requirement-type.component.html',
  styleUrls: ['./requirement-type.component.css']
})
export class RequirementTypeComponent implements OnInit {

  requirementList: any;
  displayStyle = "none";
  deleteId:number;displayAdd = "none";
  isAdd = false;
  isEdit= false;
  editRequirementTypeId: number;

  requirementTypeForm: FormGroup
  constructor(private auth: AdminAuthService, private toastr: ToastrService, private fb: FormBuilder
  ) { }


  ngOnInit(): void {
    this.getAllRequirements();

    this.requirementTypeForm = this.fb.group({
      requirementTypeName: [null, Validators.required]
    });
  }

  getAllRequirements() {
    this.auth.getRequirementTypes().subscribe(response => {
      this.requirementList = response;
    },
      (error: any) => {
        console.log(error);
      }
    );
  }

  deleteRequirement(){
    this.auth.deleteRequirement(this.deleteId).subscribe(response => {
      this.closePopup();
      this.getAllRequirements();
    },
      (error: any) => {
        this.closePopup();
        this.toastr.error(error.error.message);
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
  openAddRequirementType() {
    this.isAdd = true;
    this.displayAdd = "block";
  }

  openEditRequirementType(id: number) {
    this.isEdit = true;
    this.displayAdd = "block";

    this.editRequirementTypeId = id;
    this.auth.getRequirementTypeById(id).subscribe(response => {
      this.requirementTypeForm.patchValue({
        requirementTypeName: response.requirementTypeName
      })
    },
      (error: any) => {
        console.log(error);
      }
    );
  }
  closeRequirementTypeModal() {
    this.isAdd = false;
    this.isEdit = false;
    this.displayAdd = "none";
    this.requirementTypeForm.reset();
  }

  addRequirementType() {
    if (this.auth.isAdmin()) {
      this.auth.createRequirementType(this.requirementTypeForm.value).subscribe(data => {
        //this.toastr.success(error.message);
        this.closeRequirementTypeModal();
        this.getAllRequirements();
      },
        (error: any) => {
          this.closeRequirementTypeModal();
          console.log(error);
          this.toastr.error(error.errors);
          this.getAllRequirements();
          //this.toastr.success(error.message);
          //this.notify.showSuccess("error", error);
        }
      );
    }
  }

  editRequirementType(){
    if (this.auth.isAdmin()) {
    this.auth.editRequirementType(this.editRequirementTypeId, this.requirementTypeForm.value).subscribe(
      (data) => {
        //this.toastr.success(error.message);
        this.closeRequirementTypeModal();
        this.getAllRequirements();
      },
      (error: any) => {
        this.closeRequirementTypeModal();
        console.log(error);
        this.toastr.error(error.errors);
        //this.notify.showSuccess("error", error);
      }
    );
    }
  }
}
