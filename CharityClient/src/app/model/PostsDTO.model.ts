export interface PostsDTO {
    postId: number;
    postDescription: string;
    requirementTypeId: number;
    locationName: string;
    latitude: number;
    longitude: number;
    helpRequiredCount: number;
    stateId: number;
    cityId: number;
    pincodeId: number;
    userId: number;
    createdAt: Date;
    imageUrl: string;
    userName: string;
    spamCount: number;
    urgencyCount: number;
    commentsCount: number;
    profileImage: string;
    isSpam: boolean;
    isUrgency: boolean;
    isBookmark: boolean;
}