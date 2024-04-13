CREATE FUNCTION fn_TotalSpam(@PostId BIGINT) 
RETURNS BIGINT  
AS  
BEGIN    
    DECLARE @Total BIGINT    

    SELECT @Total = Count(SpamId) FROM [dbo].[Spam] WHERE PostId = @PostId AND IsPublished=1
    RETURN @Total
End

CREATE FUNCTION fn_TotalUrgency(@PostId BIGINT) 
RETURNS BIGINT  
AS  
BEGIN    
    DECLARE @Total BIGINT    

    SELECT @Total = Count(UrgencyId) FROM [dbo].[Urgency] WHERE PostId = @PostId AND IsPublished=1
    RETURN @Total
End

CREATE FUNCTION fn_TotalComments(@PostId BIGINT) 
RETURNS BIGINT  
AS  
BEGIN    
    DECLARE @Total BIGINT    

    SELECT @Total = Count(PostCommentId) FROM [dbo].[PostComments] WHERE PostId = @PostId AND IsPublished=1
    RETURN @Total
End


CREATE PROCEDURE sp_getPostUser(
@Pincode BIGINT =1,
@CityId BIGINT = 1,
@StateId BIGINT =1
)
AS
BEGIN
(
SELECT P.PostId,UD.UserId, UD.ProfileImage, UD.UserName, P.LocationName, P.ImageURL, CAST(P.PostDescription AS NVARCHAR) AS 'PostDescription', P.HelpRequiredCount,P.Latitude,P.Longitude,P.CityId,P.StateId,P.CreatedAt,P.PincodeId,P.RequirementTypeId,
CASE WHEN dbo.fn_TotalUrgency(P.PostId) IS NULL THEN 0 ELSE dbo.fn_TotalUrgency(P.PostId) END AS 'UrgencyCount', 
CASE WHEN dbo.fn_TotalSpam(P.PostId) IS NULL THEN 0 ELSE dbo.fn_TotalSpam(P.PostId) END AS 'SpamCount',
CASE WHEN dbo.fn_TotalComments(P.PostId) IS NULL THEN 0 ELSE dbo.fn_TotalComments(P.PostId) END AS 'CommentsCount'
FROM Post P 
JOIN UserData UD ON P.UserId = UD.UserId
WHERE P.PincodeId = @Pincode AND P.IsClosed = 0 AND P.IsPublished =1
--@User'sPincodeId
)
UNION
(
SELECT P.PostId,UD.UserId, UD.ProfileImage, UD.UserName, P.LocationName, P.ImageURL, CAST(P.PostDescription AS NVARCHAR) AS 'PostDescription', P.HelpRequiredCount,P.Latitude,P.Longitude,P.CityId,P.StateId,P.CreatedAt,P.PincodeId,P.RequirementTypeId,
CASE WHEN dbo.fn_TotalUrgency(P.PostId) IS NULL THEN 0 ELSE dbo.fn_TotalUrgency(P.PostId) END AS 'UrgencyCount', 
CASE WHEN dbo.fn_TotalSpam(P.PostId) IS NULL THEN 0 ELSE dbo.fn_TotalSpam(P.PostId) END AS 'SpamCount',
CASE WHEN dbo.fn_TotalComments(P.PostId) IS NULL THEN 0 ELSE dbo.fn_TotalComments(P.PostId) END AS 'CommentsCount'
FROM Post P 
JOIN UserData UD ON P.UserId = UD.UserId

WHERE P.CityId = @CityId AND P.IsClosed = 0 AND P.IsPublished =1
--@User'sCityId
)
UNION
(
SELECT P.PostId,UD.UserId, UD.ProfileImage, UD.UserName, P.LocationName, P.ImageURL, CAST(P.PostDescription AS NVARCHAR) AS 'PostDescription', P.HelpRequiredCount,P.Latitude,P.Longitude,P.CityId,P.StateId,P.CreatedAt,P.PincodeId,P.RequirementTypeId,
CASE WHEN dbo.fn_TotalUrgency(P.PostId) IS NULL THEN 0 ELSE dbo.fn_TotalUrgency(P.PostId) END AS 'UrgencyCount', 
CASE WHEN dbo.fn_TotalSpam(P.PostId) IS NULL THEN 0 ELSE dbo.fn_TotalSpam(P.PostId) END AS 'SpamCount',
CASE WHEN dbo.fn_TotalComments(P.PostId) IS NULL THEN 0 ELSE dbo.fn_TotalComments(P.PostId) END AS 'CommentsCount'
FROM Post P 
JOIN UserData UD ON P.UserId = UD.UserId
WHERE P.StateId = @StateId AND P.IsClosed = 0 AND P.IsPublished =1
--@User'sStateId
)
END



CREATE PROCEDURE sp_getPosts
AS
BEGIN
(
SELECT P.PostId,UD.UserId, UD.ProfileImage, UD.UserName, P.LocationName, P.ImageURL, CAST(P.PostDescription AS NVARCHAR) AS 'PostDescription', P.HelpRequiredCount,P.Latitude,P.Longitude,P.CityId,P.StateId,P.CreatedAt,P.PincodeId,P.RequirementTypeId,
CASE WHEN dbo.fn_TotalUrgency(P.PostId) IS NULL THEN 0 ELSE dbo.fn_TotalUrgency(P.PostId) END AS 'UrgencyCount', 
CASE WHEN dbo.fn_TotalSpam(P.PostId) IS NULL THEN 0 ELSE dbo.fn_TotalSpam(P.PostId) END AS 'SpamCount',
CASE WHEN dbo.fn_TotalComments(P.PostId) IS NULL THEN 0 ELSE dbo.fn_TotalComments(P.PostId) END AS 'CommentsCount'
FROM Post P 
JOIN UserData UD ON P.UserId = UD.UserId
WHERE P.IsClosed = 0 AND P.IsPublished =1
)

END