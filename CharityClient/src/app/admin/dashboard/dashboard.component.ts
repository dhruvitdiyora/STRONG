import { Component, OnInit } from '@angular/core';
import { routerTransition } from '../shared/services/router.animations';

@Component({
  selector: 'app-dashboard',
  templateUrl: './dashboard.component.html',
  styleUrls: ['./dashboard.component.css'],
  animations: [routerTransition()]
})
export class DashboardComponent implements OnInit {

  collapedSideBar: boolean;
  constructor() { }

  ngOnInit(): void {
  }
  receiveCollapsed($event: boolean) {
    this.collapedSideBar = $event;
  }

}
