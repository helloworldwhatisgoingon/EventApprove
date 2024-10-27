CREATE USER Punith WITH PASSWORD 'qwerty';
Create database Events_Organised;
GRANT CONNECT ON DATABASE Events_Organised TO Punith;
GRANT USAGE ON SCHEMA public TO Punith;
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public TO Punith;
ALTER DEFAULT PRIVILEGES IN SCHEMA public 
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO Punith;




CREATE TABLE EventsOrganized (
    id VARCHAR PRIMARY KEY
);
CREATE TABLE Workshop (
    workshopTitle VARCHAR,
    type VARCHAR CHECK (type IN ('Online', 'Offline')),
    brochure BYTEA,
    startDate DATE,
    endDate DATE,
    numberOfDays INTEGER,
    gpsPhotos BYTEA,
    report BYTEA,
    organizers VARCHAR,
    conveners VARCHAR,
    feedback BYTEA,
    participantsList BYTEA,
    certificates BYTEA,
    amountSanctioned DECIMAL,
    facultyReceivingSanctionedAmount VARCHAR,
    expenditureReport BYTEA,
    speakerDetails VARCHAR
);
CREATE TABLE FDP (
    fdpTitle VARCHAR,
    type VARCHAR CHECK (type IN ('Online', 'Offline')),
    brochure BYTEA,
    startDate DATE,
    endDate DATE,
    numberOfDays INTEGER,
    gpsPhotos BYTEA,
    report BYTEA,
    organizers VARCHAR,
    conveners VARCHAR,
    feedback BYTEA,
    participantsList BYTEA,
    certificates BYTEA,
    amountSanctioned DECIMAL,
    facultyReceivingSanctionedAmount VARCHAR,
    expenditureReport BYTEA,
    speakerDetails VARCHAR,
    sponsorship VARCHAR
);
CREATE TABLE Seminar (
    seminarTitle VARCHAR,
    type VARCHAR CHECK (type IN ('Online', 'Offline')),
    brochure BYTEA,
    startDate DATE,
    endDate DATE,
    numberOfDays INTEGER,
    gpsPhotos BYTEA,
    report BYTEA,
    organizers VARCHAR,
    conveners VARCHAR,
    feedback BYTEA,
    participantsList BYTEA,
    certificates BYTEA,
    amountSanctioned DECIMAL,
    facultyReceivingSanctionedAmount VARCHAR,
    expenditureReport BYTEA,
    speakerDetails VARCHAR
);
CREATE TABLE Conference (
    conferenceTitle VARCHAR,
    theme VARCHAR,
    type VARCHAR CHECK (type IN ('Online', 'Offline')),
    brochure BYTEA,
    startDate DATE,
    endDate DATE,
    numberOfDays INTEGER,
    gpsSchedule BYTEA,
    photos BYTEA,
    report BYTEA,
    organizers VARCHAR,
    conveners VARCHAR,
    feedback BYTEA,
    participantsList BYTEA,
    certificates BYTEA,
    amountSanctioned DECIMAL,
    facultyReceivingSanctionedAmount VARCHAR,
    expenditureReport BYTEA,
    keynoteSpeakers VARCHAR,
    speakerDetails VARCHAR,
    sponsorship VARCHAR
);
CREATE TABLE ClubActivity (
    clubName VARCHAR,
    activityType VARCHAR CHECK (activityType IN ('Workshop', 'Boot Camp', 'Seminar', 'Quiz', 'Hackathon')),
    title VARCHAR,
    startDate DATE,
    endDate DATE,
    numberOfDays INTEGER,
    gpsPhotos BYTEA,
    budgetSanctioned DECIMAL,
    report BYTEA,
    organizers VARCHAR,
    conveners VARCHAR,
    feedback BYTEA,
    participantsList BYTEA,
    certificates BYTEA,
    speakerDetails VARCHAR
);



INSERT INTO Workshop (
    workshopTitle,
    type,
    brochure,
    startDate,
    endDate,
    numberOfDays,
    gpsPhotos,
    report,
    organizers,
    conveners,
    feedback,
    participantsList,
    certificates,
    amountSanctioned,
    facultyReceivingSanctionedAmount,
    expenditureReport,
    speakerDetails
)
VALUES (
    'Advanced Python Workshop',
    'Online',
    pg_read_binary_file('C:/Users/USER/OneDrive/Documents/sample_1.pdf'),  -- PDF file path for brochure
    '2024-11-01',  -- Start Date
    '2024-11-05',  -- End Date
    5,  -- Number of Days
    pg_read_binary_file('C:/Users/USER/OneDrive/Documents/sample_1.pdf'),  -- Image file path for GPS photo
    pg_read_binary_file('C:/Users/USER/OneDrive/Documents/sample_1.pdf'),  -- PDF file path for report
    'John Doe, Jane Smith',  -- Organizers
    'Dr. Emily Clark',  -- Conveners
    pg_read_binary_file('C:/Users/USER/OneDrive/Documents/sample_1.pdf'),  -- PDF file path for certificates
    pg_read_binary_file('C:/Users/USER/OneDrive/Documents/sample_1.pdf'),
	pg_read_binary_file('C:/Users/USER/OneDrive/Documents/sample_1.pdf'),
	5000.00,  -- Amount Sanctioned
    'Dr. Emily Clark',  -- Faculty Receiving Sanctioned Amount
    pg_read_binary_file('C:/Users/USER/OneDrive/Documents/sample_1.pdf')
,  -- PDF file path for expenditure report
    'Prof. John Watson, Dr. Emily Clark'  -- Speaker Details
);



SELECT
    workshopTitle,
    type,
    startDate,
    endDate,
    numberOfDays,
    gpsPhotos,
    brochure,
    report,
    organizers,
    conveners,
    feedback,
    participantsList,
    certificates,
    amountSanctioned,
    facultyReceivingSanctionedAmount,
    expenditureReport,
    speakerDetails
FROM Workshop
WHERE workshopTitle = 'Advanced Python Workshop';

SELECT brochure
FROM Workshop
WHERE workshopTitle = 'Advanced Python Workshop';

-- Change this as you like
CREATE TABLE "Event" (
    "eventID" SERIAL PRIMARY KEY,
    "eventTitle" VARCHAR(100) NOT NULL,
    "eventType" VARCHAR(50) NOT NULL,
    "startDate" DATE NOT NULL,
    "endDate" DATE NOT NULL,
    "location" VARCHAR(100) NOT NULL,
    "approval" BOOLEAN DEFAULT FALSE
);