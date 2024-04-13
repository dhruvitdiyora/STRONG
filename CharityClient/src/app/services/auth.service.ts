import { Injectable } from '@angular/core';
import { HttpClient, HttpHeaders, HttpParams } from '@angular/common/http';
import { UserForRegister, UserForLogin, OrganisationForRegister } from '../model/user';
import { environment } from '../../environments/environment';
import { map, Observable } from 'rxjs';
import { PostsDTO } from '../model/PostsDTO.model';
import { State } from '../model/State.model';
import { City } from '../model/City.model';
import { Pincode } from '../model/Pincode.model';
import { RequirementType } from '../model/RequirementType.model';
import { EncryptService } from './encrypt.service';
import { PostComponent } from '../user/post/post.component';
import { getCommentRange } from 'typescript';
import { Post } from '../model/Post.modal';
import { OrgListDTO } from '../model/OrgListDTO.model';
import { EventListDTO } from '../model/EventListDTO.model';
import { EventPostsDTO } from '../model/EventPostsDTO.model';
import { PostComment } from '../model/PostComment.model';
import { Spam } from '../model/Spam.model';
import { Bookmark } from '../model/Bookmark.model'
import { ClusterDTO } from '../model/Cluster.model';
import { PostLike } from '../model/PostLike.model';
import { EventInteract } from '../model/EventInteract.model';
import { JoinOrg } from '../model/JoinOrg.model';

@Injectable({
  providedIn: 'root',
})
export class AuthService {
  userReg: boolean;
  orgReg: boolean;
  baseUrl = environment.baseUrl;
  constructor(private http: HttpClient, private en: EncryptService) { }

  authUser(user: UserForLogin, otp: number) {
    let para = new HttpParams();
    para.append('otp', otp);
    return this.http.post(this.baseUrl + 'authenticate/login?otp=1234' , user);
  }
  checkUser(user: UserForLogin) {
    return this.http.post(this.baseUrl + 'authenticate/login?otp=1234', user);
  }

  registerUser(user: UserForRegister) {
    return this.http.post(this.baseUrl + 'authenticate/register', user);
  }
  registerOrganisation(user: OrganisationForRegister) {
    return this.http.post(this.baseUrl + 'authenticate/register-organisation', user);
  }
  getPost(): Observable<PostsDTO[]> {
    return this.http.get<PostsDTO[]>(`${this.baseUrl}post`);
  }
  editPost(id:number, fd: FormData): Observable<any> {
    return this.http.put(`${this.baseUrl}post/`+ id, fd);
  }
  deletePost(id: number): Observable<any> {
    return this.http.delete<any>(this.baseUrl+'post/'+id);
  }
  closePost(id: number): Observable<any> {
    return this.http.get<any>(this.baseUrl+'post/close/'+id);
  }
  getCluster(): Observable<any> {
    return this.http.get<any>(`${this.baseUrl}clusterLocation`);
  }
  // getPosts(sort): Observable<PostsDTO[]> {
  //   let params = new HttpParams().set("sort", sort);
  //   return this.http.get<PostsDTO[]>(`${this.baseUrl}post`,{params:params});
  // }
  // getPostUsers(sort): Observable<PostsDTO[]> {
  //   let params = new HttpParams().set("sort", sort);
  //   return this.http.get<PostsDTO[]>(`${this.baseUrl}post/user`,{params:params});
  // }
  getPostUser(): Observable<PostsDTO[]> {
    
    return this.http.get<PostsDTO[]>(this.baseUrl + 'post/user');
  }
  // getPostUsersFilter(fd: string,pin,city,state,req): Observable<PostsDTO[]> {
  //   let params = new HttpParams().set("username", fd);
  //   params =params.set("pincodeId", pin);
  //   params =params.set("cityId", city);
  //   params =params.set("stateId", state);
  //   params =params.set("reqType", req);
    
  //   return this.http.get<PostsDTO[]>(this.baseUrl + 'post/userFilter',{params:params});
  // }
  getPostHome(fd: string,pin,city,state,req,sort,page): Observable<PostsDTO[]> {
    let params = new HttpParams().set("username", fd);
    params =params.set("pincodeId", pin);
    params =params.set("cityId", city);
    params =params.set("stateId", state);
    params =params.set("reqType", req);
    params =params.set("sort", sort);
    params =params.set("page", page);
    
    return this.http.get<PostsDTO[]>(this.baseUrl + 'post/home',{params:params});
  }
  // getPostById(id: any): Observable<any> {
  //   return this.http.get<any>(`${this.baseUrl}post/${id}`);
  // }
  getPostById(id: any): Observable<any> {
    return this.http.get<any>(this.baseUrl+'post/'+id);
  }
  getPostByIds(id: any): Observable<any> {
    return this.http.get<any>(this.baseUrl+'post/any/'+id);
  }


  getUserByUserId(id: number): Observable<any> {
    return this.http.get<any>(`${this.baseUrl}userdata/user/${id}`);
  }

  getUserByUserName(): Observable<any> {
    var username = this.getUsername();
    return this.http.get<any>(`${this.baseUrl}userdata/username/${username}`);
  }

  getOrgByUserName(): Observable<any> {
    var username = this.getUsername();
    return this.http.get<any>(`${this.baseUrl}organisationData/details/${username}`);
  }


  getCity(): Observable<City[]> {
    return this.http.get<City[]>(`${this.baseUrl}Cities`);
  }
  getCityByState(sid:number): Observable<City[]> {
    return this.http.get<City[]>(`${this.baseUrl}cities/states/${sid}`);
  }
  getState(): Observable<State[]> {
    return this.http.get<State[]>(`${this.baseUrl}States`);
  }
  getPincode(): Observable<Pincode[]> {
    return this.http.get<Pincode[]>(`${this.baseUrl}Pincode`);
  }
  getReqType(): Observable<RequirementType[]> {
    return this.http.get<RequirementType[]>(`${this.baseUrl}requirementType`);
  }
  getOrgList(): Observable<OrgListDTO[]> {
    return this.http.get<OrgListDTO[]>(`${this.baseUrl}organisationData/verifiedorg`);
  }
  getOrgById(id: string): Observable<any> {
    return this.http.get<any>(`${this.baseUrl}organisationData/${id}`);
  }

  isJoined(id:string):Observable<any>
  {
    return this.http.get<any>(`${this.baseUrl}Volunteer/check/${id}`);
  }
  isSaved(id:number):Observable<any>{
    return this.http.get<any>(`${this.baseUrl}`)
  }

  getEventList(): Observable<EventListDTO[]> {
    return this.http.get<EventListDTO[]>(`${this.baseUrl}CharityEvent`);
  }
  getAllEvent(): Observable<any> {
    return this.http.get<any>(`${this.baseUrl}CharityEvent`);
  }
  getEventByOrgId(id: string): Observable<EventListDTO[]> {
    return this.http.get<EventListDTO[]>(
      `${this.baseUrl}CharityEvent/organisation/${id}`
    );
  }
  getEventById(id: any): Observable<EventListDTO> {
    return this.http.get<EventListDTO>(`${this.baseUrl}CharityEvent/${id}`);
  }
  deleteCharityEvent(id: number): Observable<any> {
    return this.http.delete<any>(`${this.baseUrl}CharityEvent/${id}`);
  }

  getEvePostByEveId(id: string): Observable<any> {
    return this.http.get<any>(`${this.baseUrl}CharityEventPost/eventid/${id}`);
  }
  getEvePostById(id: number): Observable<any> {
    return this.http.get<any>(`${this.baseUrl}CharityEventPost/${id}`);
  }

  getVolByOrgId(id: string): Observable<any> {
    return this.http.get<any>(`${this.baseUrl}volunteer/organisationid/${id}`);
  }

  getSpam(id: number): Observable<any> {
    return this.http.get(`${this.baseUrl}Spam/post/${id}`);
  }

  getUrgency(id: number): Observable<any> {
    return this.http.get(`${this.baseUrl}urgency/post/${id}`);
  }

  getComment(id: number): Observable<any> {
    return this.http.get(`${this.baseUrl}postComments/postid/${id}`);
  }

  getPostImage(id: string): Observable<any> {
    return this.http.get(`${this.baseUrl}PostImages/postid/${id}`);
  }
  getBookmark(id: number) : Observable<any>{
    return this.http.get(`${this.baseUrl}Bookmark/${id}`);
  }

  getallcity(): Observable<any> {
    return this.http.get(`${this.baseUrl}cities`);
  }
  createPost(fd: FormData): Observable<any> {
    return this.http.post(`${this.baseUrl}post`, fd);
  }
  addSpam(spam: Spam): Observable<any> {
    return this.http.post<any>(`${this.baseUrl}Spam`, spam);
  }
  addComment(comment: PostComment): Observable<any> {
    return this.http.post<any>(`${this.baseUrl}postComments`, comment);
  }
  addUrgency(urgency: Spam): Observable<any> {
    return this.http.post<any>(`${this.baseUrl}urgency`, urgency);
  }
  addLike(like: PostLike): Observable<any> {
    return this.http.post<any>(`${this.baseUrl}charityEventPostLike/like`, like);
  }
  addDislike(dislike: PostLike): Observable<any> {
    return this.http.post<any>(`${this.baseUrl}charityEventPostLike/dislike`, dislike);
  }
  addInterested(interested: EventInteract): Observable<any> {
    return this.http.post<any>(`${this.baseUrl}charityEventInteract/interested`, interested);
  }
  addGoing(going: EventInteract): Observable<any> {
    return this.http.post<any>(`${this.baseUrl}charityEventInteract/going`, going);
  }
  addVolunteer(join: JoinOrg): Observable<any> {
    return this.http.post<any>(`${this.baseUrl}volunteer`, join);
  }
  addBookmark(bookmark: Bookmark) : Observable<any>{
    return this.http.post<any>(`${this.baseUrl}bookmark`,bookmark);
  }
  
  checkPincode(pincode: number): Observable<any> {
    return this.http.get<any>(this.baseUrl + 'pincode/pincode/' + pincode);
  }
  hasRole(role: string) {
    return this.isAuthorized() && this.getRole() === role;
  }
  isUser() {
    return this.hasRole('User');
  }
  isOrganisation() {
    return this.hasRole('Organisation');
  }

  isUserReg() {
    if (this.isUser() && this.getUserReg())
      return true;
    return false;
  }
  isOrgReg() {
    if (this.isOrganisation() && this.getOrgReg())
      return true;
    return false;
  }
  getUserReg() {
    if (localStorage.getItem('isUser'))
      return JSON.parse(localStorage.getItem('isUser'));
    return false;
  }
  getOrgReg() {
    if (localStorage.getItem('isOrg'))
      return JSON.parse(localStorage.getItem('isOrg'));
    return false;
  }


  isAdmin() {
    return this.hasRole('Admin');
  }
  getToken() {
    if (this.isUser() || this.isOrganisation()) {
      if (localStorage.getItem('token')) {
        return JSON.parse(this.en.decryptData(localStorage.getItem('token')));
      }
      return null;
    } else if (this.isAdmin()) {
      if (localStorage.getItem('tokenAd')) {
        return JSON.parse(this.en.decryptData(localStorage.getItem('tokenAd')));
      }
      return null;
    }
    return null;
  }
  setToken(token: string) {
    localStorage.setItem('token', this.en.encryptData(JSON.stringify(token)));
  }
  getUsername() {
    if (localStorage.getItem('username')) {
      return JSON.parse(this.en.decryptData(localStorage.getItem('username')));
    }
    return null;
  }
  setUsername(token: string) {
    localStorage.setItem(
      'username',
      this.en.encryptData(JSON.stringify(token))
    );
  }
  getRole() {
    if (localStorage.getItem('role')) {
      return JSON.parse(this.en.decryptData(localStorage.getItem('role')));
    }
    return null;
  }
  setRole(token: string) {
    localStorage.setItem('role', this.en.encryptData(JSON.stringify(token)));
  }

  isAuthorized() {
    //return true;
    return !!localStorage.getItem('token') || !!localStorage.getItem('tokenAd');
  }

  createEvent(fd: FormData): Observable<any> {
    return this.http.post(`${this.baseUrl}CharityEvent`, fd);
  }

  createEventPost(fd: FormData): Observable<any> {
    return this.http.post(`${this.baseUrl}CharityEventPost`, fd);
  }
  deleteCharityEventPost(id: number): Observable<any> {
    return this.http.delete<any>(`${this.baseUrl}CharityEventPost/${id}`);
  }

  getUserInfo(): Observable<any> {
    return this.http.get(`${this.baseUrl}userdata/userinfo`);
  }

  getUserdataInfo(): Observable<any> {
    return this.http.get(`${this.baseUrl}userdata/userdatainfo`);
  }

  getPincodeById(id: number): Observable<any> {
    return this.http.get(`${this.baseUrl}pincode/${id}`)
  }
  updateUserData(id: number, fd: FormData): Observable<any> {
    return this.http.put(`${this.baseUrl}userdata/` + id, fd);
  }

  getPostByUserId():Observable<any>{
    return this.http.get(`${this.baseUrl}post/userpostforuser/`)
  }

  addUserData(fd: FormData): Observable<any> {
    return this.http.post(`${this.baseUrl}userdata`, fd);
  }

  getOrgData():Observable<any> {
    return this.http.get(`${this.baseUrl}OrganisationData/orginfo`);
  }

  updateOrgData(id: number, fd: FormData): Observable<any> {
    return this.http.put(`${this.baseUrl}OrganisationData/` + id, fd);
  }

  addOrgData(fd: FormData): Observable<any> {
    return this.http.post(`${this.baseUrl}OrganisationData`, fd);
  }


}
