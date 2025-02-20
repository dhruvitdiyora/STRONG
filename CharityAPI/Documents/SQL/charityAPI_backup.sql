USE [master]
GO
/****** Object:  Database [CharityAPI]    Script Date: 09-02-2022 12:58:29 ******/
CREATE DATABASE [CharityAPI]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'CharityAPI', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\CharityAPI.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'CharityAPI_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\CharityAPI_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
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
/****** Object:  User [saa]    Script Date: 09-02-2022 12:58:29 ******/
CREATE USER [saa] FOR LOGIN [saa] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [dd]    Script Date: 09-02-2022 12:58:29 ******/
CREATE USER [dd] FOR LOGIN [dd] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  UserDefinedFunction [dbo].[fn_TotalComments]    Script Date: 09-02-2022 12:58:29 ******/
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
/****** Object:  UserDefinedFunction [dbo].[fn_TotalSpam]    Script Date: 09-02-2022 12:58:29 ******/
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
/****** Object:  UserDefinedFunction [dbo].[fn_TotalUrgency]    Script Date: 09-02-2022 12:58:29 ******/
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
/****** Object:  Table [dbo].[Admins]    Script Date: 09-02-2022 12:58:29 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CharityEvent]    Script Date: 09-02-2022 12:58:29 ******/
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
/****** Object:  Table [dbo].[CharityEventInteract]    Script Date: 09-02-2022 12:58:29 ******/
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
/****** Object:  Table [dbo].[CharityEventOrganiser]    Script Date: 09-02-2022 12:58:29 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CharityEventPost]    Script Date: 09-02-2022 12:58:29 ******/
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
/****** Object:  Table [dbo].[CharityEventPostLike]    Script Date: 09-02-2022 12:58:29 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Cities]    Script Date: 09-02-2022 12:58:29 ******/
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
/****** Object:  Table [dbo].[ClusterLocations]    Script Date: 09-02-2022 12:58:29 ******/
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
/****** Object:  Table [dbo].[OrganisationData]    Script Date: 09-02-2022 12:58:29 ******/
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
/****** Object:  Table [dbo].[Organisations]    Script Date: 09-02-2022 12:58:29 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Pincode]    Script Date: 09-02-2022 12:58:29 ******/
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
/****** Object:  Table [dbo].[Post]    Script Date: 09-02-2022 12:58:29 ******/
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
/****** Object:  Table [dbo].[PostComments]    Script Date: 09-02-2022 12:58:29 ******/
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
/****** Object:  Table [dbo].[PostImages]    Script Date: 09-02-2022 12:58:29 ******/
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
/****** Object:  Table [dbo].[RequirementType]    Script Date: 09-02-2022 12:58:29 ******/
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
/****** Object:  Table [dbo].[Spam]    Script Date: 09-02-2022 12:58:29 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[States]    Script Date: 09-02-2022 12:58:29 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Urgency]    Script Date: 09-02-2022 12:58:29 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserData]    Script Date: 09-02-2022 12:58:29 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 09-02-2022 12:58:29 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Volunteer]    Script Date: 09-02-2022 12:58:29 ******/
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
/****** Object:  Table [dbo].[WebApiExceptionLog]    Script Date: 09-02-2022 12:58:29 ******/
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
/****** Object:  Table [dbo].[WebApiRequestLog]    Script Date: 09-02-2022 12:58:29 ******/
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
SET IDENTITY_INSERT [dbo].[Admins] ON 

INSERT [dbo].[Admins] ([AdminId], [UserName], [EmailAddress], [PasswordHash], [MobileNo], [CreatedBy], [CreatedAt], [UpdatedBy], [UpdatedAt], [IsPublished]) VALUES (1, N'dhruviddd', N'dhruvddd@gmail.com', N'Dhruvit@123', N'9157041681', N'dhruviddd', CAST(N'2022-01-26T14:21:55.900' AS DateTime), N'dhruviddd', CAST(N'2022-01-26T14:21:55.900' AS DateTime), 1)
SET IDENTITY_INSERT [dbo].[Admins] OFF
GO
SET IDENTITY_INSERT [dbo].[CharityEvent] ON 

INSERT [dbo].[CharityEvent] ([EventId], [EventName], [EventDescription], [EventOrganiserId], [EventStartDate], [EventBannerURL], [EventEndDate], [IsVerified], [EventType], [CreatedBy], [CreatedAt], [UpdatedBy], [PincodeId], [UpdatedAt], [IsPublished], [IsCompleted], [LocationName]) VALUES (10004, N'current event', N'hello', 2, CAST(N'2022-02-13T00:00:00.000' AS DateTime), N'Screenshot (166) - Copy.png', CAST(N'2022-02-14T00:00:00.000' AS DateTime), 0, N'Donation camp', N'dhruvi1234', CAST(N'2022-02-02T20:07:37.557' AS DateTime), N'dhruvi1234', 3, CAST(N'2022-02-02T20:07:37.873' AS DateTime), 1, 0, N'katargam')
SET IDENTITY_INSERT [dbo].[CharityEvent] OFF
GO
SET IDENTITY_INSERT [dbo].[CharityEventInteract] ON 

INSERT [dbo].[CharityEventInteract] ([CharityEventInteractId], [EventId], [UserId], [IsInterested], [IsGoing], [CreatedBy], [CreatedAt], [UpdatedBy], [UpdatedAt], [IsPublished]) VALUES (1, 10004, 3, 0, 1, N'dhruvitdiyora', CAST(N'2022-02-05T10:51:14.383' AS DateTime), N'dhruvitdiyora', CAST(N'2022-02-05T10:51:18.080' AS DateTime), 1)
SET IDENTITY_INSERT [dbo].[CharityEventInteract] OFF
GO
SET IDENTITY_INSERT [dbo].[CharityEventPost] ON 

INSERT [dbo].[CharityEventPost] ([CharityEventPostId], [EventId], [UserId], [PostUrl], [Content], [CreatedBy], [CreatedAt], [UpdatedBy], [UpdatedAt], [IsPublished]) VALUES (2, 10004, 3, N'Screenshot (166) - Copy.png', N'hello', N'dhruvitdiyora', CAST(N'2022-02-08T17:54:04.373' AS DateTime), N'dhruvitdiyora', CAST(N'2022-02-08T17:54:04.373' AS DateTime), 1)
SET IDENTITY_INSERT [dbo].[CharityEventPost] OFF
GO
SET IDENTITY_INSERT [dbo].[Cities] ON 

INSERT [dbo].[Cities] ([CityId], [StateId], [CityName], [CreatedBy], [CreatedAt], [UpdatedBy], [UpdatedAt], [IsPublished]) VALUES (1, 3, N'Ahmedabad', N'dhruvi1234', CAST(N'2021-12-24T16:49:48.963' AS DateTime), N'dhruvi1234', CAST(N'2021-12-24T16:49:48.963' AS DateTime), 1)
INSERT [dbo].[Cities] ([CityId], [StateId], [CityName], [CreatedBy], [CreatedAt], [UpdatedBy], [UpdatedAt], [IsPublished]) VALUES (2, 3, N'Ahmedabad', N'dhruvi1234', CAST(N'2022-01-03T16:31:10.147' AS DateTime), N'dhruvi1234', CAST(N'2022-01-03T16:31:10.147' AS DateTime), 1)
SET IDENTITY_INSERT [dbo].[Cities] OFF
GO
SET IDENTITY_INSERT [dbo].[ClusterLocations] ON 

INSERT [dbo].[ClusterLocations] ([ClusterLocationId], [PostId], [RequirementTypeId], [Locations], [CityId], [StateId], [PeopleCount], [IsVerified], [CreatedBy], [CreatedAt], [UpdatedBy], [UpdatedAt], [IsPublished], [PincodeId]) VALUES (2, 10004, 3, N'Maninagar', 1, 3, 20, 1, N'dhruvitdiyora', CAST(N'2022-01-28T18:06:00.790' AS DateTime), N'dhruvitdiyora', CAST(N'2022-01-28T18:06:00.790' AS DateTime), 1, 3)
SET IDENTITY_INSERT [dbo].[ClusterLocations] OFF
GO
SET IDENTITY_INSERT [dbo].[OrganisationData] ON 

INSERT [dbo].[OrganisationData] ([OrganisationDataId], [OrganisationUserId], [OrganisationName], [OrganisationAddress], [OrganisationContactNo], [OrganisationLogoURL], [IsVerified], [CreatedBy], [CreatedAt], [UpdatedBy], [UpdatedAt], [IsPublished], [OrganisationDetail], [OrganisatioWebURL], [OrganisationUserName]) VALUES (2, 1, N'RDHA', N'Punjab', N'3124567890', N'17se02ce012.jpg', 1, N'dhruvi1234', CAST(N'2021-12-24T16:46:03.923' AS DateTime), N'dhruvi1234', CAST(N'2021-12-24T20:03:11.417' AS DateTime), 1, N'details', N'www.google.com', N'dhruvi1234')
INSERT [dbo].[OrganisationData] ([OrganisationDataId], [OrganisationUserId], [OrganisationName], [OrganisationAddress], [OrganisationContactNo], [OrganisationLogoURL], [IsVerified], [CreatedBy], [CreatedAt], [UpdatedBy], [UpdatedAt], [IsPublished], [OrganisationDetail], [OrganisatioWebURL], [OrganisationUserName]) VALUES (3, 1, N'RDHA', N'Punjab', N'3214567890', N'17se02ce012.jpg', 1, N'dhruvi1234', CAST(N'2021-12-24T20:01:05.917' AS DateTime), N'dhruvi1234', CAST(N'2021-12-24T20:01:05.917' AS DateTime), 1, NULL, NULL, NULL)
SET IDENTITY_INSERT [dbo].[OrganisationData] OFF
GO
SET IDENTITY_INSERT [dbo].[Organisations] ON 

INSERT [dbo].[Organisations] ([OrganisationId], [UserName], [EmailAddress], [PasswordHash], [MobileNo], [Otp], [OtpCreatedAt], [CreatedBy], [CreatedAt], [UpdatedBy], [UpdatedAt], [IsPublished]) VALUES (1, N'dhruvi1234', N'dhruv12345@gmail.com', N'Dhruvit@123', N'9157849887', 9139, CAST(N'2021-12-24T16:37:43.163' AS DateTime), N'dhruvi1234', CAST(N'2021-12-24T16:37:43.163' AS DateTime), N'dhruvi1234', CAST(N'2021-12-24T16:37:43.163' AS DateTime), 1)
INSERT [dbo].[Organisations] ([OrganisationId], [UserName], [EmailAddress], [PasswordHash], [MobileNo], [Otp], [OtpCreatedAt], [CreatedBy], [CreatedAt], [UpdatedBy], [UpdatedAt], [IsPublished]) VALUES (7, N'pshubh333', N'pshubh333@gmail.com', N'Dhruvit@123', N'8520963874', 5016, CAST(N'2022-02-02T17:31:31.820' AS DateTime), N'pshubh333', CAST(N'2022-02-02T17:31:31.820' AS DateTime), N'pshubh333', CAST(N'2022-02-02T17:31:31.820' AS DateTime), 1)
SET IDENTITY_INSERT [dbo].[Organisations] OFF
GO
SET IDENTITY_INSERT [dbo].[Pincode] ON 

INSERT [dbo].[Pincode] ([PincodeId], [PostOfficeName], [Pincode], [CityId], [District], [StateId], [CreatedBy], [CreatedAt], [UpdatedBy], [UpdatedAt], [IsPublished]) VALUES (3, N'bapunagar', 123456, 1, N'surat', 3, N'dhruvi1234', CAST(N'2021-12-24T16:50:10.180' AS DateTime), N'dhruvi1234', CAST(N'2021-12-24T16:50:10.180' AS DateTime), 1)
SET IDENTITY_INSERT [dbo].[Pincode] OFF
GO
SET IDENTITY_INSERT [dbo].[Post] ON 

INSERT [dbo].[Post] ([PostId], [UserId], [PostDescription], [RequirementTypeId], [LocationName], [Longitude], [Latitude], [HelpRequiredCount], [CityId], [StateId], [ImageURL], [CreatedBy], [CreatedAt], [UpdatedBy], [UpdatedAt], [IsPublished], [IsClosed], [CloseAt], [PincodeId]) VALUES (10003, 3, N'education', 1, N'Ghodasar', CAST(47.595151800 AS Decimal(12, 9)), CAST(-122.331639300 AS Decimal(12, 9)), 54, 1, 1, N'17se02ce012.png', N'dhruvitdiyora', CAST(N'2022-01-20T12:29:16.163' AS DateTime), N'dhruvitdiyora', CAST(N'2022-01-20T12:29:16.163' AS DateTime), 1, 0, CAST(N'2022-01-20T12:29:16.163' AS DateTime), 3)
INSERT [dbo].[Post] ([PostId], [UserId], [PostDescription], [RequirementTypeId], [LocationName], [Longitude], [Latitude], [HelpRequiredCount], [CityId], [StateId], [ImageURL], [CreatedBy], [CreatedAt], [UpdatedBy], [UpdatedAt], [IsPublished], [IsClosed], [CloseAt], [PincodeId]) VALUES (10004, 3, N'education', 1, N'Ghodasar', CAST(47.595151800 AS Decimal(12, 9)), CAST(-122.331639300 AS Decimal(12, 9)), 54, 1, 1, N'17se02ce012.jpg', N'dhruvitdiyora', CAST(N'2022-01-20T12:29:49.257' AS DateTime), N'dhruvitdiyora', CAST(N'2022-01-20T12:29:49.257' AS DateTime), 1, 0, CAST(N'2022-01-20T12:29:49.257' AS DateTime), 3)
INSERT [dbo].[Post] ([PostId], [UserId], [PostDescription], [RequirementTypeId], [LocationName], [Longitude], [Latitude], [HelpRequiredCount], [CityId], [StateId], [ImageURL], [CreatedBy], [CreatedAt], [UpdatedBy], [UpdatedAt], [IsPublished], [IsClosed], [CloseAt], [PincodeId]) VALUES (10005, 3, N'education', 1, N'Ghodasar', CAST(12.230000000 AS Decimal(12, 9)), CAST(23.650000000 AS Decimal(12, 9)), 54, 1, 1, N'17se02ce012.jpg', N'dhruvitdiyora', CAST(N'2022-01-20T12:35:50.313' AS DateTime), N'dhruvitdiyora', CAST(N'2022-01-20T12:35:50.313' AS DateTime), 1, 0, CAST(N'2022-01-20T12:35:50.313' AS DateTime), 3)
INSERT [dbo].[Post] ([PostId], [UserId], [PostDescription], [RequirementTypeId], [LocationName], [Longitude], [Latitude], [HelpRequiredCount], [CityId], [StateId], [ImageURL], [CreatedBy], [CreatedAt], [UpdatedBy], [UpdatedAt], [IsPublished], [IsClosed], [CloseAt], [PincodeId]) VALUES (10007, 3, N'hello', 2, N'dcda', CAST(73.089900000 AS Decimal(12, 9)), CAST(22.237400000 AS Decimal(12, 9)), 85, 1, 1, N'Screenshot (166).png', N'dhruvitdiyora', CAST(N'2022-01-31T09:48:43.210' AS DateTime), N'dhruvitdiyora', CAST(N'2022-01-31T09:48:43.210' AS DateTime), 0, 0, CAST(N'2022-01-31T09:48:43.210' AS DateTime), 3)
INSERT [dbo].[Post] ([PostId], [UserId], [PostDescription], [RequirementTypeId], [LocationName], [Longitude], [Latitude], [HelpRequiredCount], [CityId], [StateId], [ImageURL], [CreatedBy], [CreatedAt], [UpdatedBy], [UpdatedAt], [IsPublished], [IsClosed], [CloseAt], [PincodeId]) VALUES (10008, 3, N'hello', 2, N'dcda', CAST(73.089900000 AS Decimal(12, 9)), CAST(22.237400000 AS Decimal(12, 9)), 85, 1, 1, N'Screenshot (166).png', N'dhruvitdiyora', CAST(N'2022-01-31T10:10:24.783' AS DateTime), N'dhruvitdiyora', CAST(N'2022-01-31T10:10:24.783' AS DateTime), 0, 0, CAST(N'2022-01-31T10:10:24.783' AS DateTime), 3)
INSERT [dbo].[Post] ([PostId], [UserId], [PostDescription], [RequirementTypeId], [LocationName], [Longitude], [Latitude], [HelpRequiredCount], [CityId], [StateId], [ImageURL], [CreatedBy], [CreatedAt], [UpdatedBy], [UpdatedAt], [IsPublished], [IsClosed], [CloseAt], [PincodeId]) VALUES (10009, 3, N'hello', 1, N'dcda', CAST(73.089900000 AS Decimal(12, 9)), CAST(22.237400000 AS Decimal(12, 9)), 58, 1, 3, N'Screenshot (166) - Copy.png', N'dhruvitdiyora', CAST(N'2022-01-31T16:31:07.553' AS DateTime), N'dhruvitdiyora', CAST(N'2022-01-31T16:31:07.553' AS DateTime), 0, 0, CAST(N'2022-01-31T16:31:07.553' AS DateTime), 3)
INSERT [dbo].[Post] ([PostId], [UserId], [PostDescription], [RequirementTypeId], [LocationName], [Longitude], [Latitude], [HelpRequiredCount], [CityId], [StateId], [ImageURL], [CreatedBy], [CreatedAt], [UpdatedBy], [UpdatedAt], [IsPublished], [IsClosed], [CloseAt], [PincodeId]) VALUES (10010, 3, N'hello', 1, N'dcda', CAST(73.089900000 AS Decimal(12, 9)), CAST(22.237400000 AS Decimal(12, 9)), 25, 1, 3, N'Screenshot (166).png', N'dhruvitdiyora', CAST(N'2022-01-31T17:13:26.573' AS DateTime), N'dhruvitdiyora', CAST(N'2022-01-31T17:13:26.573' AS DateTime), 1, 0, CAST(N'2022-01-31T17:13:26.573' AS DateTime), 3)
INSERT [dbo].[Post] ([PostId], [UserId], [PostDescription], [RequirementTypeId], [LocationName], [Longitude], [Latitude], [HelpRequiredCount], [CityId], [StateId], [ImageURL], [CreatedBy], [CreatedAt], [UpdatedBy], [UpdatedAt], [IsPublished], [IsClosed], [CloseAt], [PincodeId]) VALUES (10011, 3, N'hello', 1, N'dcda', CAST(73.089900000 AS Decimal(12, 9)), CAST(22.237400000 AS Decimal(12, 9)), 85, 1, 3, N'Screenshot (166) - Copy.png', N'dhruvitdiyora', CAST(N'2022-01-31T17:39:18.967' AS DateTime), N'dhruvitdiyora', CAST(N'2022-01-31T17:39:18.967' AS DateTime), 0, 0, CAST(N'2022-01-31T17:39:18.967' AS DateTime), 3)
SET IDENTITY_INSERT [dbo].[Post] OFF
GO
SET IDENTITY_INSERT [dbo].[PostComments] ON 

INSERT [dbo].[PostComments] ([PostCommentId], [UserId], [PostId], [Comment], [CreatedBy], [CreatedAt], [UpdatedBy], [UpdatedAt], [IsPublished]) VALUES (3, 3, 10003, N'hello', N'dhruvitdiyora', CAST(N'2022-01-24T13:34:57.390' AS DateTime), N'dhruvitdiyora', CAST(N'2022-01-24T13:34:57.393' AS DateTime), 1)
INSERT [dbo].[PostComments] ([PostCommentId], [UserId], [PostId], [Comment], [CreatedBy], [CreatedAt], [UpdatedBy], [UpdatedAt], [IsPublished]) VALUES (4, 3, 10003, N'hello', N'dhruvitdiyora', CAST(N'2022-01-24T14:36:11.593' AS DateTime), N'dhruvitdiyora', CAST(N'2022-01-24T14:36:11.593' AS DateTime), 1)
INSERT [dbo].[PostComments] ([PostCommentId], [UserId], [PostId], [Comment], [CreatedBy], [CreatedAt], [UpdatedBy], [UpdatedAt], [IsPublished]) VALUES (5, 3, 10003, N'hello', N'dhruvitdiyora', CAST(N'2022-01-24T15:31:48.023' AS DateTime), N'dhruvitdiyora', CAST(N'2022-01-24T15:31:48.023' AS DateTime), 1)
INSERT [dbo].[PostComments] ([PostCommentId], [UserId], [PostId], [Comment], [CreatedBy], [CreatedAt], [UpdatedBy], [UpdatedAt], [IsPublished]) VALUES (6, 3, 10003, N'hello', N'dhruvitdiyora', CAST(N'2022-01-24T15:34:16.513' AS DateTime), N'dhruvitdiyora', CAST(N'2022-01-24T15:34:16.513' AS DateTime), 1)
INSERT [dbo].[PostComments] ([PostCommentId], [UserId], [PostId], [Comment], [CreatedBy], [CreatedAt], [UpdatedBy], [UpdatedAt], [IsPublished]) VALUES (7, 3, 10003, N'hello', N'dhruvitdiyora', CAST(N'2022-01-24T15:35:54.940' AS DateTime), N'dhruvitdiyora', CAST(N'2022-01-24T15:35:54.940' AS DateTime), 1)
INSERT [dbo].[PostComments] ([PostCommentId], [UserId], [PostId], [Comment], [CreatedBy], [CreatedAt], [UpdatedBy], [UpdatedAt], [IsPublished]) VALUES (8, 3, 10003, N'hello', N'dhruvitdiyora', CAST(N'2022-01-24T15:36:32.413' AS DateTime), N'dhruvitdiyora', CAST(N'2022-01-24T15:36:32.413' AS DateTime), 1)
INSERT [dbo].[PostComments] ([PostCommentId], [UserId], [PostId], [Comment], [CreatedBy], [CreatedAt], [UpdatedBy], [UpdatedAt], [IsPublished]) VALUES (9, 3, 10003, N'hello', N'dhruvitdiyora', CAST(N'2022-01-24T15:38:13.057' AS DateTime), N'dhruvitdiyora', CAST(N'2022-01-24T15:38:13.057' AS DateTime), 1)
INSERT [dbo].[PostComments] ([PostCommentId], [UserId], [PostId], [Comment], [CreatedBy], [CreatedAt], [UpdatedBy], [UpdatedAt], [IsPublished]) VALUES (10, 3, 10003, N'hello', N'dhruvitdiyora', CAST(N'2022-01-24T15:39:40.737' AS DateTime), N'dhruvitdiyora', CAST(N'2022-01-24T15:39:40.737' AS DateTime), 1)
INSERT [dbo].[PostComments] ([PostCommentId], [UserId], [PostId], [Comment], [CreatedBy], [CreatedAt], [UpdatedBy], [UpdatedAt], [IsPublished]) VALUES (11, 3, 10004, N'hello', N'dhruvitdiyora', CAST(N'2022-01-24T15:39:59.247' AS DateTime), N'dhruvitdiyora', CAST(N'2022-01-24T15:39:59.247' AS DateTime), 1)
INSERT [dbo].[PostComments] ([PostCommentId], [UserId], [PostId], [Comment], [CreatedBy], [CreatedAt], [UpdatedBy], [UpdatedAt], [IsPublished]) VALUES (12, 3, 10004, N'hello', N'dhruvitdiyora', CAST(N'2022-01-24T21:28:48.277' AS DateTime), N'dhruvitdiyora', CAST(N'2022-01-24T21:28:48.277' AS DateTime), 1)
INSERT [dbo].[PostComments] ([PostCommentId], [UserId], [PostId], [Comment], [CreatedBy], [CreatedAt], [UpdatedBy], [UpdatedAt], [IsPublished]) VALUES (13, 3, 10003, N'hello', N'dhruvitdiyora', CAST(N'2022-02-03T18:57:08.740' AS DateTime), N'dhruvitdiyora', CAST(N'2022-02-03T18:57:08.740' AS DateTime), 1)
SET IDENTITY_INSERT [dbo].[PostComments] OFF
GO
SET IDENTITY_INSERT [dbo].[PostImages] ON 

INSERT [dbo].[PostImages] ([PostImagesId], [UserId], [PostId], [ImageURL1], [ImageURL2], [ImageURL3], [ImageURL4], [CreatedBy], [CreatedAt], [UpdatedBy], [UpdatedAt]) VALUES (1, 3, 10010, N'Screenshot (167) - Copy.png', N'Screenshot (167).png', N'Screenshot (168) - Copy.png', N'Screenshot (169) - Copy.png', N'dhruvitdiyora', CAST(N'2022-01-31T17:13:26.870' AS DateTime), N'dhruvitdiyora', CAST(N'2022-01-31T17:13:26.870' AS DateTime))
INSERT [dbo].[PostImages] ([PostImagesId], [UserId], [PostId], [ImageURL1], [ImageURL2], [ImageURL3], [ImageURL4], [CreatedBy], [CreatedAt], [UpdatedBy], [UpdatedAt]) VALUES (2, 3, 10011, N'Screenshot (166).png', N'Screenshot (167) - Copy.png', N'Screenshot (167).png', N'Screenshot (168) - Copy.png', N'dhruvitdiyora', CAST(N'2022-01-31T17:39:19.607' AS DateTime), N'dhruvitdiyora', CAST(N'2022-01-31T17:39:19.607' AS DateTime))
SET IDENTITY_INSERT [dbo].[PostImages] OFF
GO
SET IDENTITY_INSERT [dbo].[RequirementType] ON 

INSERT [dbo].[RequirementType] ([RequirementTypeId], [RequirementTypeName], [CreatedBy], [CreatedAt], [UpdatedBy], [UpdatedAt], [IsPublished]) VALUES (1, N'Food', N'dhruvitdiyora', CAST(N'2022-01-20T11:11:01.993' AS DateTime), N'dhruvitdiyora', CAST(N'2022-01-20T11:11:01.993' AS DateTime), 1)
INSERT [dbo].[RequirementType] ([RequirementTypeId], [RequirementTypeName], [CreatedBy], [CreatedAt], [UpdatedBy], [UpdatedAt], [IsPublished]) VALUES (2, N'Education', N'dhruvitdiyora', CAST(N'2022-01-20T11:11:14.970' AS DateTime), N'dhruvitdiyora', CAST(N'2022-01-20T11:11:14.970' AS DateTime), 1)
INSERT [dbo].[RequirementType] ([RequirementTypeId], [RequirementTypeName], [CreatedBy], [CreatedAt], [UpdatedBy], [UpdatedAt], [IsPublished]) VALUES (3, N'Cloth', N'dhruvitdiyora', CAST(N'2022-01-20T11:11:25.610' AS DateTime), N'dhruvitdiyora', CAST(N'2022-01-20T11:11:25.610' AS DateTime), 1)
SET IDENTITY_INSERT [dbo].[RequirementType] OFF
GO
SET IDENTITY_INSERT [dbo].[Spam] ON 

INSERT [dbo].[Spam] ([SpamId], [PostId], [UserId], [CreatedBy], [CreatedAt], [UpdatedBy], [UpdatedAt], [IsPublished]) VALUES (12, 10005, 3, N'dhruvitdiyora', CAST(N'2022-02-04T18:06:37.983' AS DateTime), N'dhruvitdiyora', CAST(N'2022-02-04T18:06:37.987' AS DateTime), 1)
INSERT [dbo].[Spam] ([SpamId], [PostId], [UserId], [CreatedBy], [CreatedAt], [UpdatedBy], [UpdatedAt], [IsPublished]) VALUES (13, 10003, 3, N'dhruvitdiyora', CAST(N'2022-02-08T16:54:53.980' AS DateTime), N'dhruvitdiyora', CAST(N'2022-02-08T16:54:53.983' AS DateTime), 1)
INSERT [dbo].[Spam] ([SpamId], [PostId], [UserId], [CreatedBy], [CreatedAt], [UpdatedBy], [UpdatedAt], [IsPublished]) VALUES (15, 10004, 3, N'dhruvitdiyora', CAST(N'2022-02-08T16:56:26.567' AS DateTime), N'dhruvitdiyora', CAST(N'2022-02-08T16:56:26.567' AS DateTime), 1)
SET IDENTITY_INSERT [dbo].[Spam] OFF
GO
SET IDENTITY_INSERT [dbo].[States] ON 

INSERT [dbo].[States] ([StateId], [StateName], [CreatedBy], [CreatedAt], [UpdatedBy], [UpdatedAt], [IsPublished]) VALUES (1, N'Keral', N'dhruvi1234', CAST(N'2021-12-24T16:47:51.443' AS DateTime), N'dhruvi1234', CAST(N'2021-12-24T16:47:51.443' AS DateTime), 1)
INSERT [dbo].[States] ([StateId], [StateName], [CreatedBy], [CreatedAt], [UpdatedBy], [UpdatedAt], [IsPublished]) VALUES (3, N'gujarat', N'dhruvi1234', CAST(N'2021-12-24T16:49:08.497' AS DateTime), N'dhruvi1234', CAST(N'2021-12-24T16:49:08.497' AS DateTime), 1)
SET IDENTITY_INSERT [dbo].[States] OFF
GO
SET IDENTITY_INSERT [dbo].[Urgency] ON 

INSERT [dbo].[Urgency] ([UrgencyId], [PostId], [UserId], [CreatedBy], [CreatedAt], [UpdatedBy], [UpdatedAt], [IsPublished]) VALUES (5, 10004, 3, N'dhruvitdiyora', CAST(N'2022-01-24T21:26:54.043' AS DateTime), N'dhruvitdiyora', CAST(N'2022-01-24T21:26:54.043' AS DateTime), 1)
INSERT [dbo].[Urgency] ([UrgencyId], [PostId], [UserId], [CreatedBy], [CreatedAt], [UpdatedBy], [UpdatedAt], [IsPublished]) VALUES (6, 10005, 3, N'dhruvitdiyora', CAST(N'2022-01-24T21:33:30.317' AS DateTime), N'dhruvitdiyora', CAST(N'2022-01-24T21:33:30.317' AS DateTime), 1)
INSERT [dbo].[Urgency] ([UrgencyId], [PostId], [UserId], [CreatedBy], [CreatedAt], [UpdatedBy], [UpdatedAt], [IsPublished]) VALUES (8, 10003, 3, N'dhruvitdiyora', CAST(N'2022-02-03T19:09:15.903' AS DateTime), N'dhruvitdiyora', CAST(N'2022-02-03T19:09:15.907' AS DateTime), 1)
SET IDENTITY_INSERT [dbo].[Urgency] OFF
GO
SET IDENTITY_INSERT [dbo].[UserData] ON 

INSERT [dbo].[UserData] ([UserId], [FirstName], [LastName], [Gender], [ProfileImage], [UserDescription], [UserName], [EmailAddress], [MobileNo], [TotalPostCount], [CreatedBy], [CreatedAt], [UpdatedBy], [UpdatedAt], [IsPublished], [Users], [CityId], [StateId], [PincodeId]) VALUES (3, N'Preet2', N'Gandhi', N'Male', N'17se02ce012.jpg', N'None', N'dhruvitdiyora', N'preet2@gmail.com', N'9173086971', 1, N'dhruvitdiyora', CAST(N'2022-01-20T12:27:14.747' AS DateTime), N'dhruvitdiyora', CAST(N'2022-01-20T12:27:14.747' AS DateTime), 1, 3, 1, 1, 3)
SET IDENTITY_INSERT [dbo].[UserData] OFF
GO
SET IDENTITY_INSERT [dbo].[Users] ON 

INSERT [dbo].[Users] ([UserId], [UserName], [EmailAddress], [PasswordHash], [MobileNo], [Otp], [OtpCreatedAt], [CreatedBy], [CreatedAt], [UpdatedBy], [UpdatedAt], [IsPublished]) VALUES (3, N'dhruvitdiyora', N'dhruvit.d9688@gmail.com', N'AQAAAAEAACcQAAAAEOHiu3BxKwGNI+XWkBFHwNi1EV7wn6YWaLrFKwm+9y2qMdrew0M9hlha2k08RWg+Rg==', N'9155667788', 7098, CAST(N'2022-01-12T12:53:04.317' AS DateTime), N'dhruvitdiyora', CAST(N'2022-01-12T12:53:04.317' AS DateTime), N'dhruvitdiyora', CAST(N'2022-01-12T12:53:04.317' AS DateTime), 1)
INSERT [dbo].[Users] ([UserId], [UserName], [EmailAddress], [PasswordHash], [MobileNo], [Otp], [OtpCreatedAt], [CreatedBy], [CreatedAt], [UpdatedBy], [UpdatedAt], [IsPublished]) VALUES (4, N'dhruvidd', N'dhruvdd@gmail.com', N'AQAAAAEAACcQAAAAEMI1AC50K26cCcgGlEbxuwpccm/rvgKJtO+haTQKoRqO9S4yunnRBCSIAF18X1AYfQ==', N'9157049681', 2210, CAST(N'2022-01-26T14:19:12.147' AS DateTime), N'dhruvidd', CAST(N'2022-01-26T14:19:12.147' AS DateTime), N'dhruvidd', CAST(N'2022-01-26T14:19:12.147' AS DateTime), 1)
INSERT [dbo].[Users] ([UserId], [UserName], [EmailAddress], [PasswordHash], [MobileNo], [Otp], [OtpCreatedAt], [CreatedBy], [CreatedAt], [UpdatedBy], [UpdatedAt], [IsPublished]) VALUES (5, N'dhruvittt', N'dhruvit_d@yahoo.in', N'AQAAAAEAACcQAAAAED7Y4H7ieoi+GhzH8cGxF1QP68pVz+5UjlDqJZ5glRCNSY/2kB8Cmmd3AQyfKNetQg==', N'9898956231', 5948, CAST(N'2022-02-01T17:59:13.080' AS DateTime), N'dhruvittt', CAST(N'2022-02-01T17:59:13.080' AS DateTime), N'dhruvittt', CAST(N'2022-02-01T17:59:13.080' AS DateTime), 1)
SET IDENTITY_INSERT [dbo].[Users] OFF
GO
SET IDENTITY_INSERT [dbo].[Volunteer] ON 

INSERT [dbo].[Volunteer] ([VolunteerId], [VolunteerUserId], [OrganisationId], [CreatedBy], [CreatedAt], [UpdatedBy], [UpdatedAt], [IsPublished]) VALUES (1, 3, 3, N'dhruvitdiyora', CAST(N'2022-02-04T18:18:10.360' AS DateTime), N'dhruvitdiyora', CAST(N'2022-02-04T18:18:10.363' AS DateTime), 1)
INSERT [dbo].[Volunteer] ([VolunteerId], [VolunteerUserId], [OrganisationId], [CreatedBy], [CreatedAt], [UpdatedBy], [UpdatedAt], [IsPublished]) VALUES (2, 3, 2, N'dhruvitdiyora', CAST(N'2022-02-05T10:37:33.540' AS DateTime), N'dhruvitdiyora', CAST(N'2022-02-05T10:37:33.543' AS DateTime), 1)
SET IDENTITY_INSERT [dbo].[Volunteer] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Admins__49A14740206B7782]    Script Date: 09-02-2022 12:58:29 ******/
ALTER TABLE [dbo].[Admins] ADD UNIQUE NONCLUSTERED 
(
	[EmailAddress] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Admins__C9F28456282E2EE0]    Script Date: 09-02-2022 12:58:29 ******/
ALTER TABLE [dbo].[Admins] ADD UNIQUE NONCLUSTERED 
(
	[UserName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Admins__D60E46A22F2E5C24]    Script Date: 09-02-2022 12:58:29 ******/
ALTER TABLE [dbo].[Admins] ADD UNIQUE NONCLUSTERED 
(
	[PasswordHash] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [UK_CharityEventOrganiserEventNOrganiser]    Script Date: 09-02-2022 12:58:29 ******/
ALTER TABLE [dbo].[CharityEventOrganiser] ADD  CONSTRAINT [UK_CharityEventOrganiserEventNOrganiser] UNIQUE NONCLUSTERED 
(
	[EventOrganiserId] ASC,
	[EventId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [UK_CharityEventPostUser]    Script Date: 09-02-2022 12:58:29 ******/
ALTER TABLE [dbo].[CharityEventPostLike] ADD  CONSTRAINT [UK_CharityEventPostUser] UNIQUE NONCLUSTERED 
(
	[CharityEventPostId] ASC,
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Organisa__49A14740C4D2F9BB]    Script Date: 09-02-2022 12:58:29 ******/
ALTER TABLE [dbo].[Organisations] ADD UNIQUE NONCLUSTERED 
(
	[EmailAddress] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Organisa__C9F28456E52D0856]    Script Date: 09-02-2022 12:58:29 ******/
ALTER TABLE [dbo].[Organisations] ADD UNIQUE NONCLUSTERED 
(
	[UserName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [UK_SpamUser]    Script Date: 09-02-2022 12:58:29 ******/
ALTER TABLE [dbo].[Spam] ADD  CONSTRAINT [UK_SpamUser] UNIQUE NONCLUSTERED 
(
	[PostId] ASC,
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__States__55476315CDBD4598]    Script Date: 09-02-2022 12:58:29 ******/
ALTER TABLE [dbo].[States] ADD UNIQUE NONCLUSTERED 
(
	[StateName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [UK_UrgencyUser]    Script Date: 09-02-2022 12:58:29 ******/
ALTER TABLE [dbo].[Urgency] ADD  CONSTRAINT [UK_UrgencyUser] UNIQUE NONCLUSTERED 
(
	[PostId] ASC,
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__UserData__49A14740F88D0067]    Script Date: 09-02-2022 12:58:29 ******/
ALTER TABLE [dbo].[UserData] ADD UNIQUE NONCLUSTERED 
(
	[EmailAddress] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [UQ__UserData__64B85EBE23E514B0]    Script Date: 09-02-2022 12:58:29 ******/
ALTER TABLE [dbo].[UserData] ADD UNIQUE NONCLUSTERED 
(
	[Users] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__UserData__C9F284561982CD6B]    Script Date: 09-02-2022 12:58:29 ******/
ALTER TABLE [dbo].[UserData] ADD UNIQUE NONCLUSTERED 
(
	[UserName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Users__49A147404A362641]    Script Date: 09-02-2022 12:58:29 ******/
ALTER TABLE [dbo].[Users] ADD UNIQUE NONCLUSTERED 
(
	[EmailAddress] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Users__C9F284561749D411]    Script Date: 09-02-2022 12:58:29 ******/
ALTER TABLE [dbo].[Users] ADD UNIQUE NONCLUSTERED 
(
	[UserName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Users__D60E46A26BBED651]    Script Date: 09-02-2022 12:58:29 ******/
ALTER TABLE [dbo].[Users] ADD UNIQUE NONCLUSTERED 
(
	[PasswordHash] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
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
/****** Object:  StoredProcedure [dbo].[addCity]    Script Date: 09-02-2022 12:58:29 ******/
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
/****** Object:  StoredProcedure [dbo].[addState]    Script Date: 09-02-2022 12:58:29 ******/
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
/****** Object:  StoredProcedure [dbo].[getAllCharityEventInteracts]    Script Date: 09-02-2022 12:58:29 ******/
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
/****** Object:  StoredProcedure [dbo].[getAllcities]    Script Date: 09-02-2022 12:58:29 ******/
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
/****** Object:  StoredProcedure [dbo].[getAllClusterLocations]    Script Date: 09-02-2022 12:58:29 ******/
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
/****** Object:  StoredProcedure [dbo].[getAllOrganisationDatas]    Script Date: 09-02-2022 12:58:29 ******/
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
/****** Object:  StoredProcedure [dbo].[getAllPincode]    Script Date: 09-02-2022 12:58:29 ******/
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
/****** Object:  StoredProcedure [dbo].[getAllPostLike]    Script Date: 09-02-2022 12:58:29 ******/
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
/****** Object:  StoredProcedure [dbo].[getAllPostLikeById]    Script Date: 09-02-2022 12:58:29 ******/
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
/****** Object:  StoredProcedure [dbo].[getAllPostLikeByUserId]    Script Date: 09-02-2022 12:58:29 ******/
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
/****** Object:  StoredProcedure [dbo].[getAllSpam]    Script Date: 09-02-2022 12:58:29 ******/
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
/****** Object:  StoredProcedure [dbo].[getAllState]    Script Date: 09-02-2022 12:58:29 ******/
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
/****** Object:  StoredProcedure [dbo].[getallUnVerifiedPost]    Script Date: 09-02-2022 12:58:29 ******/
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
/****** Object:  StoredProcedure [dbo].[getAllUrgency]    Script Date: 09-02-2022 12:58:29 ******/
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
/****** Object:  StoredProcedure [dbo].[getAllUserData]    Script Date: 09-02-2022 12:58:29 ******/
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
/****** Object:  StoredProcedure [dbo].[getallVerifiedPost]    Script Date: 09-02-2022 12:58:29 ******/
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
/****** Object:  StoredProcedure [dbo].[getAllVolunteers]    Script Date: 09-02-2022 12:58:29 ******/
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
/****** Object:  StoredProcedure [dbo].[getCityByCityId]    Script Date: 09-02-2022 12:58:29 ******/
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
/****** Object:  StoredProcedure [dbo].[getCityByCityName]    Script Date: 09-02-2022 12:58:29 ******/
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
/****** Object:  StoredProcedure [dbo].[getCityByStateId]    Script Date: 09-02-2022 12:58:29 ******/
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
/****** Object:  StoredProcedure [dbo].[getClusterLocationByLocationId]    Script Date: 09-02-2022 12:58:29 ******/
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
/****** Object:  StoredProcedure [dbo].[getNumberOfDisLike]    Script Date: 09-02-2022 12:58:29 ******/
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
/****** Object:  StoredProcedure [dbo].[getNumberOfLike]    Script Date: 09-02-2022 12:58:29 ******/
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
/****** Object:  StoredProcedure [dbo].[getPincodeByCityId]    Script Date: 09-02-2022 12:58:29 ******/
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
/****** Object:  StoredProcedure [dbo].[getPincodeByPincode]    Script Date: 09-02-2022 12:58:29 ******/
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
/****** Object:  StoredProcedure [dbo].[getPincodeByPincodeId]    Script Date: 09-02-2022 12:58:29 ******/
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
/****** Object:  StoredProcedure [dbo].[getPincodeByPostOfficeName]    Script Date: 09-02-2022 12:58:29 ******/
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
/****** Object:  StoredProcedure [dbo].[getPincodeByStateId]    Script Date: 09-02-2022 12:58:29 ******/
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
/****** Object:  StoredProcedure [dbo].[getSpamByPostId]    Script Date: 09-02-2022 12:58:29 ******/
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
/****** Object:  StoredProcedure [dbo].[getSpamBySpamId]    Script Date: 09-02-2022 12:58:29 ******/
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
/****** Object:  StoredProcedure [dbo].[getSpamByUserId]    Script Date: 09-02-2022 12:58:29 ******/
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
/****** Object:  StoredProcedure [dbo].[getStateByStateId]    Script Date: 09-02-2022 12:58:29 ******/
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
/****** Object:  StoredProcedure [dbo].[getStateByStateName]    Script Date: 09-02-2022 12:58:29 ******/
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
/****** Object:  StoredProcedure [dbo].[getUrgencyByPostID]    Script Date: 09-02-2022 12:58:29 ******/
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
/****** Object:  StoredProcedure [dbo].[getUrgencyByUrgencyId]    Script Date: 09-02-2022 12:58:29 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_getPosts]    Script Date: 09-02-2022 12:58:29 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_getPostUser]    Script Date: 09-02-2022 12:58:29 ******/
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
