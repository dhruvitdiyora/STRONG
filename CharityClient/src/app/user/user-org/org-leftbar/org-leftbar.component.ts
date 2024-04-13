import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { OrgListDTO } from 'src/app/model/OrgListDTO.model';
import { AuthService } from 'src/app/services/auth.service';

@Component({
  selector: 'app-org-leftbar',
  templateUrl: './org-leftbar.component.html',
  styleUrls: ['./org-leftbar.component.css']
})
export class OrgLeftbarComponent implements OnInit {

  orgList: OrgListDTO;
  totalVolunteers: number;
  
  constructor(private activatedRoute: ActivatedRoute, 
    private auth: AuthService,) { }

  ngOnInit(): void {
    this.getOrg();
  }

  getOrg(){
    this.activatedRoute.paramMap.subscribe(params => {
      var id = params.get('orgid');
      this.auth.getOrgById(id).subscribe((response) => {
        this.orgList = response.model;
        this.totalVolunteers = response.total;
      });
    });
  }

}
