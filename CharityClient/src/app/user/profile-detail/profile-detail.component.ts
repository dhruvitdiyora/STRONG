import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { PostsDTO } from 'src/app/model/PostsDTO.model';
import { AuthService } from 'src/app/services/auth.service';
import { ImageService } from 'src/app/services/image.service';

@Component({
  selector: 'app-profile-detail',
  templateUrl: './profile-detail.component.html',
  styleUrls: ['./profile-detail.component.css']
})
export class ProfileDetailComponent implements OnInit {

  posts: any;
  id: any;;
  userUrl: string;
  postUrl: string;
  constructor(private auth: AuthService, private image: ImageService, private activatedRoute: ActivatedRoute,) { }

  ngOnInit(): void {
    //this.getPosts();
    this.getPostByUser();
    //this.getPost(7);

    //this.auth.getPostByUserId(2).subscribe(data=>this.posts=data);
    //console.log(this.posts);
    this.postUrl = this.image.getPost();
    this.userUrl = this.image.getProfile();

  }

  getPost(id: number) {
      this.auth.getUserByUserId(id).subscribe(
        (response) => {
          this.posts = response;

        },
        (error: any) => {
          console.log(error);
          //this.notify.showSuccess("error", error);
        }
      );
  }


  getPostByUser() {
    this.activatedRoute.paramMap.subscribe(params => {
      this.id = params.get('profileid');
      //console.log(id);
      this.getPost(Number(this.id));
    });
  }
}
