import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { ToastrService } from 'ngx-toastr';
import { AdminAuthService } from 'src/app/admin/shared/services/admin-auth.service';
import { State } from 'src/app/model/State.model';

@Component({
  selector: 'app-city',
  templateUrl: './city.component.html',
  styleUrls: ['./city.component.css']
})
export class CityComponent implements OnInit {

  cityList: any;
  displayStyle = "none";
  displayAdd = "none";
  deleteId:number;
  isAdd = false;
  isEdit= false;
  stateDropDown=false;
  editCityId: number;
  states: State[];
  p: number = 1;
  count: number = 100;

  cityDetailForm: FormGroup

  constructor(private auth: AdminAuthService, private toastr: ToastrService, private fb: FormBuilder) { }

  ngOnInit(): void {
    this.getAllCities();
    
    this.cityDetailForm = this.fb.group({
      stateId: [0, Validators.required],
      cityName: [null, Validators.required],
    });
    this.getState();
  }

  getAllCities() {
    this.auth.getCities().subscribe(response => {
      this.cityList = response;
    },
      (error: any) => {
        console.log(error);
      }
    );
  }

  deleteCity(){
    this.auth.deleteCity(this.deleteId).subscribe(response => {
      this.closePopup();
      this.getAllCities();
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

  openAddCity() {
    this.isAdd = true;
    this.displayAdd = "block";
  }

  openEditCity(id: number) {
    this.isEdit = true;
    this.displayAdd = "block";
    this.editCityId = id;
    this.auth.getCityById(id).subscribe(response => {
      this.cityDetailForm.patchValue({
        stateId: response.stateId,
        cityName: response.cityName
      })
    },
      (error: any) => {
        console.log(error);
      }
    );
  }

  closeCityModal() {
    this.isAdd = false;
    this.isEdit = false;
    this.displayAdd = "none";
    this.cityDetailForm.reset();
  }

  addCity(){
    if (this.auth.isAdmin()) {
      this.auth.createCity(this.cityDetailForm.value).subscribe(data => {
        //this.toastr.success(error.message);
        this.closeCityModal();
        this.getAllCities();
      },
        (error: any) => {
          this.closeCityModal();
          console.log(error);
          this.toastr.error(error.errors);
          this.getAllCities();
          //this.toastr.success(error.message);
          //this.notify.showSuccess("error", error);
        }
      );
    }
  }

  editCity(){
    if (this.auth.isAdmin()) {
      this.auth.editCity(this.editCityId, this.cityDetailForm.value).subscribe(
        (data) => {
          //this.toastr.success(error.message);
          this.closeCityModal();
          this.getAllCities();
        },
        (error: any) => {
          this.closeCityModal();
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
    const stateVal=this.cityDetailForm.get('stateId').value;
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
}
