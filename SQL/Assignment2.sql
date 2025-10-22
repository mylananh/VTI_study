-- USE `VTI_Department_DB`;
-- SELECT DATABASE();

-- Question content should have length > 5
alter table Question
add constraint question_content_length check(char_length(content) >  5);

-- Answer content should have length > 2
alter table Answer
add constraint answer_content_length check(char_length(content) > 2);

-- insert

INSERT INTO Department (DepartmentName) VALUES
('Engineer'),
('HR'),
('Finance'),
('Marketing'),
('Operations');

INSERT INTO `Position` (PositionName) VALUES
('PM'),
('BE Dev'),
('QA'),
('FE Dev'),
('SRE');

INSERT INTO Account (Email, Username, FullName, DepartmentID, PositionID) VALUES
('messi@gmail.com', 'messi', 'Lionel Messi', 1, 2),
('ronaldo@gmail.com', 'cr7', 'Ronaldo', 1, 3),
('eren.yaeger@aot.com', 'eren.yaeger', 'Eren Yaeger', 2, 1),
('mikasa@aot.com', 'mikasa', 'Mikasa Ackermann', 3, 4),
('lelouch@geass.com', 'lelouch', 'Lelouch vi Britannia', 4, 5);

INSERT INTO `Group` (GroupName, CreatorID) VALUES
('BE Devs', 1),
('FE Devs', 2),
('HR Team', 3),
('SRE Team', 4),
('Marketing Team', 5);

INSERT INTO GroupAccount (GroupID, AccountID) VALUES
(1, 1),
(1, 2),
(2, 2),
(3, 3),
(4, 4);

INSERT INTO TypeQuestion (TypeName) VALUES
('Essay'),
('Multiple Choice'),
('True/False'),
('Short Answer'),
('Coding');

INSERT INTO CategoryQuestion (CategoryName) VALUES
('Java'),
('SQL'),
('Python'),
('JS'),
('Algorithm');

INSERT INTO Question (Content, CategoryID, TypeID, CreatorID) VALUES
('What is polymorphism in Java?', 1, 1, 1),
('What is the primary key in SQL?', 2, 2, 2),
('Is Python dynamically typed?', 3, 3, 3),
('What does JS stand for?', 4, 2, 4),
('What is a stack?', 5, 1, 5);

INSERT INTO Answer (Content, QuestionID, isCorrect) VALUES
('Ability of an object to take many forms', 1, TRUE),
('A unique identifier for a record', 2, TRUE),
('Yes, it is', 3, TRUE),
('Suck language', 4, TRUE),
('LIFO data structure', 5, TRUE);

INSERT INTO Exam (Code, Title, CategoryID, Duration, CreatorID) VALUES
('EX001', 'Java Basics', 1, 60, 1),
('EX002', 'SQL Fundamentals', 2, 45, 2),
('EX003', 'Python Core', 3, 50, 3),
('EX004', 'React', 4, 40, 4),
('EX005', 'Data Structures', 5, 70, 5);

INSERT INTO ExamQuestion (ExamID, QuestionID) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5);

INSERT INTO Department (DepartmentName) VALUES
('Customer Service'),
('Research & Development'),
('Sales'),
('Legal'),
('Administration');

INSERT INTO `Position` (PositionName) VALUES
('Data Analyst'),
('Scrum Master'),
('HR Specialist'),
('Finance Officer'),
('Tech Lead');

INSERT INTO Account (Email, Username, FullName, DepartmentID, PositionID) VALUES
('frank@example.com', 'frank', 'Frank Do', 6, 6),
('gina@example.com', 'gina', 'Gina Vu', 7, 7),
('henry@example.com', 'henry', 'Henry Bui', 8, 8),
('ivy@example.com', 'ivy', 'Ivy Dang', 9, 9),
('jack@example.com', 'jack', 'Jack Phan', 10, 10);

INSERT INTO `Group` (GroupName, CreatorID) VALUES
('Support Team', 6),
('R&D Team', 7),
('Sales Team', 8),
('Legal Team', 9),
('Admin Team', 10);

INSERT INTO GroupAccount (GroupID, AccountID) VALUES
(6, 6),
(6, 1),
(7, 7),
(8, 8),
(9, 9),
(10, 10),
(7, 2),
(8, 3),
(9, 4),
(10, 5);


INSERT INTO TypeQuestion (TypeName) VALUES
('Fill in the Blank'),
('Matching'),
('Diagram'),
('Case Study'),
('Practical');


INSERT INTO CategoryQuestion (CategoryName) VALUES
('Networking'),
('Security'),
('DevOps'),
('Cloud'),
('AI & ML');


INSERT INTO Question (Content, CategoryID, TypeID, CreatorID) VALUES
('Explain OSI model.', 2, 2, 3),
('What is a firewall?', 3, 3, 2),
('What is CI/CD?', 1, 2, 2),
('What is cloud computing?', 1, 1, 3),
('What is supervised learning?', 1, 4, 3);


INSERT INTO Answer (Content, QuestionID, isCorrect) VALUES
('7 layers in OSI model', 2, TRUE),
('Network security barrier', 3, TRUE),
('Continuous Integration/Deployment', 4, TRUE),
('Delivery of computing services over the internet', 1, TRUE),
('Trained on labeled data', 2, TRUE);


INSERT INTO Exam (Code, Title, CategoryID, Duration, CreatorID) VALUES
('EX006', 'Networking 101', 1, 60, 3),
('EX007', 'Security Basics', 3, 55, 4),
('EX008', 'DevOps Intro', 2, 65, 2),
('EX009', 'Cloud Essentials', 2, 75, 1),
('EX010', 'AI and ML Concepts', 4, 80, 2);

INSERT INTO ExamQuestion (ExamID, QuestionID) VALUES
(1, 2),
(2, 3),
(3, 1),
(4, 1);
