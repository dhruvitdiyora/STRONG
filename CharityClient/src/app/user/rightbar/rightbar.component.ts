import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { EventListDTO } from 'src/app/model/EventListDTO.model';
import { OrgListDTO } from 'src/app/model/OrgListDTO.model';
import { AuthService } from 'src/app/services/auth.service';

@Component({
  selector: 'app-rightbar',
  templateUrl: './rightbar.component.html',
  styleUrls: ['./rightbar.component.css']
})
export class RightbarComponent implements OnInit {

  orgList: OrgListDTO[];
  eventList: EventListDTO[];

  constructor(
    private auth: AuthService,
  ) { }

  ngOnInit(): void {
    this.getOrgLists();
    this.getEventLists();
  }

  getOrgLists() {
    this.auth.getOrgList().subscribe(
      (response) => {
        this.orgList = response;
      },
      (error: any) => {
        console.log(error);
        //this.notify.showSuccess("error", error);
      }
    );
  }

  getEventLists() {
    this.auth.getEventList().subscribe(
      (response) => {
        
        this.eventList = response;
      },
      (error: any) => {
        console.log(error);
        //this.notify.showSuccess("error", error);
      }
    );
  }
}
