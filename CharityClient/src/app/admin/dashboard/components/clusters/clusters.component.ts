import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { ToastrService } from 'ngx-toastr';
import { AdminAuthService } from 'src/app/admin/shared/services/admin-auth.service';
import { cities } from 'src/app/model/allcity.modal';
import { State } from 'src/app/model/State.model';

@Component({
  selector: 'app-clusters',
  templateUrl: './clusters.component.html',
  styleUrls: ['./clusters.component.css']
})
export class ClustersComponent implements OnInit {

  clusterList: any;
  displayStyle = "none";
  deleteId: number;
  displayAdd = "none";
  isAdd = false;
  isEdit = false;
  stateDropDown = false;
  cityDropDown = false;
  editClusterId: number;
  states: State[];
  cities: cities[];
  postVal = false;

  clusterDetailForm: FormGroup

  constructor(private auth: AdminAuthService, private toastr: ToastrService, private fb: FormBuilder) { }

  ngOnInit(): void {
    this.getAllClusters();

    this.clusterDetailForm = this.fb.group({
      postId: [null, Validators.required],
      requirementTypeId: [0, Validators.required],
      clusterDetails: [null, Validators.required],
      stateId: [0, Validators.required],
      cityId: [0, Validators.required],
      peopleCount: [null, Validators.required],
      // pincod: [null, [Validators.required, Validators.minLength(6)]],
      pincodeId: [0, Validators.required]
    });
  }

  getAllClusters() {
    this.auth.getClusters().subscribe(response => {
      this.clusterList = response;
    },
      (error: any) => {
        console.log(error);
      }
    );
  }

  deleteCluster() {
    this.auth.deleteCluster(this.deleteId).subscribe(response => {
      this.closePopup();
      this.getAllClusters();
    },
      (error: any) => {
        console.log(error);
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

  openAddCluster() {
    this.isAdd = true;
    this.displayAdd = "block";
  }

  openEditCluster(id: number) {
    this.isEdit = true;
    this.displayAdd = "block";
    this.editClusterId = id;
    this.auth.getClusterById(id).subscribe(response => {
      this.clusterDetailForm.patchValue({
        postId: response.postId,
        requirementTypeId: response.requirementTypeId,
        clusterDetails: response.clusterDetails,
        peopleCount: response.peopleCount,
        pincodeId: response.pincodeId,
        stateId: response.stateId,
        cityId: response.cityId,
      })
    },
      (error: any) => {
        console.log(error);
      }
    );
  }

  closeClusterModal() {
    this.isAdd = false;
    this.isEdit = false;
    this.displayAdd = "none";
    this.clusterDetailForm.reset();
  }

  checkPost(e) {
    this.auth.checkPost(e.target.value).subscribe(
      (res) => {
        if (res) {
          this.postVal = true;
          this.clusterDetailForm.patchValue({
            requirementTypeId: res.requirementTypeId,
            clusterDetails: res.locationName,
            peopleCount: res.helpRequiredCount,
            pincodeId: res.pincodeId,
            stateId: res.stateId,
            cityId: res.cityId,
          });
        }
      },
      (error: any) => {
        console.log(error);
      }
    );
  }

  addCluster() {
    if (this.auth.isAdmin()) {
      this.auth.createCluster(this.clusterDetailForm.value).subscribe(data => {
        //this.toastr.success(error.message);
        this.closeClusterModal();
        this.getAllClusters();
      },
        (error: any) => {
          this.closeClusterModal();
          console.log(error);
          this.toastr.error(error.errors);
          this.getAllClusters();
          //this.toastr.success(error.message);
          //this.notify.showSuccess("error", error);
        }
      );
    }
  }

  editCluster(){
    if (this.auth.isAdmin()) {
    this.auth.editCluster(this.editClusterId, this.clusterDetailForm.value).subscribe(
      (data) => {
        //this.toastr.success(error.message);
        this.closeClusterModal();
        this.getAllClusters();
      },
      (error: any) => {
        this.closeClusterModal();
        console.log(error);
        this.toastr.error(error.errors);
        //this.notify.showSuccess("error", error);
      }
    );
    }
  }

}
