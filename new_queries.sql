DROP TABLE IF EXISTS conference;

CREATE TABLE conference (
    conference_id SERIAL PRIMARY KEY,
    paperTitle VARCHAR(255) NOT NULL,
    abstract TEXT,
    conferenceName VARCHAR(255),
    publicationLevel VARCHAR(100),
    publicationDate DATE,
    publisher VARCHAR(255),
    doiIsbn VARCHAR(100),
    document BYTEA DEFAULT NULL,
    proofLink VARCHAR(255),
	   approval BOOLEAN DEFAULT NULL
);



DROP TABLE IF EXISTS bookchapter;

CREATE TABLE bookchapter (
	bookchapter_id SERIAL PRIMARY KEY,
    authors TEXT NOT NULL,
    paperTitle VARCHAR(255) NOT NULL,
    abstract TEXT,
    journalName VARCHAR(255),
    publicationLevel VARCHAR(100),
    publicationDate DATE,
    publisher VARCHAR(255),
    doi VARCHAR(100),
    document BYTEA DEFAULT NULL,
    proofLink VARCHAR(255),
    identifier SERIAL,
	approval BOOLEAN DEFAULT NULL
);



DROP TABLE IF EXISTS fdp;

CREATE TABLE fdp (
	fdp_id SERIAL PRIMARY KEY,
    fdpTitle VARCHAR(255) NOT NULL,
    mode VARCHAR(50),
    brochure BYTEA DEFAULT NULL,
    dates VARCHAR(50), -- Stores "from" and "to" dates as a single string
    days VARCHAR(50),
    gpsMedia BYTEA DEFAULT NULL,
    report BYTEA DEFAULT NULL,
    organizers TEXT,
    conveners TEXT,
    feedback BYTEA DEFAULT NULL,
    participantsList BYTEA DEFAULT NULL,
    certificates BYTEA DEFAULT NULL,
    sanctionedAmount NUMERIC(10, 2),
    facultyReceivingAmount NUMERIC(10, 2),
    expenditureReport BYTEA DEFAULT NULL,
    speakersDetails TEXT,
    sponsorship TEXT,
    identifier SERIAL,
	approval BOOLEAN DEFAULT NULL
);



DROP TABLE IF EXISTS journals;

CREATE TABLE journals (
	journal_id SERIAL PRIMARY KEY,
    authors TEXT NOT NULL,
    paperTitle VARCHAR(255) NOT NULL,
    abstract TEXT,
    journalName VARCHAR(255),
    publicationLevel VARCHAR(100),
    publicationDate DATE,
    publisher VARCHAR(255),
    doiIsbn VARCHAR(100),
    document BYTEA DEFAULT NULL,
    proofLink VARCHAR(255),
    impactFactor NUMERIC(5, 2),
    quartile VARCHAR(50),
    identifier SERIAL,
	approval BOOLEAN DEFAULT NULL
);



DROP TABLE IF EXISTS patents;

CREATE TABLE patents (
	patent_id SERIAL PRIMARY KEY,
    applicationNumber VARCHAR(100) NOT NULL,
    patentNumber VARCHAR(100),
    title VARCHAR(255) NOT NULL,
    inventors TEXT NOT NULL,
    patenteeName VARCHAR(255) DEFAULT 'Dayananda Sagar University',
    filingDate DATE,
    status VARCHAR(100),
    patentCountry VARCHAR(100),
    publicationDate DATE,
    abstract TEXT,
    url VARCHAR(255),
    document BYTEA DEFAULT NULL,
    identifier SERIAL,
	approval BOOLEAN DEFAULT NULL
);



DROP TABLE IF EXISTS seminar;

CREATE TABLE seminar (
	seminar_id SERIAL PRIMARY KEY,
    seminarTitle VARCHAR(255) NOT NULL,
    mode VARCHAR(50),
    brochure BYTEA DEFAULT NULL,
    dates VARCHAR(50), -- Stores "from" and "to" dates as a single string
    days VARCHAR(50),
    gpsMedia BYTEA DEFAULT NULL,
    report BYTEA DEFAULT NULL,
    organizers TEXT,
    conveners TEXT,
    feedback BYTEA DEFAULT NULL,
    participantsList BYTEA DEFAULT NULL,
    certificates BYTEA DEFAULT NULL,
    sanctionedAmount NUMERIC(10, 2),
    facultyReceivingAmount NUMERIC(10, 2),
    expenditureReport BYTEA DEFAULT NULL,
    speakersDetails TEXT,
    identifier SERIAL,
	approval BOOLEAN DEFAULT NULL
);



DROP TABLE IF EXISTS workshop;

CREATE TABLE workshop (
	workshop_id SERIAL PRIMARY KEY,
    workshopTitle VARCHAR(255) NOT NULL,
    mode VARCHAR(50),
    brochure BYTEA DEFAULT NULL,
    dates VARCHAR(50), -- Stores "from" and "to" dates as a single string
    days VARCHAR(50),
    gpsMedia BYTEA DEFAULT NULL,
    report BYTEA DEFAULT NULL,
    organizers TEXT,
    conveners TEXT,
    feedback BYTEA DEFAULT NULL,
    participantsList BYTEA DEFAULT NULL,
    certificates BYTEA DEFAULT NULL,
    sanctionedAmount NUMERIC(10, 2),
    facultyReceivingAmount NUMERIC(10, 2),
    expenditureReport BYTEA DEFAULT NULL,
    speakersDetails TEXT,
    identifier SERIAL,
	approval BOOLEAN DEFAULT NULL
);

select * from conference;
select * from bookchapter;
select * from fdp;
select * from journals;
select * from patents;
select * from seminar;
select * from workshop;