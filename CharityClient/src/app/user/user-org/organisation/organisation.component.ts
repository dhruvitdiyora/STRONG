import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { OrgListDTO } from 'src/app/model/OrgListDTO.model';
import { AuthService } from 'src/app/services/auth.service';
import { ImageService } from 'src/app/services/image.service';

@Component({
  selector: 'app-organisation',
  templateUrl: './organisation.component.html',
  styleUrls: ['./organisation.component.css']
})
export class OrganisationComponent implements OnInit {

  orgList: OrgListDTO[];
  orgsurl: string;

  isCollapsedLeft = false;
  isCollapsedRight = false;


  constructor(private router: Router,
    private auth: AuthService,
    private image: ImageService)
    {}
   

  ngOnInit(): void {
    this.getOrgLists();
    this.orgsurl = this.image.getProfile();
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
}
