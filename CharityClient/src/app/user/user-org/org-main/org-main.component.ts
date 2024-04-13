import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { OrgListDTO } from 'src/app/model/OrgListDTO.model';
import { AuthService } from 'src/app/services/auth.service';

@Component({
  selector: 'app-org-main',
  templateUrl: './org-main.component.html',
  styleUrls: ['./org-main.component.css']
})
export class OrgMainComponent implements OnInit {

  isCollapsedLeft = false;
  isCollapsedRight = false;

  // orgList:OrgListDTO;
  // orgId:string;

  constructor(private router:Router, private auth: AuthService) { }

  ngOnInit(): void {
    // this.orgList= this.auth.getOrgList();
  }


  // hasRoute(route: string) {
  //   return this.router.url.includes(route);
  // }
}
