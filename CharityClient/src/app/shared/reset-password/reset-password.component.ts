import { Component, OnInit } from '@angular/core';
import { BsModalRef } from 'ngx-bootstrap/modal';
import { BsModalService } from 'ngx-bootstrap/modal';
import {FormArray, FormBuilder, FormControl, FormGroup, Validators } from '@angular/forms';

@Component({
  selector: 'app-reset-password',
  templateUrl: './reset-password.component.html',
  styleUrls: ['./reset-password.component.css']
})
export class ResetPasswordComponent implements OnInit {

  constructor(private fb: FormBuilder, public bsResetPwModal: BsModalRef) { }

  ngOnInit(): void {
  }

  //To close Reset Password Modal
  public closeResetPwModal(){
    this.bsResetPwModal.hide();
  }

  resetPwForm = this.fb.group({
  // Email: ['',[Validators.required,Validators.email]],
  NewPassword:['',Validators.required],
  ConfirmPassword:['',Validators.required,],
});

get NewPassword(){
  return this.resetPwForm.get('NewPassword');
}

get ConfirmPassword(){
  return this.resetPwForm.get('ConfirmPassword');
}


password(formGroup: FormGroup) {
  var pw1 = formGroup.get('NewPassword');
  var pw2 = formGroup.get('confirmpassword');
  return pw1 === pw2 ? null : { passwordNotMatch: true };
}

}
