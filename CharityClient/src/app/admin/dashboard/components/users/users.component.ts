import { Component, OnInit } from '@angular/core';
import { AdminAuthService } from 'src/app/admin/shared/services/admin-auth.service';

@Component({
  selector: 'app-users',
  templateUrl: './users.component.html',
  styleUrls: ['./users.component.css']
})
export class UsersComponent implements OnInit {

  usersList: any;
  displayStyle = "none";
  deleteId:number;

  constructor(private auth: AdminAuthService) { }

  ngOnInit(): void {
    this.getAllUserDatas();
  }

  getAllUserDatas() {
    this.auth.getUserDatas().subscribe(response => {
      this.usersList = response;
    },
      (error: any) => {
        console.log(error);
      }
    );
  }

  deleteUserData(){
    this.auth.deleteUserData(this.deleteId).subscribe(response => {
      this.closePopup();
      this.getAllUserDatas();
    },
      (error: any) => {
        console.log(error);
      }
    );
  }
  openPopup(id:number) {
    this.deleteId = id;
    this.displayStyle = "block";
  }
  closePopup() {
    this.displayStyle = "none";
  }
}
