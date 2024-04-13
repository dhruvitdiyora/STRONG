import { Component, OnInit } from '@angular/core';
import { AuthService } from '../services/auth.service';

@Component({
  selector: 'app-user',
  templateUrl: './user.component.html',
  styleUrls: ['./user.component.css']
})
export class UserComponent implements OnInit {

  constructor(private auth :AuthService) { }

  ngOnInit(): void {
    this.checkUser().then(x=>this.auth.userReg=x);
    this.checkOrg();
  }
  async checkUser():Promise<boolean> {
    var username = this.auth.getUsername();
    this.auth.getUserByUserName().subscribe(
      (res) => {
        if (res) {
          if (res.userName == username) {
            this.auth.userReg = true;
            return true;
          }
          return false;
        }
        else
          return false;
          //this.auth.userReg = false;
           
            
          },
      (error: any) => {
        return false;
            //this.notify.showSuccess("error", error);
      }
    );
    
      return false;
    //console.log(this.auth.checkUser());
  }
  checkOrg() {
    var username = this.auth.getUsername();
    this.auth.getOrgByUserName().subscribe(
      (res) => {
        if(res)
        {
          if (res.userName == username) {
            this.auth.orgReg = true;
          }
        }
        else
          this.auth.orgReg = false;
           
            
          },
          (error: any) => {
            //this.notify.showSuccess("error", error);
          }
        );

  }

}
