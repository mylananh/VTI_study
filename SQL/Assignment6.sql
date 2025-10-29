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

