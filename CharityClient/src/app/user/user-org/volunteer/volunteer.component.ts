import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { AuthService } from 'src/app/services/auth.service';

@Component({
  selector: 'app-volunteer',
  templateUrl: './volunteer.component.html',
  styleUrls: ['./volunteer.component.css']
})
export class VolunteerComponent implements OnInit {

  volList: any;

  constructor(
    private activatedRoute: ActivatedRoute, 
    private auth: AuthService,
  ) { }

  ngOnInit(): void {
    this.getVols();
  }

  getVols(){
    this.activatedRoute.parent.paramMap.subscribe(params => {
      var id = params.get('orgid');
      this.auth.getVolByOrgId(id).subscribe((response) => {
        this.volList = response;
        console.log(response);
      });
    });
  }

}
