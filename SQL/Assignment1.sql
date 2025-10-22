CREATE DATABASE IF NOT EXISTS `VTI_Department_DB`;

USE `VTI_Department_DB`;


CREATE TABLE IF NOT EXISTS Department (
	DepartmentID smallint auto_increment primary key,
    DepartmentName VARCHAR(200) not null
);

CREATE TABLE IF NOT EXISTS `Position` (
	PositionID smallint auto_increment primary key,
    PositionName varchar(100) not null
);

CREATE TABLE IF NOT EXISTS `Account` (
	AccountID int auto_increment primary key,
    Email varchar(150) not null unique,
    Username varchar(100) not null unique,
    FullName varchar(150) not null,
    DepartmentID smallint not null,
    PositionID smallint not null,
    CreateDate Timestamp default current_timestamp,
    foreign key (DepartmentID) references Department(DepartmentID),
    foreign key (PositionID) references `Position`(PositionID)
);

CREATE TABLE IF NOT EXISTS `Group` (
	GroupID int auto_increment primary key,
    GroupName varchar(150) not null,
    CreatorID int not null,
    CreateDate Timestamp default current_timestamp,
    foreign key (CreatorID) references `Account`(AccountID)
);

CREATE TABLE IF NOT EXISTS `GroupAccount` (
	GroupID int not null,
    AccountID int not null,
    JoinDate Timestamp default current_timestamp,
    foreign key (GroupID) references `Group`(GroupID),
    foreign key (AccountID) references `Account`(AccountID),
    Primary Key (GroupID, AccountID)
);

CREATE TABLE IF NOT EXISTS `TypeQuestion` (
	TypeID smallint auto_increment primary key,
    TypeName varchar(80) not null
);

CREATE TABLE IF NOT EXISTS `CategoryQuestion` (
	CategoryID smallint auto_increment primary key,
    CategoryName varchar(80) not null
);

CREATE TABLE IF NOT EXISTS `Question` (
	QuestionID int auto_increment primary key,
    Content TEXT not null,
    CategoryID smallint,
    TypeID smallint,
    CreatorID int not null,
    CreateDate Timestamp default current_timestamp,
    foreign key (CreatorID) references `Account`(AccountID),
    foreign key (TypeID) references `TypeQuestion`(TypeID),
    foreign key (CategoryID) references `CategoryQuestion`(CategoryID)
);

CREATE TABLE IF NOT EXISTS `Answer` (
	AnswerID int auto_increment primary key,
    Content TEXT not null,
    QuestionID int not null,
    isCorrect BOOL default false,
    foreign key (QuestionID) references `Question`(QuestionID)
);


CREATE TABLE IF NOT EXISTS `Exam` (
	ExamID int auto_increment primary key,
    Code CHAR(10) not null,
    Title VARCHAR(100) not null,
    CategoryID smallint,			-- is it same as category of question?
    Duration int default 60,	-- 60 mins
    CreatorID int not null,
    CreateDate Timestamp default current_timestamp,
    foreign key (CreatorID) references `Account`(AccountID),
    foreign key (CategoryID) references `CategoryQuestion`(CategoryID)			-- assume category of exam == category of question
);


CREATE TABLE IF NOT EXISTS `ExamQuestion` (
	ExamID int not null,
    QuestionID int not null,
    foreign key (QuestionID) references `Question`(QuestionID),
    foreign key (ExamID) references `Exam`(ExamID),
    Primary Key (ExamID, QuestionID)
);

