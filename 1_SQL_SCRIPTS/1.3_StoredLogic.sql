
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
DELIMITER $$

CREATE TRIGGER trg_UpdatePersonStatus
AFTER UPDATE ON TrainingEnrollment
FOR EACH ROW
BEGIN
    IF NEW.Status = 'Completed' THEN
        UPDATE People
        SET Status = 'Trained'
        WHERE PersonID = NEW.PersonID;
    END IF;
END$$

DELIMITER ;


-- Show person's status
SELECT PersonID, Status
FROM People
WHERE PersonID = 4;

-- Show enrollment's status
SELECT PersonID, ProgramID, Status
FROM TrainingEnrollment
WHERE PersonID = 4 AND ProgramID = 4;

-- Run the trigger and then show the status once again.
UPDATE TrainingEnrollment
SET Status = 'Completed'
WHERE PersonID = 4 AND ProgramID = 4;

--------------------------------------------------------------------------------------------------

-- Training Program Completion Report (View)
CREATE VIEW CompletedTrainingReport AS 
SELECT  
    P.PersonID, 
    P.FullName, 
    TP.ProgramName, 
    TE.EnrollmentDate, 
    TE.Status 
FROM TrainingEnrollment TE 
JOIN People P ON TE.PersonID = P.PersonID 
JOIN TrainingPrograms TP ON TE.ProgramID = TP.ProgramID 
WHERE TE.Status = 'Completed'; 

-- Show the list of the programs that's been completed
SELECT * FROM CompletedTrainingReport;

--------------------------------------------------------------------------------------------------

-- Employment Outcome After Training (View)
CREATE VIEW EmploymentAfterTraining AS
SELECT 
    P.FullName,
    TP.ProgramName,
    J.JobTitle,
    JA.Status AS ApplicationStatus
FROM People P
JOIN TrainingEnrollment TE ON P.PersonID = TE.PersonID
JOIN TrainingPrograms TP ON TE.ProgramID = TP.ProgramID
JOIN JobApplications JA ON P.PersonID = JA.PersonID
JOIN Jobs J ON JA.JobID = J.JobID
WHERE TE.Status = 'Completed';

-- Show the list of trained people who applied for jobs
SELECT * FROM EmploymentAfterTraining;

--------------------------------------------------------------------------------------------------

-- Unemployed individuals eligible for training (View)
CREATE VIEW UnemployedTrainingCandidates AS
SELECT 
    PersonID,
    FullName,
    Skills,
    RegistrationDate
FROM People
WHERE Status = 'Unemployed';

-- Show the result
SELECT * FROM UnemployedTrainingCandidates;

--------------------------------------------------------------------------------------------------

-- Job Demand by Skill (View)

CREATE VIEW JobDemandBySkill AS
SELECT 
    SkillTaught,
    COUNT(JobID) AS TotalJobs
FROM TrainingPrograms
GROUP BY SkillTaught;

-- Show the labor market trends
SELECT * FROM JobDemandBySkill;

--------------------------------------------------------------------------------------------------

-- Average Training Rating (View)
CREATE VIEW TrainingQualityReport AS
SELECT 
    TP.ProgramName,
    AVG(TF.Rating) AS AverageRating
FROM TrainingFeedback TF
JOIN TrainingPrograms TP ON TF.ProgramID = TP.ProgramID
GROUP BY TP.ProgramName;

-- Show the ratings of all program/training
SELECT * FROM TrainingQualityReport;

--------------------------------------------------------------------------------------------------
