USE [CharityAPI]
GO
/****** Object:  StoredProcedure [dbo].[sp_getPostUser]    Script Date: 24-01-2022 15:54:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[sp_getPostUser](
@Pincode BIGINT,
@CityId BIGINT,
@StateId BIGINT,
@UserId BIGINT,
@Sort VARCHAR(100)
)
AS
BEGIN
(
SELECT P.PostId,UD.UserId, UD.ProfileImage, UD.UserName, P.LocationName, P.ImageURL, CAST(P.PostDescription AS NVARCHAR) AS 'PostDescription', P.HelpRequiredCount,P.Latitude,P.Longitude,P.CityId,P.StateId,P.CreatedAt,P.PincodeId,P.RequirementTypeId,
CASE WHEN dbo.fn_TotalUrgency(P.PostId) IS NULL THEN 0 ELSE dbo.fn_TotalUrgency(P.PostId) END AS 'UrgencyCount', 
CASE WHEN dbo.fn_TotalSpam(P.PostId) IS NULL THEN 0 ELSE dbo.fn_TotalSpam(P.PostId) END AS 'SpamCount',
CASE WHEN dbo.fn_TotalComments(P.PostId) IS NULL THEN 0 ELSE dbo.fn_TotalComments(P.PostId) END AS 'CommentsCount',
CASE WHEN EXISTS (SELECT TOP 1 *
                         FROM dbo.[Urgency] 
                         WHERE PostId = P.PostId AND UserId = @UserId) 
            THEN CAST (1 AS BIT) 
            ELSE CAST (0 AS BIT) END AS 'IsUrgency',
CASE WHEN EXISTS (SELECT TOP 1 * FROM dbo.[Spam] WHERE PostId = P.PostId AND UserId = @UserId) THEN CAST (1 AS BIT) ELSE CAST (0 AS BIT) END AS 'IsSpam'
FROM Post P 
JOIN UserData UD ON P.UserId = UD.UserId
WHERE P.IsClosed = 0 AND P.IsPublished =1 AND ((P.PincodeId = @Pincode) OR (P.CityId = @CityId) OR(P.StateId = @StateId) )
--@User'sPincodeId
)ORDER BY
	CASE WHEN  @Sort =N'UrgencyLeast' THEN CASE WHEN dbo.fn_TotalUrgency(P.PostId) IS NULL THEN 0 ELSE dbo.fn_TotalUrgency(P.PostId) END
		END ASC, 
	CASE WHEN  @Sort =N'UrgencyMost' THEN CASE WHEN dbo.fn_TotalUrgency(P.PostId) IS NULL THEN 0 ELSE dbo.fn_TotalUrgency(P.PostId) END
		END DESC,
	CASE WHEN  @Sort =N'SpamLeast' THEN CASE WHEN dbo.fn_TotalSpam(P.PostId) IS NULL THEN 0 ELSE dbo.fn_TotalSpam(P.PostId) END
		END ASC,
	CASE WHEN  @Sort =N'SpamMost' THEN CASE WHEN dbo.fn_TotalSpam(P.PostId) IS NULL THEN 0 ELSE dbo.fn_TotalSpam(P.PostId) END
		END DESC,
	CASE WHEN  @Sort =N'Latest' THEN P.CreatedAt 
		END DESC,
	CASE WHEN  @Sort =N'Oldest' THEN P.CreatedAt 
		END ASC
END




USE [CharityAPI]
GO
/****** Object:  StoredProcedure [dbo].[sp_getPosts]    Script Date: 27-01-2022 PM 12:38:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[sp_getPosts](@Sort VARCHAR(50)
)
AS
BEGIN
(
SELECT P.PostId,UD.UserId, UD.ProfileImage, UD.UserName, P.LocationName, P.ImageURL, CAST(P.PostDescription AS NVARCHAR) AS 'PostDescription', P.HelpRequiredCount,P.Latitude,P.Longitude,P.CityId,P.StateId,P.CreatedAt,P.PincodeId,P.RequirementTypeId,
CASE WHEN dbo.fn_TotalUrgency(P.PostId) IS NULL THEN 0 ELSE dbo.fn_TotalUrgency(P.PostId) END AS 'UrgencyCount', 
CASE WHEN dbo.fn_TotalSpam(P.PostId) IS NULL THEN 0 ELSE dbo.fn_TotalSpam(P.PostId) END AS 'SpamCount',
CASE WHEN dbo.fn_TotalComments(P.PostId) IS NULL THEN 0 ELSE dbo.fn_TotalComments(P.PostId) END AS 'CommentsCount',
CAST (0 AS BIT) AS 'IsSpam',
CAST (0 AS BIT) AS 'IsUrgency'
FROM Post P 
JOIN UserData UD ON P.UserId = UD.UserId
WHERE P.IsClosed = 0 AND P.IsPublished =1)
ORDER BY
	CASE WHEN  @Sort =N'UrgencyLeast' THEN CASE WHEN dbo.fn_TotalUrgency(P.PostId) IS NULL THEN 0 ELSE dbo.fn_TotalUrgency(P.PostId) END
		END ASC, 
	CASE WHEN  @Sort =N'UrgencyMost' THEN CASE WHEN dbo.fn_TotalUrgency(P.PostId) IS NULL THEN 0 ELSE dbo.fn_TotalUrgency(P.PostId) END
		END DESC,
	CASE WHEN  @Sort =N'SpamLeast' THEN CASE WHEN dbo.fn_TotalSpam(P.PostId) IS NULL THEN 0 ELSE dbo.fn_TotalSpam(P.PostId) END
		END ASC,
	CASE WHEN  @Sort =N'SpamMost' THEN CASE WHEN dbo.fn_TotalSpam(P.PostId) IS NULL THEN 0 ELSE dbo.fn_TotalSpam(P.PostId) END
		END DESC,
	CASE WHEN  @Sort =N'Latest' THEN P.CreatedAt 
		END DESC,
	CASE WHEN  @Sort =N'Oldest' THEN P.CreatedAt 
		END ASC

END



CREATE PROCEDURE [dbo].[sp_getPostsFilt](
@Pincode BIGINT,
@CityId BIGINT,
@StateId BIGINT,
@ReqType BIGINT,
@UserName NVARCHAR(100),
@UserId BIGINT = 0
)
AS
BEGIN
(
	SELECT P.PostId,UD.UserId, UD.ProfileImage, UD.UserName, P.LocationName, P.ImageURL, CAST(P.PostDescription AS NVARCHAR) AS 'PostDescription', P.HelpRequiredCount,P.Latitude,P.Longitude,P.CityId,P.StateId,P.CreatedAt,P.PincodeId,P.RequirementTypeId,
CASE WHEN dbo.fn_TotalUrgency(P.PostId) IS NULL THEN 0 ELSE dbo.fn_TotalUrgency(P.PostId) END AS UrgencyCount, 
CASE WHEN dbo.fn_TotalSpam(P.PostId) IS NULL THEN 0 ELSE dbo.fn_TotalSpam(P.PostId) END AS SpamCount,
CASE WHEN dbo.fn_TotalComments(P.PostId) IS NULL THEN 0 ELSE dbo.fn_TotalComments(P.PostId) END AS CommentsCount,
CASE WHEN EXISTS (SELECT TOP 1 *
                         FROM dbo.[Urgency] 
                         WHERE PostId = P.PostId AND UserId = @UserId) 
            THEN CAST (1 AS BIT) 
            ELSE CAST (0 AS BIT) END AS 'IsUrgency',
CASE WHEN EXISTS (SELECT TOP 1 * FROM dbo.[Spam] WHERE PostId = P.PostId AND UserId = @UserId) THEN CAST (1 AS BIT) ELSE CAST (0 AS BIT) END AS 'IsSpam'
FROM Post P 

JOIN UserData UD ON P.UserId = UD.UserId
 WHERE P.IsClosed = 0 AND P.IsPublished = 1 AND P.CreatedBy LIKE '%'+  @UserName +'%' AND
 P.CityId = CASE WHEN  @CityId =0 THEN  P.CityId ELSE @CityId END AND 
 P.StateId = CASE WHEN @StateId =0 THEN P.StateId ELSE @StateId END AND
 
 P.PincodeId = CASE WHEN @Pincode =0 THEN P.PincodeId ELSE @Pincode END AND
 P.RequirementTypeId = CASE WHEN @ReqType =0 THEN P.RequirementTypeId ELSE @ReqType END)
 
END