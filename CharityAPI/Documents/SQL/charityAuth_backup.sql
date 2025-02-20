USE [master]
GO
/****** Object:  Database [CharityAuth]    Script Date: 09-02-2022 12:58:28 ******/
CREATE DATABASE [CharityAuth]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'CharityAuth', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\CharityAuth.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'CharityAuth_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\CharityAuth_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [CharityAuth] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [CharityAuth].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [CharityAuth] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [CharityAuth] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [CharityAuth] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [CharityAuth] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [CharityAuth] SET ARITHABORT OFF 
GO
ALTER DATABASE [CharityAuth] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [CharityAuth] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [CharityAuth] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [CharityAuth] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [CharityAuth] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [CharityAuth] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [CharityAuth] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [CharityAuth] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [CharityAuth] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [CharityAuth] SET  DISABLE_BROKER 
GO
ALTER DATABASE [CharityAuth] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [CharityAuth] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [CharityAuth] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [CharityAuth] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [CharityAuth] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [CharityAuth] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [CharityAuth] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [CharityAuth] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [CharityAuth] SET  MULTI_USER 
GO
ALTER DATABASE [CharityAuth] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [CharityAuth] SET DB_CHAINING OFF 
GO
ALTER DATABASE [CharityAuth] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [CharityAuth] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [CharityAuth] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [CharityAuth] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [CharityAuth] SET QUERY_STORE = OFF
GO
USE [CharityAuth]
GO
/****** Object:  User [saa]    Script Date: 09-02-2022 12:58:28 ******/
CREATE USER [saa] FOR LOGIN [saa] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [dd]    Script Date: 09-02-2022 12:58:28 ******/
CREATE USER [dd] FOR LOGIN [dd] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  Table [dbo].[__EFMigrationsHistory]    Script Date: 09-02-2022 12:58:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[__EFMigrationsHistory](
	[MigrationId] [nvarchar](150) NOT NULL,
	[ProductVersion] [nvarchar](32) NOT NULL,
 CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY CLUSTERED 
(
	[MigrationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetRoleClaims]    Script Date: 09-02-2022 12:58:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetRoleClaims](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[RoleId] [nvarchar](450) NOT NULL,
	[ClaimType] [nvarchar](max) NULL,
	[ClaimValue] [nvarchar](max) NULL,
 CONSTRAINT [PK_AspNetRoleClaims] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetRoles]    Script Date: 09-02-2022 12:58:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetRoles](
	[Id] [nvarchar](450) NOT NULL,
	[Name] [nvarchar](256) NULL,
	[NormalizedName] [nvarchar](256) NULL,
	[ConcurrencyStamp] [nvarchar](max) NULL,
 CONSTRAINT [PK_AspNetRoles] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetUserClaims]    Script Date: 09-02-2022 12:58:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserClaims](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [nvarchar](450) NOT NULL,
	[ClaimType] [nvarchar](max) NULL,
	[ClaimValue] [nvarchar](max) NULL,
 CONSTRAINT [PK_AspNetUserClaims] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetUserLogins]    Script Date: 09-02-2022 12:58:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserLogins](
	[LoginProvider] [nvarchar](450) NOT NULL,
	[ProviderKey] [nvarchar](450) NOT NULL,
	[ProviderDisplayName] [nvarchar](max) NULL,
	[UserId] [nvarchar](450) NOT NULL,
 CONSTRAINT [PK_AspNetUserLogins] PRIMARY KEY CLUSTERED 
(
	[LoginProvider] ASC,
	[ProviderKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetUserRoles]    Script Date: 09-02-2022 12:58:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserRoles](
	[UserId] [nvarchar](450) NOT NULL,
	[RoleId] [nvarchar](450) NOT NULL,
 CONSTRAINT [PK_AspNetUserRoles] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC,
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetUsers]    Script Date: 09-02-2022 12:58:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUsers](
	[Id] [nvarchar](450) NOT NULL,
	[UserName] [nvarchar](256) NULL,
	[NormalizedUserName] [nvarchar](256) NULL,
	[Email] [nvarchar](256) NULL,
	[NormalizedEmail] [nvarchar](256) NULL,
	[EmailConfirmed] [bit] NOT NULL,
	[PasswordHash] [nvarchar](max) NULL,
	[SecurityStamp] [nvarchar](max) NULL,
	[ConcurrencyStamp] [nvarchar](max) NULL,
	[PhoneNumber] [nvarchar](max) NULL,
	[PhoneNumberConfirmed] [bit] NOT NULL,
	[TwoFactorEnabled] [bit] NOT NULL,
	[LockoutEnd] [datetimeoffset](7) NULL,
	[LockoutEnabled] [bit] NOT NULL,
	[AccessFailedCount] [int] NOT NULL,
 CONSTRAINT [PK_AspNetUsers] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetUserTokens]    Script Date: 09-02-2022 12:58:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserTokens](
	[UserId] [nvarchar](450) NOT NULL,
	[LoginProvider] [nvarchar](450) NOT NULL,
	[Name] [nvarchar](450) NOT NULL,
	[Value] [nvarchar](max) NULL,
 CONSTRAINT [PK_AspNetUserTokens] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC,
	[LoginProvider] ASC,
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20211213053023_AUthentication', N'3.1.21')
GO
INSERT [dbo].[AspNetRoles] ([Id], [Name], [NormalizedName], [ConcurrencyStamp]) VALUES (N'0d3e0d7d-c1ac-474a-bbf8-bbb6d000a567', N'Admin', N'ADMIN', N'9a1ed062-9e4c-46c7-9c22-2fce843a4b13')
INSERT [dbo].[AspNetRoles] ([Id], [Name], [NormalizedName], [ConcurrencyStamp]) VALUES (N'22c49ba6-4a4c-4c85-888e-9d2b27f0c556', N'User', N'USER', N'4deb5348-55ba-49fb-8c43-c1060db5d84f')
INSERT [dbo].[AspNetRoles] ([Id], [Name], [NormalizedName], [ConcurrencyStamp]) VALUES (N'b61a39e3-ac35-484a-8d3d-20dd6ff21673', N'Organisation', N'ORGANISATION', N'cfe5f51b-6cdf-4645-8056-93d5ba45d947')
GO
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'36c97864-e702-43fb-9d4f-bd7adfea7950', N'0d3e0d7d-c1ac-474a-bbf8-bbb6d000a567')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'90a77ab4-fc5d-416d-a861-53bbe29abd9c', N'0d3e0d7d-c1ac-474a-bbf8-bbb6d000a567')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'bcb48945-0141-4bf9-a83f-d3e2a351ef19', N'0d3e0d7d-c1ac-474a-bbf8-bbb6d000a567')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'3a61ff46-81b0-426a-b6d9-3aeedf77f9f4', N'22c49ba6-4a4c-4c85-888e-9d2b27f0c556')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'3fec7ad7-da09-4525-b69c-19eef8528ab7', N'22c49ba6-4a4c-4c85-888e-9d2b27f0c556')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'6aff1d74-91b9-4a54-9b57-c5a0ada13a52', N'22c49ba6-4a4c-4c85-888e-9d2b27f0c556')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'736588d8-a0ab-4724-ba6b-760d4ece2e07', N'22c49ba6-4a4c-4c85-888e-9d2b27f0c556')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'92210aae-cc87-44a3-a078-be457c5b4091', N'22c49ba6-4a4c-4c85-888e-9d2b27f0c556')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'e8d2d200-9512-4bbd-8002-273e082e07db', N'22c49ba6-4a4c-4c85-888e-9d2b27f0c556')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'5f2981d3-b5b5-4d1f-a631-1d000d5dd793', N'b61a39e3-ac35-484a-8d3d-20dd6ff21673')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'9875e6bb-dc7e-4c8e-be98-d35cb7c00925', N'b61a39e3-ac35-484a-8d3d-20dd6ff21673')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'9f7ab803-ded2-45bd-a0e3-3ee6181abbca', N'b61a39e3-ac35-484a-8d3d-20dd6ff21673')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'e6d0e525-8d4b-419d-bcff-d86d69580788', N'b61a39e3-ac35-484a-8d3d-20dd6ff21673')
GO
INSERT [dbo].[AspNetUsers] ([Id], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'36c97864-e702-43fb-9d4f-bd7adfea7950', N'dhruviddd', N'DHRUVIDDD', N'dhruvddd@gmail.com', N'DHRUVDDD@GMAIL.COM', 1, N'AQAAAAEAACcQAAAAEKtcq/69mPI+IwwomzzQugYLBby7HXjbWASYJpemZ0OedxGIYjrZIVO9wtGwNTQUEw==', N'AELGCRT4QSQTJAYZA3MNYCALTSU7WMFS', N'2f9b145b-12bb-4075-8ebe-95903d671aea', N'9157041681', 0, 0, NULL, 1, 0)
INSERT [dbo].[AspNetUsers] ([Id], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'3a61ff46-81b0-426a-b6d9-3aeedf77f9f4', N'dhruvitdiyora', N'DHRUVITDIYORA', N'dhruvit.d9688@gmail.com', N'DHRUVIT.D9688@GMAIL.COM', 1, N'AQAAAAEAACcQAAAAEOHiu3BxKwGNI+XWkBFHwNi1EV7wn6YWaLrFKwm+9y2qMdrew0M9hlha2k08RWg+Rg==', N'JDQA7V45EJYHOC5ZAP6DSFZ4RJYTOVVP', N'0f343d73-f611-4b7e-abc5-eefcbdb75bc4', N'9155667788', 0, 0, NULL, 1, 0)
INSERT [dbo].[AspNetUsers] ([Id], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'3fec7ad7-da09-4525-b69c-19eef8528ab7', N'dhruvi', N'DHRUVI', N'dhruv1@gmail.com', N'DHRUV1@GMAIL.COM', 1, N'AQAAAAEAACcQAAAAEAsW9RTmlLqpv3B02cQbvHKYLrx9vmvI1AzqH9hn7OmV+EoD3AlVCGKPHfdIJ0r18g==', N'6IJ5XYQ2AFY5UMSMOYZODRCPTNMHD5G2', N'6d6a52d8-322a-4148-a060-18b7007cf4bb', N'9157049687', 0, 0, NULL, 1, 0)
INSERT [dbo].[AspNetUsers] ([Id], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'5f2981d3-b5b5-4d1f-a631-1d000d5dd793', N'pshubh333', N'PSHUBH333', N'pshubh333@gmail.com', N'PSHUBH333@GMAIL.COM', 1, N'AQAAAAEAACcQAAAAEClkjWpZjnN1QQLaFQVkaL/O5JpTm9A5sY5KCoqE7o/ephUsTxPBtzIyQmWjlCTVfw==', N'AUN3OBBSHLQGOTGBFV5XZUVY6LL6EPL7', N'895e8a7d-cba6-41e0-875f-6204bf60778e', N'8520963874', 0, 0, NULL, 1, 0)
INSERT [dbo].[AspNetUsers] ([Id], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'6aff1d74-91b9-4a54-9b57-c5a0ada13a52', N'dhruvittt', N'DHRUVITTT', N'dhruvit_d@yahoo.in', N'DHRUVIT_D@YAHOO.IN', 1, N'AQAAAAEAACcQAAAAED7Y4H7ieoi+GhzH8cGxF1QP68pVz+5UjlDqJZ5glRCNSY/2kB8Cmmd3AQyfKNetQg==', N'4VJGF5JWD7T223JE5RRW472EAZTOVY23', N'0c7efcf7-c12b-4ec8-af32-3221f8d075f9', N'9898956231', 0, 0, NULL, 1, 0)
INSERT [dbo].[AspNetUsers] ([Id], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'736588d8-a0ab-4724-ba6b-760d4ece2e07', N'dhruv', N'DHRUV', N'dhruvi@gmail.com', N'DHRUVI@GMAIL.COM', 1, N'AQAAAAEAACcQAAAAEGXfCarynh/jG7ix9Qp+06coh5OASBb+t+d/ProSpzZvzYP57yjfu+R5WYNKp83n1w==', N'EXRPVADT6FJ2HSD6CU7ZAYKZWBIPPSIW', N'84d5c6d1-d4fd-4876-b49a-224c4f884691', N'9157049688', 0, 0, NULL, 1, 0)
INSERT [dbo].[AspNetUsers] ([Id], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'90a77ab4-fc5d-416d-a861-53bbe29abd9c', N'dhruvitddd', N'DHRUVITDDD', N'dhruvit.ddd@gmail.com', N'DHRUVIT.DDD@GMAIL.COM', 0, N'AQAAAAEAACcQAAAAEFRUJAQw99bqBhrszSVPu3+41E2Ho/s93w3sMqjDM4QttV3YDSJNhaGcFbNyDoLoXw==', N'W4DJZHPCE2E54SFZUHO6WZTOGWAKT33B', N'd0264662-a174-4698-8c52-0913436dc1e2', N'9913219143', 0, 0, NULL, 1, 0)
INSERT [dbo].[AspNetUsers] ([Id], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'92210aae-cc87-44a3-a078-be457c5b4091', N'dhruvit', N'DHRUVIT', N'dhruvit@gmail.com', N'DHRUVIT@GMAIL.COM', 1, N'AQAAAAEAACcQAAAAEMFqEyqpr9CTfxo+lXde8mhMIf6mHOi9UHJiw4JDi0FigFs73ScZHQigZaK09vWNaQ==', N'3EZIF3GBYK65FINGUFOWB3CW63VKWLNG', N'c40a6ada-6f9a-462f-9c9e-3c7b412915f5', N'9157049689', 0, 0, NULL, 1, 0)
INSERT [dbo].[AspNetUsers] ([Id], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'9875e6bb-dc7e-4c8e-be98-d35cb7c00925', N'dhruvi123', N'DHRUVI123', N'dhruv12@gmail.com', N'DHRUV12@GMAIL.COM', 1, N'AQAAAAEAACcQAAAAELugnlrtd6Ak8hKnWo3wKjSHl88CmMfBkZCGu2nPzT6eL0imia/es/xZR1gKRJT2Xg==', N'LYXEALN7GVEH437GXZE6XFY6DNWB7CYH', N'c62728ed-6425-49bc-aa6b-3da353c4f437', N'9157049682', 0, 0, NULL, 1, 0)
INSERT [dbo].[AspNetUsers] ([Id], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'9f7ab803-ded2-45bd-a0e3-3ee6181abbca', N'dhruvi1234', N'DHRUVI1234', N'dhruv12345@gmail.com', N'DHRUV12345@GMAIL.COM', 1, N'AQAAAAEAACcQAAAAEOQSIIIknUNt/tVk4xHLJ2OZTI/BTXI2s3t50AZ4GuQMAJQ0q+DKOkzaFbfI8ZxXeg==', N'BILRSL4EE64ZAQDBVSNBLADQYNLTVCRA', N'79d35644-fe48-43a0-ad65-7868113d3080', N'9157849887', 0, 0, NULL, 1, 0)
INSERT [dbo].[AspNetUsers] ([Id], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'bcb48945-0141-4bf9-a83f-d3e2a351ef19', N'dhruvitdd', N'DHRUVITDD', N'dhruvit.dd@gmail.com', N'DHRUVIT.DD@GMAIL.COM', 0, N'AQAAAAEAACcQAAAAEOTacjFhkz29L2KBiPDrJJLv81+qqVfXPYPNuMypkuH8+RwYkpPas+j3im2KKYFCwA==', N'2W3DGZ5LPSBJ6SQH3F267K6MCG4CDTEV', N'c2f98b8d-2137-409a-b7bd-cc7e0c292979', N'9157066688', 0, 0, NULL, 1, 0)
INSERT [dbo].[AspNetUsers] ([Id], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'e6d0e525-8d4b-419d-bcff-d86d69580788', N'dhruvi12', N'DHRUVI12', N'dhruv123@gmail.com', N'DHRUV123@GMAIL.COM', 1, N'AQAAAAEAACcQAAAAEOOmOVz6ruNTLrJoiUZs5fc7NQRZs5C1i1fZosqUvMabqPmeFYeNfTjKWw3P8spGOw==', N'NHRVCLFZS7P2UAHKS3RD6UXQGSWALIT6', N'c32c2588-54e2-4b14-b315-2059b0507ebb', N'9157049887', 0, 0, NULL, 1, 0)
INSERT [dbo].[AspNetUsers] ([Id], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'e8d2d200-9512-4bbd-8002-273e082e07db', N'dhruvidd', N'DHRUVIDD', N'dhruvdd@gmail.com', N'DHRUVDD@GMAIL.COM', 1, N'AQAAAAEAACcQAAAAEMI1AC50K26cCcgGlEbxuwpccm/rvgKJtO+haTQKoRqO9S4yunnRBCSIAF18X1AYfQ==', N'3QIXUN5HCM7Q4KY67KP34TI2GUM4GC6G', N'f574b8f6-7057-4119-a523-744c29398d43', N'9157049681', 0, 0, NULL, 1, 0)
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_AspNetRoleClaims_RoleId]    Script Date: 09-02-2022 12:58:29 ******/
CREATE NONCLUSTERED INDEX [IX_AspNetRoleClaims_RoleId] ON [dbo].[AspNetRoleClaims]
(
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [RoleNameIndex]    Script Date: 09-02-2022 12:58:29 ******/
CREATE UNIQUE NONCLUSTERED INDEX [RoleNameIndex] ON [dbo].[AspNetRoles]
(
	[NormalizedName] ASC
)
WHERE ([NormalizedName] IS NOT NULL)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_AspNetUserClaims_UserId]    Script Date: 09-02-2022 12:58:29 ******/
CREATE NONCLUSTERED INDEX [IX_AspNetUserClaims_UserId] ON [dbo].[AspNetUserClaims]
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_AspNetUserLogins_UserId]    Script Date: 09-02-2022 12:58:29 ******/
CREATE NONCLUSTERED INDEX [IX_AspNetUserLogins_UserId] ON [dbo].[AspNetUserLogins]
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_AspNetUserRoles_RoleId]    Script Date: 09-02-2022 12:58:29 ******/
CREATE NONCLUSTERED INDEX [IX_AspNetUserRoles_RoleId] ON [dbo].[AspNetUserRoles]
(
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [EmailIndex]    Script Date: 09-02-2022 12:58:29 ******/
CREATE NONCLUSTERED INDEX [EmailIndex] ON [dbo].[AspNetUsers]
(
	[NormalizedEmail] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UserNameIndex]    Script Date: 09-02-2022 12:58:29 ******/
CREATE UNIQUE NONCLUSTERED INDEX [UserNameIndex] ON [dbo].[AspNetUsers]
(
	[NormalizedUserName] ASC
)
WHERE ([NormalizedUserName] IS NOT NULL)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[AspNetRoleClaims]  WITH CHECK ADD  CONSTRAINT [FK_AspNetRoleClaims_AspNetRoles_RoleId] FOREIGN KEY([RoleId])
REFERENCES [dbo].[AspNetRoles] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetRoleClaims] CHECK CONSTRAINT [FK_AspNetRoleClaims_AspNetRoles_RoleId]
GO
ALTER TABLE [dbo].[AspNetUserClaims]  WITH CHECK ADD  CONSTRAINT [FK_AspNetUserClaims_AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserClaims] CHECK CONSTRAINT [FK_AspNetUserClaims_AspNetUsers_UserId]
GO
ALTER TABLE [dbo].[AspNetUserLogins]  WITH CHECK ADD  CONSTRAINT [FK_AspNetUserLogins_AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserLogins] CHECK CONSTRAINT [FK_AspNetUserLogins_AspNetUsers_UserId]
GO
ALTER TABLE [dbo].[AspNetUserRoles]  WITH CHECK ADD  CONSTRAINT [FK_AspNetUserRoles_AspNetRoles_RoleId] FOREIGN KEY([RoleId])
REFERENCES [dbo].[AspNetRoles] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserRoles] CHECK CONSTRAINT [FK_AspNetUserRoles_AspNetRoles_RoleId]
GO
ALTER TABLE [dbo].[AspNetUserRoles]  WITH CHECK ADD  CONSTRAINT [FK_AspNetUserRoles_AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserRoles] CHECK CONSTRAINT [FK_AspNetUserRoles_AspNetUsers_UserId]
GO
ALTER TABLE [dbo].[AspNetUserTokens]  WITH CHECK ADD  CONSTRAINT [FK_AspNetUserTokens_AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserTokens] CHECK CONSTRAINT [FK_AspNetUserTokens_AspNetUsers_UserId]
GO
USE [master]
GO
ALTER DATABASE [CharityAuth] SET  READ_WRITE 
GO
