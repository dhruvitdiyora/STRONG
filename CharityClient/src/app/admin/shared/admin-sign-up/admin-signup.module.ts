import { CommonModule } from '@angular/common';
import { NgModule } from '@angular/core';
import { AdminSignUpComponent } from './admin-sign-up.component';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { AdminSignupRoutingModule } from './admin-signup-routing.module';

@NgModule({
    imports: [CommonModule, AdminSignupRoutingModule,FormsModule,
    ReactiveFormsModule],
    declarations: [AdminSignUpComponent]
})
export class AdminSignupModule { }
