
ALTER DATABASE [CharityAPI] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [CharityAPI].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [CharityAPI] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [CharityAPI] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [CharityAPI] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [CharityAPI] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [CharityAPI] SET ARITHABORT OFF 
GO
ALTER DATABASE [CharityAPI] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [CharityAPI] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [CharityAPI] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [CharityAPI] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [CharityAPI] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [CharityAPI] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [CharityAPI] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [CharityAPI] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [CharityAPI] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [CharityAPI] SET  DISABLE_BROKER 
GO
ALTER DATABASE [CharityAPI] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [CharityAPI] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [CharityAPI] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [CharityAPI] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [CharityAPI] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [CharityAPI] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [CharityAPI] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [CharityAPI] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [CharityAPI] SET  MULTI_USER 
GO
ALTER DATABASE [CharityAPI] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [CharityAPI] SET DB_CHAINING OFF 
GO
ALTER DATABASE [CharityAPI] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [CharityAPI] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [CharityAPI] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [CharityAPI] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [CharityAPI] SET QUERY_STORE = OFF
GO
USE [CharityAPI]
GO
/****** Object:  User [saa]    Script Date: 09-02-2022 13:10:06 ******/

/****** Object:  UserDefinedFunction [dbo].[fn_TotalComments]    Script Date: 09-02-2022 13:10:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fn_TotalComments](@PostId BIGINT) 
RETURNS BIGINT  
AS  
BEGIN    
    DECLARE @Total BIGINT    

    SELECT @Total = Count(PostCommentId) FROM [dbo].[PostComments] WHERE PostId = @PostId AND IsPublished=1
    RETURN @Total
End
GO
/****** Object:  UserDefinedFunction [dbo].[fn_TotalSpam]    Script Date: 09-02-2022 13:10:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fn_TotalSpam](@PostId BIGINT) 
RETURNS BIGINT  
AS  
BEGIN    
    DECLARE @Total BIGINT    

    SELECT @Total = Count(SpamId) FROM [dbo].[Spam] WHERE PostId = @PostId AND IsPublished=1
    RETURN @Total
End
GO
/****** Object:  UserDefinedFunction [dbo].[fn_TotalUrgency]    Script Date: 09-02-2022 13:10:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fn_TotalUrgency](@PostId BIGINT) 
RETURNS BIGINT  
AS  
BEGIN    
    DECLARE @Total BIGINT    

    SELECT @Total = Count(UrgencyId) FROM [dbo].[Urgency] WHERE PostId = @PostId AND IsPublished=1
    RETURN @Total
End
GO
/****** Object:  Table [dbo].[Admins]    Script Date: 09-02-2022 13:10:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Admins](
	[AdminId] [bigint] IDENTITY(1,1) NOT NULL,
	[UserName] [nvarchar](50) NOT NULL,
	[EmailAddress] [nvarchar](50) NOT NULL,
	[PasswordHash] [nvarchar](100) NOT NULL,
	[MobileNo] [nvarchar](50) NOT NULL,
	[CreatedBy] [nvarchar](50) NOT NULL,
	[CreatedAt] [datetime] NOT NULL,
	[UpdatedBy] [nvarchar](50) NOT NULL,
	[UpdatedAt] [datetime] NOT NULL,
	[IsPublished] [bit] NOT NULL,
 CONSTRAINT [PK_Admins] PRIMARY KEY CLUSTERED 
(
	[AdminId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[EmailAddress] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[UserName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],

) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CharityEvent]    Script Date: 09-02-2022 13:10:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CharityEvent](
	[EventId] [bigint] IDENTITY(1,1) NOT NULL,
	[EventName] [nvarchar](50) NOT NULL,
	[EventDescription] [text] NOT NULL,
	[EventOrganiserId] [bigint] NOT NULL,
	[EventStartDate] [datetime] NOT NULL,
	[EventBannerURL] [nvarchar](max) NOT NULL,
	[EventEndDate] [datetime] NOT NULL,
	[IsVerified] [bit] NOT NULL,
	[EventType] [nvarchar](50) NOT NULL,
	[CreatedBy] [nvarchar](50) NOT NULL,
	[CreatedAt] [datetime] NOT NULL,
	[UpdatedBy] [nvarchar](50) NOT NULL,
	[PincodeId] [bigint] NOT NULL,
	[UpdatedAt] [datetime] NOT NULL,
	[IsPublished] [bit] NOT NULL,
	[IsCompleted] [bit] NOT NULL,
	[LocationName] [nvarchar](max) NULL,
 CONSTRAINT [PK_CharityEvent] PRIMARY KEY CLUSTERED 
(
	[EventId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CharityEventInteract]    Script Date: 09-02-2022 13:10:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CharityEventInteract](
	[CharityEventInteractId] [bigint] IDENTITY(1,1) NOT NULL,
	[EventId] [bigint] NOT NULL,
	[UserId] [bigint] NOT NULL,
	[IsInterested] [bit] NOT NULL,
	[IsGoing] [bit] NOT NULL,
	[CreatedBy] [nvarchar](50) NOT NULL,
	[CreatedAt] [datetime] NOT NULL,
	[UpdatedBy] [nvarchar](50) NOT NULL,
	[UpdatedAt] [datetime] NOT NULL,
	[IsPublished] [bit] NOT NULL,
 CONSTRAINT [PK_CharityEventInteract] PRIMARY KEY CLUSTERED 
(
	[CharityEventInteractId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CharityEventOrganiser]    Script Date: 09-02-2022 13:10:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CharityEventOrganiser](
	[CharityEventOrganiserId] [bigint] IDENTITY(1,1) NOT NULL,
	[EventOrganiserId] [bigint] NOT NULL,
	[EventId] [bigint] NOT NULL,
	[CreatedBy] [nvarchar](50) NOT NULL,
	[CreatedAt] [datetime] NOT NULL,
	[UpdatedBy] [nvarchar](50) NOT NULL,
	[UpdatedAt] [datetime] NOT NULL,
	[IsPublished] [bit] NOT NULL,
 CONSTRAINT [PK_CharityEventOrganiser] PRIMARY KEY CLUSTERED 
(
	[CharityEventOrganiserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UK_CharityEventOrganiserEventNOrganiser] UNIQUE NONCLUSTERED 
(
	[EventOrganiserId] ASC,
	[EventId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CharityEventPost]    Script Date: 09-02-2022 13:10:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CharityEventPost](
	[CharityEventPostId] [bigint] IDENTITY(1,1) NOT NULL,
	[EventId] [bigint] NOT NULL,
	[UserId] [bigint] NOT NULL,
	[PostUrl] [nvarchar](max) NOT NULL,
	[Content] [text] NULL,
	[CreatedBy] [nvarchar](50) NOT NULL,
	[CreatedAt] [datetime] NOT NULL,
	[UpdatedBy] [nvarchar](50) NOT NULL,
	[UpdatedAt] [datetime] NOT NULL,
	[IsPublished] [bit] NOT NULL,
 CONSTRAINT [PK_CharityEventPost] PRIMARY KEY CLUSTERED 
(
	[CharityEventPostId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CharityEventPostLike]    Script Date: 09-02-2022 13:10:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CharityEventPostLike](
	[CharityEventPostLikeId] [bigint] IDENTITY(1,1) NOT NULL,
	[CharityEventPostId] [bigint] NOT NULL,
	[UserId] [bigint] NOT NULL,
	[Likes] [bit] NOT NULL,
	[DisLike] [bit] NOT NULL,
	[CreatedBy] [nvarchar](50) NOT NULL,
	[CreatedAt] [datetime] NOT NULL,
	[UpdatedBy] [nvarchar](50) NOT NULL,
	[UpdatedAt] [datetime] NOT NULL,
 CONSTRAINT [PK_CharityEventPostLike] PRIMARY KEY CLUSTERED 
(
	[CharityEventPostLikeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UK_CharityEventPostUser] UNIQUE NONCLUSTERED 
(
	[CharityEventPostId] ASC,
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Cities]    Script Date: 09-02-2022 13:10:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cities](
	[CityId] [bigint] IDENTITY(1,1) NOT NULL,
	[StateId] [bigint] NOT NULL,
	[CityName] [nvarchar](50) NOT NULL,
	[CreatedBy] [nvarchar](50) NOT NULL,
	[CreatedAt] [datetime] NOT NULL,
	[UpdatedBy] [nvarchar](50) NOT NULL,
	[UpdatedAt] [datetime] NOT NULL,
	[IsPublished] [bit] NOT NULL,
 CONSTRAINT [PK_Cities] PRIMARY KEY CLUSTERED 
(
	[CityId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ClusterLocations]    Script Date: 09-02-2022 13:10:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ClusterLocations](
	[ClusterLocationId] [bigint] IDENTITY(1,1) NOT NULL,
	[PostId] [bigint] NOT NULL,
	[RequirementTypeId] [bigint] NOT NULL,
	[Locations] [nvarchar](50) NOT NULL,
	[CityId] [bigint] NOT NULL,
	[StateId] [bigint] NOT NULL,
	[PeopleCount] [bigint] NOT NULL,
	[IsVerified] [bit] NOT NULL,
	[CreatedBy] [nvarchar](50) NOT NULL,
	[CreatedAt] [datetime] NOT NULL,
	[UpdatedBy] [nvarchar](50) NOT NULL,
	[UpdatedAt] [datetime] NOT NULL,
	[IsPublished] [bit] NOT NULL,
	[PincodeId] [bigint] NOT NULL,
 CONSTRAINT [PK_Cluster] PRIMARY KEY CLUSTERED 
(
	[ClusterLocationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrganisationData]    Script Date: 09-02-2022 13:10:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrganisationData](
	[OrganisationDataId] [bigint] IDENTITY(1,1) NOT NULL,
	[OrganisationUserId] [bigint] NOT NULL,
	[OrganisationName] [nvarchar](50) NOT NULL,
	[OrganisationAddress] [nvarchar](max) NOT NULL,
	[OrganisationContactNo] [nvarchar](50) NULL,
	[OrganisationLogoURL] [nvarchar](max) NOT NULL,
	[IsVerified] [bit] NOT NULL,
	[CreatedBy] [nvarchar](50) NOT NULL,
	[CreatedAt] [datetime] NOT NULL,
	[UpdatedBy] [nvarchar](50) NOT NULL,
	[UpdatedAt] [datetime] NOT NULL,
	[IsPublished] [bit] NOT NULL,
	[OrganisationDetail] [nvarchar](max) NULL,
	[OrganisatioWebURL] [nvarchar](max) NULL,
	[OrganisationUserName] [nvarchar](50) NULL,
 CONSTRAINT [PK_OrganisationData] PRIMARY KEY CLUSTERED 
(
	[OrganisationDataId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Organisations]    Script Date: 09-02-2022 13:10:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Organisations](
	[OrganisationId] [bigint] IDENTITY(1,1) NOT NULL,
	[UserName] [nvarchar](50) NOT NULL,
	[EmailAddress] [nvarchar](50) NOT NULL,
	[PasswordHash] [nvarchar](100) NOT NULL,
	[MobileNo] [nvarchar](50) NOT NULL,
	[Otp] [bigint] NULL,
	[OtpCreatedAt] [datetime] NULL,
	[CreatedBy] [nvarchar](50) NOT NULL,
	[CreatedAt] [datetime] NOT NULL,
	[UpdatedBy] [nvarchar](50) NOT NULL,
	[UpdatedAt] [datetime] NOT NULL,
	[IsPublished] [bit] NOT NULL,
 CONSTRAINT [PK_Organisations] PRIMARY KEY CLUSTERED 
(
	[OrganisationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[EmailAddress] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[UserName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Pincode]    Script Date: 09-02-2022 13:10:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Pincode](
	[PincodeId] [bigint] IDENTITY(1,1) NOT NULL,
	[PostOfficeName] [varchar](100) NULL,
	[Pincode] [bigint] NOT NULL,
	[CityId] [bigint] NOT NULL,
	[District] [varchar](100) NULL,
	[StateId] [bigint] NOT NULL,
	[CreatedBy] [nvarchar](50) NOT NULL,
	[CreatedAt] [datetime] NOT NULL,
	[UpdatedBy] [nvarchar](50) NOT NULL,
	[UpdatedAt] [datetime] NOT NULL,
	[IsPublished] [bit] NOT NULL,
 CONSTRAINT [PK_PC] PRIMARY KEY CLUSTERED 
(
	[PincodeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Post]    Script Date: 09-02-2022 13:10:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Post](
	[PostId] [bigint] IDENTITY(1,1) NOT NULL,
	[UserId] [bigint] NOT NULL,
	[PostDescription] [text] NOT NULL,
	[RequirementTypeId] [bigint] NOT NULL,
	[LocationName] [nvarchar](50) NOT NULL,
	[Longitude] [decimal](12, 9) NOT NULL,
	[Latitude] [decimal](12, 9) NOT NULL,
	[HelpRequiredCount] [bigint] NOT NULL,
	[CityId] [bigint] NOT NULL,
	[StateId] [bigint] NOT NULL,
	[ImageURL] [nvarchar](max) NOT NULL,
	[CreatedBy] [nvarchar](50) NOT NULL,
	[CreatedAt] [datetime] NOT NULL,
	[UpdatedBy] [nvarchar](50) NOT NULL,
	[UpdatedAt] [datetime] NOT NULL,
	[IsPublished] [bit] NOT NULL,
	[IsClosed] [bit] NOT NULL,
	[CloseAt] [datetime] NOT NULL,
	[PincodeId] [bigint] NOT NULL,
 CONSTRAINT [PK_Post] PRIMARY KEY CLUSTERED 
(
	[PostId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PostComments]    Script Date: 09-02-2022 13:10:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PostComments](
	[PostCommentId] [bigint] IDENTITY(1,1) NOT NULL,
	[UserId] [bigint] NOT NULL,
	[PostId] [bigint] NOT NULL,
	[Comment] [text] NOT NULL,
	[CreatedBy] [nvarchar](50) NOT NULL,
	[CreatedAt] [datetime] NOT NULL,
	[UpdatedBy] [nvarchar](50) NOT NULL,
	[UpdatedAt] [datetime] NOT NULL,
	[IsPublished] [bit] NOT NULL,
 CONSTRAINT [PK_PostComment] PRIMARY KEY CLUSTERED 
(
	[PostCommentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PostImages]    Script Date: 09-02-2022 13:10:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PostImages](
	[PostImagesId] [bigint] IDENTITY(1,1) NOT NULL,
	[UserId] [bigint] NOT NULL,
	[PostId] [bigint] NOT NULL,
	[ImageURL1] [nvarchar](max) NULL,
	[ImageURL2] [nvarchar](max) NULL,
	[ImageURL3] [nvarchar](max) NULL,
	[ImageURL4] [nvarchar](max) NULL,
	[CreatedBy] [nvarchar](50) NOT NULL,
	[CreatedAt] [datetime] NOT NULL,
	[UpdatedBy] [nvarchar](50) NOT NULL,
	[UpdatedAt] [datetime] NOT NULL,
 CONSTRAINT [PK_PostImages] PRIMARY KEY CLUSTERED 
(
	[PostImagesId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RequirementType]    Script Date: 09-02-2022 13:10:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RequirementType](
	[RequirementTypeId] [bigint] IDENTITY(1,1) NOT NULL,
	[RequirementTypeName] [nvarchar](50) NOT NULL,
	[CreatedBy] [nvarchar](50) NOT NULL,
	[CreatedAt] [datetime] NOT NULL,
	[UpdatedBy] [nvarchar](50) NOT NULL,
	[UpdatedAt] [datetime] NOT NULL,
	[IsPublished] [bit] NOT NULL,
 CONSTRAINT [PK_RequirementType] PRIMARY KEY CLUSTERED 
(
	[RequirementTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Spam]    Script Date: 09-02-2022 13:10:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Spam](
	[SpamId] [bigint] IDENTITY(1,1) NOT NULL,
	[PostId] [bigint] NOT NULL,
	[UserId] [bigint] NOT NULL,
	[CreatedBy] [nvarchar](50) NOT NULL,
	[CreatedAt] [datetime] NOT NULL,
	[UpdatedBy] [nvarchar](50) NOT NULL,
	[UpdatedAt] [datetime] NOT NULL,
	[IsPublished] [bit] NOT NULL,
 CONSTRAINT [PK_Spam] PRIMARY KEY CLUSTERED 
(
	[SpamId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UK_SpamUser] UNIQUE NONCLUSTERED 
(
	[PostId] ASC,
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[States]    Script Date: 09-02-2022 13:10:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[States](
	[StateId] [bigint] IDENTITY(1,1) NOT NULL,
	[StateName] [nvarchar](50) NOT NULL,
	[CreatedBy] [nvarchar](50) NOT NULL,
	[CreatedAt] [datetime] NOT NULL,
	[UpdatedBy] [nvarchar](50) NOT NULL,
	[UpdatedAt] [datetime] NOT NULL,
	[IsPublished] [bit] NOT NULL,
 CONSTRAINT [PK_States] PRIMARY KEY CLUSTERED 
(
	[StateId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[StateName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Urgency]    Script Date: 09-02-2022 13:10:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Urgency](
	[UrgencyId] [bigint] IDENTITY(1,1) NOT NULL,
	[PostId] [bigint] NOT NULL,
	[UserId] [bigint] NOT NULL,
	[CreatedBy] [nvarchar](50) NOT NULL,
	[CreatedAt] [datetime] NOT NULL,
	[UpdatedBy] [nvarchar](50) NOT NULL,
	[UpdatedAt] [datetime] NOT NULL,
	[IsPublished] [bit] NOT NULL,
 CONSTRAINT [PK_Urgent] PRIMARY KEY CLUSTERED 
(
	[UrgencyId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UK_UrgencyUser] UNIQUE NONCLUSTERED 
(
	[PostId] ASC,
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserData]    Script Date: 09-02-2022 13:10:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserData](
	[UserId] [bigint] IDENTITY(1,1) NOT NULL,
	[FirstName] [nvarchar](50) NOT NULL,
	[LastName] [nvarchar](50) NOT NULL,
	[Gender] [nvarchar](10) NOT NULL,
	[ProfileImage] [nvarchar](max) NULL,
	[UserDescription] [nvarchar](500) NULL,
	[UserName] [nvarchar](50) NOT NULL,
	[EmailAddress] [nvarchar](50) NOT NULL,
	[MobileNo] [nvarchar](50) NOT NULL,
	[TotalPostCount] [bigint] NOT NULL,
	[CreatedBy] [nvarchar](50) NOT NULL,
	[CreatedAt] [datetime] NOT NULL,
	[UpdatedBy] [nvarchar](50) NOT NULL,
	[UpdatedAt] [datetime] NOT NULL,
	[IsPublished] [bit] NOT NULL,
	[Users] [bigint] NOT NULL,
	[CityId] [bigint] NOT NULL,
	[StateId] [bigint] NOT NULL,
	[PincodeId] [bigint] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[EmailAddress] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[Users] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[UserName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 09-02-2022 13:10:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[UserId] [bigint] IDENTITY(1,1) NOT NULL,
	[UserName] [nvarchar](50) NOT NULL,
	[EmailAddress] [nvarchar](50) NOT NULL,
	[PasswordHash] [nvarchar](100) NOT NULL,
	[MobileNo] [nvarchar](50) NOT NULL,
	[Otp] [bigint] NULL,
	[OtpCreatedAt] [datetime] NULL,
	[CreatedBy] [nvarchar](50) NOT NULL,
	[CreatedAt] [datetime] NOT NULL,
	[UpdatedBy] [nvarchar](50) NOT NULL,
	[UpdatedAt] [datetime] NOT NULL,
	[IsPublished] [bit] NOT NULL,
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[EmailAddress] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[UserName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[PasswordHash] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Volunteer]    Script Date: 09-02-2022 13:10:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Volunteer](
	[VolunteerId] [bigint] IDENTITY(1,1) NOT NULL,
	[VolunteerUserId] [bigint] NOT NULL,
	[OrganisationId] [bigint] NOT NULL,
	[CreatedBy] [nvarchar](50) NOT NULL,
	[CreatedAt] [datetime] NOT NULL,
	[UpdatedBy] [nvarchar](50) NOT NULL,
	[UpdatedAt] [datetime] NOT NULL,
	[IsPublished] [bit] NOT NULL,
 CONSTRAINT [PK_Volunteer] PRIMARY KEY CLUSTERED 
(
	[VolunteerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[WebApiExceptionLog]    Script Date: 09-02-2022 13:10:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WebApiExceptionLog](
	[LogId] [int] IDENTITY(1,1) NOT NULL,
	[SiteId] [int] NULL,
	[Message] [ntext] NULL,
	[StackTrace] [ntext] NULL,
	[CreatedOn] [datetime] NULL,
	[CreatedBy] [int] NULL,
	[IpAddress] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[LogId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[WebApiRequestLog]    Script Date: 09-02-2022 13:10:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WebApiRequestLog](
	[LogId] [int] IDENTITY(1,1) NOT NULL,
	[LogDescription] [ntext] NULL,
	[SiteId] [int] NULL,
	[RequestUri] [nvarchar](500) NULL,
	[ControllerName] [nvarchar](300) NULL,
	[ActionName] [nvarchar](100) NULL,
	[StartTime] [time](7) NULL,
	[Timespan] [time](7) NULL,
	[CreatedOn] [datetimeoffset](7) NULL,
	[CreatedBy] [nvarchar](100) NULL,
	[IpAddress] [nvarchar](50) NULL,
 CONSTRAINT [PK__WebApiRe__5E54864822104AD2] PRIMARY KEY CLUSTERED 
(
	[LogId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[Admins] ADD  DEFAULT ((1)) FOR [IsPublished]
GO
ALTER TABLE [dbo].[CharityEvent] ADD  DEFAULT ((0)) FOR [IsVerified]
GO
ALTER TABLE [dbo].[CharityEvent] ADD  DEFAULT ((1)) FOR [IsPublished]
GO
ALTER TABLE [dbo].[CharityEvent] ADD  DEFAULT ((0)) FOR [IsCompleted]
GO
ALTER TABLE [dbo].[CharityEventInteract] ADD  DEFAULT ((0)) FOR [IsInterested]
GO
ALTER TABLE [dbo].[CharityEventInteract] ADD  DEFAULT ((0)) FOR [IsGoing]
GO
ALTER TABLE [dbo].[CharityEventInteract] ADD  DEFAULT ((1)) FOR [IsPublished]
GO
ALTER TABLE [dbo].[CharityEventOrganiser] ADD  DEFAULT ((1)) FOR [IsPublished]
GO
ALTER TABLE [dbo].[CharityEventPost] ADD  DEFAULT ((1)) FOR [IsPublished]
GO
ALTER TABLE [dbo].[CharityEventPostLike] ADD  DEFAULT ((0)) FOR [Likes]
GO
ALTER TABLE [dbo].[CharityEventPostLike] ADD  DEFAULT ((0)) FOR [DisLike]
GO
ALTER TABLE [dbo].[Cities] ADD  DEFAULT ((1)) FOR [IsPublished]
GO
ALTER TABLE [dbo].[ClusterLocations] ADD  DEFAULT ((0)) FOR [IsVerified]
GO
ALTER TABLE [dbo].[ClusterLocations] ADD  DEFAULT ((1)) FOR [IsPublished]
GO
ALTER TABLE [dbo].[OrganisationData] ADD  DEFAULT ((0)) FOR [IsVerified]
GO
ALTER TABLE [dbo].[OrganisationData] ADD  DEFAULT ((1)) FOR [IsPublished]
GO
ALTER TABLE [dbo].[Organisations] ADD  DEFAULT ((1)) FOR [IsPublished]
GO
ALTER TABLE [dbo].[Pincode] ADD  DEFAULT ((1)) FOR [IsPublished]
GO
ALTER TABLE [dbo].[Post] ADD  DEFAULT ((1)) FOR [IsPublished]
GO
ALTER TABLE [dbo].[Post] ADD  DEFAULT ((0)) FOR [IsClosed]
GO
ALTER TABLE [dbo].[PostComments] ADD  DEFAULT ((1)) FOR [IsPublished]
GO
ALTER TABLE [dbo].[RequirementType] ADD  DEFAULT ((1)) FOR [IsPublished]
GO
ALTER TABLE [dbo].[Spam] ADD  DEFAULT ((1)) FOR [IsPublished]
GO
ALTER TABLE [dbo].[States] ADD  DEFAULT ((1)) FOR [IsPublished]
GO
ALTER TABLE [dbo].[Urgency] ADD  DEFAULT ((1)) FOR [IsPublished]
GO
ALTER TABLE [dbo].[UserData] ADD  DEFAULT ((1)) FOR [IsPublished]
GO
ALTER TABLE [dbo].[Users] ADD  DEFAULT ((1)) FOR [IsPublished]
GO
ALTER TABLE [dbo].[Volunteer] ADD  DEFAULT ((1)) FOR [IsPublished]
GO
ALTER TABLE [dbo].[CharityEvent]  WITH CHECK ADD  CONSTRAINT [FK_CharityEventPincodeId] FOREIGN KEY([PincodeId])
REFERENCES [dbo].[Pincode] ([PincodeId])
GO
ALTER TABLE [dbo].[CharityEvent] CHECK CONSTRAINT [FK_CharityEventPincodeId]
GO
ALTER TABLE [dbo].[CharityEvent]  WITH CHECK ADD  CONSTRAINT [FK_CharityOrganisationId] FOREIGN KEY([EventOrganiserId])
REFERENCES [dbo].[OrganisationData] ([OrganisationDataId])
GO
ALTER TABLE [dbo].[CharityEvent] CHECK CONSTRAINT [FK_CharityOrganisationId]
GO
ALTER TABLE [dbo].[CharityEventInteract]  WITH CHECK ADD  CONSTRAINT [FK_CharityEventInteractEvent] FOREIGN KEY([EventId])
REFERENCES [dbo].[CharityEvent] ([EventId])
GO
ALTER TABLE [dbo].[CharityEventInteract] CHECK CONSTRAINT [FK_CharityEventInteractEvent]
GO
ALTER TABLE [dbo].[CharityEventInteract]  WITH CHECK ADD  CONSTRAINT [FK_CharityEventInteractUser] FOREIGN KEY([UserId])
REFERENCES [dbo].[UserData] ([UserId])
GO
ALTER TABLE [dbo].[CharityEventInteract] CHECK CONSTRAINT [FK_CharityEventInteractUser]
GO
ALTER TABLE [dbo].[CharityEventOrganiser]  WITH CHECK ADD  CONSTRAINT [FK_CharityEventOrganiserEvent] FOREIGN KEY([EventId])
REFERENCES [dbo].[CharityEvent] ([EventId])
GO
ALTER TABLE [dbo].[CharityEventOrganiser] CHECK CONSTRAINT [FK_CharityEventOrganiserEvent]
GO
ALTER TABLE [dbo].[CharityEventOrganiser]  WITH CHECK ADD  CONSTRAINT [FK_CharityEventOrganiserEventOrganiser] FOREIGN KEY([EventOrganiserId])
REFERENCES [dbo].[OrganisationData] ([OrganisationDataId])
GO
ALTER TABLE [dbo].[CharityEventOrganiser] CHECK CONSTRAINT [FK_CharityEventOrganiserEventOrganiser]
GO
ALTER TABLE [dbo].[CharityEventPost]  WITH CHECK ADD  CONSTRAINT [FK_CharityEventPostEvent] FOREIGN KEY([EventId])
REFERENCES [dbo].[CharityEvent] ([EventId])
GO
ALTER TABLE [dbo].[CharityEventPost] CHECK CONSTRAINT [FK_CharityEventPostEvent]
GO
ALTER TABLE [dbo].[CharityEventPost]  WITH CHECK ADD  CONSTRAINT [FK_CharityEventPostUser] FOREIGN KEY([UserId])
REFERENCES [dbo].[UserData] ([UserId])
GO
ALTER TABLE [dbo].[CharityEventPost] CHECK CONSTRAINT [FK_CharityEventPostUser]
GO
ALTER TABLE [dbo].[CharityEventPostLike]  WITH CHECK ADD  CONSTRAINT [FK_CharityEventLikeByUser] FOREIGN KEY([UserId])
REFERENCES [dbo].[UserData] ([UserId])
GO
ALTER TABLE [dbo].[CharityEventPostLike] CHECK CONSTRAINT [FK_CharityEventLikeByUser]
GO
ALTER TABLE [dbo].[CharityEventPostLike]  WITH CHECK ADD  CONSTRAINT [FK_CharityEventPost] FOREIGN KEY([CharityEventPostId])
REFERENCES [dbo].[CharityEventPost] ([CharityEventPostId])
GO
ALTER TABLE [dbo].[CharityEventPostLike] CHECK CONSTRAINT [FK_CharityEventPost]
GO
ALTER TABLE [dbo].[Cities]  WITH CHECK ADD  CONSTRAINT [FK_Cities] FOREIGN KEY([StateId])
REFERENCES [dbo].[States] ([StateId])
GO
ALTER TABLE [dbo].[Cities] CHECK CONSTRAINT [FK_Cities]
GO
ALTER TABLE [dbo].[ClusterLocations]  WITH CHECK ADD  CONSTRAINT [FK_ClusterCity] FOREIGN KEY([CityId])
REFERENCES [dbo].[Cities] ([CityId])
GO
ALTER TABLE [dbo].[ClusterLocations] CHECK CONSTRAINT [FK_ClusterCity]
GO
ALTER TABLE [dbo].[ClusterLocations]  WITH CHECK ADD  CONSTRAINT [FK_ClusterControId] FOREIGN KEY([RequirementTypeId])
REFERENCES [dbo].[RequirementType] ([RequirementTypeId])
GO
ALTER TABLE [dbo].[ClusterLocations] CHECK CONSTRAINT [FK_ClusterControId]
GO
ALTER TABLE [dbo].[ClusterLocations]  WITH CHECK ADD  CONSTRAINT [FK_ClusterPin] FOREIGN KEY([PincodeId])
REFERENCES [dbo].[Pincode] ([PincodeId])
GO
ALTER TABLE [dbo].[ClusterLocations] CHECK CONSTRAINT [FK_ClusterPin]
GO
ALTER TABLE [dbo].[ClusterLocations]  WITH CHECK ADD  CONSTRAINT [FK_ClusterPostId] FOREIGN KEY([PostId])
REFERENCES [dbo].[Post] ([PostId])
GO
ALTER TABLE [dbo].[ClusterLocations] CHECK CONSTRAINT [FK_ClusterPostId]
GO
ALTER TABLE [dbo].[ClusterLocations]  WITH CHECK ADD  CONSTRAINT [FK_ClusterState] FOREIGN KEY([StateId])
REFERENCES [dbo].[States] ([StateId])
GO
ALTER TABLE [dbo].[ClusterLocations] CHECK CONSTRAINT [FK_ClusterState]
GO
ALTER TABLE [dbo].[OrganisationData]  WITH CHECK ADD  CONSTRAINT [FK_OrgUser] FOREIGN KEY([OrganisationUserId])
REFERENCES [dbo].[Organisations] ([OrganisationId])
GO
ALTER TABLE [dbo].[OrganisationData] CHECK CONSTRAINT [FK_OrgUser]
GO
ALTER TABLE [dbo].[Pincode]  WITH CHECK ADD  CONSTRAINT [FK_PincodeCity] FOREIGN KEY([CityId])
REFERENCES [dbo].[Cities] ([CityId])
GO
ALTER TABLE [dbo].[Pincode] CHECK CONSTRAINT [FK_PincodeCity]
GO
ALTER TABLE [dbo].[Pincode]  WITH CHECK ADD  CONSTRAINT [FK_PincodeState] FOREIGN KEY([StateId])
REFERENCES [dbo].[States] ([StateId])
GO
ALTER TABLE [dbo].[Pincode] CHECK CONSTRAINT [FK_PincodeState]
GO
ALTER TABLE [dbo].[Post]  WITH CHECK ADD  CONSTRAINT [FK_PostCity] FOREIGN KEY([CityId])
REFERENCES [dbo].[Cities] ([CityId])
GO
ALTER TABLE [dbo].[Post] CHECK CONSTRAINT [FK_PostCity]
GO
ALTER TABLE [dbo].[Post]  WITH CHECK ADD  CONSTRAINT [FK_PostPin] FOREIGN KEY([PincodeId])
REFERENCES [dbo].[Pincode] ([PincodeId])
GO
ALTER TABLE [dbo].[Post] CHECK CONSTRAINT [FK_PostPin]
GO
ALTER TABLE [dbo].[Post]  WITH CHECK ADD  CONSTRAINT [FK_PostState] FOREIGN KEY([StateId])
REFERENCES [dbo].[States] ([StateId])
GO
ALTER TABLE [dbo].[Post] CHECK CONSTRAINT [FK_PostState]
GO
ALTER TABLE [dbo].[Post]  WITH CHECK ADD  CONSTRAINT [FK_PostUserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[UserData] ([UserId])
GO
ALTER TABLE [dbo].[Post] CHECK CONSTRAINT [FK_PostUserId]
GO
ALTER TABLE [dbo].[Post]  WITH CHECK ADD  CONSTRAINT [FK_RequirementType] FOREIGN KEY([RequirementTypeId])
REFERENCES [dbo].[RequirementType] ([RequirementTypeId])
GO
ALTER TABLE [dbo].[Post] CHECK CONSTRAINT [FK_RequirementType]
GO
ALTER TABLE [dbo].[PostComments]  WITH CHECK ADD  CONSTRAINT [FK_PostComPostId] FOREIGN KEY([PostId])
REFERENCES [dbo].[Post] ([PostId])
GO
ALTER TABLE [dbo].[PostComments] CHECK CONSTRAINT [FK_PostComPostId]
GO
ALTER TABLE [dbo].[PostComments]  WITH CHECK ADD  CONSTRAINT [FK_PostComUserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[UserData] ([UserId])
GO
ALTER TABLE [dbo].[PostComments] CHECK CONSTRAINT [FK_PostComUserId]
GO
ALTER TABLE [dbo].[PostImages]  WITH CHECK ADD  CONSTRAINT [FK_PostImgPostId] FOREIGN KEY([PostId])
REFERENCES [dbo].[Post] ([PostId])
GO
ALTER TABLE [dbo].[PostImages] CHECK CONSTRAINT [FK_PostImgPostId]
GO
ALTER TABLE [dbo].[PostImages]  WITH CHECK ADD  CONSTRAINT [FK_PostImgUserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[UserData] ([UserId])
GO
ALTER TABLE [dbo].[PostImages] CHECK CONSTRAINT [FK_PostImgUserId]
GO
ALTER TABLE [dbo].[Spam]  WITH CHECK ADD  CONSTRAINT [FK_SpamPost] FOREIGN KEY([PostId])
REFERENCES [dbo].[Post] ([PostId])
GO
ALTER TABLE [dbo].[Spam] CHECK CONSTRAINT [FK_SpamPost]
GO
ALTER TABLE [dbo].[Spam]  WITH CHECK ADD  CONSTRAINT [FK_SpamUser] FOREIGN KEY([UserId])
REFERENCES [dbo].[UserData] ([UserId])
GO
ALTER TABLE [dbo].[Spam] CHECK CONSTRAINT [FK_SpamUser]
GO
ALTER TABLE [dbo].[Urgency]  WITH CHECK ADD  CONSTRAINT [FK_UrgentPost] FOREIGN KEY([PostId])
REFERENCES [dbo].[Post] ([PostId])
GO
ALTER TABLE [dbo].[Urgency] CHECK CONSTRAINT [FK_UrgentPost]
GO
ALTER TABLE [dbo].[Urgency]  WITH CHECK ADD  CONSTRAINT [FK_UrgentUser] FOREIGN KEY([UserId])
REFERENCES [dbo].[UserData] ([UserId])
GO
ALTER TABLE [dbo].[Urgency] CHECK CONSTRAINT [FK_UrgentUser]
GO
ALTER TABLE [dbo].[UserData]  WITH CHECK ADD  CONSTRAINT [FK_UserCity] FOREIGN KEY([CityId])
REFERENCES [dbo].[Cities] ([CityId])
GO
ALTER TABLE [dbo].[UserData] CHECK CONSTRAINT [FK_UserCity]
GO
ALTER TABLE [dbo].[UserData]  WITH CHECK ADD  CONSTRAINT [FK_UserPin] FOREIGN KEY([PincodeId])
REFERENCES [dbo].[Pincode] ([PincodeId])
GO
ALTER TABLE [dbo].[UserData] CHECK CONSTRAINT [FK_UserPin]
GO
ALTER TABLE [dbo].[UserData]  WITH CHECK ADD  CONSTRAINT [FK_Users] FOREIGN KEY([Users])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[UserData] CHECK CONSTRAINT [FK_Users]
GO
ALTER TABLE [dbo].[UserData]  WITH CHECK ADD  CONSTRAINT [FK_UserState] FOREIGN KEY([StateId])
REFERENCES [dbo].[States] ([StateId])
GO
ALTER TABLE [dbo].[UserData] CHECK CONSTRAINT [FK_UserState]
GO
ALTER TABLE [dbo].[Volunteer]  WITH CHECK ADD  CONSTRAINT [FK_Volunteer] FOREIGN KEY([VolunteerUserId])
REFERENCES [dbo].[UserData] ([UserId])
GO
ALTER TABLE [dbo].[Volunteer] CHECK CONSTRAINT [FK_Volunteer]
GO
ALTER TABLE [dbo].[Volunteer]  WITH CHECK ADD  CONSTRAINT [FK_VolunteerOrg] FOREIGN KEY([OrganisationId])
REFERENCES [dbo].[OrganisationData] ([OrganisationDataId])
GO
ALTER TABLE [dbo].[Volunteer] CHECK CONSTRAINT [FK_VolunteerOrg]
GO
/****** Object:  StoredProcedure [dbo].[addCity]    Script Date: 09-02-2022 13:10:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[addCity](@sid AS BIGINT,@cname AS NVARCHAR, @cat AS DATETIME,@cby AS NVARCHAR(50), @uby AS NVARCHAR(50), @uat AS DATETIME)
AS
BEGIN
INSERT INTO
Cities(StateId,CityName,CreatedBy,CreatedAt,UpdatedBy,UpdatedAt)
VALUES (@sid,@cname,@cby,@cat,@uby,@uat)
END;
GO
/****** Object:  StoredProcedure [dbo].[addState]    Script Date: 09-02-2022 13:10:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[addState](@sname AS NVARCHAR(50),@cby AS NVARCHAR(50), @cat AS DATETIME, @uby AS NVARCHAR(50), @uat AS DATETIME)
	AS
BEGIN
	INSERT INTO 
	States (StateName,CreatedBy,CreatedAt,UpdatedBy,UpdatedAt)
	VALUES (@sname,@cby,@cat,@uby,@uat)
END;
GO
/****** Object:  StoredProcedure [dbo].[getAllCharityEventInteracts]    Script Date: 09-02-2022 13:10:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[getAllCharityEventInteracts]
AS
BEGIN
    SELECT * FROM CharityEventInteract
END;
GO
/****** Object:  StoredProcedure [dbo].[getAllcities]    Script Date: 09-02-2022 13:10:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[getAllcities]
AS
BEGIN
    SELECT 
		*
    FROM 
        Cities
END;
GO
/****** Object:  StoredProcedure [dbo].[getAllClusterLocations]    Script Date: 09-02-2022 13:10:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[getAllClusterLocations]
AS
BEGIN
    SELECT * FROM ClusterLocations
END;
GO
/****** Object:  StoredProcedure [dbo].[getAllOrganisationDatas]    Script Date: 09-02-2022 13:10:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[getAllOrganisationDatas]
AS
BEGIN
    SELECT * FROM OrganisationData
END;
GO
/****** Object:  StoredProcedure [dbo].[getAllPincode]    Script Date: 09-02-2022 13:10:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[getAllPincode]
AS
BEGIN
    SELECT 
		*
    FROM 
        Pincode
END;
GO
/****** Object:  StoredProcedure [dbo].[getAllPostLike]    Script Date: 09-02-2022 13:10:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[getAllPostLike]
AS
BEGIN
    SELECT
		*
    FROM 
        CharityEventPostLike
END;
GO
/****** Object:  StoredProcedure [dbo].[getAllPostLikeById]    Script Date: 09-02-2022 13:10:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[getAllPostLikeById](@postlikeid AS bit)
AS
BEGIN
    SELECT
		*
    FROM 
        CharityEventPostLike
	WHERE
		CharityEventPostLikeId=@postlikeid;
END;
GO
/****** Object:  StoredProcedure [dbo].[getAllPostLikeByUserId]    Script Date: 09-02-2022 13:10:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[getAllPostLikeByUserId](@userid AS bit)
AS
BEGIN
    SELECT
		*
    FROM 
        CharityEventPostLike
	WHERE
		UserId=@userid;
END;
GO
/****** Object:  StoredProcedure [dbo].[getAllSpam]    Script Date: 09-02-2022 13:10:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[getAllSpam]
AS
BEGIN
    SELECT 
		*
    FROM 
        Spam
END;
GO
/****** Object:  StoredProcedure [dbo].[getAllState]    Script Date: 09-02-2022 13:10:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[getAllState]
AS
BEGIN
    SELECT 
		*
    FROM 
        States
END;
GO
/****** Object:  StoredProcedure [dbo].[getallUnVerifiedPost]    Script Date: 09-02-2022 13:10:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[getallUnVerifiedPost]
AS
BEGIN
	SELECT 
		*
	FROM 
		Post
	WHERE
		IsPublished='False';
END;
GO
/****** Object:  StoredProcedure [dbo].[getAllUrgency]    Script Date: 09-02-2022 13:10:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[getAllUrgency]
AS
BEGIN
    SELECT 
		*
    FROM 
        Urgency
END;
GO
/****** Object:  StoredProcedure [dbo].[getAllUserData]    Script Date: 09-02-2022 13:10:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[getAllUserData]
AS
BEGIN
    SELECT * FROM UserData
END;
GO
/****** Object:  StoredProcedure [dbo].[getallVerifiedPost]    Script Date: 09-02-2022 13:10:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[getallVerifiedPost]
AS
BEGIN
	SELECT 
		*
	FROM 
		Post
	WHERE
		IsPublished='True';
END;
GO
/****** Object:  StoredProcedure [dbo].[getAllVolunteers]    Script Date: 09-02-2022 13:10:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[getAllVolunteers]
AS
BEGIN
    SELECT * FROM Volunteer
END;
GO
/****** Object:  StoredProcedure [dbo].[getCityByCityId]    Script Date: 09-02-2022 13:10:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[getCityByCityId](@cityId AS BIGINT)
AS
BEGIN
    SELECT
		*
    FROM 
        Cities
	WHERE
		CityId=@cityId
END;
GO
/****** Object:  StoredProcedure [dbo].[getCityByCityName]    Script Date: 09-02-2022 13:10:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[getCityByCityName](@cityname AS NVARCHAR(50) )
AS
BEGIN
    SELECT
		*
    FROM 
        Cities
	WHERE
		CityName=@cityname
END;
GO
/****** Object:  StoredProcedure [dbo].[getCityByStateId]    Script Date: 09-02-2022 13:10:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[getCityByStateId](@stateid AS BIGINT)
AS
BEGIN
    SELECT
		*
    FROM 
        Cities
	WHERE
		StateId=@stateid
END;
GO
/****** Object:  StoredProcedure [dbo].[getClusterLocationByLocationId]    Script Date: 09-02-2022 13:10:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[getClusterLocationByLocationId](@locationId AS BIGINT)
AS
BEGIN
    SELECT * FROM  ClusterLocations WHERE ClusterLocationId=@locationId
END;
GO
/****** Object:  StoredProcedure [dbo].[getNumberOfDisLike]    Script Date: 09-02-2022 13:10:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[getNumberOfDisLike] (@postid AS bit)
AS
BEGIN
	SELECT 
		COUNT(DisLike) 
	AS 
		NumberOfDisLikes
	FROM 
		CharityEventPostLike
	WHERE
		CharityEventPostId=@postid;
END;
GO
/****** Object:  StoredProcedure [dbo].[getNumberOfLike]    Script Date: 09-02-2022 13:10:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[getNumberOfLike] (@postid AS bit)
AS
BEGIN
	SELECT 
		COUNT(Likes) 
	AS 
		NumberOfLikes
	FROM 
		CharityEventPostLike
	WHERE
		CharityEventPostId=@postid;
END;
GO
/****** Object:  StoredProcedure [dbo].[getPincodeByCityId]    Script Date: 09-02-2022 13:10:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[getPincodeByCityId](@cityid AS BIGINT )
AS
BEGIN
    SELECT
		*
    FROM 
        Pincode
	WHERE
		CityId=@cityid
END;
GO
/****** Object:  StoredProcedure [dbo].[getPincodeByPincode]    Script Date: 09-02-2022 13:10:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[getPincodeByPincode](@pincode AS BIGINT )
AS
BEGIN
    SELECT
		*
    FROM 
        Pincode
	WHERE
		Pincode=@pincode
END;
GO
/****** Object:  StoredProcedure [dbo].[getPincodeByPincodeId]    Script Date: 09-02-2022 13:10:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[getPincodeByPincodeId](@pincodeid AS BIGINT)
AS
BEGIN
    SELECT
		*
    FROM 
        Pincode
	WHERE
		PincodeId=@pincodeid
END;
GO
/****** Object:  StoredProcedure [dbo].[getPincodeByPostOfficeName]    Script Date: 09-02-2022 13:10:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[getPincodeByPostOfficeName](@postoffice AS VARCHAR(100) )
AS
BEGIN
    SELECT
		*
    FROM 
        Pincode
	WHERE
		PostOfficeName=@postoffice
END
GO
/****** Object:  StoredProcedure [dbo].[getPincodeByStateId]    Script Date: 09-02-2022 13:10:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[getPincodeByStateId](@stateid AS BIGINT )
AS
BEGIN
    SELECT
		*
    FROM 
        Pincode
	WHERE
		StateId=@stateid
END;
GO
/****** Object:  StoredProcedure [dbo].[getSpamByPostId]    Script Date: 09-02-2022 13:10:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[getSpamByPostId](@postid AS BIGINT )
AS
BEGIN
    SELECT
		*
    FROM 
        Spam
	WHERE
		PostId=@postid
END;
GO
/****** Object:  StoredProcedure [dbo].[getSpamBySpamId]    Script Date: 09-02-2022 13:10:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[getSpamBySpamId](@spamid AS BIGINT)
AS
BEGIN
    SELECT
		*
    FROM 
        Spam
	WHERE
		SpamId=@spamid
END;
GO
/****** Object:  StoredProcedure [dbo].[getSpamByUserId]    Script Date: 09-02-2022 13:10:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[getSpamByUserId](@userid AS BIGINT )
AS
BEGIN
    SELECT
		*
    FROM 
        Spam
	WHERE
		UserId=@userid
END;
GO
/****** Object:  StoredProcedure [dbo].[getStateByStateId]    Script Date: 09-02-2022 13:10:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[getStateByStateId](@stateid AS BIGINT)
AS
BEGIN
    SELECT
		*
    FROM 
        States
	WHERE
		StateId=@stateid
END;
GO
/****** Object:  StoredProcedure [dbo].[getStateByStateName]    Script Date: 09-02-2022 13:10:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[getStateByStateName](@statename AS NVARCHAR(50) )
AS
BEGIN
    SELECT
		*
    FROM 
        States
	WHERE
		StateName=@statename
END;
GO
/****** Object:  StoredProcedure [dbo].[getUrgencyByPostID]    Script Date: 09-02-2022 13:10:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[getUrgencyByPostID](@postid AS BIGINT )
AS
BEGIN
    SELECT
		*
    FROM 
        Urgency
	WHERE
		PostId=@postid
END;
GO
/****** Object:  StoredProcedure [dbo].[getUrgencyByUrgencyId]    Script Date: 09-02-2022 13:10:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[getUrgencyByUrgencyId](@uid AS BIGINT)
AS
BEGIN
    SELECT
		*
    FROM 
        Urgency
	WHERE
		UrgencyId=@uid
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_getPosts]    Script Date: 09-02-2022 13:10:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_getPosts]
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
WHERE P.IsClosed = 0 AND P.IsPublished =1
)

END
GO
/****** Object:  StoredProcedure [dbo].[sp_getPostUser]    Script Date: 09-02-2022 13:10:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_getPostUser](
@Pincode BIGINT =1,
@CityId BIGINT = 1,
@StateId BIGINT =1,
@UserId BIGINT = 1
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
WHERE P.PincodeId = @Pincode AND P.IsClosed = 0 AND P.IsPublished =1
--@User'sPincodeId
)
UNION
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

WHERE P.CityId = @CityId AND P.IsClosed = 0 AND P.IsPublished =1
--@User'sCityId
)
UNION
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
WHERE P.StateId = @StateId AND P.IsClosed = 0 AND P.IsPublished =1
--@User'sStateId
)
END
GO
USE [master]
GO
ALTER DATABASE [CharityAPI] SET  READ_WRITE 
GO
