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

CREATE TABLE "Event" (
    "eventID" SERIAL PRIMARY KEY,
    "eventTitle" VARCHAR(100) NOT NULL,
    "eventType" VARCHAR(50) NOT NULL,
    "startDate" DATE NOT NULL,
    "endDate" DATE NOT NULL,
    "location" VARCHAR(100) NOT NULL,
    "approval" BOOLEAN DEFAULT FALSE
);

ALTER TABLE "Event"
ADD COLUMN "Faculty involved" VARCHAR(255);

ALTER TABLE "Event"
RENAME COLUMN "Faculty involved" TO "faculty";

ALTER TABLE "Event"
ALTER COLUMN "approval" SET DEFAULT NULL;

UPDATE "Event"
SET "approval"=NULL;
