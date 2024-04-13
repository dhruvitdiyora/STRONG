import { Component, OnInit } from '@angular/core';
import { FormBuilder, NgForm } from '@angular/forms';
import { Router } from '@angular/router';
import { ToastrService } from 'ngx-toastr';
import { AdminAuthService } from '../services/admin-auth.service';
import { routerTransition } from '../services/router.animations';

@Component({
  selector: 'app-admin-login',
  templateUrl: './admin-login.component.html',
  styleUrls: ['./admin-login.component.css'],
  animations: [routerTransition()]
})
export class AdminLoginComponent implements OnInit {

  constructor(public router: Router,private auth:AdminAuthService,private toastr: ToastrService,private fb: FormBuilder,) { }

  ngOnInit(): void {
  }

  onLoggedin() {
    
    localStorage.setItem('isLoggedin', 'true');
    
  }
  onLogin(loginForm: NgForm) {
    this.auth.authAdmin(loginForm.value).subscribe(
      (response: any) => {
        localStorage.clear();
        const user = response;
        this.auth.setToken(user.token);
        this.auth.setUsername(user.username);
        this.auth.setRole(user.role);
        localStorage.setItem('isLoggedin', 'true');
        this.toastr.success("Login Successful");
        this.router.navigate(['/admin']);
      }, error => {
        console.log(error);
        this.toastr.error(JSON.stringify(error.error.message));
      }
    );
  }

}
