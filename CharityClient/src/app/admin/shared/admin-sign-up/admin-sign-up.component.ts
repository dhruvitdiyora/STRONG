import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormControl, FormGroup, NgForm, Validators } from '@angular/forms';
import { Router } from '@angular/router';
import { ToastrService } from 'ngx-toastr';
import { AdminAuthService } from '../services/admin-auth.service';
import { routerTransition } from '../services/router.animations';

@Component({
  selector: 'app-admin-sign-up',
  templateUrl: './admin-sign-up.component.html',
  styleUrls: ['./admin-sign-up.component.css'],
  animations: [routerTransition()]
})
export class AdminSignUpComponent implements OnInit {

  submitForm: FormGroup;
  error_messages = {

    'Username': [
      { type: 'required', message: 'User Name is required.' }
    ],
    'Email': [
      { type: 'required', message: 'Email is required.' },
      { type: 'minlength', message: 'Email length.' },
      { type: 'maxlength', message: 'Email length.' },
      { type: 'email', message: 'please enter a valid email address.' }
    ],

    'PhoneNumber': [
      { type: 'required', message: 'Email is required.' },
      { type: 'pattern', message: 'Please, Enter 10 digit Mobile Number.' },
    ],

    'Password': [
      { type: 'required', message: 'password is required.' },
      { type: 'minlength', message: 'password length.' },
      { type: 'maxlength', message: 'password length.' }
    ],
    'confirmpassword': [
      { type: 'required', message: 'password is required.' },
      { type: 'minlength', message: 'password length.' },
      { type: 'maxlength', message: 'password length.' }
    ],
  }
  constructor(public router: Router,private auth:AdminAuthService,private toastr: ToastrService,private fb: FormBuilder) { }

  ngOnInit(): void {
    this.submitForm = this.fb.group({
       Username: new FormControl('', Validators.compose([
        Validators.required,
      ])),
      PhoneNumber: ['', [Validators.required, Validators.pattern("^((\\+91-?)|0)?[0-9]{10}$")]],
      Email: new FormControl('', Validators.compose([
        Validators.required,
         Validators.email,
        Validators.minLength(6),
        Validators.maxLength(30)
      ])),
      Password: new FormControl('', Validators.compose([
        Validators.required,
        Validators.minLength(6),
        Validators.maxLength(30)
      ])),
      confirmpassword: new FormControl('', Validators.compose([
        Validators.required,
        Validators.minLength(6),
        Validators.maxLength(30)
      ])),
    }, { 
      validators: this.Password.bind(this)
    });
  }
  Password(formGroup: FormGroup) {
    const { value: Password } = formGroup.get('Password');
    const { value: confirmPassword } = formGroup.get('confirmpassword');
    return Password === confirmPassword ? null : { passwordNotMatch: true };
  }

  onSubmit() {
    this.auth.regAdmin(this.submitForm.value).subscribe(
      (response: any) => {
        // localStorage.clear();
        // console.log(response);
        // const user = response;
        // this.auth.setToken(user.token);
        // this.auth.setUsername(user.username);
        // this.auth.setRole(user.role);
        // localStorage.setItem('isLoggedin', 'true');
        // this.toastr.success("Login Successful");
        this.router.navigate(['/adminLogin']);
      }, error => {
        console.log(error);
        this.toastr.error(JSON.stringify(error.error.message));
      }
    );
  }
}
