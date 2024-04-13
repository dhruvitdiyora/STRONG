import { HttpErrorResponse, HttpEvent, HttpHandler, HttpInterceptor, HttpRequest } from '@angular/common/http';
import { Injectable, Injector } from '@angular/core';
import { catchError, Observable, throwError } from 'rxjs';
import { AdminAuthService } from '../admin/shared/services/admin-auth.service';
import { AuthService } from './auth.service';

@Injectable()
export class AuthInterceptor implements HttpInterceptor {

  constructor(private injector: Injector) { }
  intercept(req: HttpRequest<any>, next: HttpHandler): Observable<HttpEvent<any>> {
    let authService = this.injector.get(AuthService); 
    var token = authService.getToken();
    if (token) {
      // If we have a token, we set it to the header
      req = req.clone({
        setHeaders: { Authorization: `Bearer ${token}` }
      });
    }
    let tokenReq = req.clone({
      setHeaders: {
        Authorization: `Bearer ${authService.getToken()}`
      }
    })

    return next.handle(tokenReq).pipe(
      catchError((err) => {
        if (err instanceof HttpErrorResponse) {
          if (err.status === 401) {
            // redirect user to the logout page


          }
        }
        return throwError(err);
      })
    )

  }

}
