
CREATE TABLE People (
    PersonID INT AUTO_INCREMENT PRIMARY KEY,
    FullName VARCHAR(150) NOT NULL,
    Age INT NOT NULL CHECK (Age BETWEEN 18 AND 60),
    Status VARCHAR(50) NOT NULL CHECK (Status IN ('Unemployed', 'Employed', 'In Training', 'Trained')),
    Skills VARCHAR(255),
    RegistrationDate DATE NOT NULL
);

CREATE TABLE Jobs (
    JobID INT AUTO_INCREMENT PRIMARY KEY,
    JobTitle VARCHAR(150) NOT NULL,
    CompanyName VARCHAR(150) NOT NULL,
    Location VARCHAR(150),
    Salary DECIMAL(10,2),
    JobType VARCHAR(100)
);

CREATE TABLE TrainingPrograms (
    ProgramID INT AUTO_INCREMENT PRIMARY KEY,
    ProgramName VARCHAR(150) NOT NULL,
    SkillTaught VARCHAR(100) NOT NULL,
    DurationWeeks INT NOT NULL CHECK (DurationWeeks > 0),
    AvailableTo VARCHAR(100) NOT NULL,
    JobID INT,
    FOREIGN KEY (JobID) REFERENCES Jobs(JobID) ON DELETE SET NULL
);

CREATE TABLE TrainingEnrollment (
    EnrollmentID INT AUTO_INCREMENT PRIMARY KEY,
    PersonID INT NOT NULL,
    ProgramID INT NOT NULL,
    EnrollmentDate DATE NOT NULL,
    Status VARCHAR(50) NOT NULL CHECK (Status IN ('Enrolled', 'Completed', 'Dropped')),
    FOREIGN KEY (PersonID) REFERENCES People(PersonID) ON DELETE CASCADE,
    FOREIGN KEY (ProgramID) REFERENCES TrainingPrograms(ProgramID) ON DELETE CASCADE,
    UNIQUE(PersonID, ProgramID) -- to prevent duplicate applications
);

CREATE TABLE JobApplications (
    ApplicationID INT AUTO_INCREMENT PRIMARY KEY,
    PersonID INT NOT NULL,
    JobID INT NOT NULL,
    ApplicationDate DATE NOT NULL,
    Status VARCHAR(50) DEFAULT 'Pending',
    FOREIGN KEY (PersonID) REFERENCES People(PersonID) ON DELETE CASCADE,
    FOREIGN KEY (JobID) REFERENCES Jobs(JobID) ON DELETE CASCADE,
    UNIQUE(PersonID, JobID) -- to prevent duplicate applications
);

CREATE TABLE TrainingFeedback (
    FeedbackID INT AUTO_INCREMENT PRIMARY KEY,
    PersonID INT NOT NULL,
    ProgramID INT NOT NULL,
    Rating INT NOT NULL CHECK (Rating BETWEEN 1 AND 5),
    Comments VARCHAR(500),
    FeedbackDate DATE NOT NULL,
    FOREIGN KEY (PersonID) REFERENCES People(PersonID) ON DELETE CASCADE,
    FOREIGN KEY (ProgramID) REFERENCES TrainingPrograms(ProgramID) ON DELETE CASCADE
);
