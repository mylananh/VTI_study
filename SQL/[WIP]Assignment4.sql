USE `VTI_Department_DB`;

-- Account with department info
SELECT A.AccountID, A.FullName, A.Email, D.DepartmentID as DepID, D.DepartmentName
FROM `Account` A LEFT JOIN Department D
	ON A.DepartmentID = D.DepartmentID;
    
--- Account created after 2010-12-20
Select * From `Account` Where CreateDate > '2010-12-20';

-- Account of Position Dev
SELECT * FROM `Account`
	WHERE PositionID IN (
		SELECT PositionID FROM `Position` WHERE PositionName = 'Dev'
	);

-- List of department has more than 3 accounts
SELECT T.DepartmentID as DepID, D.DepartmentName as DepName, NumAccount
	FROM (
		SELECT DepartmentID, Count(AccountID) as NumAccount
		FROM `Account`
		GROUP BY DepartmentID
		HAVING NumAccount > 3
	) T LEFT JOIN Department D ON T.DepartmentID = D.DepartmentID;

-- List of questions used in exams most
WITH ExamCountTable AS (
	SELECT QuestionID, COUNT(ExamID) as ExamCount
	FROM ExamQuestion
	GROUP BY QuestionID
)
SELECT E.QuestionID as QuestionID, Q.Content
FROM (
	ExamCountTable E LEFT JOIN Question Q ON E.QuestionID = Q.QuestionID
)
WHERE ExamCount = (SELECT MAX(ExamCount) FROM ExamCountTable);

-- Category - Question Count map
SELECT C.CategoryID, C.CategoryName, IF(N.QuesCount IS NULL, 0, N.QuesCount) as QuesCount
FROM CategoryQuestion C LEFT JOIN (
	SELECT CategoryID, Count(QuestionID) as QuesCount
	FROM Question
	WHERE CategoryID IS NOT NULL
	GROUP BY CategoryID
) N ON C.CategoryID = N.CategoryID;

-- Question - exam count map
SELECT Q.QuestionID, Q.Content, IF(N.ExamCount IS NULL, 0, N.ExamCount) as ExamCount
FROM Question Q LEFT JOIN (
	SELECT QuestionID, Count(ExamID) as ExamCount
	FROM ExamQuestion
	GROUP BY QuestionID
) N ON Q.QuestionID = N.QuestionID;

-- Question with most answers. Use LIMIT solution.
SELECT QuestionID, Count(AnswerID) as AnswerCount
FROM Answer
GROUP BY QuestionID
ORDER BY AnswerCount DESC
LIMIT 1;

-- Group account count map 
SELECT G.GroupID, G.GroupName, IF(N.NumAccount IS NULL, 0, N.NumAccount) as NumAccount
FROM (
	SELECT GroupID, Count(AccountID) as NumAccount
	FROM GroupAccount
	GROUP BY GroupID
) N RIGHT JOIN `Group` G ON G.GroupID = N.GroupID;

-- Position with fewest account
SELECT P.PositionID, P.PositionName, IF(N.NumAccount IS NULL, 0, N.NumAccount) as NumAccount
FROM `Position` P LEFT JOIN (
	SELECT PositionID, COUNT(AccountID) as NumAccount
    FROM `Account`
    GROUP BY PositionID
) N ON P.PositionID = N.PositionID
ORDER BY NumAccount ASC
LIMIT 1;

-- Each deparment, how many dev, test, scrum master, PM
SELECT
	D.DepartmentID as DepID,
	SUM(IF(PositionName = 'Dev', 1, 0)) as DevCount,
    SUM(IF(PositionName = 'Test', 1, 0)) as TestCount,
    SUM(IF(PositionName = 'Scrum Master', 1, 0)) as SMCount,
    SUM(IF(PositionName = 'PM', 1, 0)) as PMCount
FROM 
	Department D LEFT JOIN 
	(SELECT A.DepartmentID as DepID, PositionName
		FROM `Account` A INNER JOIN
			(SELECT * FROM `Position` WHERE PositionName IN ('Dev', 'Test', 'Scrum Master', 'PM')) P
		ON A.PositionID = P.PositionID
	) T ON D.DepartmentID = T.DepID
GROUP BY D.DepartmentID;

-- Question Detail
SELECT Q.QuestionID, Q.Content, C.CategoryName, A.FullName as Creator, A1.Content as AnswerContent
FROM Question Q 
	LEFT JOIN CategoryQuestion C ON Q.CategoryID = C.CategoryID 
	LEFT JOIN `Account` A ON Q.CreatorID = A.AccountID
	LEFT JOIN `Answer` A1 ON Q.QuestionID = A1.QuestionID;
    
-- Type question map 
SELECT C.CategoryID, C.CategoryName, COUNT(Q.QuestionID) as QuesCount
FROM CategoryQuestion C LEFT JOIN Question Q 
	ON C.CategoryID = Q.CategoryID
GROUP BY C.CategoryID;

-- Group no account
SELECT *
From `Group` WHERE GroupID NOT IN (
	SELECT DISTINCT(GroupID)
	FROM GroupAccount
);

-- Question without answer
SELECT *
FROM `Question` WHERE QuestionID NOT IN (
	SELECT Distinct QuestionID
    From Answer
);
    