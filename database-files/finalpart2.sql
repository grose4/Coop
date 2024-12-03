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

insert into Users  (UserID, Occupation, Location, email, Name, Age, Bio, ReferredBy) values (1, 'Staff Scientist', 'China', 'ofaustin0@phpbb.com', 'trist0', 97, 'fringilla rhoncus mauris enim leo rhoncus sed vestibulum sit amet cursus', 21);
insert into Users  (UserID, Occupation, Location, email, Name, Age, Bio, ReferredBy) values (2, 'Computer Systems Analyst IV', 'Angola', 'nniven1@google.ru', 'aashcroft1', 70, 'consequat varius integer ac leo pellentesque ultrices mattis odio donec', 22);
insert into Users  (UserID, Occupation, Location, email, Name, Age, Bio, ReferredBy) values (3, 'Teacher', 'Portugal', 'cgiacobilio2@storify.com', 'egiacoppo2', 7, 'magnis dis parturient montes nascetur ridiculus mus etiam vel augue vestibulum', 35);
insert into Users  (UserID, Occupation, Location, email, Name, Age, Bio, ReferredBy) values (4, 'Data Coordinator', 'Mexico', 'jashbrook3@umich.edu', 'rtenbrug3', 92, 'sit amet', null);
insert into Users  (UserID, Occupation, Location, email, Name, Age, Bio, ReferredBy) values (5, 'Community Outreach Specialist', 'Ukraine', 'ainmett4@bing.com', 'kpriestland4', 54, 'ullamcorper augue a', 38);
insert into Users  (UserID, Occupation, Location, email, Name, Age, Bio, ReferredBy) values (6, 'Systems Administrator I', 'Brazil', 'fsellack5@sphinn.com', 'gwoodfin5', 27, 'morbi', null);
insert into Users  (UserID, Occupation, Location, email, Name, Age, Bio, ReferredBy) values (7, 'Office Assistant II', 'Finland', 'sadame6@issuu.com', 'maizkovitch6', 57, 'praesent blandit lacinia erat vestibulum sed magna at nunc', 13);
insert into Users  (UserID, Occupation, Location, email, Name, Age, Bio, ReferredBy) values (8, 'VP Quality Control', 'China', 'styas7@diigo.com', 'mglewe7', 55, 'amet nulla quisque arcu libero rutrum ac lobortis vel dapibus', null);
insert into Users  (UserID, Occupation, Location, email, Name, Age, Bio, ReferredBy) values (9, 'Electrical Engineer', 'Slovenia', 'mkillick8@newyorker.com', 'kmingaud8', 56, 'ut volutpat sapien arcu sed augue aliquam', 54);
insert into Users  (UserID, Occupation, Location, email, Name, Age, Bio, ReferredBy) values (10, 'Environmental Specialist', 'Greece', 'hmycock9@google.com.br', 'bstrachan9', 97, 'felis ut at dolor quis odio consequat', null);
insert into Users  (UserID, Occupation, Location, email, Name, Age, Bio, ReferredBy) values (11, 'Analog Circuit Design manager', 'Brazil', 'rsnodaya@sciencedirect.com', 'abarcrofta', 25, 'ut dolor', 29);
insert into Users  (UserID, Occupation, Location, email, Name, Age, Bio, ReferredBy) values (12, 'Senior Sales Associate', 'Azerbaijan', 'cscarlanb@t.co', 'twitherbedb', 19, 'id consequat in consequat ut nulla sed accumsan felis', null);
insert into Users  (UserID, Occupation, Location, email, Name, Age, Bio, ReferredBy) values (13, 'Speech Pathologist', 'Poland', 'sshubothamc@google.co.uk', 'cecobc', 30, 'etiam vel augue vestibulum rutrum rutrum neque aenean auctor gravida sem', 33);
insert into Users  (UserID, Occupation, Location, email, Name, Age, Bio, ReferredBy) values (14, 'Payment Adjustment Coordinator', 'Micronesia', 'rreussd@mapy.cz', 'wiorid', 24, 'sociis natoque penatibus et magnis', null);
insert into Users  (UserID, Occupation, Location, email, Name, Age, Bio, ReferredBy) values (15, 'Senior Quality Engineer', 'Indonesia', 'mstatherse@opera.com', 'dcuncliffee', 57, 'justo in blandit ultrices enim', 61);
insert into Users  (UserID, Occupation, Location, email, Name, Age, Bio, ReferredBy) values (16, 'Physical Therapy Assistant', 'Philippines', 'mmayhof@psu.edu', 'dmcnuttf', 6, 'placerat ante nulla justo aliquam quis turpis eget elit', 22);
insert into Users  (UserID, Occupation, Location, email, Name, Age, Bio, ReferredBy) values (17, 'Senior Sales Associate', 'Philippines', 'bwhitingtong@huffingtonpost.com', 'jmonteithg', 93, 'quis orci', null);
insert into Users  (UserID, Occupation, Location, email, Name, Age, Bio, ReferredBy) values (18, 'Programmer Analyst III', 'Tanzania', 'myurkevichh@oaic.gov.au', 'lcheneryh', 83, 'vulputate vitae nisl aenean lectus pellentesque eget nunc donec quis', null);
insert into Users  (UserID, Occupation, Location, email, Name, Age, Bio, ReferredBy) values (19, 'Senior Sales Associate', 'China', 'apittendreighi@usda.gov', 'kcooli', 14, 'in faucibus orci luctus', null);
insert into Users  (UserID, Occupation, Location, email, Name, Age, Bio, ReferredBy) values (20, 'Senior Editor', 'Indonesia', 'lwinkettj@scientificamerican.com', 'aertelj', 17, 'eget nunc donec quis orci eget', 30);
insert into Users  (UserID, Occupation, Location, email, Name, Age, Bio, ReferredBy) values (21, 'Biostatistician IV', 'Philippines', 'acutridgek@theglobeandmail.com', 'gkenank', 59, 'nec euismod scelerisque quam', null);
insert into Users  (UserID, Occupation, Location, email, Name, Age, Bio, ReferredBy) values (22, 'Media Manager IV', 'Indonesia', 'tcoppensl@surveymonkey.com', 'lkitcattl', 54, 'volutpat dui maecenas tristique est et', 63);
insert into Users  (UserID, Occupation, Location, email, Name, Age, Bio, ReferredBy) values (23, 'Structural Engineer', 'Armenia', 'myssonm@vistaprint.com', 'jbenkinm', 76, 'blandit ultrices enim', null);
insert into Users  (UserID, Occupation, Location, email, Name, Age, Bio, ReferredBy) values (24, 'Dental Hygienist', 'China', 'yyeelln@sogou.com', 'qyesinovn', 83, 'quam fringilla rhoncus mauris enim leo rhoncus sed vestibulum sit amet', null);
insert into Users  (UserID, Occupation, Location, email, Name, Age, Bio, ReferredBy) values (25, 'Web Designer IV', 'United States', 'kdominyo@miibeian.gov.cn', 'agullamo', 9, 'sagittis nam congue risus semper porta volutpat quam pede lobortis ligula sit amet eleifend pede', 68);
insert into Users  (UserID, Occupation, Location, email, Name, Age, Bio, ReferredBy) values (26, 'Speech Pathologist', 'China', 'jnixp@weibo.com', 'lallikerp', 60, 'ac consequat metus sapien', 16);
insert into Users  (UserID, Occupation, Location, email, Name, Age, Bio, ReferredBy) values (27, 'Internal Auditor', 'Portugal', 'mbensonq@php.net', 'imccrostieq', 30, 'aenean sit amet justo morbi ut odio cras mi', 85);
insert into Users  (UserID, Occupation, Location, email, Name, Age, Bio, ReferredBy) values (28, 'Marketing Manager', 'Philippines', 'hpassmanr@slate.com', 'slitzmannr', 14, 'pede morbi porttitor lorem id ligula suspendisse ornare consequat lectus', 70);
insert into Users  (UserID, Occupation, Location, email, Name, Age, Bio, ReferredBy) values (29, 'Human Resources Manager', 'Egypt', 'mboyers@infoseek.co.jp', 'imenarys', 88, 'eros suspendisse accumsan tortor quis turpis sed ante vivamus tortor duis mattis egestas', 29);
insert into Users  (UserID, Occupation, Location, email, Name, Age, Bio, ReferredBy) values (30, 'Account Representative I', 'Colombia', 'hmarshlandt@google.nl', 'pchithamt', 94, 'nisi vulputate nonummy maecenas tincidunt lacus at velit vivamus vel', 40);
insert into Users  (UserID, Occupation, Location, email, Name, Age, Bio, ReferredBy) values (31, 'Data Coordinator', 'Thailand', 'plegionu@fastcompany.com', 'jlampetu', 57, 'pede lobortis ligula sit amet eleifend pede libero quis orci nullam molestie', 33);
insert into Users  (UserID, Occupation, Location, email, Name, Age, Bio, ReferredBy) values (32, 'Business Systems Development Analyst', 'Indonesia', 'acrosbyv@jigsy.com', 'bcossarv', 60, 'in quis justo maecenas rhoncus aliquam lacus morbi quis tortor', 12);
insert into Users  (UserID, Occupation, Location, email, Name, Age, Bio, ReferredBy) values (33, 'Teacher', 'Honduras', 'acopelandw@nsw.gov.au', 'awarretw', 70, 'in quis', 14);
insert into Users  (UserID, Occupation, Location, email, Name, Age, Bio, ReferredBy) values (34, 'Recruiting Manager', 'China', 'rreinax@shop-pro.jp', 'gshielx', 93, 'aliquam erat volutpat in congue etiam justo etiam', 26);
insert into Users  (UserID, Occupation, Location, email, Name, Age, Bio, ReferredBy) values (35, 'Geologist II', 'Indonesia', 'kpellery@blinklist.com', 'gbrainey', 76, 'sit amet lobortis sapien sapien non', 44);
insert into Users  (UserID, Occupation, Location, email, Name, Age, Bio, ReferredBy) values (36, 'Senior Developer', 'Colombia', 'ylombardoz@gov.uk', 'lroadz', 99, 'at diam nam tristique tortor', null);
insert into Users  (UserID, Occupation, Location, email, Name, Age, Bio, ReferredBy) values (37, 'Civil Engineer', 'Argentina', 'rwastell10@nature.com', 'jchettle10', 65, 'ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae mauris viverra diam', 81);
insert into Users  (UserID, Occupation, Location, email, Name, Age, Bio, ReferredBy) values (38, 'VP Quality Control', 'Indonesia', 'ahassekl11@about.com', 'mjackes11', 40, 'adipiscing lorem vitae mattis', 98);
insert into Users  (UserID, Occupation, Location, email, Name, Age, Bio, ReferredBy) values (39, 'Associate Professor', 'Philippines', 'pcostley12@livejournal.com', 'bbranthwaite12', 55, 'felis ut at dolor quis odio consequat varius integer ac leo pellentesque', 55);
insert into Users  (UserID, Occupation, Location, email, Name, Age, Bio, ReferredBy) values (40, 'Software Test Engineer III', 'Indonesia', 'rjacomb13@virginia.edu', 'kmitchiner13', 63, 'eu orci', 38);
insert into Users  (UserID, Occupation, Location, email, Name, Age, Bio, ReferredBy) values (41, 'Nuclear Power Engineer', 'Greece', 'ueingerfield14@google.co.uk', 'zmcart14', 4, 'suspendisse potenti cras in purus eu magna vulputate luctus cum sociis natoque', 47);
insert into Users  (UserID, Occupation, Location, email, Name, Age, Bio, ReferredBy) values (42, 'Dental Hygienist', 'Japan', 'cstilgoe15@squarespace.com', 'splose15', 51, 'dui maecenas tristique est et tempus', null);
insert into Users  (UserID, Occupation, Location, email, Name, Age, Bio, ReferredBy) values (43, 'Account Coordinator', 'China', 'rswinney16@dion.ne.jp', 'fcamus16', 28, 'vel pede', 72);
insert into Users  (UserID, Occupation, Location, email, Name, Age, Bio, ReferredBy) values (44, 'Cost Accountant', 'China', 'whobben17@yelp.com', 'bstockow17', 63, 'arcu sed augue aliquam erat volutpat', null);
insert into Users  (UserID, Occupation, Location, email, Name, Age, Bio, ReferredBy) values (45, 'Technical Writer', 'China', 'mhellwig18@tripadvisor.com', 'vscalera18', 47, 'odio condimentum id luctus nec', 97);
insert into Users  (UserID, Occupation, Location, email, Name, Age, Bio, ReferredBy) values (46, 'Social Worker', 'China', 'vkopfen19@sphinn.com', 'rbeeke19', 9, 'pretium quis lectus suspendisse potenti in eleifend quam a odio in hac habitasse platea dictumst', null);
insert into Users  (UserID, Occupation, Location, email, Name, Age, Bio, ReferredBy) values (47, 'Teacher', 'Ukraine', 'gstreak1a@webmd.com', 'fmcgrill1a', 31, 'ut erat curabitur gravida nisi at nibh in hac habitasse', 80);
insert into Users  (UserID, Occupation, Location, email, Name, Age, Bio, ReferredBy) values (48, 'Occupational Therapist', 'Russia', 'lshillito1b@quantcast.com', 'mdrought1b', 95, 'praesent lectus vestibulum quam sapien varius ut blandit non interdum in ante vestibulum', 39);
insert into Users  (UserID, Occupation, Location, email, Name, Age, Bio, ReferredBy) values (49, 'Accounting Assistant IV', 'China', 'bmclagan1c@illinois.edu', 'hwoolstenholmes1c', 69, 'diam in magna bibendum imperdiet', null);
insert into Users  (UserID, Occupation, Location, email, Name, Age, Bio, ReferredBy) values (50, 'Safety Technician III', 'Israel', 'gbanasevich1d@wikipedia.org', 'mmacteggart1d', 45, 'sit amet lobortis sapien', null);
insert into Users  (UserID, Occupation, Location, email, Name, Age, Bio, ReferredBy) values (51, 'Account Executive', 'China', 'nashmore1e@ycombinator.com', 'fshallcrass1e', 44, 'eget orci vehicula condimentum curabitur in libero ut massa volutpat', null);
insert into Users  (UserID, Occupation, Location, email, Name, Age, Bio, ReferredBy) values (52, 'Physical Therapy Assistant', 'Cuba', 'abosward1f@artisteer.com', 'edibden1f', 5, 'volutpat sapien arcu sed augue aliquam erat volutpat in congue etiam justo', 79);
insert into Users  (UserID, Occupation, Location, email, Name, Age, Bio, ReferredBy) values (53, 'Research Associate', 'China', 'rbrody1g@spiegel.de', 'krossin1g', 68, 'vestibulum sagittis', 22);
insert into Users  (UserID, Occupation, Location, email, Name, Age, Bio, ReferredBy) values (54, 'Senior Developer', 'Micronesia', 'jfalls1h@mapquest.com', 'hmuress1h', 80, 'viverra dapibus nulla suscipit ligula in lacus curabitur at ipsum ac tellus semper interdum', null);
insert into Users  (UserID, Occupation, Location, email, Name, Age, Bio, ReferredBy) values (55, 'Social Worker', 'Argentina', 'abartomeu1i@whitehouse.gov', 'ecollomosse1i', 58, 'in ante vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia', 21);
insert into Users  (UserID, Occupation, Location, email, Name, Age, Bio, ReferredBy) values (56, 'Compensation Analyst', 'United States', 'oscipsey1j@g.co', 'lbougen1j', 93, 'elit sodales scelerisque mauris', 44);
insert into Users  (UserID, Occupation, Location, email, Name, Age, Bio, ReferredBy) values (57, 'Quality Control Specialist', 'Iran', 'agosart1k@altervista.org', 'nmargrett1k', 4, 'sit amet consectetuer adipiscing elit proin interdum mauris non ligula pellentesque', 40);
insert into Users  (UserID, Occupation, Location, email, Name, Age, Bio, ReferredBy) values (58, 'Administrative Assistant II', 'Philippines', 'ldayton1l@dmoz.org', 'lseignior1l', 48, 'morbi a ipsum integer a nibh in quis', 55);
insert into Users  (UserID, Occupation, Location, email, Name, Age, Bio, ReferredBy) values (59, 'Senior Cost Accountant', 'Denmark', 'vwakely1m@netscape.com', 'caddison1m', 54, 'cras', 75);
insert into Users  (UserID, Occupation, Location, email, Name, Age, Bio, ReferredBy) values (60, 'Physical Therapy Assistant', 'China', 'mbiddiss1n@exblog.jp', 'ggalpen1n', 17, 'neque duis bibendum morbi non quam nec dui luctus rutrum nulla tellus in', null);
insert into Users  (UserID, Occupation, Location, email, Name, Age, Bio, ReferredBy) values (61, 'Software Consultant', 'China', 'ewetter1o@icq.com', 'kpettendrich1o', 60, 'vivamus tortor duis mattis egestas metus aenean fermentum donec ut mauris', 56);
insert into Users  (UserID, Occupation, Location, email, Name, Age, Bio, ReferredBy) values (62, 'Staff Accountant IV', 'Panama', 'vbedding1p@hp.com', 'pfurmagier1p', 87, 'morbi', 1);
insert into Users  (UserID, Occupation, Location, email, Name, Age, Bio, ReferredBy) values (63, 'Project Manager', 'Lithuania', 'atinner1q@rambler.ru', 'lblencowe1q', 92, 'sapien placerat ante nulla justo aliquam quis turpis eget elit sodales scelerisque mauris sit', 34);
insert into Users  (UserID, Occupation, Location, email, Name, Age, Bio, ReferredBy) values (64, 'Mechanical Systems Engineer', 'China', 'wkrug1r@elegantthemes.com', 'lbasten1r', 95, 'dapibus augue vel accumsan tellus nisi eu orci mauris lacinia sapien', null);
insert into Users  (UserID, Occupation, Location, email, Name, Age, Bio, ReferredBy) values (65, 'Web Designer III', 'Belarus', 'afrank1s@pinterest.com', 'mspuffard1s', 31, 'lorem quisque ut', null);
insert into Users  (UserID, Occupation, Location, email, Name, Age, Bio, ReferredBy) values (66, 'Chemical Engineer', 'China', 'dneeson1t@umich.edu', 'eangelo1t', 47, 'sodales scelerisque mauris sit amet eros suspendisse accumsan tortor quis turpis sed ante vivamus tortor', null);
insert into Users  (UserID, Occupation, Location, email, Name, Age, Bio, ReferredBy) values (67, 'Desktop Support Technician', 'Mexico', 'jculshaw1u@economist.com', 'jbresland1u', 82, 'turpis sed ante vivamus tortor duis mattis egestas metus aenean fermentum', null);
insert into Users  (UserID, Occupation, Location, email, Name, Age, Bio, ReferredBy) values (68, 'Software Engineer IV', 'Chad', 'ibernakiewicz1v@privacy.gov.au', 'jgulland1v', 36, 'risus auctor sed tristique in tempus sit amet sem fusce', null);
insert into Users  (UserID, Occupation, Location, email, Name, Age, Bio, ReferredBy) values (69, 'Senior Cost Accountant', 'Armenia', 'vshacklady1w@blogs.com', 'cmedcraft1w', 40, 'pede venenatis non sodales sed tincidunt eu felis fusce posuere felis sed', 18);
insert into Users  (UserID, Occupation, Location, email, Name, Age, Bio, ReferredBy) values (70, 'Nurse', 'Russia', 'hpestricke1x@myspace.com', 'dclapston1x', 98, 'accumsan tortor quis turpis sed ante vivamus tortor duis mattis egestas', null);
insert into Users  (UserID, Occupation, Location, email, Name, Age, Bio, ReferredBy) values (71, 'Community Outreach Specialist', 'China', 'rredborn1y@arstechnica.com', 'glibby1y', 15, 'dapibus dolor', null);
insert into Users  (UserID, Occupation, Location, email, Name, Age, Bio, ReferredBy) values (72, 'Information Systems Manager', 'Estonia', 'kingles1z@ebay.com', 'rmachoste1z', 4, 'magna at nunc commodo placerat', null);
insert into Users  (UserID, Occupation, Location, email, Name, Age, Bio, ReferredBy) values (73, 'Account Coordinator', 'Indonesia', 'cevill20@businesswire.com', 'ealeshkov20', 18, 'parturient montes nascetur ridiculus mus vivamus vestibulum sagittis sapien cum sociis natoque penatibus et magnis', null);
insert into Users  (UserID, Occupation, Location, email, Name, Age, Bio, ReferredBy) values (74, 'Senior Editor', 'Greece', 'hburgoin21@princeton.edu', 'acolson21', 17, 'purus phasellus', null);
insert into Users  (UserID, Occupation, Location, email, Name, Age, Bio, ReferredBy) values (75, 'Media Manager II', 'Indonesia', 'wmoxom22@cam.ac.uk', 'gbenford22', 19, 'sit amet cursus id turpis integer aliquet massa', null);

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
