import { Injectable } from '@angular/core';

import * as CryptoJS from 'crypto-js';
import { encryptSecretKey } from 'src/environments/environment';

@Injectable({
  providedIn: 'root'
})
export class EncryptService {

  constructor() { }

  encryptData(data) {

    try {
      return CryptoJS.AES.encrypt(JSON.stringify(data), encryptSecretKey).toString();
    } catch (e) {
      console.log(e);
    }
  }

  decryptData(data) {

    try {
      const bytes = CryptoJS.AES.decrypt(data, encryptSecretKey);
      if (bytes.toString()) {
        return JSON.parse(bytes.toString(CryptoJS.enc.Utf8));
      }
      return data;
    } catch (e) {
      console.log(e);
    }
  }

}
