SELECT A.AccountID, A.FullName, A.Email, D.DepartmentName
FROM `Account` A LEFT JOIN Department D
	ON A.DepartmentID = D.DepartmentID;
    
Select * From Account Where CreateDate > '2010-12-20';

SET @DevDepartmentName = 'Engineer';
Select * From `Account`
WHERE DepartmentID IN (
	SELECT DepartmentID FROM Department WHERE DepartmentName = @DevDepartmentName
);

SELECT D.DepartmentID, D.DepartmentName
FROM Department D
	LEFT JOIN Account A
	ON D.DepartmentID = A.DepartmentID
GROUP BY D.DepartmentID
HAVING COUNT(AccountID) > 1;



WITH ExamCountTop AS (
	SELECT Count(ExamID) as X
	From ExamQuestion
	Group by QuestionID
	Order by Count(ExamID) DESC
	LIMIT 1
),
TopQuestion AS (
	SELECT QuestionID, Count(ExamID) as NumExam
    From ExamQuestion
    Group by QuestionID
    HAVING Count(ExamID) IN (SELECT `X` From ExamCountTop)
)
SELECT Q.QuestionID as QuestionID, Content, NumExam
FROM Question Q INNER JOIN TopQuestion T
WHERE Q.QuestionID = T.QuestionID;

    
