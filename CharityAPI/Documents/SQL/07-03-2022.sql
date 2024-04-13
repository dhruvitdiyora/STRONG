CREATE TABLE Bookmark (
	BookmarkId BIGINT IDENTITY(1,1) CONSTRAINT PK_Bookmark PRIMARY KEY,
	UserId BIGINT NOT NULL,
	PostId BIGINT NOT NULL,
	CreatedBy NVARCHAR(50) NOT NULL, 
	CreatedAt DATETIME NOT NULL, 
	UpdatedBy NVARCHAR(50) NOT NULL, 
	UpdatedAt DATETIME NOT NULL,
	IsPublished BIT NOT NULL DEFAULT 1,
	)

ALTER TABLE Bookmark WITH CHECK ADD CONSTRAINT FK_BookmarkUserId FOREIGN KEY(UserId) REFERENCES UserData(UserId)
ALTER TABLE Bookmark WITH CHECK ADD CONSTRAINT FK_BookmarkPostId FOREIGN KEY(PostId) REFERENCES Post(PostId)
