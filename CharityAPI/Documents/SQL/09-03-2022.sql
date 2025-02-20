USE [CharityAPI]
GO
/****** Object:  StoredProcedure [dbo].[sp_getHome]    Script Date: 08-03-2022 18:30:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[sp_getHome](
@Pincode BIGINT,
@CityId BIGINT,
@StateId BIGINT,
@ReqType BIGINT,
@UserName NVARCHAR(100),
@UserId BIGINT,
@Sort VARCHAR(100),
@Page BIGINT,
@TotalRecord BIGINT,
@Filt BIGINT
)
AS
IF(@Filt=0)
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
CASE WHEN EXISTS (SELECT TOP 1 * FROM dbo.[Spam] WHERE PostId = P.PostId AND UserId = @UserId) THEN CAST (1 AS BIT) ELSE CAST (0 AS BIT) END AS 'IsSpam',
CASE WHEN EXISTS (SELECT TOP 1 * FROM dbo.[Bookmark] WHERE PostId = P.PostId AND UserId = @UserId) THEN CAST (1 AS BIT) ELSE CAST (0 AS BIT) END AS 'IsBookmark'
FROM Post P 
JOIN UserData UD ON P.UserId = UD.UserId
WHERE P.IsClosed = 0 AND P.IsPublished =1 AND P.CreatedBy LIKE '%'+  @UserName +'%' AND
 P.CityId = CASE WHEN  @CityId =0 THEN  P.CityId ELSE @CityId END AND 
 P.StateId = CASE WHEN @StateId =0 THEN P.StateId ELSE @StateId END AND
 
 P.PincodeId = CASE WHEN @Pincode =0 THEN P.PincodeId ELSE @Pincode END AND
 P.RequirementTypeId = CASE WHEN @ReqType =0 THEN P.RequirementTypeId ELSE @ReqType END 

)ORDER BY
	CASE WHEN  @Sort ='UrgencyLeast' THEN CASE WHEN dbo.fn_TotalUrgency(P.PostId) IS NULL THEN 0 ELSE dbo.fn_TotalUrgency(P.PostId) END
		END ASC, 
	CASE WHEN  @Sort ='UrgencyMost' THEN CASE WHEN dbo.fn_TotalUrgency(P.PostId) IS NULL THEN 0 ELSE dbo.fn_TotalUrgency(P.PostId) END
		END DESC,
	CASE WHEN  @Sort ='SpamLeast' THEN CASE WHEN dbo.fn_TotalSpam(P.PostId) IS NULL THEN 0 ELSE dbo.fn_TotalSpam(P.PostId) END
		END ASC,
	CASE WHEN  @Sort ='SpamMost' THEN CASE WHEN dbo.fn_TotalSpam(P.PostId) IS NULL THEN 0 ELSE dbo.fn_TotalSpam(P.PostId) END
		END DESC,
	CASE WHEN  @Sort ='Latest' THEN P.CreatedAt 
		END DESC,
	CASE WHEN  @Sort ='Oldest' THEN P.CreatedAt 
		END ASC
	OFFSET @Page*@TotalRecord ROWS 
	FETCH NEXT @TotalRecord ROWS ONLY
END
ELSE
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
CASE WHEN EXISTS (SELECT TOP 1 * FROM dbo.[Spam] WHERE PostId = P.PostId AND UserId = @UserId) THEN CAST (1 AS BIT) ELSE CAST (0 AS BIT) END AS 'IsSpam',
CASE WHEN EXISTS (SELECT TOP 1 * FROM dbo.[Bookmark] WHERE PostId = P.PostId AND UserId = @UserId) THEN CAST (1 AS BIT) ELSE CAST (0 AS BIT) END AS 'IsBookmark'
FROM Post P 
JOIN UserData UD ON P.UserId = UD.UserId
WHERE P.IsClosed = 0 AND P.IsPublished =1 AND 
 ((P.PincodeId = @Pincode) OR (P.CityId = @CityId) OR(P.StateId = @StateId))

)ORDER BY
	CASE WHEN  @Sort ='UrgencyLeast' THEN CASE WHEN dbo.fn_TotalUrgency(P.PostId) IS NULL THEN 0 ELSE dbo.fn_TotalUrgency(P.PostId) END
		END ASC, 
	CASE WHEN  @Sort ='UrgencyMost' THEN CASE WHEN dbo.fn_TotalUrgency(P.PostId) IS NULL THEN 0 ELSE dbo.fn_TotalUrgency(P.PostId) END
		END DESC,
	CASE WHEN  @Sort ='SpamLeast' THEN CASE WHEN dbo.fn_TotalSpam(P.PostId) IS NULL THEN 0 ELSE dbo.fn_TotalSpam(P.PostId) END
		END ASC,
	CASE WHEN  @Sort ='SpamMost' THEN CASE WHEN dbo.fn_TotalSpam(P.PostId) IS NULL THEN 0 ELSE dbo.fn_TotalSpam(P.PostId) END
		END DESC,
	CASE WHEN  @Sort ='Latest' THEN P.CreatedAt 
		END DESC,
	CASE WHEN  @Sort ='Oldest' THEN P.CreatedAt 
		END ASC
	OFFSET @Page*@TotalRecord ROWS 
	FETCH NEXT @TotalRecord ROWS ONLY
END