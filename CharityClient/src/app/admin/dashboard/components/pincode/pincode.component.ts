import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { ToastrService } from 'ngx-toastr';
import { AdminAuthService } from 'src/app/admin/shared/services/admin-auth.service';
import { cities } from 'src/app/model/allcity.modal';
import { State } from 'src/app/model/State.model';
import { NgxPaginationModule } from 'ngx-pagination';


@Component({
  selector: 'app-pincode',
  templateUrl: './pincode.component.html',
  styleUrls: ['./pincode.component.css']
})
export class PincodeComponent implements OnInit {

  pincodeList: any;
  displayStyle = "none";
  displayAdd = "none";
  deleteId:number;
  isAdd = false;
  isEdit= false;
  stateDropDown=false;
  cityDropDown=false;
  editPincodeId: number;
  states: State[];
  cities: cities[];
  p: number = 1;
  count: number = 300;

  pincodeDetailForm: FormGroup

  constructor(private auth: AdminAuthService,private toastr: ToastrService, private fb: FormBuilder) { }

  ngOnInit(): void {
    this.getAllPincodes();

    this.pincodeDetailForm = this.fb.group({
      postOfficeName: [null,Validators.required],
      pincode1: [null,[Validators.required, Validators.minLength(6)]],
      district: [null,Validators.required],
      stateId: [0, Validators.required],
      cityId: [0, Validators.required],
    });
    this.getState();
    this.getCity();
  }

  getAllPincodes() {
    this.auth.getPincodes().subscribe(response => {
      this.pincodeList = response;
      console.log(response);
    },
      (error: any) => {
        console.log(error);
      }
    );
  }

  deletePincode(){
    this.auth.deletePincode(this.deleteId).subscribe(response => {
      this.closePopup();
      this.getAllPincodes();
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

  openAddPincode() {
    this.isAdd = true;
    this.displayAdd = "block";
  }

  openEditPincode(id: number) {
    this.isEdit = true;
    this.displayAdd = "block";
    this.editPincodeId = id;
    this.auth.getPincodeById(id).subscribe(response => {
      this.pincodeDetailForm.patchValue({
        postOfficeName: response.postOfficeName,
        pincode1: response.pincode1,
        district: response.district,
        stateId: response.stateId,
        cityId: response.cityId
      })
    },
      (error: any) => {
        console.log(error);
      }
    );
  }

  closePincodeModal() {
    this.isAdd = false;
    this.isEdit = false;
    this.displayAdd = "none";
    this.pincodeDetailForm.reset();
  }
  
  addPincode(){
    if (this.auth.isAdmin()) {
      this.auth.createPincode(this.pincodeDetailForm.value).subscribe(data => {
        //this.toastr.success(error.message);
        this.closePincodeModal();
        this.getAllPincodes();
      },
        (error: any) => {
          this.closePincodeModal();
          console.log(error);
          this.toastr.error(error.errors);
          this.getAllPincodes();
          //this.toastr.success(error.message);
          //this.notify.showSuccess("error", error);
        }
      );
    }
  }

  editPincode(){
    if (this.auth.isAdmin()) {
      this.auth.editPincode(this.editPincodeId, this.pincodeDetailForm.value).subscribe(
        (data) => {
          //this.toastr.success(error.message);
          this.closePincodeModal();
          this.getAllPincodes();
        },
        (error: any) => {
          this.closePincodeModal();
          console.log(error);
          this.toastr.error(error.errors);
          //this.notify.showSuccess("error", error);
        }
      );
    }
  }

  getState() {
    this.auth.getStates().subscribe((data) => {
      this.states = [{ stateId: 0, stateName: 'Select State' }, ...data];
    });
  }

  stateVal(){
    const stateVal=this.pincodeDetailForm.get('stateId').value;
    if(stateVal==0)
      {
        this.stateDropDown=true;
      }
      else
      {
        this.stateDropDown=false;
      }
    // console.log(this.editPostForm.get('cityId').value); 
  }

  getCity() {
    this.auth.getCities().subscribe((data) => {
      this.cities = [{ cityId: 0, cityName: 'Select City' }, ...data];
    });
  }

  cityVal(){
    const cityVal=this.pincodeDetailForm.get('cityId').value;
    if(cityVal==0)
      {
        this.cityDropDown=true;
      }
      else
      {
        this.cityDropDown=false;
      }
    // console.log(this.editPostForm.get('cityId').value); 
  }
}
