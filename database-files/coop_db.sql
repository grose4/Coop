DROP DATABASE IF EXISTS finalpart2;
CREATE DATABASE finalpart2;
USE finalpart2;

-- Drop tables in reverse dependency order to avoid errors
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

-- Create Users table
CREATE TABLE Users (
    UserID INT AUTO_INCREMENT PRIMARY KEY,
    RegisteredAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    Occupation VARCHAR(100),
    Location VARCHAR(40) NOT NULL,
    Name VARCHAR(40) NOT NULL,
    Age INT NOT NULL,
    Bio VARCHAR(300) NOT NULL,
    ReferredBy INT,
    Online BOOLEAN DEFAULT FALSE,
    Admin BOOLEAN DEFAULT FALSE
);

-- Create Notifications table
CREATE TABLE Notifications (
    NotifID INT AUTO_INCREMENT PRIMARY KEY,
    CreatedBy INT NOT NULL,
    Text TEXT,
    Active BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (CreatedBy) REFERENCES Users(UserID)
);

-- Create Student table
CREATE TABLE Student (
    StuID INT AUTO_INCREMENT PRIMARY KEY,
    Year INT NOT NULL,
    NumPreviousCoOps INT,
    PayTransparency BOOLEAN DEFAULT FALSE,
    Companies VARCHAR(100),
    Skills VARCHAR(100),
    FOREIGN KEY (StuID) REFERENCES Users(UserID)
);

-- Create Faculty table
CREATE TABLE Faculty (
    FacID INT AUTO_INCREMENT PRIMARY KEY,
    ClassesTaught VARCHAR(100),
    Skills VARCHAR(100),
    FOREIGN KEY (FacID) REFERENCES Users(UserID)
);

-- Create Company table
CREATE TABLE Company (
    CompanyID INT AUTO_INCREMENT PRIMARY KEY,
    CompanyName VARCHAR(200),
    CompanyDescription TEXT
);

-- Create Employer table
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

-- Create User_Type table
CREATE TABLE User_Type (
    UserID INT PRIMARY KEY,
    StuID INT UNIQUE,
    FacID INT UNIQUE,
    EmpID INT UNIQUE,
    FOREIGN KEY (UserID) REFERENCES Users(UserID),
    FOREIGN KEY (StuID) REFERENCES Student(StuID),
    FOREIGN KEY (FacID) REFERENCES Faculty(FacID),
    FOREIGN KEY (EmpID) REFERENCES Employer(EmpID)
);

-- Create SupportTickets table
CREATE TABLE SupportTickets (
    TikNum INT AUTO_INCREMENT PRIMARY KEY,
    UserID INT NOT NULL,
    StartedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    Category VARCHAR(100),
    RespondedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP NOT NULL,
    Active BOOLEAN DEFAULT FALSE,
    Text VARCHAR(500) NOT NULL,
    Urgency INT NOT NULL,
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);

-- Create Job_Postings table
CREATE TABLE Job_Postings (
    JobPostingID INT AUTO_INCREMENT PRIMARY KEY,
    Text TEXT,
    SalaryRange VARCHAR(30),
    Title VARCHAR(30) NOT NULL,
    GPA_Range VARCHAR(30),
    Location VARCHAR(50),
    Deadline DATETIME,
    Experience_Level VARCHAR(30)
);

-- Create Interactions table
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

-- Create Contact table
CREATE TABLE Contact (
    ContactID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(50) NOT NULL,
    Phone VARCHAR(20),
    Email VARCHAR(50),
    FOREIGN KEY (ContactID) REFERENCES Users(UserID)
);

-- Create Industry table
CREATE TABLE Industry (
    IndustryID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(40) NOT NULL,
    NUCollege VARCHAR(50)
);

-- Create User_Industry table
CREATE TABLE User_Industry (
    UserID INT,
    IndustryID INT,
    PRIMARY KEY (UserID, IndustryID),
    FOREIGN KEY (UserID) REFERENCES Users(UserID),
    FOREIGN KEY (IndustryID) REFERENCES Industry(IndustryID)
);


-- FAKE DATA -- 
INSERT INTO Users (UserID, Occupation, Location, Name, Age, Bio, ReferredBy) VALUES 
(1, 'Staff Scientist', 'China', 'trist0', 97, 'fringilla rhoncus mauris enim leo rhoncus sed vestibulum sit amet cursus', 21),
(2, 'Computer Systems Analyst IV', 'Angola', 'aashcroft1', 70, 'consequat varius integer ac leo pellentesque ultrices mattis odio donec', 22),
(3, 'Teacher', 'Portugal', 'egiacoppo2', 7, 'magnis dis parturient montes nascetur ridiculus mus etiam vel augue vestibulum', 35),
(4, 'Data Coordinator', 'Mexico', 'rtenbrug3', 92, 'sit amet', NULL),
(5, 'Community Outreach Specialist', 'Ukraine', 'kpriestland4', 54, 'ullamcorper augue a', 38),
(6, 'Systems Administrator I', 'Brazil', 'gwoodfin5', 27, 'morbi', NULL),
(7, 'Office Assistant II', 'Finland', 'maizkovitch6', 57, 'praesent blandit lacinia erat vestibulum sed magna at nunc', 13),
(8, 'VP Quality Control', 'China', 'mglewe7', 55, 'amet nulla quisque arcu libero rutrum ac lobortis vel dapibus', NULL),
(9, 'Electrical Engineer', 'Slovenia', 'kmingaud8', 56, 'ut volutpat sapien arcu sed augue aliquam', 54),
(10, 'Environmental Specialist', 'Greece', 'bstrachan9', 97, 'felis ut at dolor quis odio consequat', NULL),
(11, 'Analog Circuit Design manager', 'Brazil', 'abarcrofta', 25, 'ut dolor', 29),
(12, 'Senior Sales Associate', 'Azerbaijan', 'twitherbedb', 19, 'id consequat in consequat ut nulla sed accumsan felis', NULL),
(13, 'Speech Pathologist', 'Poland', 'cecobc', 30, 'etiam vel augue vestibulum rutrum rutrum neque aenean auctor gravida sem', 33),
(14, 'Payment Adjustment Coordinator', 'Micronesia', 'wiorid', 24, 'sociis natoque penatibus et magnis', NULL),
(15, 'Senior Quality Engineer', 'Indonesia', 'dcuncliffee', 57, 'justo in blandit ultrices enim', 61),
(16, 'Physical Therapy Assistant', 'Philippines', 'dmcnuttf', 6, 'placerat ante nulla justo aliquam quis turpis eget elit', 22),
(17, 'Senior Sales Associate', 'Philippines', 'jmonteithg', 93, 'quis orci', NULL),
(18, 'Programmer Analyst III', 'Tanzania', 'lcheneryh', 83, 'vulputate vitae nisl aenean lectus pellentesque eget nunc donec quis', NULL),
(19, 'Senior Sales Associate', 'China', 'kcooli', 14, 'in faucibus orci luctus', NULL),
(20, 'Senior Editor', 'Indonesia', 'aertelj', 17, 'eget nunc donec quis orci eget', 30),
(21, 'Biostatistician IV', 'Philippines', 'gkenank', 59, 'nec euismod scelerisque quam', NULL),
(22, 'Media Manager IV', 'Indonesia', 'lkitcattl', 54, 'volutpat dui maecenas tristique est et', 63),
(23, 'Structural Engineer', 'Armenia', 'jbenkinm', 76, 'blandit ultrices enim', NULL),
(24, 'Dental Hygienist', 'China', 'qyesinovn', 83, 'quam fringilla rhoncus mauris enim leo rhoncus sed vestibulum sit amet', NULL),
(25, 'Web Designer IV', 'United States', 'agullamo', 9, 'sagittis nam congue risus semper porta volutpat quam pede lobortis ligula sit amet eleifend pede', 68),
(26, 'Speech Pathologist', 'China', 'lallikerp', 60, 'ac consequat metus sapien', 16),
(27, 'Internal Auditor', 'Portugal', 'imccrostieq', 30, 'aenean sit amet justo morbi ut odio cras mi', 85),
(28, 'Marketing Manager', 'Philippines', 'slitzmannr', 14, 'pede morbi porttitor lorem id ligula suspendisse ornare consequat lectus', 70),
(29, 'Human Resources Manager', 'Egypt', 'imenarys', 88, 'eros suspendisse accumsan tortor quis turpis sed ante vivamus tortor duis mattis egestas', 29),
(30, 'Account Representative I', 'Colombia', 'pchithamt', 94, 'nisi vulputate nonummy maecenas tincidunt lacus at velit vivamus vel', 40),
(31, 'Data Coordinator', 'Thailand', 'jlampetu', 57, 'pede lobortis ligula sit amet eleifend pede libero quis orci nullam molestie', 33),
(32, 'Business Systems Development Analyst', 'Indonesia', 'bcossarv', 60, 'in quis justo maecenas rhoncus aliquam lacus morbi quis tortor', 12),
(33, 'Teacher', 'Honduras', 'awarretw', 70, 'in quis', 14),
(34, 'Recruiting Manager', 'China', 'gshielx', 93, 'aliquam erat volutpat in congue etiam justo etiam', 26),
(35, 'Geologist II', 'Indonesia', 'gbrainey', 76, 'sit amet lobortis sapien sapien non', 44),
(36, 'Senior Developer', 'Colombia', 'lroadz', 99, 'at diam nam tristique tortor', NULL),
(37, 'Civil Engineer', 'Argentina', 'jchettle10', 65, 'ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae mauris viverra diam', 81),
(38, 'VP Quality Control', 'Indonesia', 'mjackes11', 40, 'adipiscing lorem vitae mattis', 98),
(39, 'Associate Professor', 'Philippines', 'bbranthwaite12', 55, 'felis ut at dolor quis odio consequat varius integer ac leo pellentesque', 55),
(40, 'Software Test Engineer III', 'Indonesia', 'kmitchiner13', 63, 'eu orci', 38),
(41, 'Nuclear Power Engineer', 'Greece', 'zmcart14', 4, 'suspendisse potenti cras in purus eu magna vulputate luctus cum sociis natoque', 47),
(42, 'Dental Hygienist', 'Japan', 'splose15', 51, 'dui maecenas tristique est et tempus', NULL),
(43, 'Account Coordinator', 'China', 'fcamus16', 28, 'vel pede', 72),
(44, 'Cost Accountant', 'China', 'bstockow17', 63, 'arcu sed augue aliquam erat volutpat', NULL),
(45, 'Technical Writer', 'China', 'vscalera18', 47, 'odio condimentum id luctus nec', 97),
(46, 'Social Worker', 'China', 'rbeeke19', 9, 'pretium quis lectus suspendisse potenti in eleifend quam a odio in hac habitasse platea dictumst', NULL),
(47, 'Teacher', 'Ukraine', 'fmcgrill1a', 31, 'ut erat curabitur gravida nisi at nibh in hac habitasse', 80),
(48, 'Occupational Therapist', 'Russia', 'mdrought1b', 95, 'praesent lectus vestibulum quam sapien varius ut blandit non interdum in ante vestibulum', 39),
(49, 'Accounting Assistant IV', 'China', 'hwoolstenholmes1c', 69, 'diam in magna bibendum imperdiet', NULL),
(50, 'Safety Technician III', 'Israel', 'mmacteggart1d', 45, 'sit amet lobortis sapien', NULL);


insert into Notifications  (CreatedBy, Text) values (1, 'volutpat convallis morbi odio odio elementum eu');
insert into Notifications  (CreatedBy, Text) values (2, 'primis in faucibus orci luctus et ultrices');
insert into Notifications  (CreatedBy, Text) values (3, 'odio condimentum id luctus nec molestie sed justo pellentesque');
insert into Notifications  (CreatedBy, Text) values (4, 'fusce congue diam id ornare imperdiet sapien urna pretium nisl ut');
insert into Notifications  (CreatedBy, Text) values (5, 'odio in hac habitasse platea dictumst maecenas');
insert into Notifications  (CreatedBy, Text) values (6, 'euismod scelerisque quam turpis adipiscing lorem vitae mattis nibh ligula');
insert into Notifications  (CreatedBy, Text) values (7, 'lectus in est risus');
insert into Notifications  (CreatedBy, Text) values (8, 'mauris non ligula pellentesque ultrices phasellus id sapien in sapien iaculis congue vivamus metus arcu');
insert into Notifications  (CreatedBy, Text) values (9, 'convallis');
insert into Notifications  (CreatedBy, Text) values (10, 'blandit mi in porttitor pede justo eu massa donec dapibus duis at velit');
insert into Notifications  (CreatedBy, Text) values (11, 'sem duis aliquam convallis nunc proin at turpis a pede');
insert into Notifications  (CreatedBy, Text) values (12, 'nibh in lectus pellentesque');
insert into Notifications  (CreatedBy, Text) values (13, 'in faucibus orci luctus et ultrices posuere cubilia curae mauris viverra diam vitae quam suspendisse');
insert into Notifications  (CreatedBy, Text) values (14, 'nec euismod scelerisque quam turpis adipiscing lorem vitae mattis nibh ligula nec sem duis');
insert into Notifications  (CreatedBy, Text) values (15, 'libero');
insert into Notifications  (CreatedBy, Text) values (16, 'ante ipsum primis');
insert into Notifications  (CreatedBy, Text) values (17, 'vehicula condimentum curabitur in libero ut massa volutpat convallis morbi odio odio');
insert into Notifications  (CreatedBy, Text) values (18, 'augue vel accumsan tellus nisi');
insert into Notifications  (CreatedBy, Text) values (19, 'justo etiam pretium iaculis justo in hac');
insert into Notifications  (CreatedBy, Text) values (20, 'lorem integer tincidunt ante');
insert into Notifications  (CreatedBy, Text) values (21, 'dui nec nisi volutpat');
insert into Notifications  (CreatedBy, Text) values (22, 'odio cras mi pede malesuada in imperdiet et commodo vulputate');
insert into Notifications  (CreatedBy, Text) values (23, 'nulla');
insert into Notifications  (CreatedBy, Text) values (24, 'vel accumsan tellus nisi eu orci mauris lacinia sapien');
insert into Notifications  (CreatedBy, Text) values (25, 'dis parturient montes nascetur ridiculus mus vivamus vestibulum sagittis sapien cum sociis natoque penatibus');
insert into Notifications  (CreatedBy, Text) values (26, 'leo maecenas pulvinar lobortis est phasellus');
insert into Notifications  (CreatedBy, Text) values (27, 'convallis eget eleifend luctus ultricies eu nibh quisque id justo sit amet sapien');
insert into Notifications  (CreatedBy, Text) values (28, 'consequat nulla nisl nunc');
insert into Notifications  (CreatedBy, Text) values (29, 'neque');
insert into Notifications  (CreatedBy, Text) values (30, 'nulla tellus in sagittis dui vel');
insert into Notifications  (CreatedBy, Text) values (31, 'eu orci mauris');
insert into Notifications  (CreatedBy, Text) values (32, 'egestas metus aenean');
insert into Notifications  (CreatedBy, Text) values (33, 'faucibus orci luctus et ultrices posuere cubilia');
insert into Notifications  (CreatedBy, Text) values (34, 'nam dui proin leo');
insert into Notifications  (CreatedBy, Text) values (35, 'lacus at turpis donec posuere metus vitae ipsum aliquam non');
insert into Notifications  (CreatedBy, Text) values (36, 'pretium nisl ut');
insert into Notifications  (CreatedBy, Text) values (37, 'ac nibh fusce lacus');
insert into Notifications  (CreatedBy, Text) values (38, 'sagittis sapien cum sociis natoque penatibus et');
insert into Notifications  (CreatedBy, Text) values (39, 'augue aliquam erat volutpat in congue etiam justo etiam pretium iaculis justo in hac habitasse');
insert into Notifications  (CreatedBy, Text) values (40, 'mus');

insert into Student  (Year, NumPreviousCoOps, PayTransparency, Companies, Skills) values (4, 3, false, 'penatibus et', null);
insert into Student  (Year, NumPreviousCoOps, PayTransparency, Companies, Skills) values (2, 1, null, 'etiam vel', 'cum sociis natoque penatibus et');
insert into Student  (Year, NumPreviousCoOps, PayTransparency, Companies, Skills) values (4, 3, null, 'id nulla', 'non quam nec dui');
insert into Student  (Year, NumPreviousCoOps, PayTransparency, Companies, Skills) values (4, 4, false, 'maecenas leo odio', null);
insert into Student  (Year, NumPreviousCoOps, PayTransparency, Companies, Skills) values (1, 1, false, 'ante', 'orci luctus et ultrices posuere');
insert into Student  (Year, NumPreviousCoOps, PayTransparency, Companies, Skills) values (3, 4, false, 'imperdiet', null);
insert into Student  (Year, NumPreviousCoOps, PayTransparency, Companies, Skills) values (1, 1, true, 'in quis justo maecenas', 'habitasse platea dictumst morbi');
insert into Student  (Year, NumPreviousCoOps, PayTransparency, Companies, Skills) values (1, 4, null, 'dui proin leo odio', 'quam pharetra magna ac consequat');
insert into Student  (Year, NumPreviousCoOps, PayTransparency, Companies, Skills) values (2, null, null, 'vel lectus in quam', 'cursus urna ut');
insert into Student  (Year, NumPreviousCoOps, PayTransparency, Companies, Skills) values (2, 2, false, 'nisi volutpat eleifend donec', 'curae mauris');
insert into Student  (Year, NumPreviousCoOps, PayTransparency, Companies, Skills) values (3, 1, false, 'elementum', null);
insert into Student  (Year, NumPreviousCoOps, PayTransparency, Companies, Skills) values (4, 1, false, 'quis turpis', 'libero quis orci nullam molestie');
insert into Student  (Year, NumPreviousCoOps, PayTransparency, Companies, Skills) values (4, 3, true, 'velit donec diam', 'venenatis turpis enim');
insert into Student  (Year, NumPreviousCoOps, PayTransparency, Companies, Skills) values (3, 2, false, 'ipsum praesent blandit lacinia', null);
insert into Student  (Year, NumPreviousCoOps, PayTransparency, Companies, Skills) values (2, null, null, 'donec dapibus', null);
insert into Student  (Year, NumPreviousCoOps, PayTransparency, Companies, Skills) values (3, 3, null, 'mi', 'mauris');
insert into Student  (Year, NumPreviousCoOps, PayTransparency, Companies, Skills) values (2, 1, null, 'integer tincidunt ante', null);
insert into Student  (Year, NumPreviousCoOps, PayTransparency, Companies, Skills) values (3, null, null, 'vestibulum', null);
insert into Student  (Year, NumPreviousCoOps, PayTransparency, Companies, Skills) values (3, 1, true, 'vestibulum', 'consequat');
insert into Student  (Year, NumPreviousCoOps, PayTransparency, Companies, Skills) values (1, 1, null, 'quis orci nullam molestie nibh', null);
insert into Student  (Year, NumPreviousCoOps, PayTransparency, Companies, Skills) values (1, null, true, 'quisque', 'ligula in');
insert into Student  (Year, NumPreviousCoOps, PayTransparency, Companies, Skills) values (4, null, null, 'nisi vulputate nonummy maecenas tincidunt', 'dis parturient montes nascetur ridiculus');
insert into Student  (Year, NumPreviousCoOps, PayTransparency, Companies, Skills) values (4, 2, false, 'justo lacinia eget tincidunt', null);
insert into Student  (Year, NumPreviousCoOps, PayTransparency, Companies, Skills) values (3, 3, false, 'phasellus in felis', null);
insert into Student  (Year, NumPreviousCoOps, PayTransparency, Companies, Skills) values (4, 1, null, 'imperdiet', 'eget tempus vel');
insert into Student  (Year, NumPreviousCoOps, PayTransparency, Companies, Skills) values (2, 4, true, 'a ipsum integer a nibh', 'nunc commodo');
insert into Student  (Year, NumPreviousCoOps, PayTransparency, Companies, Skills) values (2, 2, null, 'cursus', 'morbi a ipsum integer a');
insert into Student  (Year, NumPreviousCoOps, PayTransparency, Companies, Skills) values (2, 2, null, 'luctus tincidunt nulla mollis', 'consectetuer adipiscing');
insert into Student  (Year, NumPreviousCoOps, PayTransparency, Companies, Skills) values (2, 3, null, 'vel', 'tempor turpis nec');
insert into Student  (Year, NumPreviousCoOps, PayTransparency, Companies, Skills) values (2, 3, null, 'id ornare', 'pede');
insert into Student  (Year, NumPreviousCoOps, PayTransparency, Companies, Skills) values (1, null, null, 'vitae', 'vestibulum proin eu');
insert into Student  (Year, NumPreviousCoOps, PayTransparency, Companies, Skills) values (3, null, null, 'justo pellentesque', 'dolor sit amet');
insert into Student  (Year, NumPreviousCoOps, PayTransparency, Companies, Skills) values (2, 2, false, 'pede justo lacinia eget', 'felis sed');
insert into Student  (Year, NumPreviousCoOps, PayTransparency, Companies, Skills) values (1, 3, null, 'feugiat et eros vestibulum', 'nullam varius nulla');
insert into Student  (Year, NumPreviousCoOps, PayTransparency, Companies, Skills) values (3, null, null, 'ut', 'magna at nunc commodo');
insert into Student  (Year, NumPreviousCoOps, PayTransparency, Companies, Skills) values (4, null, null, 'erat curabitur', 'erat eros viverra eget');
insert into Student  (Year, NumPreviousCoOps, PayTransparency, Companies, Skills) values (3, 3, null, 'volutpat convallis', 'sit amet sapien');
insert into Student  (Year, NumPreviousCoOps, PayTransparency, Companies, Skills) values (4, 1, null, 'adipiscing molestie', 'lorem integer tincidunt');
insert into Student  (Year, NumPreviousCoOps, PayTransparency, Companies, Skills) values (2, 4, true, 'eleifend', 'quam a odio in hac');
insert into Student  (Year, NumPreviousCoOps, PayTransparency, Companies, Skills) values (1, 4, true, 'etiam vel augue', 'felis fusce posuere felis');


insert into Faculty (ClassesTaught, Skills) values ('proin', 'mauris laoreet ut');
insert into Faculty (ClassesTaught, Skills) values ('', 'luctus rutrum nulla');
insert into Faculty (ClassesTaught, Skills) values ('et ultrices posuere', 'vestibulum ante');
insert into Faculty (ClassesTaught, Skills) values ('vel sem', 'quis tortor');
insert into Faculty (ClassesTaught, Skills) values ('pellentesque ultrices phasellus', 'duis ac nibh');
insert into Faculty (ClassesTaught, Skills) values ('est quam pharetra magna', 'leo odio');
insert into Faculty (ClassesTaught, Skills) values ('vulputate justo', 'platea');
insert into Faculty (ClassesTaught, Skills) values ('quisque id', 'eu');
insert into Faculty (ClassesTaught, Skills) values ('', 'erat');
insert into Faculty (ClassesTaught, Skills) values ('enim in tempor', 'lacus morbi');
insert into Faculty (ClassesTaught, Skills) values ('', 'justo aliquam quis turpis eget');
insert into Faculty (ClassesTaught, Skills) values ('quam sollicitudin', 'eget vulputate ut ultrices');
insert into Faculty (ClassesTaught, Skills) values ('suscipit ligula in', 'semper');
insert into Faculty (ClassesTaught, Skills) values ('vestibulum', 'sit amet eleifend pede');
insert into Faculty (ClassesTaught, Skills) values ('dui vel nisl', 'bibendum');
insert into Faculty (ClassesTaught, Skills) values ('nibh quisque id', 'morbi');
insert into Faculty (ClassesTaught, Skills) values ('odio', 'sagittis dui vel nisl duis');
insert into Faculty (ClassesTaught, Skills) values ('', 'et ultrices');
insert into Faculty (ClassesTaught, Skills) values ('sapien', 'odio justo sollicitudin ut');
insert into Faculty (ClassesTaught, Skills) values ('id massa', 'fusce congue diam id');
insert into Faculty (ClassesTaught, Skills) values ('vitae quam', 'porttitor id consequat in');
insert into Faculty (ClassesTaught, Skills) values ('', 'ut blandit non interdum in');
insert into Faculty (ClassesTaught, Skills) values ('elit proin risus praesent lectus', 'vel augue vestibulum');
insert into Faculty (ClassesTaught, Skills) values ('sapien urna pretium nisl ut', 'venenatis');
insert into Faculty (ClassesTaught, Skills) values ('blandit', 'morbi ut odio cras mi');
insert into Faculty (ClassesTaught, Skills) values ('orci luctus et ultrices posuere', 'donec semper sapien a');
insert into Faculty (ClassesTaught, Skills) values ('mauris', 'tortor duis mattis egestas');
insert into Faculty (ClassesTaught, Skills) values ('platea dictumst maecenas ut', 'rutrum rutrum neque aenean auctor');
insert into Faculty (ClassesTaught, Skills) values ('odio odio', 'ut massa quis augue luctus');
insert into Faculty (ClassesTaught, Skills) values ('mattis', 'sodales scelerisque');
insert into Faculty (ClassesTaught, Skills) values ('', 'nulla');
insert into Faculty (ClassesTaught, Skills) values ('quam', 'convallis duis consequat');
insert into Faculty (ClassesTaught, Skills) values ('sodales sed tincidunt', 'volutpat quam pede');
insert into Faculty (ClassesTaught, Skills) values ('eleifend donec', 'habitasse platea dictumst maecenas ut');
insert into Faculty (ClassesTaught, Skills) values ('in leo maecenas pulvinar lobortis', 'augue quam sollicitudin');
insert into Faculty (ClassesTaught, Skills) values ('id pretium', 'ultrices erat tortor');
insert into Faculty (ClassesTaught, Skills) values ('turpis elementum ligula vehicula', 'eros suspendisse accumsan');
insert into Faculty (ClassesTaught, Skills) values ('curae donec pharetra', 'et tempus');
insert into Faculty (ClassesTaught, Skills) values ('eu tincidunt in leo maecenas', 'cubilia curae mauris viverra');
insert into Faculty (ClassesTaught, Skills) values ('aenean', 'proin eu mi');
insert into Faculty (ClassesTaught, Skills) values ('rutrum rutrum neque', 'dui');
insert into Faculty (ClassesTaught, Skills) values ('id turpis integer aliquet massa', 'lobortis vel');
insert into Faculty (ClassesTaught, Skills) values ('nulla ut erat id', 'dignissim vestibulum vestibulum ante ipsum');
insert into Faculty (ClassesTaught, Skills) values ('in quis justo maecenas', 'enim in tempor');
insert into Faculty (ClassesTaught, Skills) values ('sem', 'commodo placerat');
insert into Faculty (ClassesTaught, Skills) values ('amet sapien dignissim', 'aliquet maecenas leo odio');
insert into Faculty (ClassesTaught, Skills) values ('quis lectus suspendisse potenti', 'consequat');
insert into Faculty (ClassesTaught, Skills) values ('tempor', 'nullam sit');
insert into Faculty (ClassesTaught, Skills) values ('elit sodales', 'ut erat');
insert into Faculty (ClassesTaught, Skills) values ('in congue', 'risus auctor');

insert into Company (CompanyName, CompanyDescription) values ('Avaveo', 'id luctus');
insert into Company (CompanyName, CompanyDescription) values ('Divanoodle', null);
insert into Company (CompanyName, CompanyDescription) values ('Agivu', 'natoque penatibus');
insert into Company (CompanyName, CompanyDescription) values ('Reallinks', null);
insert into Company (CompanyName, CompanyDescription) values ('Kimia', null);
insert into Company (CompanyName, CompanyDescription) values ('Flashset', 'ipsum integer');
insert into Company (CompanyName, CompanyDescription) values ('Zoomzone', 'amet eros suspendisse accumsan tortor');
insert into Company (CompanyName, CompanyDescription) values ('Zoomcast', 'orci nullam molestie');
insert into Company (CompanyName, CompanyDescription) values ('Browsedrive', 'ipsum integer');
insert into Company (CompanyName, CompanyDescription) values ('Muxo', 'justo morbi ut');
insert into Company (CompanyName, CompanyDescription) values ('Linkbuzz', 'at feugiat non');
insert into Company (CompanyName, CompanyDescription) values ('Kimia', 'quis odio consequat varius integer');
insert into Company (CompanyName, CompanyDescription) values ('Tagopia', 'placerat');
insert into Company (CompanyName, CompanyDescription) values ('Gabcube', null);
insert into Company (CompanyName, CompanyDescription) values ('Katz', 'sapien iaculis');
insert into Company (CompanyName, CompanyDescription) values ('Riffpedia', 'ultrices phasellus id sapien in');
insert into Company (CompanyName, CompanyDescription) values ('Twimm', null);
insert into Company (CompanyName, CompanyDescription) values ('Rhybox', null);
insert into Company (CompanyName, CompanyDescription) values ('Meeveo', 'pede libero quis');
insert into Company (CompanyName, CompanyDescription) values ('Fiveclub', null);
insert into Company (CompanyName, CompanyDescription) values ('Agimba', 'vel nisl duis');
insert into Company (CompanyName, CompanyDescription) values ('Blogtags', 'integer pede justo lacinia eget');
insert into Company (CompanyName, CompanyDescription) values ('Gabvine', 'proin leo odio porttitor');
insert into Company (CompanyName, CompanyDescription) values ('Edgeify', 'aliquam sit');
insert into Company (CompanyName, CompanyDescription) values ('Edgeify', 'pellentesque at');
insert into Company (CompanyName, CompanyDescription) values ('Skiba', 'posuere cubilia');
insert into Company (CompanyName, CompanyDescription) values ('Centizu', 'nullam sit amet turpis elementum');
insert into Company (CompanyName, CompanyDescription) values ('Aimbo', 'vel augue vestibulum rutrum rutrum');
insert into Company (CompanyName, CompanyDescription) values ('Browseblab', 'phasellus id sapien in');
insert into Company (CompanyName, CompanyDescription) values ('Brainbox', 'at nulla');
insert into Company (CompanyName, CompanyDescription) values ('Kimia', 'et ultrices posuere cubilia');
insert into Company (CompanyName, CompanyDescription) values ('Centizu', 'nisl duis bibendum felis');
insert into Company (CompanyName, CompanyDescription) values ('Fivechat', null);
insert into Company (CompanyName, CompanyDescription) values ('Linklinks', null);
insert into Company (CompanyName, CompanyDescription) values ('Yacero', 'nullam porttitor');
insert into Company (CompanyName, CompanyDescription) values ('Browsetype', 'vulputate vitae nisl aenean');
insert into Company (CompanyName, CompanyDescription) values ('Realcube', 'sed ante');
insert into Company (CompanyName, CompanyDescription) values ('Realfire', 'risus auctor sed');
insert into Company (CompanyName, CompanyDescription) values ('Skimia', 'vel');
insert into Company (CompanyName, CompanyDescription) values ('Blogspan', 'sapien non mi');
insert into Company (CompanyName, CompanyDescription) values ('Skajo', 'nisl duis ac nibh');
insert into Company (CompanyName, CompanyDescription) values ('Tagopia', null);
insert into Company (CompanyName, CompanyDescription) values ('Midel', 'mi');
insert into Company (CompanyName, CompanyDescription) values ('Zoonder', 'cubilia');
insert into Company (CompanyName, CompanyDescription) values ('Rhynyx', null);
insert into Company (CompanyName, CompanyDescription) values ('Vidoo', null);
insert into Company (CompanyName, CompanyDescription) values ('Realblab', 'enim lorem ipsum');
insert into Company (CompanyName, CompanyDescription) values ('Topiczoom', 'in imperdiet et');
insert into Company (CompanyName, CompanyDescription) values ('Babbleset', 'in est risus auctor sed');
insert into Company (CompanyName, CompanyDescription) values ('Flashpoint', null);


insert into Employer (TechnicalSkills, GPARequired, SoftSkills, PayOffered, CompanyID) values ('augue quam sollicitudin vitae consectetuer', null, 'PFEP', null, 1);
insert into Employer (TechnicalSkills, GPARequired, SoftSkills, PayOffered, CompanyID) values ('ipsum integer a nibh', null, null, null, 2);
insert into Employer (TechnicalSkills, GPARequired, SoftSkills, PayOffered, CompanyID) values (null, null, null, true, 3);
insert into Employer (TechnicalSkills, GPARequired, SoftSkills, PayOffered, CompanyID) values ('leo rhoncus sed', 2.49, 'Bash', null, 4);
insert into Employer (TechnicalSkills, GPARequired, SoftSkills, PayOffered, CompanyID) values ('platea dictumst morbi', 1.35, 'IT Service Management', true, 5);
insert into Employer (TechnicalSkills, GPARequired, SoftSkills, PayOffered, CompanyID) values ('quam suspendisse potenti nullam porttitor', 3.95, null, null, 6);
insert into Employer (TechnicalSkills, GPARequired, SoftSkills, PayOffered, CompanyID) values (null, 1.73, null, false, 7);
insert into Employer (TechnicalSkills, GPARequired, SoftSkills, PayOffered, CompanyID) values ('mi pede malesuada in', null, 'Grievances', null, 8);
insert into Employer (TechnicalSkills, GPARequired, SoftSkills, PayOffered, CompanyID) values ('dictumst etiam faucibus cursus', 3.69, null, true, 9);
insert into Employer (TechnicalSkills, GPARequired, SoftSkills, PayOffered, CompanyID) values (null, 2.31, null, null, 10);
insert into Employer (TechnicalSkills, GPARequired, SoftSkills, PayOffered, CompanyID) values ('dictumst aliquam augue', 1.58, 'PWA', true, 11);
insert into Employer (TechnicalSkills, GPARequired, SoftSkills, PayOffered, CompanyID) values (null, 3.39, 'Thermodynamics', null, 12);
insert into Employer (TechnicalSkills, GPARequired, SoftSkills, PayOffered, CompanyID) values ('interdum venenatis', 2.02, 'NRP Instruction', false, 13);
insert into Employer (TechnicalSkills, GPARequired, SoftSkills, PayOffered, CompanyID) values ('ut odio cras mi', null, 'CBOT', true, 14);
insert into Employer (TechnicalSkills, GPARequired, SoftSkills, PayOffered, CompanyID) values ('ligula vehicula', 4.0, null, null, 15);
insert into Employer (TechnicalSkills, GPARequired, SoftSkills, PayOffered, CompanyID) values ('velit nec nisi vulputate nonummy', 2.36, 'World War II', true, 16);
insert into Employer (TechnicalSkills, GPARequired, SoftSkills, PayOffered, CompanyID) values (null, null, 'vRanger', true, 17);
insert into Employer (TechnicalSkills, GPARequired, SoftSkills, PayOffered, CompanyID) values ('odio consequat varius integer ac', 2.73, 'ESB', false, 18);
insert into Employer (TechnicalSkills, GPARequired, SoftSkills, PayOffered, CompanyID) values ('tellus', null, 'Short Sales', false, 19);
insert into Employer (TechnicalSkills, GPARequired, SoftSkills, PayOffered, CompanyID) values ('nec euismod scelerisque quam', 1.33, 'Teacher Training', false, 20);
insert into Employer (TechnicalSkills, GPARequired, SoftSkills, PayOffered, CompanyID) values ('lacinia aenean', 1.86, 'GSA Contracting', false, 21);
insert into Employer (TechnicalSkills, GPARequired, SoftSkills, PayOffered, CompanyID) values ('amet sem', 2.43, null, null, 22);
insert into Employer (TechnicalSkills, GPARequired, SoftSkills, PayOffered, CompanyID) values (null, 1.35, null, false, 23);
insert into Employer (TechnicalSkills, GPARequired, SoftSkills, PayOffered, CompanyID) values (null, 2.9, 'WFO', null, 24);
insert into Employer (TechnicalSkills, GPARequired, SoftSkills, PayOffered, CompanyID) values ('habitasse platea dictumst morbi vestibulum', 2.95, null, null, 25);
insert into Employer (TechnicalSkills, GPARequired, SoftSkills, PayOffered, CompanyID) values ('ipsum dolor sit amet', 3.09, null, null, 26);
insert into Employer (TechnicalSkills, GPARequired, SoftSkills, PayOffered, CompanyID) values ('dis parturient', 3.76, 'Xactly Incent', false, 27);
insert into Employer (TechnicalSkills, GPARequired, SoftSkills, PayOffered, CompanyID) values ('quis justo maecenas rhoncus aliquam', 1.4, 'KPI Implementation', true, 28);
insert into Employer (TechnicalSkills, GPARequired, SoftSkills, PayOffered, CompanyID) values (null, 3.94, 'Xactly', null, 29);
insert into Employer (TechnicalSkills, GPARequired, SoftSkills, PayOffered, CompanyID) values ('condimentum neque sapien placerat ante', 2.09, 'GSLC', false, 30);
insert into Employer (TechnicalSkills, GPARequired, SoftSkills, PayOffered, CompanyID) values ('orci', 3.52, 'Hudson', null, 31);
insert into Employer (TechnicalSkills, GPARequired, SoftSkills, PayOffered, CompanyID) values ('volutpat quam pede lobortis', 3.04, null, null, 32);
insert into Employer (TechnicalSkills, GPARequired, SoftSkills, PayOffered, CompanyID) values ('eleifend', 2.98, 'LLBLGen Pro', null, 33);
insert into Employer (TechnicalSkills, GPARequired, SoftSkills, PayOffered, CompanyID) values (null, 1.75, 'Salesforce.com', true, 34);
insert into Employer (TechnicalSkills, GPARequired, SoftSkills, PayOffered, CompanyID) values (null, null, 'BMC Remedy', null, 35);
insert into Employer (TechnicalSkills, GPARequired, SoftSkills, PayOffered, CompanyID) values ('tincidunt', 2.03, 'Luxury Goods', null, 36);
insert into Employer (TechnicalSkills, GPARequired, SoftSkills, PayOffered, CompanyID) values ('in hac habitasse platea dictumst', null, 'R&amp;TTE', null, 37);
insert into Employer (TechnicalSkills, GPARequired, SoftSkills, PayOffered, CompanyID) values ('semper', null, 'Procurement Outsourcing', null, 38);
insert into Employer (TechnicalSkills, GPARequired, SoftSkills, PayOffered, CompanyID) values ('felis sed interdum venenatis turpis', 2.05, 'Runway', null, 39);
insert into Employer (TechnicalSkills, GPARequired, SoftSkills, PayOffered, CompanyID) values (null, null, 'Ion', null, 40);
insert into Employer (TechnicalSkills, GPARequired, SoftSkills, PayOffered, CompanyID) values ('sed ante vivamus', 1.66, 'OJEU', null, 41);
insert into Employer (TechnicalSkills, GPARequired, SoftSkills, PayOffered, CompanyID) values ('vivamus tortor duis', 2.17, 'JMP', null, 42);
insert into Employer (TechnicalSkills, GPARequired, SoftSkills, PayOffered, CompanyID) values ('cras', 3.53, null, null, 43);
insert into Employer (TechnicalSkills, GPARequired, SoftSkills, PayOffered, CompanyID) values (null, 1.18, 'NCPDP', null, 44);
insert into Employer (TechnicalSkills, GPARequired, SoftSkills, PayOffered, CompanyID) values ('fusce', 1.79, 'Algorithms', null, 45);
insert into Employer (TechnicalSkills, GPARequired, SoftSkills, PayOffered, CompanyID) values (null, 1.74, 'Sales Presentations', null, 46);
insert into Employer (TechnicalSkills, GPARequired, SoftSkills, PayOffered, CompanyID) values ('eleifend pede', 2.99, 'Product Knowledge', null, 47);
insert into Employer (TechnicalSkills, GPARequired, SoftSkills, PayOffered, CompanyID) values ('risus dapibus', 3.3, 'International Logistics', null, 48);
insert into Employer (TechnicalSkills, GPARequired, SoftSkills, PayOffered, CompanyID) values ('cursus urna', 2.79, 'Class III Medical Devices', null, 49);
insert into Employer (TechnicalSkills, GPARequired, SoftSkills, PayOffered, CompanyID) values ('enim lorem ipsum', 3.98, 'WebLogic', null, 50);

INSERT INTO User_Type (UserID, StuID, FacID, EmpID) VALUES (1, 1, NULL, NULL);
INSERT INTO User_Type (UserID, StuID, FacID, EmpID) VALUES (2, NULL, 2, NULL);
INSERT INTO User_Type (UserID, StuID, FacID, EmpID) VALUES (3, NULL, 3, NULL);
INSERT INTO User_Type (UserID, StuID, FacID, EmpID) VALUES (4, 4, NULL, NULL);
INSERT INTO User_Type (UserID, StuID, FacID, EmpID) VALUES (5, NULL, 5, NULL);
INSERT INTO User_Type (UserID, StuID, FacID, EmpID) VALUES (6, NULL, NULL, 6);
INSERT INTO User_Type (UserID, StuID, FacID, EmpID) VALUES (7, 7, NULL, NULL);
INSERT INTO User_Type (UserID, StuID, FacID, EmpID) VALUES (8, NULL, NULL, 8);
INSERT INTO User_Type (UserID, StuID, FacID, EmpID) VALUES (9, NULL, NULL, 9);
INSERT INTO User_Type (UserID, StuID, FacID, EmpID) VALUES (10, NULL, NULL, 10);
INSERT INTO User_Type (UserID, StuID, FacID, EmpID) VALUES (11, NULL, NULL, 11);
INSERT INTO User_Type (UserID, StuID, FacID, EmpID) VALUES (12, NULL, 12, NULL);
INSERT INTO User_Type (UserID, StuID, FacID, EmpID) VALUES (13, 13, NULL, NULL);
INSERT INTO User_Type (UserID, StuID, FacID, EmpID) VALUES (14, NULL, 14, NULL);
INSERT INTO User_Type (UserID, StuID, FacID, EmpID) VALUES (15, NULL, 15, NULL);
INSERT INTO User_Type (UserID, StuID, FacID, EmpID) VALUES (16, NULL, 16, NULL);
INSERT INTO User_Type (UserID, StuID, FacID, EmpID) VALUES (17, NULL, NULL, 17);
INSERT INTO User_Type (UserID, StuID, FacID, EmpID) VALUES (18, NULL, NULL, 18);
INSERT INTO User_Type (UserID, StuID, FacID, EmpID) VALUES (19, NULL, NULL, 19);
INSERT INTO User_Type (UserID, StuID, FacID, EmpID) VALUES (20, 20, NULL, NULL);
INSERT INTO User_Type (UserID, StuID, FacID, EmpID) VALUES (21, 21, NULL, NULL);
INSERT INTO User_Type (UserID, StuID, FacID, EmpID) VALUES (22, NULL, NULL, 22);
INSERT INTO User_Type (UserID, StuID, FacID, EmpID) VALUES (23, NULL, NULL, 23);
INSERT INTO User_Type (UserID, StuID, FacID, EmpID) VALUES (24, NULL, NULL, 24);
INSERT INTO User_Type (UserID, StuID, FacID, EmpID) VALUES (25, 25, NULL, NULL);
INSERT INTO User_Type (UserID, StuID, FacID, EmpID) VALUES (26, NULL, 26, NULL);
INSERT INTO User_Type (UserID, StuID, FacID, EmpID) VALUES (27, NULL, 27, NULL);
INSERT INTO User_Type (UserID, StuID, FacID, EmpID) VALUES (28, NULL, NULL, 28);
INSERT INTO User_Type (UserID, StuID, FacID, EmpID) VALUES (29, NULL, NULL, 29);
INSERT INTO User_Type (UserID, StuID, FacID, EmpID) VALUES (30, NULL, NULL, 30);





insert into SupportTickets  (UserID, Category, Active, Text, Urgency) values (1, null, 1, 'curae duis faucibus accumsan odio', 2);
insert into SupportTickets  (UserID, Category, Active, Text, Urgency) values (2, 'Speech Pathologist', null, 'morbi ut odio', 2);
insert into SupportTickets  (UserID, Category, Active, Text, Urgency) values (3, 'Paralegal', 3, 'nam congue risus semper', 3);
insert into SupportTickets  (UserID, Category, Active, Text, Urgency) values (4, 'Associate Professor', 4, 'aliquet ultrices', 3);
insert into SupportTickets  (UserID, Category, Active, Text, Urgency) values (5, 'Geological Engineer', null, 'quisque id justo sit amet sapien dignissim vestibulum vestibulum', 3);
insert into SupportTickets  (UserID, Category, Active, Text, Urgency) values (6, 'Information Systems Manager', 6, 'lacinia aenean sit amet justo morbi', 1);
insert into SupportTickets  (UserID, Category, Active, Text, Urgency) values (7, 'Associate Professor', 7, 'tortor risus dapibus augue vel accumsan', 1);
insert into SupportTickets  (UserID, Category, Active, Text, Urgency) values (8, 'Physical Therapy Assistant', 8, 'posuere felis sed lacus', 1);
insert into SupportTickets  (UserID, Category, Active, Text, Urgency) values (9, 'Media Manager I', null, 'dolor sit', 2);
insert into SupportTickets  (UserID, Category, Active, Text, Urgency) values (10, 'Staff Scientist', 10, 'sapien dignissim vestibulum vestibulum ante ipsum primis', 3);
insert into SupportTickets  (UserID, Category, Active, Text, Urgency) values (11, 'VP Accounting', 11, 'nullam varius nulla facilisi', 3);
insert into SupportTickets  (UserID, Category, Active, Text, Urgency) values (12, 'Help Desk Operator', 12, 'porttitor pede justo eu massa donec dapibus', 2);
insert into SupportTickets  (UserID, Category, Active, Text, Urgency) values (13, null, 13, 'dui vel', 1);
insert into SupportTickets  (UserID, Category, Active, Text, Urgency) values (14, 'Registered Nurse', 14, 'sit amet turpis elementum ligula vehicula consequat', 3);
insert into SupportTickets  (UserID, Category, Active, Text, Urgency) values (15, 'Junior Executive', 15, 'amet nulla quisque arcu libero', 3);
insert into SupportTickets  (UserID, Category, Active, Text, Urgency) values (16, 'Executive Secretary', null, 'quisque id justo sit amet sapien', 3);
insert into SupportTickets  (UserID, Category, Active, Text, Urgency) values (17, null, 17, 'vitae mattis', 3);
insert into SupportTickets  (UserID, Category, Active, Text, Urgency) values (18, 'VP Sales', 18, 'primis in faucibus orci luctus et ultrices posuere cubilia', 1);
insert into SupportTickets  (UserID, Category, Active, Text, Urgency) values (19, 'Accountant IV', 19, 'purus aliquet at', 3);
insert into SupportTickets  (UserID, Category, Active, Text, Urgency) values (20, null, 20, 'sed lacus morbi sem', 3);
insert into SupportTickets  (UserID, Category, Active, Text, Urgency) values (21, 'Director of Sales', 21, 'sapien dignissim vestibulum', 1);
insert into SupportTickets  (UserID, Category, Active, Text, Urgency) values (22, 'Recruiter', 22, 'libero', 1);
insert into SupportTickets  (UserID, Category, Active, Text, Urgency) values (23, null, 23, 'vitae quam suspendisse potenti nullam porttitor lacus at', 2);
insert into SupportTickets  (UserID, Category, Active, Text, Urgency) values (24, null, 24, 'primis in faucibus orci luctus et ultrices posuere cubilia', 2);
insert into SupportTickets  (UserID, Category, Active, Text, Urgency) values (25, null, 25, 'volutpat eleifend donec ut dolor morbi', 2);
insert into SupportTickets  (UserID, Category, Active, Text, Urgency) values (26, 'Analog Circuit Design manager', 26, 'curae mauris viverra diam vitae', 3);
insert into SupportTickets  (UserID, Category, Active, Text, Urgency) values (27, null, 27, 'erat id mauris vulputate elementum', 3);
insert into SupportTickets  (UserID, Category, Active, Text, Urgency) values (28, null, 28, 'lacus morbi sem mauris laoreet ut rhoncus aliquet pulvinar sed', 1);
insert into SupportTickets  (UserID, Category, Active, Text, Urgency) values (29, null, null, 'ultrices', 3);
insert into SupportTickets  (UserID, Category, Active, Text, Urgency) values (30, null, 30, 'turpis enim blandit mi in porttitor pede justo', 2);
insert into SupportTickets  (UserID, Category, Active, Text, Urgency) values (31, 'Account Representative IV', null, 'blandit non interdum in ante vestibulum', 2);
insert into SupportTickets  (UserID, Category, Active, Text, Urgency) values (32, 'Geological Engineer', null, 'id ligula suspendisse ornare consequat lectus in est risus auctor', 1);
insert into SupportTickets  (UserID, Category, Active, Text, Urgency) values (33, null, 33, 'magnis dis parturient', 1);
insert into SupportTickets  (UserID, Category, Active, Text, Urgency) values (34, 'Civil Engineer', 34, 'pretium quis lectus suspendisse potenti', 3);
insert into SupportTickets  (UserID, Category, Active, Text, Urgency) values (35, null, null, 'habitasse platea dictumst morbi vestibulum velit', 1);
insert into SupportTickets  (UserID, Category, Active, Text, Urgency) values (36, 'VP Marketing', null, 'hac habitasse platea dictumst etiam faucibus cursus urna ut tellus', 3);
insert into SupportTickets  (UserID, Category, Active, Text, Urgency) values (37, null, 37, 'nunc commodo placerat praesent', 3);
insert into SupportTickets  (UserID, Category, Active, Text, Urgency) values (38, null, 38, 'ac neque duis bibendum morbi non quam nec', 2);
insert into SupportTickets  (UserID, Category, Active, Text, Urgency) values (39, null, 39, 'eu', 2);
insert into SupportTickets  (UserID, Category, Active, Text, Urgency) values (40, null, 40, 'felis eu sapien cursus', 1);
insert into SupportTickets  (UserID, Category, Active, Text, Urgency) values (41, 'Office Assistant IV', 41, 'id lobortis convallis tortor risus dapibus', 3);
insert into SupportTickets  (UserID, Category, Active, Text, Urgency) values (42, 'Web Developer II', null, 'volutpat erat quisque', 1);
insert into SupportTickets  (UserID, Category, Active, Text, Urgency) values (43, 'Electrical Engineer', 43, 'eleifend donec ut dolor morbi vel lectus', 3);
insert into SupportTickets  (UserID, Category, Active, Text, Urgency) values (44, null, 44, 'cubilia curae donec pharetra magna vestibulum aliquet', 3);
insert into SupportTickets  (UserID, Category, Active, Text, Urgency) values (45, null, 45, 'etiam', 1);
insert into SupportTickets  (UserID, Category, Active, Text, Urgency) values (46, null, 46, 'cras non velit nec nisi vulputate nonummy', 2);
insert into SupportTickets  (UserID, Category, Active, Text, Urgency) values (47, 'Health Coach III', 47, 'ultrices posuere cubilia curae mauris viverra diam', 3);
insert into SupportTickets  (UserID, Category, Active, Text, Urgency) values (48, null, 48, 'aliquam erat', 1);
insert into SupportTickets  (UserID, Category, Active, Text, Urgency) values (49, null, null, 'turpis', 1);
insert into SupportTickets  (UserID, Category, Active, Text, Urgency) values (50, null, 50, 'at velit vivamus vel nulla eget eros elementum pellentesque quisque', 1);

INSERT INTO Job_Postings (Text, SalaryRange, GPA_Range, Location, Deadline, Experience_Level) 
VALUES ('quisque ut erat curabitur gravida nisi at nibh in hac', 498, 2.37, 'Mexico', '2024-01-31', 1);
INSERT INTO Job_Postings (Text, SalaryRange, GPA_Range, Location, Deadline, Experience_Level) 
VALUES ('turpis integer aliquet massa id lobortis convallis tortor risus dapibus', 95, 1.85, 'Indonesia', '2024-11-12', 9);
INSERT INTO Job_Postings (Text, SalaryRange, GPA_Range, Location, Deadline, Experience_Level) 
VALUES ('elit proin interdum mauris non ligula pellentesque ultrices phasellus', null, 2.23, 'Brazil', '2024-11-28', null);
INSERT INTO Job_Postings (Text, SalaryRange, GPA_Range, Location, Deadline, Experience_Level) 
VALUES ('volutpat quam pede', 226, 3.43, 'Indonesia', '2024-03-18', 6);
INSERT INTO Job_Postings (Text, SalaryRange, GPA_Range, Location, Deadline, Experience_Level) 
VALUES ('sapien', 250, 3.79, 'Colombia', '2024-05-27', 1);
INSERT INTO Job_Postings (Text, SalaryRange, GPA_Range, Location, Deadline, Experience_Level) 
VALUES ('id ligula suspendisse ornare consequat lectus in est risus auctor', null, 2.78, 'Poland', '2024-07-18', 8);
INSERT INTO Job_Postings (Text, SalaryRange, GPA_Range, Location, Deadline, Experience_Level) 
VALUES ('platea dictumst morbi vestibulum velit id pretium iaculis', null, 3.64, 'China', '2024-11-26', 3);
INSERT INTO Job_Postings (Text, SalaryRange, GPA_Range, Location, Deadline, Experience_Level) 
VALUES ('luctus cum', 81, 1.56, 'Panama', '2024-09-22', 8);
INSERT INTO Job_Postings (Text, SalaryRange, GPA_Range, Location, Deadline, Experience_Level) 
VALUES ('vestibulum quam sapien varius', null, 3.76, 'Dominican Republic', '2024-02-24', 9);
INSERT INTO Job_Postings (Text, SalaryRange, GPA_Range, Location, Deadline, Experience_Level) 
VALUES ('sapien ut nunc vestibulum ante ipsum primis', 419, 2.82, 'Czech Republic', '2024-05-11', 1);
INSERT INTO Job_Postings (Text, SalaryRange, GPA_Range, Location, Deadline, Experience_Level) 
VALUES ('consectetuer eget', null, 2.21, 'Ethiopia', '2024-09-05', 3);
INSERT INTO Job_Postings (Text, SalaryRange, GPA_Range, Location, Deadline, Experience_Level) 
VALUES ('auctor gravida sem praesent id massa id nisl venenatis lacinia', 28, 2.13, 'Russia', '2024-01-22', null);
INSERT INTO Job_Postings (Text, SalaryRange, GPA_Range, Location, Deadline, Experience_Level) 
VALUES ('nullam sit amet turpis', 48, 3.8, 'China', '2024-05-25', 3);
INSERT INTO Job_Postings (Text, SalaryRange, GPA_Range, Location, Deadline, Experience_Level) 
VALUES ('elit sodales scelerisque', null, 1.52, 'Indonesia', '2023-12-03', 2);
INSERT INTO Job_Postings (Text, SalaryRange, GPA_Range, Location, Deadline, Experience_Level) 
VALUES ('morbi sem mauris laoreet ut rhoncus aliquet pulvinar sed nisl', 422, 1.06, 'Georgia', '2024-05-23', 6);
INSERT INTO Job_Postings (Text, SalaryRange, GPA_Range, Location, Deadline, Experience_Level) 
VALUES ('accumsan tortor quis turpis sed ante vivamus tortor duis mattis', 60, 2.07, 'Indonesia', '2024-11-29', 6);
INSERT INTO Job_Postings (Text, SalaryRange, GPA_Range, Location, Deadline, Experience_Level) 
VALUES ('nec nisi volutpat eleifend donec ut dolor morbi', null, 2.48, 'Israel', '2024-03-29', 7);
INSERT INTO Job_Postings (Text, SalaryRange, GPA_Range, Location, Deadline, Experience_Level) 
VALUES ('quis orci nullam molestie nibh in', 406, 2.96, 'France', '2023-12-10', 4);
INSERT INTO Job_Postings (Text, SalaryRange, GPA_Range, Location, Deadline, Experience_Level) 
VALUES ('quis', null, 3.34, 'Tajikistan', '2024-10-22', 8);
INSERT INTO Job_Postings (Text, SalaryRange, GPA_Range, Location, Deadline, Experience_Level) 
VALUES ('ut erat curabitur gravida nisi at', null, 1.27, 'Portugal', '2024-04-10', 1);

insert into Interactions  (Type, ToUserID, FromUserID, Subject, Text, JobPostingID, Resume) values ('tellus', null, 1, 'vel est', 'nisl aenean lectus pellentesque eget nunc donec quis orci eget orci vehicula condimentum', null, 'Psychotherapy');
insert into Interactions  (Type, ToUserID, FromUserID, Subject, Text, JobPostingID, Resume) values ('ultrices posuere', null, 2, 'est phasellus', 'ultrices posuere cubilia curae duis faucibus accumsan odio curabitur convallis duis consequat dui', null, 'Toyota Production System');
insert into Interactions  (Type, ToUserID, FromUserID, Subject, Text, JobPostingID, Resume) values ('laoreet ut', null, 3, 'quis', 'vel augue', null, 'JVs');
insert into Interactions  (Type, ToUserID, FromUserID, Subject, Text, JobPostingID, Resume) values ('nam', 4, 4, 'in ante vestibulum', 'augue vel accumsan tellus nisi eu orci mauris lacinia sapien', null, 'Recombinant DNA');
insert into Interactions  (Type, ToUserID, FromUserID, Subject, Text, JobPostingID, Resume) values ('nulla quisque', 5, 5, 'id consequat in consequat', 'convallis', null, 'PFMEA');
insert into Interactions  (Type, ToUserID, FromUserID, Subject, Text, JobPostingID, Resume) values ('rutrum nulla', null, 6, 'nec nisi vulputate', 'neque duis bibendum morbi non quam nec dui luctus rutrum nulla tellus', null, 'TV Production');
insert into Interactions  (Type, ToUserID, FromUserID, Subject, Text, JobPostingID, Resume) values ('id', 7, 7, 'praesent id massa id nisl', 'metus sapien ut nunc vestibulum', null, 'TPT');
insert into Interactions  (Type, ToUserID, FromUserID, Subject, Text, JobPostingID, Resume) values ('mauris', 8, 8, 'nunc proin at turpis a', 'amet eleifend pede libero quis orci nullam molestie', null, 'Quality Patient Care');
insert into Interactions  (Type, ToUserID, FromUserID, Subject, Text, JobPostingID, Resume) values ('posuere', null, 9, 'felis ut at', 'lacus curabitur at ipsum ac tellus semper interdum mauris ullamcorper purus', 9, 'Shopping Centers');
insert into Interactions  (Type, ToUserID, FromUserID, Subject, Text, JobPostingID, Resume) values ('praesent lectus', 10, 10, 'quam fringilla rhoncus', 'erat eros viverra eget congue eget semper rutrum nulla nunc purus', null, null);
insert into Interactions  (Type, ToUserID, FromUserID, Subject, Text, JobPostingID, Resume) values ('habitasse platea', null, 11, 'elit', 'primis', 11, null);
insert into Interactions  (Type, ToUserID, FromUserID, Subject, Text, JobPostingID, Resume) values ('a ipsum', 12, 12, 'nonummy integer', 'aenean fermentum donec', null, null);
insert into Interactions  (Type, ToUserID, FromUserID, Subject, Text, JobPostingID, Resume) values ('in', 13, 13, 'lacus at turpis', 'ac lobortis vel dapibus at diam nam tristique tortor', null, 'Ocular Disease');
insert into Interactions  (Type, ToUserID, FromUserID, Subject, Text, JobPostingID, Resume) values ('lectus', 14, 14, 'duis bibendum', 'leo maecenas pulvinar lobortis est phasellus sit amet erat nulla tempus vivamus', null, 'Galleries');
insert into Interactions  (Type, ToUserID, FromUserID, Subject, Text, JobPostingID, Resume) values ('lectus pellentesque', 15, 15, 'suscipit ligula in', 'sed vel enim sit amet nunc', 15, 'GC-MS');
insert into Interactions  (Type, ToUserID, FromUserID, Subject, Text, JobPostingID, Resume) values ('duis', 16, 16, 'ut erat id mauris vulputate', 'molestie', 16, null);
insert into Interactions  (Type, ToUserID, FromUserID, Subject, Text, JobPostingID, Resume) values ('aliquam lacus', null, 17, 'felis fusce posuere', 'quam suspendisse potenti nullam', null, 'RF Systems');
insert into Interactions  (Type, ToUserID, FromUserID, Subject, Text, JobPostingID, Resume) values ('vivamus', null, 18, 'fusce congue diam id ornare', 'montes nascetur ridiculus mus etiam vel augue vestibulum rutrum rutrum neque aenean auctor gravida', null, null);
insert into Interactions  (Type, ToUserID, FromUserID, Subject, Text, JobPostingID, Resume) values ('ac leo', 19, 19, 'risus praesent lectus vestibulum quam', 'vestibulum vestibulum ante ipsum primis in faucibus orci', null, 'IBM Content Manager');
insert into Interactions  (Type, ToUserID, FromUserID, Subject, Text, JobPostingID, Resume) values ('ut erat', null, 20, 'nisl venenatis', 'pellentesque volutpat dui maecenas tristique', null, null);
insert into Interactions  (Type, ToUserID, FromUserID, Subject, Text, JobPostingID, Resume) values ('vestibulum sagittis', 21, 21, 'risus dapibus augue vel accumsan', 'tincidunt eu felis fusce posuere felis sed lacus morbi sem mauris laoreet ut rhoncus aliquet', 21, null);
insert into Interactions  (Type, ToUserID, FromUserID, Subject, Text, JobPostingID, Resume) values ('ipsum dolor', null, 22, 'nulla', 'consequat in consequat ut nulla sed accumsan felis ut at dolor quis', 22, 'ESL');
insert into Interactions  (Type, ToUserID, FromUserID, Subject, Text, JobPostingID, Resume) values ('ac', null, 23, 'est quam pharetra magna', 'aliquam erat volutpat in congue etiam justo etiam pretium iaculis justo', null, null);
insert into Interactions  (Type, ToUserID, FromUserID, Subject, Text, JobPostingID, Resume) values ('interdum', 24, 24, 'quis turpis eget elit', 'pretium iaculis diam erat fermentum justo nec condimentum neque sapien placerat ante nulla', null, null);
insert into Interactions  (Type, ToUserID, FromUserID, Subject, Text, JobPostingID, Resume) values ('cras non', 25, 25, 'non lectus aliquam sit', 'id nulla ultrices aliquet', null, null);
insert into Interactions  (Type, ToUserID, FromUserID, Subject, Text, JobPostingID, Resume) values ('ipsum', null, 26, 'magna ac consequat', 'orci pede venenatis non sodales sed tincidunt eu felis fusce posuere felis sed', 26, null);
insert into Interactions  (Type, ToUserID, FromUserID, Subject, Text, JobPostingID, Resume) values ('eu est', null, 27, 'non mauris', 'tincidunt in leo maecenas', null, 'Aesthetic Surgery');
insert into Interactions  (Type, ToUserID, FromUserID, Subject, Text, JobPostingID, Resume) values ('pede', 28, 28, 'eros elementum pellentesque quisque porta', 'amet consectetuer adipiscing elit proin risus praesent lectus vestibulum quam sapien varius', null, null);
insert into Interactions  (Type, ToUserID, FromUserID, Subject, Text, JobPostingID, Resume) values ('praesent id', 29, 29, 'dolor quis', 'et commodo', null, null);
insert into Interactions  (Type, ToUserID, FromUserID, Subject, Text, JobPostingID, Resume) values ('in', 30, 30, 'odio', 'rhoncus aliquet pulvinar sed nisl nunc rhoncus', null, null);
insert into Interactions  (Type, ToUserID, FromUserID, Subject, Text, JobPostingID, Resume) values ('dis', 31, 31, 'justo', 'vulputate nonummy maecenas tincidunt lacus at velit vivamus vel', null, 'DDR3');
insert into Interactions  (Type, ToUserID, FromUserID, Subject, Text, JobPostingID, Resume) values ('platea dictumst', null, 32, 'sapien varius ut blandit', 'venenatis turpis enim blandit', null, null);
insert into Interactions  (Type, ToUserID, FromUserID, Subject, Text, JobPostingID, Resume) values ('amet', 33, 33, 'magna at nunc commodo', 'nisl nunc nisl duis bibendum felis sed interdum venenatis turpis enim blandit mi', null, null);
insert into Interactions  (Type, ToUserID, FromUserID, Subject, Text, JobPostingID, Resume) values ('lobortis convallis', null, 34, 'sapien non', 'est risus', null, 'Offshore Oil &amp; Gas');
insert into Interactions  (Type, ToUserID, FromUserID, Subject, Text, JobPostingID, Resume) values ('ac nibh', 35, 35, 'eget eros elementum', 'sem', 35, null);
insert into Interactions  (Type, ToUserID, FromUserID, Subject, Text, JobPostingID, Resume) values ('vulputate', null, 36, 'quisque erat eros viverra', 'blandit non interdum in ante vestibulum ante ipsum', null, 'TMMi');
insert into Interactions  (Type, ToUserID, FromUserID, Subject, Text, JobPostingID, Resume) values ('curabitur', null, 37, 'adipiscing lorem vitae mattis', 'ornare consequat lectus in est risus auctor sed tristique in', null, 'Financial Accounting');
insert into Interactions  (Type, ToUserID, FromUserID, Subject, Text, JobPostingID, Resume) values ('id lobortis', 38, 38, 'tincidunt', 'tincidunt eget tempus vel pede morbi porttitor', 38, 'Zines');
insert into Interactions  (Type, ToUserID, FromUserID, Subject, Text, JobPostingID, Resume) values ('elit', 39, 39, 'libero', 'nibh quisque id justo sit amet sapien', null, 'CPOE');
insert into Interactions  (Type, ToUserID, FromUserID, Subject, Text, JobPostingID, Resume) values ('arcu sed', null, 40, 'platea dictumst', 'convallis nunc proin at turpis a pede posuere nonummy integer non velit donec diam neque', null, 'WPS');
insert into Interactions  (Type, ToUserID, FromUserID, Subject, Text, JobPostingID, Resume) values ('sapien cum', null, 41, 'ligula', 'primis in faucibus orci luctus et ultrices posuere cubilia curae mauris', 41, null);
insert into Interactions  (Type, ToUserID, FromUserID, Subject, Text, JobPostingID, Resume) values ('orci vehicula', null, 42, 'nisi venenatis tristique fusce congue', 'orci nullam molestie nibh in lectus pellentesque at nulla suspendisse', 42, null);
insert into Interactions  (Type, ToUserID, FromUserID, Subject, Text, JobPostingID, Resume) values ('quis turpis', 43, 43, 'primis in faucibus orci luctus', 'ut ultrices vel augue vestibulum ante ipsum primis in faucibus orci', 43, 'DFMA');
insert into Interactions  (Type, ToUserID, FromUserID, Subject, Text, JobPostingID, Resume) values ('odio cras', 44, 44, 'eu sapien cursus', 'id ornare imperdiet sapien urna pretium nisl ut', 44, null);
insert into Interactions  (Type, ToUserID, FromUserID, Subject, Text, JobPostingID, Resume) values ('platea dictumst', null, 45, 'eget', 'auctor gravida sem praesent id massa id nisl venenatis lacinia aenean', 45, 'Gifts');
insert into Interactions  (Type, ToUserID, FromUserID, Subject, Text, JobPostingID, Resume) values ('erat', null, 46, 'amet lobortis', 'ultrices aliquet maecenas leo', 46, 'RHEV');
insert into Interactions  (Type, ToUserID, FromUserID, Subject, Text, JobPostingID, Resume) values ('rutrum', null, 47, 'dignissim vestibulum', 'pede lobortis ligula sit amet eleifend pede libero quis orci nullam molestie nibh', null, 'Pediatrics');
insert into Interactions  (Type, ToUserID, FromUserID, Subject, Text, JobPostingID, Resume) values ('ipsum primis', null, 48, 'molestie sed justo pellentesque', 'sapien quis libero nullam sit amet', 48, null);
insert into Interactions  (Type, ToUserID, FromUserID, Subject, Text, JobPostingID, Resume) values ('ac tellus', null, 49, 'lorem quisque ut erat', 'elementum eu interdum eu tincidunt in leo maecenas pulvinar lobortis est phasellus sit amet erat', null, 'Affordable Housing');
insert into Interactions  (Type, ToUserID, FromUserID, Subject, Text, JobPostingID, Resume) values ('id', 50, 50, 'suspendisse', 'risus praesent lectus vestibulum quam sapien', 50, null);

insert into Contact (Name, Phone, Email) values ('vestibulum velit', '298-328-2781', 'mheadrick0@rediff.com');
insert into Contact (Name, Phone, Email) values ('faucibus orci', null, null);
insert into Contact (Name, Phone, Email) values ('amet', '317-554-4656', 'smandre2@ucla.edu');
insert into Contact (Name, Phone, Email) values ('congue etiam', null, 'jmuge3@patch.com');
insert into Contact (Name, Phone, Email) values ('integer', null, 'amccarrick4@meetup.com');
insert into Contact (Name, Phone, Email) values ('vel', '896-580-4872', 'tmcilory5@seesaa.net');
insert into Contact (Name, Phone, Email) values ('eu', '971-356-6372', 'mswinburn6@abc.net.au');
insert into Contact (Name, Phone, Email) values ('sed accumsan', '107-509-9578', 'mdignon7@tripadvisor.com');
insert into Contact (Name, Phone, Email) values ('tempus semper', null, 'smerrall8@tmall.com');
insert into Contact (Name, Phone, Email) values ('tempus', '155-780-9004', null);
insert into Contact (Name, Phone, Email) values ('iaculis', '687-151-9817', 'rrustmana@epa.gov');
insert into Contact (Name, Phone, Email) values ('sapien cum', null, null);
insert into Contact (Name, Phone, Email) values ('vivamus vestibulum', '676-791-7021', 'adossantosc@vk.com');
insert into Contact (Name, Phone, Email) values ('congue diam', '297-251-0412', 'ccapelind@arstechnica.com');
insert into Contact (Name, Phone, Email) values ('lobortis', '823-675-5718', 'dcombere@psu.edu');
insert into Contact (Name, Phone, Email) values ('mattis', '831-720-3629', 'bvanderhoevenf@admin.ch');
insert into Contact (Name, Phone, Email) values ('lectus vestibulum', null, 'idemongeotg@constantcontact.com');
insert into Contact (Name, Phone, Email) values ('quis', '298-144-9614', null);
insert into Contact (Name, Phone, Email) values ('feugiat et', null, 'dmalloyi@samsung.com');
insert into Contact (Name, Phone, Email) values ('ultrices enim', '372-586-7493', 'cbenniej@ox.ac.uk');
insert into Contact (Name, Phone, Email) values ('convallis', '744-737-2429', 'dmaestrok@webmd.com');
insert into Contact (Name, Phone, Email) values ('libero nam', null, 'pashurstl@goo.gl');
insert into Contact (Name, Phone, Email) values ('erat', '143-999-5563', 'cricardetm@nba.com');
insert into Contact (Name, Phone, Email) values ('nisi venenatis', null, null);
insert into Contact (Name, Phone, Email) values ('sapien', '102-770-8623', 'blanglando@mlb.com');
insert into Contact (Name, Phone, Email) values ('erat', null, 'aflowerdewp@berkeley.edu');
insert into Contact (Name, Phone, Email) values ('justo etiam', null, null);
insert into Contact (Name, Phone, Email) values ('tincidunt ante', null, 'ldabourner@nymag.com');
insert into Contact (Name, Phone, Email) values ('diam nam', '485-909-7962', 'lserrelss@home.pl');
insert into Contact (Name, Phone, Email) values ('lacinia eget', '814-583-7474', 'rnavant@dropbox.com');
insert into Contact (Name, Phone, Email) values ('elementum ligula', null, 'fhammarbergu@moonfruit.com');
insert into Contact (Name, Phone, Email) values ('libero', '432-445-7893', 'jdonavanv@answers.com');
insert into Contact (Name, Phone, Email) values ('eget', '239-698-2158', 'oriseboroughw@zdnet.com');
insert into Contact (Name, Phone, Email) values ('est', '299-187-9231', 'agowmanx@smh.com.au');
insert into Contact (Name, Phone, Email) values ('vel', null, 'rbuery@baidu.com');
insert into Contact (Name, Phone, Email) values ('quam pede', null, null);
insert into Contact (Name, Phone, Email) values ('ullamcorper augue', '360-542-8617', null);
insert into Contact (Name, Phone, Email) values ('lacinia aenean', '237-999-1160', 'agyrgorcewicx11@technorati.com');
insert into Contact (Name, Phone, Email) values ('pellentesque volutpat', '304-291-9441', null);
insert into Contact (Name, Phone, Email) values ('ante ipsum', '531-225-9714', 'mriatt13@about.com');
insert into Contact (Name, Phone, Email) values ('tortor sollicitudin', null, 'kruncie14@wired.com');
insert into Contact (Name, Phone, Email) values ('in hac', '168-564-1123', 'dpoulson15@reddit.com');
insert into Contact (Name, Phone, Email) values ('volutpat', '346-388-4879', 'mfalks16@histats.com');
insert into Contact (Name, Phone, Email) values ('molestie lorem', '735-619-7384', 'egourlie17@amazon.de');
insert into Contact (Name, Phone, Email) values ('morbi', '978-576-6129', 'nmcdougald18@zimbio.com');
insert into Contact (Name, Phone, Email) values ('ligula nec', '776-984-2331', 'kthrussell19@java.com');
insert into Contact (Name, Phone, Email) values ('tortor quis', '670-213-1241', 'lvilla1a@hc360.com');
insert into Contact (Name, Phone, Email) values ('cras pellentesque', '637-278-0549', 'lcattenach1b@wordpress.org');
insert into Contact (Name, Phone, Email) values ('donec', null, 'zlalonde1c@eepurl.com');
insert into Contact (Name, Phone, Email) values ('consectetuer', null, 'runstead1d@cargocollective.com');

insert into Industry (Name, NUCollege) values ('urna ut', 'nibh in');
insert into Industry (Name, NUCollege) values ('etiam justo', null);
insert into Industry (Name, NUCollege) values ('tellus nisi', 'in');
insert into Industry (Name, NUCollege) values ('augue', 'ut tellus');
insert into Industry (Name, NUCollege) values ('ut erat', null);
insert into Industry (Name, NUCollege) values ('sapien a', null);
insert into Industry (Name, NUCollege) values ('enim leo', 'vel');
insert into Industry (Name, NUCollege) values ('turpis nec', null);
insert into Industry (Name, NUCollege) values ('sed', null);
insert into Industry (Name, NUCollege) values ('platea', null);
insert into Industry (Name, NUCollege) values ('congue eget', null);
insert into Industry (Name, NUCollege) values ('lobortis vel', 'luctus et');
insert into Industry (Name, NUCollege) values ('ac diam', null);
insert into Industry (Name, NUCollege) values ('volutpat', null);
insert into Industry (Name, NUCollege) values ('quis odio', 'a');
insert into Industry (Name, NUCollege) values ('maecenas tristique', 'dolor quis');
insert into Industry (Name, NUCollege) values ('etiam', null);
insert into Industry (Name, NUCollege) values ('porta', null);
insert into Industry (Name, NUCollege) values ('ac neque', 'donec');
insert into Industry (Name, NUCollege) values ('nullam', 'bibendum');
insert into Industry (Name, NUCollege) values ('velit nec', 'scelerisque');
insert into Industry (Name, NUCollege) values ('orci', 'quam');
insert into Industry (Name, NUCollege) values ('id nulla', 'faucibus accumsan');
insert into Industry (Name, NUCollege) values ('nulla nisl', 'posuere');
insert into Industry (Name, NUCollege) values ('vitae', 'posuere metus');
insert into Industry (Name, NUCollege) values ('gravida', 'sem praesent');
insert into Industry (Name, NUCollege) values ('massa', 'consectetuer adipiscing');
insert into Industry (Name, NUCollege) values ('ultrices', 'proin');
insert into Industry (Name, NUCollege) values ('consequat', null);
insert into Industry (Name, NUCollege) values ('amet lobortis', null);
insert into Industry (Name, NUCollege) values ('vel enim', null);
insert into Industry (Name, NUCollege) values ('nunc', 'at ipsum');
insert into Industry (Name, NUCollege) values ('pulvinar', null);
insert into Industry (Name, NUCollege) values ('tristique in', null);
insert into Industry (Name, NUCollege) values ('sed interdum', 'mattis');
insert into Industry (Name, NUCollege) values ('vestibulum', 'ultrices posuere');
insert into Industry (Name, NUCollege) values ('lacus at', null);
insert into Industry (Name, NUCollege) values ('accumsan', 'dis parturient');
insert into Industry (Name, NUCollege) values ('tortor sollicitudin', null);
insert into Industry (Name, NUCollege) values ('morbi', null);
insert into Industry (Name, NUCollege) values ('vitae mattis', 'sed vestibulum');
insert into Industry (Name, NUCollege) values ('sapien', 'purus');
insert into Industry (Name, NUCollege) values ('quam', 'in');
insert into Industry (Name, NUCollege) values ('molestie nibh', 'velit eu');
insert into Industry (Name, NUCollege) values ('consequat dui', 'auctor');
insert into Industry (Name, NUCollege) values ('convallis nunc', 'arcu adipiscing');
insert into Industry (Name, NUCollege) values ('erat', 'molestie');
insert into Industry (Name, NUCollege) values ('orci', 'quam fringilla');
insert into Industry (Name, NUCollege) values ('augue', 'vestibulum ante');
insert into Industry (Name, NUCollege) values ('ornare', 'morbi non');

insert into User_Industry (UserID, IndustryID) values (1, 1);
insert into User_Industry (UserID, IndustryID) values (2, 2);
insert into User_Industry (UserID, IndustryID) values (3, 3);
insert into User_Industry (UserID, IndustryID) values (4, 4);
insert into User_Industry (UserID, IndustryID) values (5, 5);
insert into User_Industry (UserID, IndustryID) values (6, 6);
insert into User_Industry (UserID, IndustryID) values (7, 7);
insert into User_Industry (UserID, IndustryID) values (8, 8);
insert into User_Industry (UserID, IndustryID) values (9, 9);
insert into User_Industry (UserID, IndustryID) values (10, 10);
insert into User_Industry (UserID, IndustryID) values (11, 11);
insert into User_Industry (UserID, IndustryID) values (12, 12);
insert into User_Industry (UserID, IndustryID) values (13, 13);
insert into User_Industry (UserID, IndustryID) values (14, 14);
insert into User_Industry (UserID, IndustryID) values (15, 15);
insert into User_Industry (UserID, IndustryID) values (16, 16);
insert into User_Industry (UserID, IndustryID) values (17, 17);
insert into User_Industry (UserID, IndustryID) values (18, 18);
insert into User_Industry (UserID, IndustryID) values (19, 19);
insert into User_Industry (UserID, IndustryID) values (20, 20);
insert into User_Industry (UserID, IndustryID) values (21, 21);
insert into User_Industry (UserID, IndustryID) values (22, 22);
insert into User_Industry (UserID, IndustryID) values (23, 23);
insert into User_Industry (UserID, IndustryID) values (24, 24);
insert into User_Industry (UserID, IndustryID) values (25, 25);
insert into User_Industry (UserID, IndustryID) values (26, 26);
insert into User_Industry (UserID, IndustryID) values (27, 27);
insert into User_Industry (UserID, IndustryID) values (28, 28);
insert into User_Industry (UserID, IndustryID) values (29, 29);
insert into User_Industry (UserID, IndustryID) values (30, 30);
insert into User_Industry (UserID, IndustryID) values (31, 31);
insert into User_Industry (UserID, IndustryID) values (32, 32);
insert into User_Industry (UserID, IndustryID) values (33, 33);
insert into User_Industry (UserID, IndustryID) values (34, 34);
insert into User_Industry (UserID, IndustryID) values (35, 35);
insert into User_Industry (UserID, IndustryID) values (36, 36);
insert into User_Industry (UserID, IndustryID) values (37, 37);
insert into User_Industry (UserID, IndustryID) values (38, 38);
insert into User_Industry (UserID, IndustryID) values (39, 39);
insert into User_Industry (UserID, IndustryID) values (40, 40);
insert into User_Industry (UserID, IndustryID) values (41, 41);
insert into User_Industry (UserID, IndustryID) values (42, 42);
insert into User_Industry (UserID, IndustryID) values (43, 43);
insert into User_Industry (UserID, IndustryID) values (44, 44);
insert into User_Industry (UserID, IndustryID) values (45, 45);
insert into User_Industry (UserID, IndustryID) values (46, 46);
insert into User_Industry (UserID, IndustryID) values (47, 47);
insert into User_Industry (UserID, IndustryID) values (48, 48);
insert into User_Industry (UserID, IndustryID) values (49, 49);
insert into User_Industry (UserID, IndustryID) values (50, 50);

SELECT *
From Student;