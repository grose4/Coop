DROP DATABASE IF EXISTS finalpart2;
CREATE DATABASE finalpart2;
USE finalpart2;


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
    Location VARCHAR(40) NOT NULL,
    Name VARCHAR(40) NOT NULL,
    Age INT NOT NULL,
    Bio VARCHAR(300) NOT NULL,
    ReferredBy INT,
    Online BOOLEAN DEFAULT FALSE,
    Admin BOOLEAN DEFAULT FALSE
);

CREATE TABLE Notifications (
    NotifID INT AUTO_INCREMENT PRIMARY KEY,
    CreatedBy INT NOT NULL,
    Text TEXT,
    Active BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (CreatedBy) REFERENCES Users(UserID)
);



CREATE TABLE Student (
    StuID INT AUTO_INCREMENT PRIMARY KEY,
    Year INT NOT NULL,
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
    UserID INT NOT NULL,
    StartedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    Category VARCHAR(100),
    RespondedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP NOT NULL,
    Active BOOLEAN DEFAULT FALSE,
    Text VARCHAR(500) NOT NULL,
    Urgency INT NOT NULL,
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);

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
    Name VARCHAR(50) NOT NULL,
    Phone VARCHAR(20),
    Email VARCHAR(50),
    FOREIGN KEY (ContactID) REFERENCES Users(UserID)
);

CREATE TABLE Industry (
    IndustryID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(40) NOT NULL,
    NUCollege VARCHAR(50)
);

CREATE TABLE User_Industry (
    UserID INT,
    IndustryID INT,
    PRIMARY KEY (UserID, IndustryID),
    FOREIGN KEY (UserID) REFERENCES Users(UserID),
    FOREIGN KEY (IndustryID) REFERENCES Industry(IndustryID)
);


-- FAKE DATA -- 

insert into Users  (UserID, Occupation, Location, Email, Name, Age, Bio, ReferredBy) values (1, 'Staff Scientist', 'China', 'ofaustin0@phpbb.com', 'trist0', 97, 'fringilla rhoncus mauris enim leo rhoncus sed vestibulum sit amet cursus', 21);
insert into Users  (UserID, Occupation, Location, Email, Name, Age, Bio, ReferredBy) values (2, 'Computer Systems Analyst IV', 'Angola', 'nniven1@google.ru', 'aashcroft1', 70, 'consequat varius integer ac leo pellentesque ultrices mattis odio donec', 22);
insert into Users  (UserID, Occupation, Location, Email, Name, Age, Bio, ReferredBy) values (3, 'Teacher', 'Portugal', 'cgiacobilio2@storify.com', 'egiacoppo2', 7, 'magnis dis parturient montes nascetur ridiculus mus etiam vel augue vestibulum', 35);
insert into Users  (UserID, Occupation, Location, Email, Name, Age, Bio, ReferredBy) values (4, 'Data Coordinator', 'Mexico', 'jashbrook3@umich.edu', 'rtenbrug3', 92, 'sit amet', null);
insert into Users  (UserID, Occupation, Location, Email, Name, Age, Bio, ReferredBy) values (5, 'Community Outreach Specialist', 'Ukraine', 'ainmett4@bing.com', 'kpriestland4', 54, 'ullamcorper augue a', 38);
insert into Users  (UserID, Occupation, Location, Email, Name, Age, Bio, ReferredBy) values (6, 'Systems Administrator I', 'Brazil', 'fsellack5@sphinn.com', 'gwoodfin5', 27, 'morbi', null);
insert into Users  (UserID, Occupation, Location, Email, Name, Age, Bio, ReferredBy) values (7, 'Office Assistant II', 'Finland', 'sadame6@issuu.com', 'maizkovitch6', 57, 'praesent blandit lacinia erat vestibulum sed magna at nunc', 13);
insert into Users  (UserID, Occupation, Location, Email, Name, Age, Bio, ReferredBy) values (8, 'VP Quality Control', 'China', 'styas7@diigo.com', 'mglewe7', 55, 'amet nulla quisque arcu libero rutrum ac lobortis vel dapibus', null);
insert into Users  (UserID, Occupation, Location, Email, Name, Age, Bio, ReferredBy) values (9, 'Electrical Engineer', 'Slovenia', 'mkillick8@newyorker.com', 'kmingaud8', 56, 'ut volutpat sapien arcu sed augue aliquam', 54);
insert into Users  (UserID, Occupation, Location, Email, Name, Age, Bio, ReferredBy) values (10, 'Environmental Specialist', 'Greece', 'hmycock9@google.com.br', 'bstrachan9', 97, 'felis ut at dolor quis odio consequat', null);
insert into Users  (UserID, Occupation, Location, Email, Name, Age, Bio, ReferredBy) values (11, 'Analog Circuit Design manager', 'Brazil', 'rsnodaya@sciencedirect.com', 'abarcrofta', 25, 'ut dolor', 29);
insert into Users  (UserID, Occupation, Location, Email, Name, Age, Bio, ReferredBy) values (12, 'Senior Sales Associate', 'Azerbaijan', 'cscarlanb@t.co', 'twitherbedb', 19, 'id consequat in consequat ut nulla sed accumsan felis', null);
insert into Users  (UserID, Occupation, Location, Email, Name, Age, Bio, ReferredBy) values (13, 'Speech Pathologist', 'Poland', 'sshubothamc@google.co.uk', 'cecobc', 30, 'etiam vel augue vestibulum rutrum rutrum neque aenean auctor gravida sem', 33);
insert into Users  (UserID, Occupation, Location, Email, Name, Age, Bio, ReferredBy) values (14, 'Payment Adjustment Coordinator', 'Micronesia', 'rreussd@mapy.cz', 'wiorid', 24, 'sociis natoque penatibus et magnis', null);
insert into Users  (UserID, Occupation, Location, Email, Name, Age, Bio, ReferredBy) values (15, 'Senior Quality Engineer', 'Indonesia', 'mstatherse@opera.com', 'dcuncliffee', 57, 'justo in blandit ultrices enim', 61);
insert into Users  (UserID, Occupation, Location, Email, Name, Age, Bio, ReferredBy) values (16, 'Physical Therapy Assistant', 'Philippines', 'mmayhof@psu.edu', 'dmcnuttf', 6, 'placerat ante nulla justo aliquam quis turpis eget elit', 22);
insert into Users  (UserID, Occupation, Location, Email, Name, Age, Bio, ReferredBy) values (17, 'Senior Sales Associate', 'Philippines', 'bwhitingtong@huffingtonpost.com', 'jmonteithg', 93, 'quis orci', null);
insert into Users  (UserID, Occupation, Location, Email, Name, Age, Bio, ReferredBy) values (18, 'Programmer Analyst III', 'Tanzania', 'myurkevichh@oaic.gov.au', 'lcheneryh', 83, 'vulputate vitae nisl aenean lectus pellentesque eget nunc donec quis', null);
insert into Users  (UserID, Occupation, Location, Email, Name, Age, Bio, ReferredBy) values (19, 'Senior Sales Associate', 'China', 'apittendreighi@usda.gov', 'kcooli', 14, 'in faucibus orci luctus', null);
insert into Users  (UserID, Occupation, Location, Email, Name, Age, Bio, ReferredBy) values (20, 'Senior Editor', 'Indonesia', 'lwinkettj@scientificamerican.com', 'aertelj', 17, 'eget nunc donec quis orci eget', 30);
insert into Users  (UserID, Occupation, Location, Email, Name, Age, Bio, ReferredBy) values (21, 'Biostatistician IV', 'Philippines', 'acutridgek@theglobeandmail.com', 'gkenank', 59, 'nec euismod scelerisque quam', null);
insert into Users  (UserID, Occupation, Location, Email, Name, Age, Bio, ReferredBy) values (22, 'Media Manager IV', 'Indonesia', 'tcoppensl@surveymonkey.com', 'lkitcattl', 54, 'volutpat dui maecenas tristique est et', 63);
insert into Users  (UserID, Occupation, Location, Email, Name, Age, Bio, ReferredBy) values (23, 'Structural Engineer', 'Armenia', 'myssonm@vistaprint.com', 'jbenkinm', 76, 'blandit ultrices enim', null);
insert into Users  (UserID, Occupation, Location, Email, Name, Age, Bio, ReferredBy) values (24, 'Dental Hygienist', 'China', 'yyeelln@sogou.com', 'qyesinovn', 83, 'quam fringilla rhoncus mauris enim leo rhoncus sed vestibulum sit amet', null);
insert into Users  (UserID, Occupation, Location, Email, Name, Age, Bio, ReferredBy) values (25, 'Web Designer IV', 'United States', 'kdominyo@miibeian.gov.cn', 'agullamo', 9, 'sagittis nam congue risus semper porta volutpat quam pede lobortis ligula sit amet eleifend pede', 68);
insert into Users  (UserID, Occupation, Location, Email, Name, Age, Bio, ReferredBy) values (26, 'Speech Pathologist', 'China', 'jnixp@weibo.com', 'lallikerp', 60, 'ac consequat metus sapien', 16);
insert into Users  (UserID, Occupation, Location, Email, Name, Age, Bio, ReferredBy) values (27, 'Internal Auditor', 'Portugal', 'mbensonq@php.net', 'imccrostieq', 30, 'aenean sit amet justo morbi ut odio cras mi', 85);
insert into Users  (UserID, Occupation, Location, Email, Name, Age, Bio, ReferredBy) values (28, 'Marketing Manager', 'Philippines', 'hpassmanr@slate.com', 'slitzmannr', 14, 'pede morbi porttitor lorem id ligula suspendisse ornare consequat lectus', 70);
insert into Users  (UserID, Occupation, Location, Email, Name, Age, Bio, ReferredBy) values (29, 'Human Resources Manager', 'Egypt', 'mboyers@infoseek.co.jp', 'imenarys', 88, 'eros suspendisse accumsan tortor quis turpis sed ante vivamus tortor duis mattis egestas', 29);
insert into Users  (UserID, Occupation, Location, Email, Name, Age, Bio, ReferredBy) values (30, 'Account Representative I', 'Colombia', 'hmarshlandt@google.nl', 'pchithamt', 94, 'nisi vulputate nonummy maecenas tincidunt lacus at velit vivamus vel', 40);
insert into Users  (UserID, Occupation, Location, Email, Name, Age, Bio, ReferredBy) values (31, 'Data Coordinator', 'Thailand', 'plegionu@fastcompany.com', 'jlampetu', 57, 'pede lobortis ligula sit amet eleifend pede libero quis orci nullam molestie', 33);
insert into Users  (UserID, Occupation, Location, Email, Name, Age, Bio, ReferredBy) values (32, 'Business Systems Development Analyst', 'Indonesia', 'acrosbyv@jigsy.com', 'bcossarv', 60, 'in quis justo maecenas rhoncus aliquam lacus morbi quis tortor', 12);
insert into Users  (UserID, Occupation, Location, Email, Name, Age, Bio, ReferredBy) values (33, 'Teacher', 'Honduras', 'acopelandw@nsw.gov.au', 'awarretw', 70, 'in quis', 14);
insert into Users  (UserID, Occupation, Location, Email, Name, Age, Bio, ReferredBy) values (34, 'Recruiting Manager', 'China', 'rreinax@shop-pro.jp', 'gshielx', 93, 'aliquam erat volutpat in congue etiam justo etiam', 26);
insert into Users  (UserID, Occupation, Location, Email, Name, Age, Bio, ReferredBy) values (35, 'Geologist II', 'Indonesia', 'kpellery@blinklist.com', 'gbrainey', 76, 'sit amet lobortis sapien sapien non', 44);
insert into Users  (UserID, Occupation, Location, Email, Name, Age, Bio, ReferredBy) values (36, 'Senior Developer', 'Colombia', 'ylombardoz@gov.uk', 'lroadz', 99, 'at diam nam tristique tortor', null);
insert into Users  (UserID, Occupation, Location, Email, Name, Age, Bio, ReferredBy) values (37, 'Civil Engineer', 'Argentina', 'rwastell10@nature.com', 'jchettle10', 65, 'ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae mauris viverra diam', 81);
insert into Users  (UserID, Occupation, Location, Email, Name, Age, Bio, ReferredBy) values (38, 'VP Quality Control', 'Indonesia', 'ahassekl11@about.com', 'mjackes11', 40, 'adipiscing lorem vitae mattis', 98);
insert into Users  (UserID, Occupation, Location, Email, Name, Age, Bio, ReferredBy) values (39, 'Associate Professor', 'Philippines', 'pcostley12@livejournal.com', 'bbranthwaite12', 55, 'felis ut at dolor quis odio consequat varius integer ac leo pellentesque', 55);
insert into Users  (UserID, Occupation, Location, Email, Name, Age, Bio, ReferredBy) values (40, 'Software Test Engineer III', 'Indonesia', 'rjacomb13@virginia.edu', 'kmitchiner13', 63, 'eu orci', 38);
insert into Users  (UserID, Occupation, Location, Email, Name, Age, Bio, ReferredBy) values (41, 'Nuclear Power Engineer', 'Greece', 'ueingerfield14@google.co.uk', 'zmcart14', 4, 'suspendisse potenti cras in purus eu magna vulputate luctus cum sociis natoque', 47);
insert into Users  (UserID, Occupation, Location, Email, Name, Age, Bio, ReferredBy) values (42, 'Dental Hygienist', 'Japan', 'cstilgoe15@squarespace.com', 'splose15', 51, 'dui maecenas tristique est et tempus', null);
insert into Users  (UserID, Occupation, Location, Email, Name, Age, Bio, ReferredBy) values (43, 'Account Coordinator', 'China', 'rswinney16@dion.ne.jp', 'fcamus16', 28, 'vel pede', 72);
insert into Users  (UserID, Occupation, Location, Email, Name, Age, Bio, ReferredBy) values (44, 'Cost Accountant', 'China', 'whobben17@yelp.com', 'bstockow17', 63, 'arcu sed augue aliquam erat volutpat', null);
insert into Users  (UserID, Occupation, Location, Email, Name, Age, Bio, ReferredBy) values (45, 'Technical Writer', 'China', 'mhellwig18@tripadvisor.com', 'vscalera18', 47, 'odio condimentum id luctus nec', 97);
insert into Users  (UserID, Occupation, Location, Email, Name, Age, Bio, ReferredBy) values (46, 'Social Worker', 'China', 'vkopfen19@sphinn.com', 'rbeeke19', 9, 'pretium quis lectus suspendisse potenti in eleifend quam a odio in hac habitasse platea dictumst', null);
insert into Users  (UserID, Occupation, Location, Email, Name, Age, Bio, ReferredBy) values (47, 'Teacher', 'Ukraine', 'gstreak1a@webmd.com', 'fmcgrill1a', 31, 'ut erat curabitur gravida nisi at nibh in hac habitasse', 80);
insert into Users  (UserID, Occupation, Location, Email, Name, Age, Bio, ReferredBy) values (48, 'Occupational Therapist', 'Russia', 'lshillito1b@quantcast.com', 'mdrought1b', 95, 'praesent lectus vestibulum quam sapien varius ut blandit non interdum in ante vestibulum', 39);
insert into Users  (UserID, Occupation, Location, Email, Name, Age, Bio, ReferredBy) values (49, 'Accounting Assistant IV', 'China', 'bmclagan1c@illinois.edu', 'hwoolstenholmes1c', 69, 'diam in magna bibendum imperdiet', null);
insert into Users  (UserID, Occupation, Location, Email, Name, Age, Bio, ReferredBy) values (50, 'Safety Technician III', 'Israel', 'gbanasevich1d@wikipedia.org', 'mmacteggart1d', 45, 'sit amet lobortis sapien', null);
insert into Users  (UserID, Occupation, Location, Email, Name, Age, Bio, ReferredBy) values (51, 'Account Executive', 'China', 'nashmore1e@ycombinator.com', 'fshallcrass1e', 44, 'eget orci vehicula condimentum curabitur in libero ut massa volutpat', null);
insert into Users  (UserID, Occupation, Location, Email, Name, Age, Bio, ReferredBy) values (52, 'Physical Therapy Assistant', 'Cuba', 'abosward1f@artisteer.com', 'edibden1f', 5, 'volutpat sapien arcu sed augue aliquam erat volutpat in congue etiam justo', 79);
insert into Users  (UserID, Occupation, Location, Email, Name, Age, Bio, ReferredBy) values (53, 'Research Associate', 'China', 'rbrody1g@spiegel.de', 'krossin1g', 68, 'vestibulum sagittis', 22);
insert into Users  (UserID, Occupation, Location, Email, Name, Age, Bio, ReferredBy) values (54, 'Senior Developer', 'Micronesia', 'jfalls1h@mapquest.com', 'hmuress1h', 80, 'viverra dapibus nulla suscipit ligula in lacus curabitur at ipsum ac tellus semper interdum', null);
insert into Users  (UserID, Occupation, Location, Email, Name, Age, Bio, ReferredBy) values (55, 'Social Worker', 'Argentina', 'abartomeu1i@whitehouse.gov', 'ecollomosse1i', 58, 'in ante vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia', 21);
insert into Users  (UserID, Occupation, Location, Email, Name, Age, Bio, ReferredBy) values (56, 'Compensation Analyst', 'United States', 'oscipsey1j@g.co', 'lbougen1j', 93, 'elit sodales scelerisque mauris', 44);
insert into Users  (UserID, Occupation, Location, Email, Name, Age, Bio, ReferredBy) values (57, 'Quality Control Specialist', 'Iran', 'agosart1k@altervista.org', 'nmargrett1k', 4, 'sit amet consectetuer adipiscing elit proin interdum mauris non ligula pellentesque', 40);
insert into Users  (UserID, Occupation, Location, Email, Name, Age, Bio, ReferredBy) values (58, 'Administrative Assistant II', 'Philippines', 'ldayton1l@dmoz.org', 'lseignior1l', 48, 'morbi a ipsum integer a nibh in quis', 55);
insert into Users  (UserID, Occupation, Location, Email, Name, Age, Bio, ReferredBy) values (59, 'Senior Cost Accountant', 'Denmark', 'vwakely1m@netscape.com', 'caddison1m', 54, 'cras', 75);
insert into Users  (UserID, Occupation, Location, Email, Name, Age, Bio, ReferredBy) values (60, 'Physical Therapy Assistant', 'China', 'mbiddiss1n@exblog.jp', 'ggalpen1n', 17, 'neque duis bibendum morbi non quam nec dui luctus rutrum nulla tellus in', null);
insert into Users  (UserID, Occupation, Location, Email, Name, Age, Bio, ReferredBy) values (61, 'Software Consultant', 'China', 'ewetter1o@icq.com', 'kpettendrich1o', 60, 'vivamus tortor duis mattis egestas metus aenean fermentum donec ut mauris', 56);
insert into Users  (UserID, Occupation, Location, Email, Name, Age, Bio, ReferredBy) values (62, 'Staff Accountant IV', 'Panama', 'vbedding1p@hp.com', 'pfurmagier1p', 87, 'morbi', 1);
insert into Users  (UserID, Occupation, Location, Email, Name, Age, Bio, ReferredBy) values (63, 'Project Manager', 'Lithuania', 'atinner1q@rambler.ru', 'lblencowe1q', 92, 'sapien placerat ante nulla justo aliquam quis turpis eget elit sodales scelerisque mauris sit', 34);
insert into Users  (UserID, Occupation, Location, Email, Name, Age, Bio, ReferredBy) values (64, 'Mechanical Systems Engineer', 'China', 'wkrug1r@elegantthemes.com', 'lbasten1r', 95, 'dapibus augue vel accumsan tellus nisi eu orci mauris lacinia sapien', null);
insert into Users  (UserID, Occupation, Location, Email, Name, Age, Bio, ReferredBy) values (65, 'Web Designer III', 'Belarus', 'afrank1s@pinterest.com', 'mspuffard1s', 31, 'lorem quisque ut', null);
insert into Users  (UserID, Occupation, Location, Email, Name, Age, Bio, ReferredBy) values (66, 'Chemical Engineer', 'China', 'dneeson1t@umich.edu', 'eangelo1t', 47, 'sodales scelerisque mauris sit amet eros suspendisse accumsan tortor quis turpis sed ante vivamus tortor', null);
insert into Users  (UserID, Occupation, Location, Email, Name, Age, Bio, ReferredBy) values (67, 'Desktop Support Technician', 'Mexico', 'jculshaw1u@economist.com', 'jbresland1u', 82, 'turpis sed ante vivamus tortor duis mattis egestas metus aenean fermentum', null);
insert into Users  (UserID, Occupation, Location, Email, Name, Age, Bio, ReferredBy) values (68, 'Software Engineer IV', 'Chad', 'ibernakiewicz1v@privacy.gov.au', 'jgulland1v', 36, 'risus auctor sed tristique in tempus sit amet sem fusce', null);
insert into Users  (UserID, Occupation, Location, Email, Name, Age, Bio, ReferredBy) values (69, 'Senior Cost Accountant', 'Armenia', 'vshacklady1w@blogs.com', 'cmedcraft1w', 40, 'pede venenatis non sodales sed tincidunt eu felis fusce posuere felis sed', 18);
insert into Users  (UserID, Occupation, Location, Email, Name, Age, Bio, ReferredBy) values (70, 'Nurse', 'Russia', 'hpestricke1x@myspace.com', 'dclapston1x', 98, 'accumsan tortor quis turpis sed ante vivamus tortor duis mattis egestas', null);
insert into Users  (UserID, Occupation, Location, Email, Name, Age, Bio, ReferredBy) values (71, 'Community Outreach Specialist', 'China', 'rredborn1y@arstechnica.com', 'glibby1y', 15, 'dapibus dolor', null);
insert into Users  (UserID, Occupation, Location, Email, Name, Age, Bio, ReferredBy) values (72, 'Information Systems Manager', 'Estonia', 'kingles1z@ebay.com', 'rmachoste1z', 4, 'magna at nunc commodo placerat', null);
insert into Users  (UserID, Occupation, Location, Email, Name, Age, Bio, ReferredBy) values (73, 'Account Coordinator', 'Indonesia', 'cevill20@businesswire.com', 'ealeshkov20', 18, 'parturient montes nascetur ridiculus mus vivamus vestibulum sagittis sapien cum sociis natoque penatibus et magnis', null);
insert into Users  (UserID, Occupation, Location, Email, Name, Age, Bio, ReferredBy) values (74, 'Senior Editor', 'Greece', 'hburgoin21@princeton.edu', 'acolson21', 17, 'purus phasellus', null);
insert into Users  (UserID, Occupation, Location, Email, Name, Age, Bio, ReferredBy) values (75, 'Media Manager II', 'Indonesia', 'wmoxom22@cam.ac.uk', 'gbenford22', 19, 'sit amet cursus id turpis integer aliquet massa', null);

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

insert into User_Type (StuID, FacID, EmpID) values (1, null, null);
insert into User_Type (StuID, FacID, EmpID) values (null, 2, null);
insert into User_Type (StuID, FacID, EmpID) values (null, 3, 3);
insert into User_Type (StuID, FacID, EmpID) values (4, null, null);
insert into User_Type (StuID, FacID, EmpID) values (null, 5, null);
insert into User_Type (StuID, FacID, EmpID) values (6, null, 6);
insert into User_Type (StuID, FacID, EmpID) values (7, 7, null);
insert into User_Type (StuID, FacID, EmpID) values (null, 8, 8);
insert into User_Type (StuID, FacID, EmpID) values (9, 9, 9);
insert into User_Type (StuID, FacID, EmpID) values (10, 10, 10);
insert into User_Type (StuID, FacID, EmpID) values (11, 11, 11);
insert into User_Type (StuID, FacID, EmpID) values (null, 12, 12);
insert into User_Type (StuID, FacID, EmpID) values (13, null, null);
insert into User_Type (StuID, FacID, EmpID) values (null, 14, 14);
insert into User_Type (StuID, FacID, EmpID) values (null, 15, 15);
insert into User_Type (StuID, FacID, EmpID) values (null, 16, 16);
insert into User_Type (StuID, FacID, EmpID) values (null, null, 17);
insert into User_Type (StuID, FacID, EmpID) values (18, 18, 18);
insert into User_Type (StuID, FacID, EmpID) values (19, 19, null);
insert into User_Type (StuID, FacID, EmpID) values (20, null, 20);
insert into User_Type (StuID, FacID, EmpID) values (21, 21, 21);
insert into User_Type (StuID, FacID, EmpID) values (22, null, 22);
insert into User_Type (StuID, FacID, EmpID) values (23, 23, null);
insert into User_Type (StuID, FacID, EmpID) values (24, null, null);
insert into User_Type (StuID, FacID, EmpID) values (null, 25, null);
insert into User_Type (StuID, FacID, EmpID) values (null, 26, null);
insert into User_Type (StuID, FacID, EmpID) values (27, 27, 27);
insert into User_Type (StuID, FacID, EmpID) values (28, 28, 28);
insert into User_Type (StuID, FacID, EmpID) values (29, null, 29);
insert into User_Type (StuID, FacID, EmpID) values (null, 30, null);
insert into User_Type (StuID, FacID, EmpID) values (31, null, null);
insert into User_Type (StuID, FacID, EmpID) values (null, 32, null);
insert into User_Type (StuID, FacID, EmpID) values (null, 33, 33);
insert into User_Type (StuID, FacID, EmpID) values (34, 34, null);
insert into User_Type (StuID, FacID, EmpID) values (null, null, null);
insert into User_Type (StuID, FacID, EmpID) values (null, 36, null);
insert into User_Type (StuID, FacID, EmpID) values (37, null, 37);
insert into User_Type (StuID, FacID, EmpID) values (null, 38, 38);
insert into User_Type (StuID, FacID, EmpID) values (null, 39, 39);
insert into User_Type (StuID, FacID, EmpID) values (null, 40, 40);
insert into User_Type (StuID, FacID, EmpID) values (null, 41, 41);
insert into User_Type (StuID, FacID, EmpID) values (42, 42, null);
insert into User_Type (StuID, FacID, EmpID) values (43, 43, null);
insert into User_Type (StuID, FacID, EmpID) values (44, 44, null);
insert into User_Type (StuID, FacID, EmpID) values (45, 45, null);
insert into User_Type (StuID, FacID, EmpID) values (46, 46, null);
insert into User_Type (StuID, FacID, EmpID) values (47, null, 47);
insert into User_Type (StuID, FacID, EmpID) values (48, 48, 48);
insert into User_Type (StuID, FacID, EmpID) values (null, 49, 49);
insert into User_Type (StuID, FacID, EmpID) values (50, 50, 50);


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

insert into Job_Postings  (Text, SalaryRange, GPA_Range, Location, Deadline, Experience_Level) values ('quisque ut erat curabitur gravida nisi at nibh in hac', 498, 2.37, 'Mexico', '1/31/2024', 1);
insert into Job_Postings  (Text, SalaryRange, GPA_Range, Location, Deadline, Experience_Level) values ('turpis integer aliquet massa id lobortis convallis tortor risus dapibus', 95, 1.85, 'Indonesia', '11/12/2024', 9);
insert into Job_Postings  (Text, SalaryRange, GPA_Range, Location, Deadline, Experience_Level) values ('elit proin interdum mauris non ligula pellentesque ultrices phasellus', null, 2.23, 'Brazil', '11/28/2024', null);
insert into Job_Postings  (Text, SalaryRange, GPA_Range, Location, Deadline, Experience_Level) values ('volutpat quam pede', 226, 3.43, 'Indonesia', '3/18/2024', 6);
insert into Job_Postings  (Text, SalaryRange, GPA_Range, Location, Deadline, Experience_Level) values ('sapien', 250, 3.79, 'Colombia', '5/27/2024', 1);
insert into Job_Postings  (Text, SalaryRange, GPA_Range, Location, Deadline, Experience_Level) values ('id ligula suspendisse ornare consequat lectus in est risus auctor', null, 2.78, 'Poland', '7/18/2024', 8);
insert into Job_Postings  (Text, SalaryRange, GPA_Range, Location, Deadline, Experience_Level) values ('platea dictumst morbi vestibulum velit id pretium iaculis', null, 3.64, 'China', '11/26/2024', 3);
insert into Job_Postings  (Text, SalaryRange, GPA_Range, Location, Deadline, Experience_Level) values ('luctus cum', 81, 1.56, 'Panama', '9/22/2024', 8);
insert into Job_Postings  (Text, SalaryRange, GPA_Range, Location, Deadline, Experience_Level) values ('vestibulum quam sapien varius', null, 3.76, 'Dominican Republic', '2/24/2024', 9);
insert into Job_Postings  (Text, SalaryRange, GPA_Range, Location, Deadline, Experience_Level) values ('sapien ut nunc vestibulum ante ipsum primis', 419, 2.82, 'Czech Republic', '5/11/2024', 1);
insert into Job_Postings  (Text, SalaryRange, GPA_Range, Location, Deadline, Experience_Level) values ('consectetuer eget', null, 2.21, 'Ethiopia', '9/5/2024', 3);
insert into Job_Postings  (Text, SalaryRange, GPA_Range, Location, Deadline, Experience_Level) values ('auctor gravida sem praesent id massa id nisl venenatis lacinia', 28, 2.13, 'Russia', '1/22/2024', null);
insert into Job_Postings  (Text, SalaryRange, GPA_Range, Location, Deadline, Experience_Level) values ('nullam sit amet turpis', 48, 3.8, 'China', '5/25/2024', 3);
insert into Job_Postings  (Text, SalaryRange, GPA_Range, Location, Deadline, Experience_Level) values ('elit sodales scelerisque', null, 1.52, 'Indonesia', '12/3/2023', 2);
insert into Job_Postings  (Text, SalaryRange, GPA_Range, Location, Deadline, Experience_Level) values ('morbi sem mauris laoreet ut rhoncus aliquet pulvinar sed nisl', 422, 1.06, 'Georgia', '5/23/2024', 6);
insert into Job_Postings  (Text, SalaryRange, GPA_Range, Location, Deadline, Experience_Level) values ('accumsan tortor quis turpis sed ante vivamus tortor duis mattis', 60, 2.07, 'Indonesia', '11/29/2024', 6);
insert into Job_Postings  (Text, SalaryRange, GPA_Range, Location, Deadline, Experience_Level) values ('nec nisi volutpat eleifend donec ut dolor morbi', null, 2.48, 'Israel', '3/29/2024', 7);
insert into Job_Postings  (Text, SalaryRange, GPA_Range, Location, Deadline, Experience_Level) values ('quis orci nullam molestie nibh in', 406, 2.96, 'France', '12/10/2023', 4);
insert into Job_Postings  (Text, SalaryRange, GPA_Range, Location, Deadline, Experience_Level) values ('quis', null, 3.34, 'Tajikistan', '10/22/2024', 8);
insert into Job_Postings  (Text, SalaryRange, GPA_Range, Location, Deadline, Experience_Level) values ('ut erat curabitur gravida nisi at', null, 1.27, 'Portugal', '4/10/2024', 1);
insert into Job_Postings  (Text, SalaryRange, GPA_Range, Location, Deadline, Experience_Level) values ('donec ut dolor morbi vel lectus in', 265, 2.62, 'Ukraine', '3/3/2024', 4);
insert into Job_Postings  (Text, SalaryRange, GPA_Range, Location, Deadline, Experience_Level) values ('integer tincidunt ante vel', 159, 1.17, 'Russia', '8/17/2024', 6);
insert into Job_Postings  (Text, SalaryRange, GPA_Range, Location, Deadline, Experience_Level) values ('porta volutpat erat quisque erat eros', 77, 3.15, 'Yemen', '11/25/2024', null);
insert into Job_Postings  (Text, SalaryRange, GPA_Range, Location, Deadline, Experience_Level) values ('sem praesent id massa id nisl venenatis lacinia', 462, 3.7, 'South Korea', '1/17/2024', 3);
insert into Job_Postings  (Text, SalaryRange, GPA_Range, Location, Deadline, Experience_Level) values ('eu magna vulputate luctus cum', null, 1.19, 'Myanmar', '10/29/2024', 9);
insert into Job_Postings  (Text, SalaryRange, GPA_Range, Location, Deadline, Experience_Level) values ('augue vestibulum ante ipsum primis in', null, 1.29, 'Russia', '6/20/2024', 10);
insert into Job_Postings  (Text, SalaryRange, GPA_Range, Location, Deadline, Experience_Level) values ('posuere', 107, 2.8, 'China', '7/2/2024', null);
insert into Job_Postings  (Text, SalaryRange, GPA_Range, Location, Deadline, Experience_Level) values ('semper rutrum nulla nunc purus', null, 1.32, 'Portugal', '12/31/2023', null);
insert into Job_Postings  (Text, SalaryRange, GPA_Range, Location, Deadline, Experience_Level) values ('vel ipsum praesent blandit lacinia erat vestibulum sed', 69, 1.56, 'France', '3/8/2024', null);
insert into Job_Postings  (Text, SalaryRange, GPA_Range, Location, Deadline, Experience_Level) values ('aliquet massa id lobortis convallis tortor risus dapibus augue', null, 2.27, 'Peru', '6/30/2024', null);
insert into Job_Postings  (Text, SalaryRange, GPA_Range, Location, Deadline, Experience_Level) values ('cubilia curae nulla dapibus dolor vel est donec', 240, 3.98, 'Poland', '4/1/2024', 3);
insert into Job_Postings  (Text, SalaryRange, GPA_Range, Location, Deadline, Experience_Level) values ('pellentesque quisque', 480, 2.6, 'Brazil', '3/15/2024', null);
insert into Job_Postings  (Text, SalaryRange, GPA_Range, Location, Deadline, Experience_Level) values ('nisi volutpat eleifend donec', null, 3.7, 'Argentina', '7/30/2024', 8);
insert into Job_Postings  (Text, SalaryRange, GPA_Range, Location, Deadline, Experience_Level) values ('curae nulla dapibus dolor vel est donec odio justo', 316, 3.25, 'Trinidad and Tobago', '7/7/2024', 6);
insert into Job_Postings  (Text, SalaryRange, GPA_Range, Location, Deadline, Experience_Level) values ('viverra pede ac diam cras pellentesque volutpat', 284, 2.1, 'Brazil', '7/26/2024', 7);
insert into Job_Postings  (Text, SalaryRange, GPA_Range, Location, Deadline, Experience_Level) values ('donec diam neque vestibulum eget vulputate', 461, 2.38, 'China', '8/19/2024', 9);
insert into Job_Postings  (Text, SalaryRange, GPA_Range, Location, Deadline, Experience_Level) values ('consequat varius integer ac leo pellentesque ultrices mattis odio donec', 260, 2.25, 'Czech Republic', '3/3/2024', 6);
insert into Job_Postings  (Text, SalaryRange, GPA_Range, Location, Deadline, Experience_Level) values ('proin leo odio porttitor id consequat', null, 3.96, 'Argentina', '3/22/2024', 8);
insert into Job_Postings  (Text, SalaryRange, GPA_Range, Location, Deadline, Experience_Level) values ('ut nulla sed accumsan felis ut at dolor quis', null, 1.55, 'Russia', '1/13/2024', 3);
insert into Job_Postings  (Text, SalaryRange, GPA_Range, Location, Deadline, Experience_Level) values ('ut odio cras mi pede malesuada in', 152, 2.02, 'China', '7/11/2024', null);
insert into Job_Postings  (Text, SalaryRange, GPA_Range, Location, Deadline, Experience_Level) values ('viverra eget congue eget', 183, 1.47, 'Spain', '3/6/2024', 5);
insert into Job_Postings  (Text, SalaryRange, GPA_Range, Location, Deadline, Experience_Level) values ('purus aliquet at feugiat non pretium quis lectus suspendisse', null, 1.22, 'Portugal', '11/26/2024', 7);
insert into Job_Postings  (Text, SalaryRange, GPA_Range, Location, Deadline, Experience_Level) values ('ac lobortis vel dapibus at diam nam tristique tortor', 160, 2.11, 'Poland', '5/7/2024', 3);
insert into Job_Postings  (Text, SalaryRange, GPA_Range, Location, Deadline, Experience_Level) values ('erat tortor sollicitudin mi sit amet lobortis sapien sapien non', 214, 3.59, 'Peru', '6/25/2024', null);
insert into Job_Postings  (Text, SalaryRange, GPA_Range, Location, Deadline, Experience_Level) values ('id lobortis convallis tortor risus dapibus augue vel accumsan', 293, 2.32, 'Indonesia', '12/25/2023', 7);
insert into Job_Postings  (Text, SalaryRange, GPA_Range, Location, Deadline, Experience_Level) values ('pede ac diam cras pellentesque volutpat dui', 325, 2.85, 'Thailand', '9/25/2024', 5);
insert into Job_Postings  (Text, SalaryRange, GPA_Range, Location, Deadline, Experience_Level) values ('quam sollicitudin vitae consectetuer eget rutrum at lorem integer', 427, 3.54, 'Brazil', '2/9/2024', null);
insert into Job_Postings  (Text, SalaryRange, GPA_Range, Location, Deadline, Experience_Level) values ('pharetra magna ac', 469, 3.79, 'Russia', '4/10/2024', 4);
insert into Job_Postings  (Text, SalaryRange, GPA_Range, Location, Deadline, Experience_Level) values ('sit amet', 113, 3.14, 'Thailand', '1/27/2024', 7);
insert into Job_Postings  (Text, SalaryRange, GPA_Range, Location, Deadline, Experience_Level) values ('id sapien in', null, 1.64, 'China', '7/12/2024', null);


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
