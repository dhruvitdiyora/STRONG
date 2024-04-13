import { Component, Input, OnInit } from '@angular/core';
import { PostsDTO } from 'src/app/model/PostsDTO.model';
import { AuthService } from 'src/app/services/auth.service';
import { ImageService } from 'src/app/services/image.service';
import { BsModalRef, BsModalService } from 'ngx-bootstrap/modal';
import { CreatePostComponent } from '../create-post/create-post.component';
import { ToastrService } from 'ngx-toastr';
@Component({
  selector: 'app-post-info',
  templateUrl: './post-info.component.html',
  styleUrls: ['./post-info.component.css']
})
export class PostInfoComponent implements OnInit {


  createPostModal!: BsModalRef;
  openCreateForm() {
    if(this.auth.getUserReg())
    {
      this.createPostModal = this.createPost.show(CreatePostComponent)

    }
    else{
      this.toastr.error('Please Create Profile properly to add post');
    }
    
  };
  //@Input() post: PostsDTO;
  posts: PostsDTO[];
  displayStyle = "none";

  openPopup() {
    this.displayStyle = "block";
  }
  closePopup() {
    this.displayStyle = "none";
  }

  constructor(private auth: AuthService,
    private createPost: BsModalService,
    private toastr: ToastrService
  ) { }

  postButtonShow:boolean;

  ngOnInit(): void {
    this.getPosts();
    //this.postButtonShow = this.auth.userReg;
  }
  ngOnChanges(): void {
    this.getPosts();
    //this.postButtonShow = this.auth.userReg;
  }
  onUpdateChild(): void{
    this.getPosts();
  }

  getPosts() {
    if (this.auth.isUserReg()) {
      this.auth.getPostUser().subscribe(
        (response) => {
          this.posts = response;
        },
        (error: any) => {
          console.log(error);
          //this.notify.showSuccess("error", error);
        }
      );
    }
    else {
      this.auth.getPost().subscribe(
        (response) => {
          this.posts = response;
        },
        (error: any) => {
          console.log(error);
          //this.notify.showSuccess("error", error);
        }
      );
    }
  
    this.postButtonShow = this.auth.isUser();
  }

}
