DROP DATABASE IF EXISTS ProjectDatabase;
CREATE DATABASE ProjectDatabase;
USE ProjectDatabase;


DROP TABLE IF EXISTS User_Industry;
DROP TABLE IF EXISTS Industry;
DROP TABLE IF EXISTS Contact;
DROP TABLE IF EXISTS Notifications;
DROP TABLE IF EXISTS Interactions;
DROP TABLE IF EXISTS SupportTickets;
DROP TABLE IF EXISTS Job_Postings;
DROP TABLE IF EXISTS Company;
DROP TABLE IF EXISTS User_Type;
DROP TABLE IF EXISTS Employer;
DROP TABLE IF EXISTS Faculty;
DROP TABLE IF EXISTS Student;
DROP TABLE IF EXISTS Users;



CREATE TABLE Users (
    UserID INT AUTO_INCREMENT PRIMARY KEY,
    RegisteredAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    Occupation VARCHAR(100),
    Location VARCHAR(40),
    Name VARCHAR(40),
    Age INT,
    Bio VARCHAR(300),
    ReferredBy INT,
    Online BOOLEAN DEFAULT FALSE,
    Admin BOOLEAN DEFAULT FALSE
);

CREATE TABLE Notifications (
    NotifID INT AUTO_INCREMENT PRIMARY KEY,
    CreatedBy INT,
    Text TEXT,
    Active BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (CreatedBy) REFERENCES Users(UserID)
);



CREATE TABLE Student (
    StuID INT AUTO_INCREMENT PRIMARY KEY,
    Year INT,
    NumPreviousCoOps INT,
    PayTransparency BOOLEAN DEFAULT FALSE,
    Companies VARCHAR(100),
    Skills VARCHAR(100),
    FOREIGN KEY (StuID) REFERENCES Users(UserID)
);

CREATE TABLE Faculty (
    FacID INT AUTO_INCREMENT PRIMARY KEY,
    ClassesTaught VARCHAR(100),
    Skills VARCHAR(100),
    FOREIGN KEY (FacID) REFERENCES Users(UserID)
);

CREATE TABLE Company (
    CompanyID INT AUTO_INCREMENT PRIMARY KEY,
    CompanyName VARCHAR(200),
    CompanyDescription TEXT
);

CREATE TABLE Employer (
    EmpID INT AUTO_INCREMENT PRIMARY KEY,
    TechnicalSkills VARCHAR(100),
    GPARequired FLOAT,
    SoftSkills VARCHAR(100),
    PayOffered BOOLEAN DEFAULT FALSE,
    CompanyID INT,
    FOREIGN KEY (EmpID) REFERENCES Users(UserID),
    FOREIGN KEY (CompanyID) REFERENCES Company(CompanyID)
);

CREATE TABLE User_Type (
    UserID INT AUTO_INCREMENT PRIMARY KEY,
    StuID INT,
    FacID INT,
    EmpID INT,
    FOREIGN KEY (StuID) REFERENCES Student(StuID),
    FOREIGN KEY (FacID) REFERENCES Faculty(FacID),
    FOREIGN KEY (EmpID) REFERENCES Employer(EmpID)
);





CREATE TABLE SupportTickets (
    TikNum INT AUTO_INCREMENT PRIMARY KEY,
    UserID INT,
    StartedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    Category VARCHAR(100),
    RespondedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP NOT NULL,
    Active BOOLEAN DEFAULT FALSE,
    Text VARCHAR(500),
    Urgency INT,
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);

CREATE TABLE Job_Postings (
    JobPostingID INT AUTO_INCREMENT PRIMARY KEY,
    Text TEXT,
    SalaryRange VARCHAR(30),
    Title VARCHAR(30),
    GPA_Range VARCHAR(30),
    Location VARCHAR(50),
    Deadline DATE,
    Experience_Level VARCHAR(30)
);

CREATE TABLE Interactions (
    InteractionID INT AUTO_INCREMENT PRIMARY KEY,
    Type VARCHAR(50),
    ToUserID INT,
    FromUserID INT NOT NULL,
    Subject VARCHAR(50),
    Text VARCHAR(500),
    JobPostingID INT,
    Resume VARCHAR(100),
    FOREIGN KEY (FromUserID) REFERENCES Users(UserID),
    FOREIGN KEY (JobPostingID) REFERENCES Job_Postings(JobPostingID)
);


CREATE TABLE Contact (
    ContactID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(50),
    Phone VARCHAR(20),
    Email VARCHAR(50),
    FOREIGN KEY (ContactID) REFERENCES Users(UserID)
);

CREATE TABLE Industry (
    IndustryID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(40),
    NUCollege VARCHAR(50)
);

CREATE TABLE User_Industry (
    UserID INT,
    IndustryID INT,
    PRIMARY KEY (UserID, IndustryID),
    FOREIGN KEY (UserID) REFERENCES Users(UserID),
    FOREIGN KEY (IndustryID) REFERENCES Industry(IndustryID)
);


INSERT INTO Users (RegisteredAt, Occupation, Location, Name, Age, Bio, Online, Admin)
VALUES
('2023-11-01', 'Student', 'New York', 'Gabe John', 22, 'CS Major', TRUE, FALSE),
('2023-10-15', 'Faculty', 'Boston', 'Bobby Smith', 45, 'Professor of CS', FALSE, FALSE);

INSERT INTO Student (Year, NumPreviousCoOps, PayTransparency, Companies, Skills)
VALUES
(3, 2, TRUE, 'Mckinsey, Khoury', 'Python, SQL'),
(2, 1, FALSE, 'BCG', 'Excel, R');

INSERT INTO Faculty (ClassesTaught, Skills)
VALUES
('Database Design, Machine Learning', 'SQL, Python'),
('Software Engineering, Intro to DS', 'Java, JS');

INSERT INTO Company (CompanyName, CompanyDescription)
VALUES
('Khoury', 'College of Comp Sci'),
('BCG', 'Consulting Firm');

INSERT INTO Employer (TechnicalSkills, GPARequired, SoftSkills, PayOffered, CompanyID)
VALUES
('Java, SQL', 3.5, 'Teamwork, Communication', TRUE, 1),
('Python, Pandas', 3.2, 'Critical Thinking', FALSE, 2);

INSERT INTO User_Type (UserID, StuID, FacID, EmpID)
VALUES
(1, 1, NULL, NULL),
(2, NULL, 2, NULL);

INSERT INTO SupportTickets (UserID, StartedAt, Category, Active, Text, Urgency)
VALUES
(1, '2023-11-18', 'New Feature Request', TRUE, 'Would love to be able to filter based on GPA', 1),
(2, '2023-11-19', 'Bug Report', FALSE, 'Unable to upload resume.', 2);

INSERT INTO Job_Postings (Text, SalaryRange, Title, GPA_Range, Location, Deadline, Experience_Level)
VALUES
('Software Developer Internship', '$30-$40/hour', 'Intern', '3.5+', 'New York', '2024-12-31', 'Entry'),
('Data Analyst Position', '$60K-$70K', 'Analyst', '3.0+', 'Boston', '2025-01-15', 'Intermediate');

INSERT INTO Interactions (Type, ToUserID, FromUserID, Subject, Text, JobPostingID, Resume)
VALUES
('Message', 2, 1, 'Question', 'How are you?', NULL, NULL),
('Job Application', NULL, 2, 'Data Analyst', 'My Application', 1, 'jacobresume.pdf');

INSERT INTO Notifications (CreatedBy, Text, Active)
VALUES
(1, 'System is down for fixing', TRUE),
(2, 'The app is now launched!', FALSE);

INSERT INTO Contact (Name, Phone, Email)
VALUES
('Jacob B', '123-456-7890', 'benesch.j@northeastern.edu'),
('Eesha D', '987-654-3210', 'eeshad@gmail.com');

INSERT INTO Industry (Name, NUCollege)
VALUES
('Technology', 'COE'),
('Consulting', 'DAmore Mckim');

INSERT INTO User_Industry (UserID, IndustryID)
VALUES
(1, 1),
(2, 2);


