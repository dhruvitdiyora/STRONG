import { Injectable } from '@angular/core';
import { ActivatedRouteSnapshot, CanActivate, Router, RouterStateSnapshot, UrlTree } from '@angular/router';
import { BsModalRef, BsModalService } from 'ngx-bootstrap/modal';
import { Observable } from 'rxjs';
import { LoginComponent } from '../shared/login/login.component';
import { AuthService } from './auth.service';

@Injectable({
  providedIn: 'root'
})
export class AuthGuardGuard implements CanActivate {
  constructor(private auth: AuthService, private router: Router,private loginModalService: BsModalService) { }
  bsLoginModal!: BsModalRef;
  canActivate(
    route: ActivatedRouteSnapshot,
    state: RouterStateSnapshot): Observable<boolean | UrlTree> | Promise<boolean | UrlTree> | boolean | UrlTree {



      
      if (this.auth.isUser() || this.auth.isOrganisation()) {
        return true;
      }
      else {
        this.bsLoginModal = this.loginModalService.show(LoginComponent);
        return false;
      }
  }

}
