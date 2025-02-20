USE [CharityAPI]
GO
/****** Object:  StoredProcedure [dbo].[sp_getHome]    Script Date: 10-03-2022 09:40:23 ******/
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
@TotalRecord BIGINT
)
AS
BEGIN
DECLARE @sql AS NVARCHAR(MAX)
SET @sql='SELECT P.PostId,UD.UserId, UD.ProfileImage, UD.UserName, P.LocationName, P.ImageURL, CAST(P.PostDescription AS NVARCHAR) AS PostDescription, P.HelpRequiredCount,P.Latitude,P.Longitude,P.CityId,P.StateId,P.CreatedAt,P.PincodeId,P.RequirementTypeId,
CASE WHEN dbo.fn_TotalUrgency(P.PostId) IS NULL THEN 0 ELSE dbo.fn_TotalUrgency(P.PostId) END AS UrgencyCount, 
CASE WHEN dbo.fn_TotalSpam(P.PostId) IS NULL THEN 0 ELSE dbo.fn_TotalSpam(P.PostId) END AS SpamCount,
CASE WHEN dbo.fn_TotalComments(P.PostId) IS NULL THEN 0 ELSE dbo.fn_TotalComments(P.PostId) END AS CommentsCount,
CASE WHEN EXISTS (SELECT TOP 1 *
                         FROM dbo.[Urgency] 
                         WHERE PostId = P.PostId AND UserId = @UserId) 
            THEN CAST (1 AS BIT) 
            ELSE CAST (0 AS BIT) END AS IsUrgency,
CASE WHEN EXISTS (SELECT TOP 1 * FROM dbo.[Spam] WHERE PostId = P.PostId AND UserId = @UserId) THEN CAST (1 AS BIT) ELSE CAST (0 AS BIT) END AS IsSpam,
CASE WHEN EXISTS (SELECT TOP 1 * FROM dbo.[Bookmark] WHERE PostId = P.PostId AND UserId = @UserId) THEN CAST (1 AS BIT) ELSE CAST (0 AS BIT) END AS IsBookmark
FROM Post P 
JOIN UserData UD ON P.UserId = UD.UserId
WHERE P.IsClosed = 0 AND P.IsPublished =1 AND '
IF @UserName IS NOT NULL OR @UserName!=''
set @UserName='%'+@UserName+'%'
SET @sql = @sql+'  P.CreatedBy LIKE @UserName AND '
IF @CityId !=0
SET @sql = @sql+' P.CityId = @CityId AND '
IF @Pincode !=0
SET @sql = @sql+' P.PincodeId = @Pincode AND '
IF @ReqType !=0
SET @sql = @sql+' P.RequirementTypeId = @ReqType AND '
IF @StateId !=0
SET @sql = @sql+' P.StateId = @StateId AND '
 
 SET @sql = LEFT(@sql,len(@sql)-4)
 SET @sql = @sql+' ORDER BY '

 IF @Sort='UrgencyLeast'
 SET @sql =@sql+ ' dbo.fn_TotalUrgency(P.PostId) ASC '
  IF @Sort='UrgencyMost'
 SET @sql =@sql+ ' dbo.fn_TotalUrgency(P.PostId) DESC '
  IF @Sort='SpamLeast'
 SET @sql =@sql+ '  dbo.fn_TotalSpam(P.PostId) ASC '
  IF @Sort='SpamMost'
 SET @sql =@sql+ ' dbo.fn_TotalSpam(P.PostId) DESC '
  IF @Sort='Latest'
 SET @sql =@sql+ ' P.CreatedAt DESC '
  IF @Sort='Oldest'
 SET @sql =@sql+ '  P.CreatedAt ASC '

SET @sql = @sql + 'OFFSET @Page*@TotalRecord ROWS 
	FETCH NEXT @TotalRecord ROWS ONLY'
EXEC sp_executesql @sql,N'@Pincode BIGINT,
@CityId BIGINT,
@StateId BIGINT,
@ReqType BIGINT,
@UserName NVARCHAR(100),
@UserId BIGINT,
@Sort VARCHAR(100),
@Page BIGINT,
@TotalRecord BIGINT',@Pincode,@CityId,@StateId,@ReqType,@UserName,@UserId,@Sort,@Page,@TotalRecord


END