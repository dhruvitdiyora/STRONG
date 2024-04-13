import { Component, OnInit } from '@angular/core';
import { BsModalService } from 'ngx-bootstrap/modal';
import { BsModalRef } from 'ngx-bootstrap/modal';
import { LoginComponent } from 'src/app/shared/login/login.component';
import { ToastrService } from 'ngx-toastr';
import { AuthService } from 'src/app/services/auth.service';
import { Router } from '@angular/router';


@Component({
  selector: 'app-navbar',
  templateUrl: './navbar.component.html',
  styleUrls: ['./navbar.component.css']
})
export class NavbarComponent implements OnInit {

  loggedinUser: String;
  isCollapsed = true;

  constructor(
    private loginModalService: BsModalService,
    private toastr: ToastrService,
    private auth: AuthService,
    private router: Router
  ) { }

  ngOnInit(): void {
  }

  bsLoginModal!: BsModalRef;

  public openLoginModal() {
    /* this is how we open a Modal Component from another component */
    this.bsLoginModal = this.loginModalService.show(LoginComponent);
  }


  loggedin() {

    if (!!localStorage.getItem('username')) {
      this.loggedinUser = this.auth.getUsername();
      return this.loggedinUser;
    }
    return null

  }

  openProfile(){
    if(this.auth.isUser()){
      this.router.navigate(['/profile']);
    }
    else if(this.auth.isOrganisation())
      this.router.navigate(['/orgprofile']);
  }
  onLogout() {
    // localStorage.removeItem('token');
    localStorage.clear();
    this.toastr.error('You are logged out !');
    window.location.reload();
  }

}
