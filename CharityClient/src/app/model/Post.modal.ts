export interface Post {
    userId:number,
    PostDescription:string,
    RequirementTypeId:number,
    LocationName:string,
    Longitude:number,
    Latitude: number,
    HelpRequiredCount:number,
    CityId:number,
    StateId:number,
    ImageURL:File,
    IsPublished:boolean,
    IsClosed:boolean,
    PincodeId:number
}
