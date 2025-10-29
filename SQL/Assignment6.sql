USE `VTI_Department_DB`;

DELIMITER $$

CREATE PROCEDURE GetAccountsInDepartment(IN DepartmentNameIn VARCHAR(200))
BEGIN
    SELECT AccountID, Email, Username, FullName FROM `Account`
    WHERE AccountID IN (
        SELECT DepartmentID FROM `Department`
        WHERE DepartmentName = DepartmentNameIn
    );
END $$

CALL GetAccountsInDepartment('Engineer');
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE GetAccountPerGroup()
BEGIN
	SELECT G.GroupID as GID, G.GroupName as GroupName, COUNT(AccountID) as NumAccount
    FROM `Group` G LEFT JOIN `GroupAccount` GA ON G.GroupID = GA.GroupID
	GROUP BY G.GroupID;
END $$

CALL GetAccountPerGroup();

DELIMITER ;
