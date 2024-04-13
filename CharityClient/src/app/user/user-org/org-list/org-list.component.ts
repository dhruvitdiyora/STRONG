import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { OrgListDTO } from 'src/app/model/OrgListDTO.model';
import { AuthService } from 'src/app/services/auth.service';
import { ImageService } from 'src/app/services/image.service';

@Component({
  selector: 'app-org-list',
  templateUrl: './org-list.component.html',
  styleUrls: ['./org-list.component.css']
})
export class OrgListComponent implements OnInit {

  orgList: OrgListDTO[];
  orgsurl: string;


  constructor(private router: Router,
    private auth: AuthService,
    private image: ImageService,
    ) { }

  ngOnInit(): void {
    this.getOrgLists();
    this.orgsurl = this.image.getOrgProfile();
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

  // hasRoute(route: string) {
  //   return this.router.url.includes(route);
  // }
}
