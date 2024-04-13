export interface EventPostsDTO {
    charityEventPostId: number;
    eventId: number;
    userId: number;
    postUrl: string;
    content: string;
    isLike: boolean;
    isDislike: boolean;
}