import { Injectable } from '@angular/core';
import { base } from 'src/environments/environment';

@Injectable({
  providedIn: 'root'
})
export class ImageService {

  constructor() { }
  getEventBanner() {
    const ur = "assets/images/organisations/events/banner/";
    return base + ur;
  }
  getEventPost() {
    const ur = "assets/images/organisations/events/posts/";
    return base + ur;
  }
  getPost() {
    const ur = "assets/images/users/posts/";
    return base + ur;
  }
  getProfile() {
    const ur = "assets/images/users/profile/";
    return base + ur;
  }
  getOrgProfile() {
    const ur = "assets/images/organisations/profile/";
    return base + ur;
  }
}
