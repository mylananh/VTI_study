-- CREATE DATABASE IF NOT EXISTS VTI_Learning;

-- USE VTI_Learning;

-- SELECT DATABASE();

CREATE TABLE IF NOT EXISTS `Trainee` (
	TraineeID INT AUTO_INCREMENT PRIMARY KEY,
    Full_Name VARCHAR(100) NOT NULL,
    Birth_Date DATE NOT NULL,
    Gender ENUM('male', 'female', 'unknown') NOT NULL,
    ET_IQ TINYINT UNSIGNED CHECK (ET_IQ BETWEEN 0 and 20) DEFAULT 0,
    ET_Gmath TINYINT UNSIGNED CHECK (ET_Gmath BETWEEN 0 and 20) DEFAULT 0,
    ET_English TINYINT UNSIGNED CHECK (ET_English BETWEEN 0 and 50) DEFAULT 0,
    Training_Class CHAR(10) NOT NULL,		-- assume class code is a fixed of 10 characters
    Evaluation_Notes TEXT,
    Created_At TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- INSERT INTO `Trainee` (Full_Name, Birth_Date, Gender, ET_IQ, ET_Gmath, ET_English, Training_Class, Evaluation_Notes) 
-- VALUES ('Eren', '2000-01-01', 'male', 10, 10, 1, 'VTIAOT2013', NULL),
-- 		('Mikasa', '1999-01-01', 'female', 20, 10, 15, 'VTIAOT2013', NULL),
--         ('Yagami Light', '1997-12-12', 'male', 20, 20, 50, 'VTIDEN2006', 'Death Note');
        
SELECT * FROM Trainee;

ALTER TABLE Trainee
ADD COLUMN VTI_Account VARCHAR(255) UNIQUE
AFTER Full_Name;

-- UPDATE Trainee
-- SET VTI_Account = LOWER(CONCAT(Full_Name, '.X', TraineeID, '@gmail.com'))
-- WHERE TraineeID > 0;	-- bypass safe update check

ALTER TABLE Trainee MODIFY COLUMN VTI_Account VARCHAR(255) NOT NULL;
