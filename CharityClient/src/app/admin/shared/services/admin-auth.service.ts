import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { State } from 'src/app/model/State.model';
import { EncryptService } from 'src/app/services/encrypt.service';
import { environment } from 'src/environments/environment';

@Injectable({
  providedIn: 'root'
})
export class AdminAuthService {
   baseUrl = environment.baseUrl;
 constructor(private http: HttpClient, private en: EncryptService) { }
  login(data: any) {
    return this.http.post(`${this.baseUrl}/Authentication/login-admin`, data);
  }
  logout() {
    localStorage.clear();
  }

  getUser(): string | null {
    return localStorage.getItem('user');
  }

  isLoggedIn(): boolean {
    return localStorage.getItem('isLoggedin') !== null;
  }
  authAdmin(model: any) {
     return this.http.post<any>(`${this.baseUrl}authenticate/login-admin`, model);
       // return this.http.post(`${baseUrl}authenticate/login-admin`, model);
  }
  regAdmin(model: any) {
    return this.http.post<any>(`${this.baseUrl}authenticate/register-admin`, model);
  }
  getToken() {
        if (localStorage.getItem('tokenAd')) {
          console.log(this.en.decryptData(localStorage.getItem('tokenAd')));
          
            return JSON.parse(this.en.decryptData(localStorage.getItem('tokenAd')));
        }
        return null;


    }
    setToken(token: string) {
        localStorage.setItem('tokenAd', this.en.encryptData(JSON.stringify(token)));
    }
    getUsername() {
        const usern = localStorage.getItem('usernameAd');
        return JSON.parse(this.en.decryptData(usern));
    }
    setUsername(token: string) {
        localStorage.setItem('usernameAd', this.en.encryptData(JSON.stringify(token)));
    }
    getRole() {
        const roles = JSON.parse(this.en.decryptData(localStorage.getItem('role')));
        return roles;
    }
    setRole(token: string) {
        localStorage.setItem('role', this.en.encryptData(JSON.stringify(token)));
    }

    isAuthorized() {
        return !!localStorage.getItem('tokenAd');
    }
  isAdmin() {
        return this.hasRole("Admin")
  }
  hasRole(role: string) {
        return this.isAuthorized() && this.getRole() === role;
    }
  
  getVerifiedPosts(): Observable<any> {
    return this.http.get<any>(`${this.baseUrl}post/verifiedpost`);
  }
  getUnVerifiedPosts(): Observable<any> {
    return this.http.get<any>(`${this.baseUrl}post/unverifiedpost`);
  }
  getPostById(id: number): Observable<any> {
    return this.http.get<any>(this.baseUrl+'post/any/'+id);
  }
  editPost(id:number, fd: FormData): Observable<any> {
    return this.http.put(`${this.baseUrl}post/`+ id, fd);
  }
  verifyPost(id: number): Observable<any> {
    return this.http.get<any>(this.baseUrl+'post/verification/'+id);
  }
  deletePost(id: number): Observable<any> {
    return this.http.delete<any>(this.baseUrl+'post/'+id);
  }
  checkPost(postId: number): Observable<any> {
    return this.http.get<any>(this.baseUrl + 'post/' + postId);
  }

  getStates(): Observable<State[]> {
    return this.http.get<State[]>(`${this.baseUrl}states`);
  }
  getStateById(id: number): Observable<any> {
    return this.http.get<any>(this.baseUrl+'states/'+id);
  }
  createState(state: FormData): Observable<any>{
    return this.http.post(`${this.baseUrl}states`, state)
  }
  editState(id:number, state: FormData): Observable<any> {
    return this.http.put(this.baseUrl+'states/'+id, state);
  }
  deleteState(id: number): Observable<State> {
    return this.http.delete<State>(`${this.baseUrl}states/${id}`);
  }

  getCities(): Observable<any> {
    return this.http.get<any>(`${this.baseUrl}cities`);
  }
  getCityById(id: number): Observable<any> {
    return this.http.get<any>(this.baseUrl+'cities/'+id);
  }
  createCity(city: FormData): Observable<any>{
    return this.http.post(`${this.baseUrl}cities`, city)
  }
  editCity(id:number, city: FormData): Observable<any> {
    return this.http.put(this.baseUrl+'cities/'+id, city);
  }
  deleteCity(id: number): Observable<any> {
    return this.http.delete<any>(`${this.baseUrl}cities/${id}`);
  }

  getPincodes(): Observable<any> {
    return this.http.get<any>(`${this.baseUrl}pincode`);
  }
  getPincodeById(id: number): Observable<any> {
    return this.http.get<any>(this.baseUrl+'pincode/'+id);
  }
  createPincode(pincode: FormData): Observable<any>{
    return this.http.post(`${this.baseUrl}pincode`, pincode)
  }
  editPincode(id:number, pincode: FormData): Observable<any> {
    return this.http.put(this.baseUrl+'pincode/'+id, pincode);
  }
  deletePincode(id: number): Observable<any> {
    return this.http.delete<any>(`${this.baseUrl}pincode/${id}`);
  }
  checkPincode(pincode: number): Observable<any> {
    return this.http.get<any>(this.baseUrl + 'pincode/pincode/' + pincode);
  }

  getClusters(): Observable<any> {
    return this.http.get<any>(`${this.baseUrl}clusterLocation`);
  }
  createCluster(cluster: FormData): Observable<any>{
    return this.http.post(`${this.baseUrl}clusterLocation`, cluster)
  }
  editCluster(id:number, cluster: FormData): Observable<any> {
    return this.http.put(this.baseUrl+'clusterLocation/'+id, cluster);
  }
  getClusterById(id: number): Observable<any> {
    return this.http.get<any>(this.baseUrl+'clusterLocation/'+id);
  }
  deleteCluster(id: number): Observable<any> {
    return this.http.delete<any>(`${this.baseUrl}clusterLocation/${id}`);
  }

  getRequirementTypes(): Observable<any> {
    return this.http.get<any>(`${this.baseUrl}RequirementType`);
  }
  getRequirementTypeById(id: number): Observable<any> {
    return this.http.get<any>(this.baseUrl+'RequirementType/'+id);
  }
  createRequirementType(requirementType: FormData): Observable<any>{
    return this.http.post(`${this.baseUrl}RequirementType`, requirementType)
  }
  editRequirementType(id:number, requirementType: FormData): Observable<any> {
    return this.http.put(this.baseUrl+'RequirementType/'+id, requirementType);
  }
  deleteRequirement(id: number): Observable<any> {
    return this.http.delete<any>(`${this.baseUrl}RequirementType/${id}`);
  }

  getUserDatas(): Observable<any> {
    return this.http.get<any>(`${this.baseUrl}userData`);
  }
  getUserById(id: number): Observable<any> {
    return this.http.get<any>(this.baseUrl+'userData/'+id);
  }
  editUser(id:number, userData: FormData): Observable<any> {
    return this.http.put(this.baseUrl+'userData/'+id, userData);
  }
  deleteUserData(id: number): Observable<any> {
    return this.http.delete<any>(`${this.baseUrl}userData/${id}`);
  }

  getVerifiedOrgs(): Observable<any> {
    return this.http.get<any>(`${this.baseUrl}organisationData/verifiedorg`);
  }
  getUnVerifiedOrgs(): Observable<any> {
    return this.http.get<any>(`${this.baseUrl}organisationData/unverifiedorg`);
  }
  getOrgById(id: number): Observable<any> {
    return this.http.get<any>(this.baseUrl+'organisationData/'+id);
  }
  editOrg(id:number, fd: FormData): Observable<any> {
    return this.http.put(this.baseUrl+'organisationData/'+id, fd);
  }
  verifyOrg(id: number): Observable<any> {
    return this.http.get<any>(this.baseUrl+'organisationData/verification/'+id);
  }
  deleteOrganisationData(id: number): Observable<any> {
    return this.http.delete<any>(this.baseUrl+'organisationData/'+id);
  }

  getCharityEvents(): Observable<any> {
    return this.http.get<any>(`${this.baseUrl}CharityEvent`);
  }
  getEventById(id: number): Observable<any> {
    return this.http.get<any>(this.baseUrl+'charityEvent/'+id);
  }
  editEvent(id:number, fd: FormData): Observable<any> {
    return this.http.put(this.baseUrl+'charityEvent/'+id, fd);
  }
  deleteCharityEvent(id: number): Observable<any> {
    return this.http.delete<any>(`${this.baseUrl}CharityEvent/${id}`);
  }

  getCharityEventPosts(): Observable<any> {
    return this.http.get<any>(`${this.baseUrl}CharityEventPost`);
  }
  getEventPostById(id: number): Observable<any> {
    return this.http.get<any>(this.baseUrl+'charityEventPost/'+id);
  }
  editEventPost(id:number, fd: FormData): Observable<any> {
    return this.http.put(this.baseUrl+'charityEventPost/'+id, fd);
  }
  deleteCharityEventPost(id: number): Observable<any> {
    return this.http.delete<any>(`${this.baseUrl}CharityEventPost/${id}`);
  }
}
