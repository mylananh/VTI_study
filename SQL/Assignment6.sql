-- USE `VTI_Department_DB`;

-- DELIMITER $$

-- CREATE PROCEDURE GetAccountsInDepartment(IN DepartmentNameIn VARCHAR(200))
-- BEGIN
--     SELECT AccountID, Email, Username, FullName FROM `Account`
--     WHERE AccountID IN (
--         SELECT DepartmentID FROM `Department`
--         WHERE DepartmentName = DepartmentNameIn
--     );
-- END $$

-- CALL GetAccountsInDepartment('Engineer');
-- DELIMITER ;

-- DELIMITER $$
-- CREATE PROCEDURE GetAccountPerGroup()
-- BEGIN
-- 	SELECT G.GroupID as GID, G.GroupName as GroupName, COUNT(AccountID) as NumAccount
--     FROM `Group` G LEFT JOIN `GroupAccount` GA ON G.GroupID = GA.GroupID
-- 	GROUP BY G.GroupID;
-- END $$

-- CALL GetAccountPerGroup();

-- DELIMITER ;




DROP PROCEDURE TypeQuestionStatsThisMonth;
DELIMITER $$
CREATE PROCEDURE TypeQuestionStatsThisMonth()
BEGIN
	SELECT T.TypeID, T.TypeName, COUNT(*) as NumQuestion, CONCAT(MONTH(NOW()), '-', YEAR(NOW())) as Time
    FROM TypeQuestion T LEFT JOIN (
        SELECT TypeID
        FROM Question
        WHERE MONTH(CreateDate) = MONTH(NOW()) AND YEAR(CreateDate) = YEAR(NOW())
    ) Q
        ON T.TypeID = Q.TypeID
    GROUP BY T.TypeID;
END $$


DELIMITER ;


CALL TypeQuestionStatsThisMonth();

-- Tạo store để trả ra id của type question có nhiều câu hỏi nhất
DELIMITER >>

CREATE PROCEDURE IdOfBestQuestionType(OUT BestID INT)
BEGIN
	SELECT TypeID into BestID
    FROM Question
    GROUP BY TypeID
    ORDER BY COUNT(*) DESC
    LIMIT 1;
END >>

DELIMITER ;

CALL IdOfBestQuestionType(@BestID);
SELECT @BestID as Hehe;

DELIMITER &&&&&&&

CREATE PROCEDURE NameOfBestQuestionType()
BEGIN
	CALL IdOfBestQuestionType(@BestID);
    SELECT TypeName from `TypeQuestion` WHERE TypeID = @BestID;
END &&&&&&&

DELIMITER ;

CALL NameOfBestQuestionType();

-- Viết 1 store cho phép người dùng nhập vào 1 chuỗi và trả về group có tên
-- chứa chuỗi của người dùng nhập vào hoặc trả về user có username chứa
-- chuỗi của người dùng nhập vào

DELIMITER VTI

CREATE PROCEDURE NameOrGroup(IN TargetName VARCHAR(200))
BEGIN
    (
		SELECT 'Group' as `Type`, GroupName as `Name`
		FROM `Group` WHERE GroupName LIKE concat('%', TargetName, '%')
    ) UNION ALL
    (
		SELECT 'User' as `Type`, Username as `Name`
		FROM `Account` WHERE Username LIKE concat('%', TargetName, '%')
    );
END VTI

DELIMITER ;

CALL NameOrGroup('an');

