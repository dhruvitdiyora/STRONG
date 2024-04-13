import { Component, OnInit } from '@angular/core';
import { Router, ActivatedRoute } from '@angular/router';
import { BsModalRef, BsModalService } from 'ngx-bootstrap/modal';
import { FormArray, FormBuilder, FormControl, FormGroup, Validators } from '@angular/forms';
import { OrganisationForRegister, UserForRegister } from 'src/app/model/user';
import { ToastrService } from 'ngx-toastr';
import { AuthService } from 'src/app/services/auth.service';
import { LoginComponent } from '../login/login.component';

@Component({
  selector: 'app-register',
  templateUrl: './register.component.html',
  styleUrls: ['./register.component.css']
})
export class RegisterComponent implements OnInit {

  bsLoginModal!: BsModalRef;

  constructor(
    private fb: FormBuilder,
    public bsRegisterModal: BsModalRef,
    private authService: AuthService,
    private toastr: ToastrService,
    private router: Router,
    private loginModalService: BsModalService
  ) { }

  ngOnInit(): void {
    this.createRegisterForm();
  }

  //Close RegisterModal
  public closeRegisterModal() {
    this.bsRegisterModal.hide();
  }

  //registerForm
  registerForm: FormGroup;

  //cretating Register Form
  createRegisterForm() {
    this.registerForm = this.fb.group({
      SignUpAs: ['',Validators.required],
      Username: ['', Validators.required],
      Email: ['', [Validators.required, Validators.email]],
      PhoneNumber: ['', [Validators.required, Validators.pattern("^[6789][0-9]{9}$")]],
      Password: ['', [Validators.required, Validators.minLength(9)]],

    });
  }

  get SignUpAs() {
    return this.registerForm.get('SignUpAs').value;
  }

  get Username() {
    return this.registerForm.get('Username') as FormControl;
  }

  get Email() {
    return this.registerForm.get('Email') as FormControl;
  }

  get PhoneNumber() {
    return this.registerForm.get('PhoneNumber') as FormControl;
  }

  get Password() {
    return this.registerForm.get('Password') as FormControl;
  }

  //onRegister Method
  onRegister() {
    if (this.SignUpAs == "0") {
      this.authService.registerUser(this.registerForm.value).subscribe(
        (response: UserForRegister) => {
          // localStorage.setItem('username', JSON.stringify(user.username));
          // localStorage.setItem('token', JSON.stringify(user.token));
          this.toastr.success("Register Successful");
          this.bsLoginModal = this.loginModalService.show(LoginComponent);
        }, error => {
          console.log(error);
          this.toastr.error(JSON.stringify(error.error.message));
        }
      );
    }
    if(this.SignUpAs == "1"){
      this.authService.registerOrganisation(this.registerForm.value).subscribe(
        (response: OrganisationForRegister) => {
          // localStorage.setItem('username', JSON.stringify(user.username));
          // localStorage.setItem('token', JSON.stringify(user.token));
          this.toastr.success("Register Successful");
          this.bsLoginModal = this.loginModalService.show(LoginComponent);
        }, error => {
          console.log(error);
          this.toastr.error(JSON.stringify(error.error.message));
        }
      );
    }
  }



  // user: UserForRegister;
  // userData(): UserForRegister {
  //   return this.user = {
  //     username: this.Username.value,
  //     email: this.Email.value,
  //     phonenumber: this.PhoneNumber.value,
  //     password: this.Password.value,

  //   };
  // }

  // onRegister() {
  //   console.log(this.registerForm.value);
  //   // this.registerForm = true;
  //   if (this.registerForm.valid) {
  //     // this.user = Object.assign(this.user, this.registerationForm.value);
  //     this.authService.registerUser(this.userData()).subscribe(() => {
  //       this.toastr.success('Congrats, you are successfully registered');
  //     });
  //   }
  // }
}
