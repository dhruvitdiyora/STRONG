import { Component, OnInit } from '@angular/core';
import { NavigationEnd, Router } from '@angular/router';
import { ToastrService } from 'ngx-toastr';
import { AdminAuthService } from 'src/app/admin/shared/services/admin-auth.service';

@Component({
    selector: 'app-header',
    templateUrl: './header.component.html',
    styleUrls: ['./header.component.css']
})
export class HeaderComponent implements OnInit {
    // public pushRightClass: string;

    loggedinUser:string;

    constructor(
        public router: Router, 
        private auth: AdminAuthService, 
        private toastr: ToastrService) {
        // this.router.events.subscribe((val) => {
        //     if (val instanceof NavigationEnd && window.innerWidth <= 992 && this.isToggled()) {
        //         this.toggleSidebar();
        //     }
        // });
    }

    ngOnInit() {
        this.loggedin();
        // this.pushRightClass = 'push-right';
    }

    // isToggled(): boolean {
    //     const dom: any = document.querySelector('body');
    //     return dom.classList.contains(this.pushRightClass);
    // }

    // toggleSidebar() {
    //     const dom: any = document.querySelector('body');
    //     dom.classList.toggle(this.pushRightClass);
    // }

    // rltAndLtr() {
    //     const dom: any = document.querySelector('body');
    //     dom.classList.toggle('rtl');
    // }

    // onLoggedout() {
    //     localStorage.removeItem('isLoggedin');
    // }

    loggedin() {

        if (!!localStorage.getItem('usernameAd')) {
          this.loggedinUser = this.auth.getUsername();
          
          return this.loggedinUser;
        }
        return null;
    
      }
    
      onLogout() {
        // localStorage.removeItem('token');
        localStorage.clear();
        this.toastr.error('You are logged out !');
        window.location.reload();
      }

}
