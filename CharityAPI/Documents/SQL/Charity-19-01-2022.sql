CREATE TABLE States (
	StateId BIGINT IDENTITY(1,1) CONSTRAINT PK_States PRIMARY KEY,
	StateName NVARCHAR(50) NOT NULL UNIQUE,
	CreatedBy NVARCHAR(50) NOT NULL, 
	CreatedAt DATETIME NOT NULL, 
	UpdatedBy NVARCHAR(50) NOT NULL, 
	UpdatedAt DATETIME NOT NULL,
	IsPublished BIT NOT NULL DEFAULT 1,
	)


	CREATE TABLE Cities (
	CityId BIGINT IDENTITY(1,1) CONSTRAINT PK_Cities PRIMARY KEY,
	StateId BIGINT NOT NULL,
	CityName NVARCHAR(50) NOT NULL,
	CreatedBy NVARCHAR(50) NOT NULL, 
	CreatedAt DATETIME NOT NULL, 
	UpdatedBy NVARCHAR(50) NOT NULL, 
	UpdatedAt DATETIME NOT NULL,
	IsPublished BIT NOT NULL DEFAULT 1,
	)

ALTER TABLE Cities WITH CHECK ADD CONSTRAINT FK_Cities FOREIGN KEY(StateId) REFERENCES States(StateId)


CREATE TABLE Pincode(
	PincodeId BIGINT IDENTITY(1,1) CONSTRAINT PK_PC PRIMARY KEY,
	PostOfficeName VARCHAR(100),
	Pincode BIGINT NOT NULL,
	CityId BIGINT NOT NULL,
	District VARCHAR(100),
	StateId BIGINT NOT NULL,
	CreatedBy NVARCHAR(50) NOT NULL, 
	CreatedAt DATETIME NOT NULL, 
	UpdatedBy NVARCHAR(50) NOT NULL, 
	UpdatedAt DATETIME NOT NULL,
	IsPublished BIT NOT NULL DEFAULT 1,
	) 
ALTER TABLE Pincode WITH CHECK ADD CONSTRAINT FK_PincodeCity FOREIGN KEY(CityId) REFERENCES Cities(CityId)
ALTER TABLE Pincode WITH CHECK ADD CONSTRAINT FK_PincodeState FOREIGN KEY(StateId) REFERENCES States(StateId)

--CREATE TABLE Module (
--    ModuleId BIGINT IDENTITY(1,1) CONSTRAINT PK_Module PRIMARY KEY,
--    ModuleName NVARCHAR(30) NOT NULL,
--    ModuleType NVARCHAR(20) NOT NULL,
--    IsVerified BIT NOT NULL DEFAULT 1,
--    CreatedBy NVARCHAR(50) NOT NULL, 
--	CreatedAt DATETIME NOT NULL, 
--	UpdatedBy NVARCHAR(50) NOT NULL, 
--	UpdatedAt DATETIME NOT NULL,
--	IsPublished BIT NOT NULL DEFAULT 1,
--    )
--	CREATE TABLE RoleType (
--	RoleTypeId BIGINT IDENTITY(1,1) CONSTRAINT PK_RoleType PRIMARY KEY,
--	RoleType NVARCHAR(30) NOT NULL,
--	CreatedBy NVARCHAR(50) NOT NULL, 
--	CreatedAt DATETIME NOT NULL, 
--	UpdatedBy NVARCHAR(50) NOT NULL, 
--	UpdatedAt DATETIME NOT NULL,
--	IsPublished BIT NOT NULL DEFAULT 1,
--	)
CREATE TABLE RequirementType (
    RequirementTypeId BIGINT IDENTITY(1,1) CONSTRAINT PK_RequirementType PRIMARY KEY,
    RequirementTypeName NVARCHAR(50) NOT NULL,
	CreatedBy NVARCHAR(50) NOT NULL, 
	CreatedAt DATETIME NOT NULL, 
	UpdatedBy NVARCHAR(50) NOT NULL, 
	UpdatedAt DATETIME NOT NULL,
	IsPublished BIT NOT NULL DEFAULT 1,
   ) 

CREATE TABLE Admins(
	AdminId BIGINT IDENTITY(1,1) CONSTRAINT PK_Admins PRIMARY KEY,
	UserName NVARCHAR(50) NOT NULL UNIQUE,
	EmailAddress NVARCHAR(50) NOT NULL UNIQUE,
	PasswordHash NVARCHAR(100) NOT NULL UNIQUE,
	MobileNo NVARCHAR(50) NOT NULL,
	CreatedBy NVARCHAR(50) NOT NULL, 
	CreatedAt DATETIME NOT NULL, 
	UpdatedBy NVARCHAR(50) NOT NULL, 
	UpdatedAt DATETIME NOT NULL,
	IsPublished BIT NOT NULL DEFAULT 1
	)

CREATE TABLE Users(
	UserId BIGINT IDENTITY(1,1) CONSTRAINT PK_Users PRIMARY KEY,
	UserName NVARCHAR(50) NOT NULL UNIQUE,
	EmailAddress NVARCHAR(50) NOT NULL UNIQUE,
	PasswordHash NVARCHAR(100) NOT NULL UNIQUE,
	MobileNo NVARCHAR(50) NOT NULL,
	Otp BIGINT,
	OtpCreatedAt DATETIME, 
	CreatedBy NVARCHAR(50) NOT NULL, 
	CreatedAt DATETIME NOT NULL, 
	UpdatedBy NVARCHAR(50) NOT NULL, 
	UpdatedAt DATETIME NOT NULL,
	IsPublished BIT NOT NULL DEFAULT 1
	)

CREATE TABLE UserData (
	UserId BIGINT IDENTITY(1,1) PRIMARY KEY,
	FirstName NVARCHAR(50) NOT NULL,
	LastName NVARCHAR(50) NOT NULL,
	Gender NVARCHAR(10) NOT NULL,
	ProfileImage NVARCHAR(MAX) NULL,
	UserDescription NVARCHAR(500) NULL,
	UserName NVARCHAR(50) NOT NULL UNIQUE,
	EmailAddress NVARCHAR(50) NOT NULL UNIQUE,
	MobileNo NVARCHAR(50) NOT NULL ,
	TotalPostCount BIGINT NOT NULL,
	CreatedBy NVARCHAR(50) NOT NULL, 
	CreatedAt DATETIME NOT NULL, 
	UpdatedBy NVARCHAR(50) NOT NULL, 
	UpdatedAt DATETIME NOT NULL,
	IsPublished BIT NOT NULL DEFAULT 1,
	Users BIGINT NOT NULL UNIQUE,
	CityId BIGINT NOT NULL,
	StateId BIGINT NOT NULL,
	PincodeId BIGINT NOT NULL 
	)

ALTER TABLE UserData WITH CHECK ADD CONSTRAINT FK_UserCity FOREIGN KEY(CityId) REFERENCES Cities(CityId)
ALTER TABLE UserData WITH CHECK ADD CONSTRAINT FK_UserPin FOREIGN KEY(PincodeId) REFERENCES Pincode(PincodeId)
ALTER TABLE UserData WITH CHECK ADD CONSTRAINT FK_UserState FOREIGN KEY(StateId) REFERENCES States(StateId)
ALTER TABLE UserData WITH CHECK ADD CONSTRAINT FK_Users FOREIGN KEY(Users) REFERENCES Users(UserId)

CREATE TABLE Organisations(
	OrganisationId BIGINT IDENTITY(1,1) CONSTRAINT PK_Organisations PRIMARY KEY,
	UserName NVARCHAR(50) NOT NULL UNIQUE,
	EmailAddress NVARCHAR(50) NOT NULL UNIQUE,
	PasswordHash NVARCHAR(100) NOT NULL UNIQUE,
	MobileNo NVARCHAR(50) NOT NULL,
	Otp BIGINT,
	OtpCreatedAt DATETIME, 
	CreatedBy NVARCHAR(50) NOT NULL, 
	CreatedAt DATETIME NOT NULL, 
	UpdatedBy NVARCHAR(50) NOT NULL, 
	UpdatedAt DATETIME NOT NULL,
	IsPublished BIT NOT NULL DEFAULT 1
	)
CREATE TABLE OrganisationData (
    OrganisationDataId BIGINT IDENTITY(1,1) CONSTRAINT PK_OrganisationData PRIMARY KEY,
    OrganisationUserId BIGINT NOT NULL,
    OrganisationName NVARCHAR(50) NOT NULL,
    OrganisationAddress NVARCHAR(MAX) NOT NULL,
    OrganisationContactNo NVARCHAR(50),
    OrganisationLogoURL NVARCHAR(MAX) NOT NULL,
    IsVerified BIT NOT NULL DEFAULT 0,
    CreatedBy NVARCHAR(50) NOT NULL, 
	CreatedAt DATETIME NOT NULL, 
	UpdatedBy NVARCHAR(50) NOT NULL, 
	UpdatedAt DATETIME NOT NULL,
	IsPublished BIT NOT NULL DEFAULT 1,
    )

ALTER TABLE OrganisationData WITH CHECK ADD CONSTRAINT FK_OrgUser FOREIGN KEY(OrganisationUserId) REFERENCES Organisations(OrganisationId)
--19/01/2022
ALTER TABLE OrganisationData ADD OrganisationDetail NVARCHAR(MAX);
ALTER TABLE OrganisationData ADD OrganisatioWebURL NVARCHAR(MAX);
--24/01/2022
ALTER TABLE OrganisationData ADD OrganisationUserName NVARCHAR(50);
ALTER TABLE OrganisationData WITH CHECK ADD CONSTRAINT UK_OrgUserName UNIQUE(OrganisationUserName);

--CREATE TABLE Roles (
--	RolePermissionID BIGINT IDENTITY(1,1) CONSTRAINT PK_Roles PRIMARY KEY,
--	RoleTypeId BIGINT NOT NULL,
--	UserId BIGINT NOT NULL,
--	ModuleId BIGINT NOT NULL,
--	IsPermissionAdd BIT NOT NULL DEFAULT 0,
--	IsPermissionEdit BIT NOT NULL DEFAULT 0,
--	IsPermissionView BIT NOT NULL DEFAULT 0,
--	IsPermissionDelete BIT NOT NULL DEFAULT 0,
--	CreatedBy NVARCHAR(50) NOT NULL, 
--	CreatedAt DATETIME NOT NULL, 
--	UpdatedBy NVARCHAR(50) NOT NULL, 
--	UpdatedAt DATETIME NOT NULL,
--	IsPublished BIT NOT NULL DEFAULT 1,
--	)
--ALTER TABLE Roles WITH CHECK ADD CONSTRAINT FK_UserIdRole FOREIGN KEY(UserId) REFERENCES UserData(UserId)
--ALTER TABLE Roles WITH CHECK ADD CONSTRAINT FK_ModuleRole FOREIGN KEY(ModuleId) REFERENCES Module(ModuleId)
--ALTER TABLE Roles WITH CHECK ADD CONSTRAINT FK_RoleTypeID FOREIGN KEY(RoleTypeId) REFERENCES RoleType(RoleTypeId)

CREATE TABLE CharityEvent (
	EventId BIGINT IDENTITY(1,1) CONSTRAINT PK_CharityEvent PRIMARY KEY,
	EventName NVARCHAR(50) NOT NULL,
	EventDescription TEXT NOT NULL,
	EventOrganiserId BIGINT NOT NULL,
	EventStartDate DATETIME NOT NULL,
	EventBannerURL NVARCHAR(MAX) NOT NULL,
	EventEndDate DATETIME NOT NULL,
	IsVerified BIT NOT NULL DEFAULT 0,
	EventType NVARCHAR(50) NOT NULL,
	CreatedBy NVARCHAR(50) NOT NULL, 
	CreatedAt DATETIME NOT NULL, 
	UpdatedBy NVARCHAR(50) NOT NULL,
	PincodeId BIGINT NOT NULL,
	UpdatedAt DATETIME NOT NULL,
	IsPublished BIT NOT NULL DEFAULT 1,
	IsCompleted BIT NOT NULL DEFAULT 0
	)

ALTER TABLE CharityEvent WITH CHECK ADD CONSTRAINT FK_CharityOrganisationId FOREIGN KEY(EventOrganiserId) REFERENCES OrganisationData(OrganisationDataId)
ALTER TABLE CharityEvent WITH CHECK ADD CONSTRAINT FK_CharityEventPincodeId FOREIGN KEY(PincodeId) REFERENCES Pincode(PincodeId)

CREATE TABLE CharityEventPost(
	CharityEventPostId BIGINT IDENTITY(1,1) CONSTRAINT PK_CharityEventPost PRIMARY KEY,
	EventId BIGINT NOT NULL,
	UserId BIGINT NOT NULL,
	PostUrl NVARCHAR(MAX) NOT NULL,
	Content Text,
	CreatedBy NVARCHAR(50) NOT NULL, 
	CreatedAt DATETIME NOT NULL, 
	UpdatedBy NVARCHAR(50) NOT NULL,
	UpdatedAt DATETIME NOT NULL,
	IsPublished BIT NOT NULL DEFAULT 1,
)
ALTER TABLE CharityEventPost WITH CHECK ADD CONSTRAINT FK_CharityEventPostUser FOREIGN KEY(UserId) REFERENCES UserData(UserId)
ALTER TABLE CharityEventPost WITH CHECK ADD CONSTRAINT FK_CharityEventPostEvent FOREIGN KEY(EventId) REFERENCES CharityEvent(EventId)

CREATE TABLE CharityEventPostLike(
	CharityEventPostLikeId BIGINT IDENTITY(1,1) CONSTRAINT PK_CharityEventPostLike PRIMARY KEY,
	CharityEventPostId BIGINT NOT NULL,
	UserId BIGINT NOT NULL,
	Likes BIT NOT NULL DEFAULT 0,
	DisLike BIT NOT NULL DEFAULT 0,
	CreatedBy NVARCHAR(50) NOT NULL, 
	CreatedAt DATETIME NOT NULL, 
	UpdatedBy NVARCHAR(50) NOT NULL,
	UpdatedAt DATETIME NOT NULL,
)

ALTER TABLE CharityEventPostLike WITH CHECK ADD CONSTRAINT FK_CharityEventPost FOREIGN KEY(CharityEventPostId) REFERENCES CharityEventPost(CharityEventPostId)
ALTER TABLE CharityEventPostLike WITH CHECK ADD CONSTRAINT FK_CharityEventLikeByUser FOREIGN KEY(UserId) REFERENCES UserData(UserId)
ALTER TABLE CharityEventPostLike WITH CHECK ADD CONSTRAINT UK_CharityEventPostUser UNIQUE(CharityEventPostId,UserId)

CREATE TABLE CharityEventInteract(
	CharityEventInteractId BIGINT IDENTITY(1,1) CONSTRAINT PK_CharityEventInteract PRIMARY KEY,
	EventId BIGINT NOT NULL,
	UserId BIGINT NOT NULL,
	IsInterested BIT NOT NULL DEFAULT 0,
	IsGoing BIT NOT NULL DEFAULT 0,
	CreatedBy NVARCHAR(50) NOT NULL, 
	CreatedAt DATETIME NOT NULL, 
	UpdatedBy NVARCHAR(50) NOT NULL,
	UpdatedAt DATETIME NOT NULL,
	IsPublished BIT NOT NULL DEFAULT 1,
)

ALTER TABLE CharityEventInteract WITH CHECK ADD CONSTRAINT FK_CharityEventInteractEvent FOREIGN KEY(EventId) REFERENCES CharityEvent(EventId)
ALTER TABLE CharityEventInteract WITH CHECK ADD CONSTRAINT FK_CharityEventInteractUser FOREIGN KEY(UserId) REFERENCES UserData(UserId)


CREATE TABLE CharityEventOrganiser(
	CharityEventOrganiserId BIGINT IDENTITY(1,1) CONSTRAINT PK_CharityEventOrganiser PRIMARY KEY,
	EventOrganiserId BIGINT NOT NULL,
	EventId BIGINT NOT NULL,
	CreatedBy NVARCHAR(50) NOT NULL, 
	CreatedAt DATETIME NOT NULL, 
	UpdatedBy NVARCHAR(50) NOT NULL,
	UpdatedAt DATETIME NOT NULL,
	IsPublished BIT NOT NULL DEFAULT 1,
)
ALTER TABLE CharityEventOrganiser WITH CHECK ADD CONSTRAINT FK_CharityEventOrganiserEventOrganiser FOREIGN KEY(EventOrganiserId) REFERENCES OrganisationData(OrganisationDataId)

ALTER TABLE CharityEventOrganiser WITH CHECK ADD CONSTRAINT FK_CharityEventOrganiserEvent FOREIGN KEY(EventId) REFERENCES CharityEvent(EventId)
ALTER TABLE CharityEventOrganiser WITH CHECK ADD CONSTRAINT UK_CharityEventOrganiserEventNOrganiser UNIQUE(EventOrganiserId,EventId)



CREATE TABLE Volunteer (
    VolunteerId BIGINT IDENTITY(1,1) NOT NULL CONSTRAINT PK_Volunteer PRIMARY KEY,
    VolunteerUserId BIGINT NOT NULL,
	OrganisationId BIGINT NOT NULL,
    CreatedBy NVARCHAR(50) NOT NULL, 
	CreatedAt DATETIME NOT NULL, 
	UpdatedBy NVARCHAR(50) NOT NULL, 
	UpdatedAt DATETIME NOT NULL,
	IsPublished BIT NOT NULL DEFAULT 1,
    )

ALTER TABLE Volunteer WITH CHECK ADD CONSTRAINT FK_Volunteer FOREIGN KEY(VolunteerUserId) REFERENCES UserData(UserId)
ALTER TABLE Volunteer WITH CHECK ADD CONSTRAINT FK_VolunteerOrg FOREIGN KEY(OrganisationId) REFERENCES OrganisationData(OrganisationDataId)

CREATE TABLE Post (
	PostId BIGINT IDENTITY(1,1) CONSTRAINT PK_Post PRIMARY KEY, 
	UserId BIGINT NOT NULL,
	PostDescription TEXT NOT NULL, 
	RequirementTypeId BIGINT NOT NULL, 
	LocationName NVARCHAR(50) NOT NULL, 
	Longitude DECIMAL(12,9) NOT NULL, 
	Latitude DECIMAL(12,9) NOT NULL, 
	HelpRequiredCount BIGINT NOT NULL,
	CityId BIGINT NOT NULL,
	StateId BIGINT NOT NULL,
	ImageURL NVARCHAR(MAX) NOT NULL, 
	CreatedBy NVARCHAR(50) NOT NULL, 
	CreatedAt DATETIME NOT NULL, 
	UpdatedBy NVARCHAR(50) NOT NULL, 
	UpdatedAt DATETIME NOT NULL,
	IsPublished BIT NOT NULL DEFAULT 1,
	IsClosed BIT NOT NULL DEFAULT 0,
	CloseAt DATETIME NOT NULL,
	PincodeId BIGINT NOT NULL
	)

ALTER TABLE Post WITH CHECK ADD CONSTRAINT FK_RequirementType FOREIGN KEY(RequirementTypeId) REFERENCES RequirementType(RequirementTypeId)
ALTER TABLE Post WITH CHECK ADD CONSTRAINT FK_PostUserId FOREIGN KEY(UserId) REFERENCES UserData(UserId)
ALTER TABLE Post WITH CHECK ADD CONSTRAINT FK_PostCity FOREIGN KEY(CityId) REFERENCES Cities(CityId)
ALTER TABLE Post WITH CHECK ADD CONSTRAINT FK_PostState FOREIGN KEY(StateId) REFERENCES States(StateId)
ALTER TABLE Post WITH CHECK ADD CONSTRAINT FK_PostPin FOREIGN KEY(PincodeId) REFERENCES Pincode(PincodeId)

CREATE TABLE PostComments(
PostCommentId BIGINT IDENTITY(1,1) CONSTRAINT PK_PostComment PRIMARY KEY,
UserId BIGINT NOT NULL,
PostId BIGINT NOT NULL,
Comment TEXT NOT NULL,
CreatedBy NVARCHAR(50) NOT NULL,
CreatedAt DATETIME NOT NULL,
UpdatedBy NVARCHAR(50) NOT NULL,
UpdatedAt DATETIME NOT NULL,
IsPublished BIT NOT NULL DEFAULT 1
)

ALTER TABLE PostComments WITH CHECK ADD CONSTRAINT FK_PostComUserId FOREIGN KEY(UserId) REFERENCES UserData(UserId)
ALTER TABLE PostComments WITH CHECK ADD CONSTRAINT FK_PostComPostId FOREIGN KEY(PostId) REFERENCES Post(PostId)

CREATE TABLE PostImages(
	PostImagesId BIGINT IDENTITY(1,1) CONSTRAINT PK_PostImages PRIMARY KEY,
	UserId BIGINT NOT NULL,
	PostId BIGINT NOT NULL,
	ImageURL1 NVARCHAR(MAX),
	ImageURL2 NVARCHAR(MAX),
	ImageURL3 NVARCHAR(MAX),
	ImageURL4 NVARCHAR(MAX),
	CreatedBy NVARCHAR(50) NOT NULL,
	CreatedAt DATETIME NOT NULL,
	UpdatedBy NVARCHAR(50) NOT NULL,
	UpdatedAt DATETIME NOT NULL 
	)

ALTER TABLE PostImages WITH CHECK ADD CONSTRAINT FK_PostImgUserId FOREIGN KEY(UserId) REFERENCES UserData(UserId)
ALTER TABLE PostImages WITH CHECK ADD CONSTRAINT FK_PostImgPostId FOREIGN KEY(PostId) REFERENCES Post(PostId)

CREATE TABLE PostComments(
	PostCommentId BIGINT IDENTITY(1,1) CONSTRAINT PK_PostComment PRIMARY KEY,
	UserId BIGINT NOT NULL,
	PostId BIGINT NOT NULL,
	Comment TEXT NOT NULL,
	CreatedBy NVARCHAR(50) NOT NULL, 
	CreatedAt DATETIME NOT NULL, 
	UpdatedBy NVARCHAR(50) NOT NULL, 
	UpdatedAt DATETIME NOT NULL
)

ALTER TABLE PostComments WITH CHECK ADD CONSTRAINT FK_PostComUserId FOREIGN KEY(UserId) REFERENCES UserData(UserId)
ALTER TABLE PostComments WITH CHECK ADD CONSTRAINT FK_PostComPostId FOREIGN KEY(PostId) REFERENCES Post(PostId) 


CREATE TABLE ClusterLocations (
    ClusterLocationId BIGINT IDENTITY(1,1) CONSTRAINT PK_Cluster PRIMARY KEY,
	UserId BIGINT NOT NULL,
	PostId BIGINT NOT NULL,
	RequirementTypeId BIGINT NOT NULL,
    Locations NVARCHAR(50) NOT NULL,
	CityId BIGINT NOT NULL,
	StateId BIGINT NOT NULL,
    PeopleCount BIGINT NOT NULL,
    IsVerified BIT NOT NULL DEFAULT 0,
    CreatedBy NVARCHAR(50) NOT NULL, 
	CreatedAt DATETIME NOT NULL, 
	UpdatedBy NVARCHAR(50) NOT NULL, 
	UpdatedAt DATETIME NOT NULL,
	IsPublished BIT NOT NULL DEFAULT 1,
	PincodeId BIGINT NOT NULL
    )

ALTER TABLE ClusterLocations WITH CHECK ADD CONSTRAINT FK_ClusterUserId FOREIGN KEY(UserId) REFERENCES UserData(UserId)
ALTER TABLE ClusterLocations WITH CHECK ADD CONSTRAINT FK_ClusterPostId FOREIGN KEY(PostId) REFERENCES Post(PostId)
ALTER TABLE ClusterLocations WITH CHECK ADD CONSTRAINT FK_ClusterControId FOREIGN KEY(RequirementTypeId) REFERENCES RequirementType(RequirementTypeId)
ALTER TABLE ClusterLocations WITH CHECK ADD CONSTRAINT FK_ClusterCity FOREIGN KEY(CityId) REFERENCES Cities(CityId)
ALTER TABLE ClusterLocations WITH CHECK ADD CONSTRAINT FK_ClusterState FOREIGN KEY(StateId) REFERENCES States(StateId)
ALTER TABLE ClusterLocations WITH CHECK ADD CONSTRAINT FK_ClusterPin FOREIGN KEY(PincodeId) REFERENCES Pincode(PincodeId)

CREATE TABLE Urgency (
    UrgencyId BIGINT IDENTITY(1,1) CONSTRAINT PK_Urgent PRIMARY KEY,
    PostId BIGINT NOT NULL,
    UserId BIGINT NOT NULL,
	CreatedBy NVARCHAR(50) NOT NULL, 
	CreatedAt DATETIME NOT NULL, 
	UpdatedBy NVARCHAR(50) NOT NULL, 
	UpdatedAt DATETIME NOT NULL,
	IsPublished BIT NOT NULL DEFAULT 1,
    )
ALTER TABLE Urgency WITH CHECK ADD CONSTRAINT FK_UrgentPost FOREIGN KEY(PostId) REFERENCES Post(PostId)
ALTER TABLE Urgency WITH CHECK ADD CONSTRAINT FK_UrgentUser FOREIGN KEY(UserId) REFERENCES UserData(UserId)
ALTER TABLE Urgency WITH CHECK ADD CONSTRAINT UK_UrgencyUser UNIQUE(PostId,UserId)

CREATE TABLE Spam (
    SpamId BIGINT IDENTITY(1,1) CONSTRAINT PK_Spam PRIMARY KEY,
    PostId BIGINT NOT NULL,
    UserId BIGINT NOT NULL,
	CreatedBy NVARCHAR(50) NOT NULL, 
	CreatedAt DATETIME NOT NULL, 
	UpdatedBy NVARCHAR(50) NOT NULL, 
	UpdatedAt DATETIME NOT NULL,
	IsPublished BIT NOT NULL DEFAULT 1,
    ) 
ALTER TABLE Spam WITH CHECK ADD CONSTRAINT FK_SpamPost FOREIGN KEY(PostId) REFERENCES Post(PostId)
ALTER TABLE Spam WITH CHECK ADD CONSTRAINT FK_SpamUser FOREIGN KEY(UserId) REFERENCES UserData(UserId)
ALTER TABLE Spam WITH CHECK ADD CONSTRAINT UK_SpamUser UNIQUE(PostId,UserId)
