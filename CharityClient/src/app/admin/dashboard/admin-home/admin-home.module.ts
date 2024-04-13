import { CommonModule } from '@angular/common';
import { NgModule } from '@angular/core';
import { NgbDropdownModule } from '@ng-bootstrap/ng-bootstrap';
import { AdminHomeRoutingModule } from './admin-home-routing.module';
import { AdminHomeComponent } from './admin-home.component';

@NgModule({
    imports: [CommonModule, AdminHomeRoutingModule, NgbDropdownModule],
    declarations: [AdminHomeComponent]
})
export class AdminHomeModule { }
