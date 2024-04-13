import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { BsModalRef, BsModalService } from 'ngx-bootstrap/modal';
import { ToastrService } from 'ngx-toastr';
import { AuthService } from 'src/app/services/auth.service';
import { CreatePostComponent } from '../create-post/create-post.component';
@Component({
  selector: 'app-leftbar',
  templateUrl: './leftbar.component.html',
  styleUrls: ['./leftbar.component.css']
})
export class LeftbarComponent implements OnInit {

  constructor( private createPost: BsModalService,private toastr: ToastrService,
    private auth: AuthService,
    private router: Router) { }

  ngOnInit(): void {
  }
  createPostModal!: BsModalRef;
  openCreateForm(){
    this.createPostModal=this.createPost.show(CreatePostComponent)
  };
  openProfile(){
    if(this.auth.isUser()){
      this.router.navigate(['/profile']);
    }
    else if(this.auth.isOrganisation())
      this.router.navigate(['/orgprofile']);
  }



}
