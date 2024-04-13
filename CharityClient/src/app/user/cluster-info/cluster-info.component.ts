import { Component, Input, OnInit } from '@angular/core';
import { NavbarComponent } from 'src/app/user/navbar/navbar.component';
import { ClusterDTO } from 'src/app/model/Cluster.model';
import { ToastrService } from 'ngx-toastr';
import { importType } from '@angular/compiler/src/output/output_ast';
import { AuthService } from 'src/app/services/auth.service';
import { host } from 'src/environments/environment';

@Component({
  selector: 'app-cluster-info',
  templateUrl: './cluster-info.component.html',
  styleUrls: ['./cluster-info.component.css']
})
export class ClusterInfoComponent implements OnInit {

  clusters: any;
  displayStyle = "none";

  openPopup(id: number) {
    document.getElementById('sharepost').setAttribute('value', host+'cluster/'+id);
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
  lng: any;
  lat: any;
  constructor(
    private auth: AuthService,
    private toastr: ToastrService,
  ) { 
    
  }

  ngOnInit(): void {
    this.getClusters();
    if (navigator)
    {
    navigator.geolocation.getCurrentPosition( clusters => {
        this.lng = this.clusters.post.longitude;
        this.lat = this.clusters.post.latitude;
      });
    }
  }

  getClusters() {
    this.auth.getCluster().subscribe(
      (response) => {
        this.clusters = response;
        console.log(response);
      },
      (error: any) => {
        console.log(error);
        //this.notify.showSuccess("error", error);
      }
    );
}
goToLink(lat: number, long: number) {
  const url = "https://www.google.com/maps/search/?api=1&query=" + long + "," + lat;
  window.open(url, "_blank");
}
}
