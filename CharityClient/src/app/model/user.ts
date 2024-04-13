export interface UserForRegister {
    username: string;
    email: string;
    password: string;
    phonenumber: string;
}

export interface OrganisationForRegister {
    username: string;
    email: string;
    password: string;
    phonenumber: string;
}

export interface UserForLogin {
    username: string;
    password: string;
    otp: number;
    token: string;
}
