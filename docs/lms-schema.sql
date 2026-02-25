CREATE TABLE Genre (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    GenreName NVARCHAR(100) NOT NULL UNIQUE,
    CreatedOn DATETIME NOT NULL DEFAULT GETDATE()
);

CREATE TABLE Author (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    AuthorName NVARCHAR(150) NOT NULL UNIQUE,
    CreatedOn DATETIME NOT NULL DEFAULT GETDATE()
);

CREATE TABLE Book (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Title NVARCHAR(250) NOT NULL,
    ShortDescription NVARCHAR(MAX) NULL,
    ISBN NVARCHAR(20) NOT NULL UNIQUE,
    GenreId INT NOT NULL,
    Publisher NVARCHAR(200) NULL,
    PublishedYear INT NULL,
    Pages INT NULL,
    Length DECIMAL(6,2) NULL,
    Width DECIMAL(6,2) NULL,
    Height DECIMAL(6,2) NULL,
    TotalCopies INT NOT NULL DEFAULT 1,
    AvailableCopies INT NOT NULL DEFAULT 1,
    IsActive BIT NOT NULL DEFAULT 1,
    Image NVARCHAR(500) NULL,
    CreatedOn DATETIME NOT NULL DEFAULT GETDATE(),

    CONSTRAINT FK_Book_Genre FOREIGN KEY (GenreId)
        REFERENCES Genre(Id),

    CONSTRAINT CHK_Book_Copies
        CHECK (AvailableCopies <= TotalCopies),

    CONSTRAINT CHK_Book_TotalCopies
        CHECK (TotalCopies >= 0),

    CONSTRAINT CHK_Book_AvailableCopies
        CHECK (AvailableCopies >= 0)
);

CREATE TABLE BookAuthor (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    BookId INT NOT NULL,
    AuthorId INT NOT NULL,

    CONSTRAINT FK_BookAuthor_Book FOREIGN KEY (BookId)
        REFERENCES Book(Id),

    CONSTRAINT FK_BookAuthor_Author FOREIGN KEY (AuthorId)
        REFERENCES Author(Id),

    CONSTRAINT UQ_BookAuthor UNIQUE (BookId, AuthorId)
);

CREATE TABLE Role (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    RoleName NVARCHAR(50) NOT NULL UNIQUE
);

INSERT INTO Role (RoleName) VALUES
('Admin'),
('Librarian'),
('Member');

CREATE TABLE Subscription (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    SubscriptionName NVARCHAR(100) NOT NULL UNIQUE,
    YearlyFee DECIMAL(10,2) NOT NULL,
    BookingCount INT NOT NULL,
    BookingTime INT NOT NULL,
    IsActive BIT NOT NULL DEFAULT 1,

    CONSTRAINT CHK_Subscription_BookingCount CHECK (BookingCount > 0),
    CONSTRAINT CHK_Subscription_BookingTime CHECK (BookingTime > 0),
    CONSTRAINT CHK_Subscription_Fee CHECK (YearlyFee >= 0)
);


CREATE TABLE Member (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Name NVARCHAR(150) NOT NULL,
    Email NVARCHAR(150) NOT NULL UNIQUE,
    Mobile NVARCHAR(20) NULL,
    Password NVARCHAR(500) NOT NULL,
    Salt UNIQUEIDENTIFIER NOT NULL,
    IsActive BIT NOT NULL DEFAULT 1,
    Remarks NVARCHAR(500) NULL,
    CreatedOn DATETIME NOT NULL DEFAULT GETDATE(),
    LastLogin DATETIME NULL
);

CREATE TABLE MemberRole (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    MemberId INT NOT NULL,
    RoleId INT NOT NULL,
    IsActive BIT NOT NULL DEFAULT 1,

    CONSTRAINT FK_MemberRole_Member FOREIGN KEY (MemberId)
        REFERENCES Member(Id),

    CONSTRAINT FK_MemberRole_Role FOREIGN KEY (RoleId)
        REFERENCES Role(Id),

    CONSTRAINT UQ_MemberRole UNIQUE (MemberId, RoleId)
);

CREATE TABLE MemberSubscription (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    MemberId INT NOT NULL,
    SubscriptionId INT NOT NULL,
    FromDate DATE NOT NULL,
    ToDate DATE NOT NULL,
    AmountPaid DECIMAL(10,2) NOT NULL,
    BookingCount INT NOT NULL,
    BookingTime INT NOT NULL,
    PaymentMode NVARCHAR(20) NOT NULL,
    PayDate DATETIME NOT NULL DEFAULT GETDATE(),

    CONSTRAINT FK_MemberSubscription_Member FOREIGN KEY (MemberId)
        REFERENCES Member(Id),

    CONSTRAINT FK_MemberSubscription_Subscription FOREIGN KEY (SubscriptionId)
        REFERENCES Subscription(Id),

    CONSTRAINT CHK_MemberSubscription_Dates CHECK (FromDate <= ToDate)
);

CREATE TABLE BookReview (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    MemberId INT NOT NULL,
    BookId INT NOT NULL,
    Ratings INT NOT NULL,
    IsRecommended BIT NOT NULL DEFAULT 0,
    Comments NVARCHAR(MAX) NULL,
    IsApproved BIT NOT NULL DEFAULT 0,
    ReviewedOn DATETIME NOT NULL DEFAULT GETDATE(),

    CONSTRAINT FK_BookReview_Member FOREIGN KEY (MemberId)
        REFERENCES Member(Id),

    CONSTRAINT FK_BookReview_Book FOREIGN KEY (BookId)
        REFERENCES Book(Id),

    CONSTRAINT CHK_BookReview_Ratings CHECK (Ratings BETWEEN 1 AND 5)
);

CREATE TABLE BookRecommendation (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    BookId INT NOT NULL,
    MemberId INT NOT NULL,
    Remarks NVARCHAR(500) NULL,
    RecommendationDate DATETIME NOT NULL DEFAULT GETDATE(),

    CONSTRAINT FK_BookRecommendation_Book FOREIGN KEY (BookId)
        REFERENCES Book(Id),

    CONSTRAINT FK_BookRecommendation_Member FOREIGN KEY (MemberId)
        REFERENCES Member(Id)
);

CREATE TABLE BookReservation (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    MemberId INT NOT NULL,
    BookId INT NOT NULL,
    FromDate DATE NOT NULL,
    ToDate DATE NOT NULL,
    IsComplete BIT NOT NULL DEFAULT 0,
    IsViolation BIT NOT NULL DEFAULT 0,
    ViolationType INT NULL,
    ViolationRemarks NVARCHAR(500) NULL,
    LastUpdatedBy INT NULL,
    LastUpdatedOn DATETIME NULL,

    CONSTRAINT FK_BookReservation_Member FOREIGN KEY (MemberId)
        REFERENCES Member(Id),

    CONSTRAINT FK_BookReservation_Book FOREIGN KEY (BookId)
        REFERENCES Book(Id),

    CONSTRAINT CHK_BookReservation_Dates CHECK (FromDate <= ToDate)
);


