import { CommonModule } from '@angular/common';
import { NgModule } from '@angular/core';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { AdminLoginRoutingModule } from './admin-login-routing.module';
import { AdminLoginComponent } from './admin-login.component';

@NgModule({
    imports: [CommonModule, AdminLoginRoutingModule,FormsModule,
    ReactiveFormsModule
],
    declarations: [AdminLoginComponent]
})
export class AdminLoginModule { }
