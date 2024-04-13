import { Component, OnInit } from '@angular/core';
import { NavbarComponent } from 'src/app/user/navbar/navbar.component';
import { Router } from '@angular/router';
import { ClusterDTO } from 'src/app/model/Cluster.model';
import { AuthService } from 'src/app/services/auth.service';


@Component({
  selector: 'app-cluster',
  templateUrl: './cluster.component.html',
  styleUrls: ['./cluster.component.css']
})
export class ClusterComponent implements OnInit {

  isCollapsedLeft = false;
  isCollapsedRight = false;

  clusters: ClusterDTO[];


  constructor(
    private auth: AuthService
  ) { }

  ngOnInit(): void {
  }

  

}
