import { Component, OnInit } from '@angular/core';
import { Router, ActivatedRoute } from '@angular/router';
import { FormArray, FormBuilder, FormControl, FormGroup, Validators, NgForm } from '@angular/forms';
import { BsModalRef, BsModalService } from 'ngx-bootstrap/modal';
import { RegisterComponent } from 'src/app/shared/register/register.component';
import { ForgotPasswordComponent } from '../forgot-password/forgot-password.component';
import { AuthService } from 'src/app/services/auth.service';
import { ToastrService } from 'ngx-toastr';
import { UserForLogin } from 'src/app/model/user';




@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.css'],
})
export class LoginComponent implements OnInit {

  verified=false;
  // Modal Content
  constructor(
    private fb: FormBuilder,
    public bsLoginModal: BsModalRef,
    private forgotPwService: BsModalService,
    private registerService: BsModalService,
    private authService: AuthService,
    private toastr: ToastrService,
    private router: Router
  ) { }

  ngOnInit(): void {
  };

  //To Open ForgotPwModal
  bsForgotPwModal!: BsModalRef;

  public openForgotPwModal() {
    /* this is how we open a Modal Component from another component */
    this.bsLoginModal.hide();
    this.bsForgotPwModal = this.forgotPwService.show(ForgotPasswordComponent);
  }

  //To Open RegisterModal
  bsRegisterModal!: BsModalRef;

  public openRegisterModal() {
    /* this is how we open a Modal Component from another component */
    this.bsLoginModal.hide();
    this.bsRegisterModal = this.registerService.show(RegisterComponent);
  }

  //To Close LoginModal
  public closeLoginModal() {
    this.bsLoginModal.hide();
  }
  checkUser(loginForm:NgForm)
  {
    this.authService.checkUser(loginForm.value).subscribe(
      (response: any) => {
        if (response)
          if (response.status=="Success")
            this.verified = true;
      }, error => {
        console.log(error);
        this.toastr.error(JSON.stringify(error.error.message));
      }

    );
  }

  //onLogin Method
  onLogin(loginForm: NgForm) {
    
    this.authService.authUser(loginForm.value,loginForm.value.OTP).subscribe(
      (response: any) => {
        localStorage.clear();
        const user = response;
        this.authService.setToken(user.token);
        this.authService.setUsername(user.username);
        this.authService.setRole(user.role);
        if (this.authService.isUser())
          this.checkUserAvail();
        if (this.authService.isOrganisation())
          this.checkOrgAvail();

        this.toastr.success("Login Successful");
        if(this.authService.isUser())
          if(!this.authService.isUserReg())
            this.router.navigate(['/home']);
        if(this.authService.isOrganisation())
          if(!this.authService.isOrgReg())
            this.router.navigate(['/home']);
      }, error => {
        console.log(error);
        this.toastr.error(JSON.stringify(error.error.message));
      }
    );
  }
  checkUserAvail() {
    this.authService.getUserByUserName().subscribe(
      (res) => {
        
        if (res) {
          localStorage.setItem('isUser', JSON.stringify(res.message))
        }
          },
      (error: any) => {
        console.log(error);
      }
    );
    //console.log(this.auth.checkUser());
  }
  async checkOrgAvail() {
    this.authService.getOrgByUserName().subscribe(
      (res) => {
        
        if (res) {
          localStorage.setItem('isOrg', JSON.stringify(res.message))
        }
          },
      (error: any) => {
        console.log(error);
      }
    );
  }
}

