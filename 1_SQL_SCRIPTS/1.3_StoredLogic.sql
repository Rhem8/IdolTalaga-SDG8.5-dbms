
-- Apply for a Job (Stored Procedure)
DELIMITER $$

CREATE PROCEDURE ApplyForJob (
    IN p_PersonID INT,
    IN p_JobID INT
)
BEGIN
    DECLARE alreadyApplied INT;

    START TRANSACTION;

    SELECT COUNT(*) INTO alreadyApplied
    FROM JobApplications
    WHERE PersonID = p_PersonID AND JobID = p_JobID;

    IF alreadyApplied > 0 THEN
        ROLLBACK;
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Application already exists.';
    ELSE
        INSERT INTO JobApplications (PersonID, JobID, ApplicationDate, Status)
        VALUES (p_PersonID, p_JobID, CURDATE(), 'Pending');

        COMMIT;
    END IF;
END$$

DELIMITER ;

-- execute the procedure
CALL ApplyForJob(1, 5);
-- or other (PersonID, JobID)

-- show the result
SELECT * 
FROM JobApplications
WHERE PersonID = 1 AND JobID = 5;

--------------------------------------------------------------------------------------------------

-- Complete Training Program (Stored Procedure)
DELIMITER $$

CREATE PROCEDURE CompleteTraining (
    IN p_PersonID INT,
    IN p_ProgramID INT
)
BEGIN
    START TRANSACTION;

    UPDATE TrainingEnrollment
    SET Status = 'Completed'
    WHERE PersonID = p_PersonID
      AND ProgramID = p_ProgramID;

    UPDATE People
    SET Status = 'Trained'
    WHERE PersonID = p_PersonID;

    COMMIT;
END$$

DELIMITER ;

-- execute the procedure
CALL CompleteTraining(1, 1);
-- or other (PersonID, ProgramID)

-- show the result
SELECT PersonID, ProgramID, Status
FROM TrainingEnrollment
WHERE PersonID = 1 AND ProgramID = 1;

--------------------------------------------------------------------------------------------------

-- Auto-update Person Status When Training Is Completed (Trigger)
...
