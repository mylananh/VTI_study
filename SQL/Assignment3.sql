-- All department
select * from Department;

-- All sale department
INSERT INTO Department (DepartmentName) VALUES
('Sale'),
('Sale');
SELECT DepartmentID from Department WHERE lower(DepartmentName) LIKE "%sale%";

-- longest name
select FullName
from Account
order by char_length(FullName) desc
limit 1;

-- longest name of department 3
select FullName
from Account
where DepartmentID = 3
order by char_length(FullName) desc
limit 1;

-- group with create date < 24/10
select *
from `Group`
where CreateDate < '2025-10-24';

-- question with more than 4 answers
select Q.QuestionID as ID
from Question Q left join Answer
On Q.QuestionID = Answer.QuestionID
Group by Q.QuestionID
Having count(AnswerID) >= 4;

-- code of exam, before 24 Oct and Duration >= 60 mins
select Distinct(`Code`) as `code`
from Exam
where CreateDate < '2025-10-24' and Duration >= 60;

-- no of account of dep 2
select count(AccountID)
from Account
where DepartmentID = 2;

-- All account name start with E and end with r
Select *
from Account
where FullName Like 'E%r';

DELETE FROM Exam
WHERE CreateDate < '2019-12-20';

DELETE FROM Question
WHERE Content LIKE `câu hỏi%`;

UPDATE `Account`
SET FullName = "Nguyễn Trọng Luân", email = "luannguyentrong98@gmail.com"
WHERE AccountID = 5;

Update `GroupAccount`
SET GroupID = 4
WHERE AccountID = 5;

