import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators, FormControl } from '@angular/forms';
import { BsModalRef } from 'ngx-bootstrap/modal';
import { BsModalService } from 'ngx-bootstrap/modal';
import { RegisterComponent} from 'src/app/shared/register/register.component';
import { ResetPasswordComponent } from '../reset-password/reset-password.component';

@Component({
  selector: 'app-forgot-password',
  templateUrl: './forgot-password.component.html',
  styleUrls: ['./forgot-password.component.css']
})
export class ForgotPasswordComponent implements OnInit {

  constructor(
    private fb: FormBuilder, 
    public bsForgotPwModal: BsModalRef, 
    private resetPwService: BsModalService) { }

  ngOnInit(): void {
  }

  //open Reset Password Modal
  bsResetPwModal!: BsModalRef;
  
  public openResetPwModal() {
  /* this is how we open a Modal Component from another component */
  this.bsForgotPwModal.hide();
  this.bsResetPwModal = this.resetPwService.show(ResetPasswordComponent);
}

//To close Forgot Password Modal
public closeForgotPwModal(){
  this.bsForgotPwModal.hide();
}

// Forgot Password Form
forgotPwForm = this.fb.group({
  Email:['',[Validators.required,Validators.email]],
  OTP:['',Validators.required],
});

get Email(){
  return this.forgotPwForm.get('Email');
}

get OTP(){
  return this.forgotPwForm.get('OTP');
}
} 
