from flask_sqlalchemy import SQLAlchemy

# Initialize the database instance
db = SQLAlchemy()

class Event(db.Model):
    __tablename__ = 'Event'

    eventID = db.Column(db.Integer, primary_key=True, autoincrement=True, nullable=True)  # Auto-incrementing integer ID
    eventTitle = db.Column(db.String, nullable=False)
    eventType = db.Column(db.String, nullable=False)
    startDate = db.Column(db.Date, nullable=False)
    endDate = db.Column(db.Date, nullable=False)
    location = db.Column(db.String, nullable=False)
    approval = db.Column(db.Boolean, default=False)
    eventPDF = db.Column(db.LargeBinary, nullable=True)  # New column for storing PDF files
    timings = db.Column(db.String, nullable=False)
    faculty = db.Column(db.String, nullable=False)

    def to_dict(self):
        return {
            'eventID': self.eventID,
            'eventTitle': self.eventTitle,
            'eventType': self.eventType,
            'startDate': self.startDate.isoformat(),
            'endDate': self.endDate.isoformat(),
            'location': self.location,
            'approval': self.approval,
            'eventPDF': bool(self.eventPDF),  # Indicates if a PDF is stored
            'timings': self.timings,
            'faculty': self.faculty,
        }

class Conference(db.Model):
    __tablename__ = 'conference'

    conference_id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    master_id = db.Column(db.Integer, db.ForeignKey('master_event.master_id'), nullable=False)
    papertitle = db.Column(db.String(255), nullable=False)
    abstract = db.Column(db.Text, nullable=True)
    conferencename = db.Column(db.String(255), nullable=True)
    publicationlevel = db.Column(db.String(100), nullable=True)
    publicationdate = db.Column(db.Date, nullable=True)
    publisher = db.Column(db.String(255), nullable=True)
    doiisbn = db.Column(db.String(100), nullable=True)
    document = db.Column(db.LargeBinary, nullable=True, default=None)
    prooflink = db.Column(db.String(255), nullable=True)

    def to_dict(self):
        """Convert the object to a dictionary for easy serialization."""
        return {
            'conference_id': self.conference_id,
            'master_id': self.master_id,
            'papertitle': self.papertitle,
            'abstract': self.abstract,
            'conferencename': self.conferencename,
            'publicationlevel': self.publicationlevel,
            'publicationdate': self.publicationdate.isoformat() if self.publicationdate else None,
            'publisher': self.publisher,
            'doiisbn': self.doiisbn,
            'document': self.document if self.document else None,  # Return actual bytes instead of bool
            'prooflink': self.prooflink
        }

class Journal(db.Model):
    __tablename__ = 'journals'

    journal_id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    authors = db.Column(db.Text, nullable=False)
    papertitle = db.Column(db.String(255), nullable=False)
    abstract = db.Column(db.Text, nullable=True)
    journalname = db.Column(db.String(255), nullable=True)
    publicationlevel = db.Column(db.String(100), nullable=True)
    publicationdate = db.Column(db.Date, nullable=True)
    publisher = db.Column(db.String(255), nullable=True)
    doiisbn = db.Column(db.String(100), nullable=True)
    document = db.Column(db.LargeBinary, nullable=True, default=None)
    prooflink = db.Column(db.String(255), nullable=True)
    impactfactor = db.Column(db.Numeric(5, 2), nullable=True)
    quartile = db.Column(db.String(50), nullable=True)
    identifier = db.Column(db.Integer, nullable=False, autoincrement=True)
    master_id = db.Column(db.Integer, db.ForeignKey('master_event.master_id'), nullable=True)

    def to_dict(self):
        """Convert the object to a dictionary for easy serialization."""
        return {
            'journal_id': self.journal_id,
            'authors': self.authors,
            'papertitle': self.papertitle,
            'abstract': self.abstract,
            'journalname': self.journalname,
            'publicationlevel': self.publicationlevel,
            'publicationdate': self.publicationdate.isoformat() if self.publicationdate else None,
            'publisher': self.publisher,
            'doiisbn': self.doiisbn,
            'document': self.document if self.document else None,
            'prooflink': self.prooflink,
            'impactfactor': float(self.impactfactor) if self.impactfactor else None,
            'quartile': self.quartile,
            'identifier': self.identifier,
            'master_id': self.master_id
        }

class BookChapter(db.Model):
    __tablename__ = 'bookchapter'

    bookchapter_id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    authors = db.Column(db.Text, nullable=False)
    papertitle = db.Column(db.String(255), nullable=False)
    abstract = db.Column(db.Text, nullable=True)
    journalname = db.Column(db.String(255), nullable=True)
    publicationlevel = db.Column(db.String(100), nullable=True)
    publicationdate = db.Column(db.Date, nullable=True)
    publisher = db.Column(db.String(255), nullable=True)
    doi = db.Column(db.String(100), nullable=True)
    document = db.Column(db.LargeBinary, nullable=True, default=None)
    prooflink = db.Column(db.String(255), nullable=True)
    identifier = db.Column(db.Integer, nullable=False, autoincrement=True)
    master_id = db.Column(db.Integer, db.ForeignKey('master_event.master_id'), nullable=True)

    def to_dict(self):
        """Convert the object to a dictionary for easy serialization."""
        return {
            'bookchapter_id': self.bookchapter_id,
            'authors': self.authors,
            'papertitle': self.papertitle,
            'abstract': self.abstract,
            'journalname': self.journalname,
            'publicationlevel': self.publicationlevel,
            'publicationdate': self.publicationdate.isoformat() if self.publicationdate else None,
            'publisher': self.publisher,
            'doi': self.doi,
            'document': self.document if self.document else None,
            'prooflink': self.prooflink,
            'identifier': self.identifier,
            'master_id': self.master_id
        }
    
class Workshop(db.Model):
    __tablename__ = 'workshop'

    workshop_id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    workshoptitle = db.Column(db.String(255), nullable=False)
    mode = db.Column(db.String(50), nullable=True)
    brochure = db.Column(db.LargeBinary, nullable=True, default=None)
    dates = db.Column(db.String(50), nullable=True)
    days = db.Column(db.String(50), nullable=True)
    gpsmedia = db.Column(db.LargeBinary, nullable=True, default=None)
    report = db.Column(db.LargeBinary, nullable=True, default=None)
    organizers = db.Column(db.Text, nullable=True)
    conveners = db.Column(db.Text, nullable=True)
    feedback = db.Column(db.LargeBinary, nullable=True, default=None)
    participantslist = db.Column(db.LargeBinary, nullable=True, default=None)
    certificates = db.Column(db.LargeBinary, nullable=True, default=None)
    sanctionedamount = db.Column(db.Numeric(10, 2), nullable=True)
    facultyreceivingamount = db.Column(db.Numeric(10, 2), nullable=True)
    expenditurereport = db.Column(db.LargeBinary, nullable=True, default=None)
    speakersdetails = db.Column(db.Text, nullable=True)
    identifier = db.Column(db.Integer, nullable=False, autoincrement=True)
    master_id = db.Column(db.Integer, db.ForeignKey('master_event.master_id'), nullable=True)

    def to_dict(self):
        """Convert the object to a dictionary for easy serialization."""
        return {
            'workshop_id': self.workshop_id,
            'workshoptitle': self.workshoptitle,
            'mode': self.mode,
            'brochure': self.brochure if self.brochure else None,
            'dates': self.dates,
            'days': self.days,
            'gpsmedia': self.gpsmedia if self.gpsmedia else None,
            'report': self.report if self.report else None,
            'organizers': self.organizers,
            'conveners': self.conveners,
            'feedback': self.feedback if self.feedback else None,
            'participantslist': self.participantslist if self.participantslist else None,
            'certificates': self.certificates if self.certificates else None,
            'sanctionedamount': str(self.sanctionedamount) if self.sanctionedamount else None,
            'facultyreceivingamount': str(self.facultyreceivingamount) if self.facultyreceivingamount else None,
            'expenditurereport': self.expenditurereport if self.expenditurereport else None,
            'speakersdetails': self.speakersdetails,
            'identifier': self.identifier,
            'master_id': self.master_id
        }
    
class Patent(db.Model):
    __tablename__ = 'patents'

    patent_id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    applicationnumber = db.Column(db.String(100), nullable=False)
    patentnumber = db.Column(db.String(100), nullable=True)
    title = db.Column(db.String(255), nullable=False)
    inventors = db.Column(db.Text, nullable=False)
    patenteename = db.Column(db.String(255), nullable=True, default='Dayananda Sagar University')
    filingdate = db.Column(db.Date, nullable=True)
    status = db.Column(db.String(100), nullable=True)
    patentcountry = db.Column(db.String(100), nullable=True)
    publicationdate = db.Column(db.Date, nullable=True)
    abstract = db.Column(db.Text, nullable=True)
    url = db.Column(db.String(255), nullable=True)
    document = db.Column(db.LargeBinary, nullable=True, default=None)
    identifier = db.Column(db.Integer, nullable=False, autoincrement=True)
    master_id = db.Column(db.Integer, db.ForeignKey('master_event.master_id'), nullable=True)

    def to_dict(self):
        """Convert the object to a dictionary for easy serialization."""
        return {
            'patent_id': self.patent_id,
            'applicationnumber': self.applicationnumber,
            'patentnumber': self.patentnumber,
            'title': self.title,
            'inventors': self.inventors,
            'patenteename': self.patenteename,
            'filingdate': self.filingdate.isoformat() if self.filingdate else None,
            'status': self.status,
            'patentcountry': self.patentcountry,
            'publicationdate': self.publicationdate.isoformat() if self.publicationdate else None,
            'abstract': self.abstract,
            'url': self.url,
            'document': self.document if self.document else None,
            'identifier': self.identifier,
            'master_id': self.master_id
        }

class Fdp(db.Model):
    __tablename__ = 'fdp'

    fdp_id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    fdptitle = db.Column(db.String(255), nullable=False)
    mode = db.Column(db.String(50), nullable=True)
    brochure = db.Column(db.LargeBinary, nullable=True)
    dates = db.Column(db.String(50), nullable=True)
    days = db.Column(db.String(50), nullable=True)
    gpsmedia = db.Column(db.LargeBinary, nullable=True)
    report = db.Column(db.LargeBinary, nullable=True)
    organizers = db.Column(db.Text, nullable=True)
    conveners = db.Column(db.Text, nullable=True)
    feedback = db.Column(db.LargeBinary, nullable=True)
    participantslist = db.Column(db.LargeBinary, nullable=True)
    certificates = db.Column(db.LargeBinary, nullable=True)
    sanctionedamount = db.Column(db.Numeric(10, 2), nullable=True)
    facultyreceivingamount = db.Column(db.Numeric(10, 2), nullable=True)
    expenditurereport = db.Column(db.LargeBinary, nullable=True)
    speakersdetails = db.Column(db.Text, nullable=True)
    sponsorship = db.Column(db.Text, nullable=True)
    identifier = db.Column(db.Integer, nullable=False, autoincrement=True)
    master_id = db.Column(db.Integer, db.ForeignKey('master_event.master_id'), nullable=True)

    def to_dict(self):
        """Convert the object to a dictionary for easy serialization."""
        return {
            'fdp_id': self.fdp_id,
            'fdptitle': self.fdptitle,
            'mode': self.mode,
            'brochure': self.brochure if self.brochure else None,
            'dates': self.dates,
            'days': self.days,
            'gpsmedia': self.gpsmedia if self.gpsmedia else None,
            'report': self.report if self.report else None,
            'organizers': self.organizers,
            'conveners': self.conveners,
            'feedback': self.feedback if self.feedback else None,
            'participantslist': self.participantslist if self.participantslist else None,
            'certificates': self.certificates if self.certificates else None,
            'sanctionedamount': float(self.sanctionedamount) if self.sanctionedamount else None,
            'facultyreceivingamount': float(self.facultyreceivingamount) if self.facultyreceivingamount else None,
            'expenditurereport': self.expenditurereport if self.expenditurereport else None,
            'speakersdetails': self.speakersdetails,
            'sponsorship': self.sponsorship,
            'identifier': self.identifier,
            'master_id': self.master_id
        }

class Seminar(db.Model):
    __tablename__ = 'seminar'

    seminar_id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    seminartitle = db.Column(db.String(255), nullable=False)
    mode = db.Column(db.String(50), nullable=True)
    brochure = db.Column(db.LargeBinary, nullable=True)
    dates = db.Column(db.String(50), nullable=True)
    days = db.Column(db.String(50), nullable=True)
    gpsmedia = db.Column(db.LargeBinary, nullable=True)
    report = db.Column(db.LargeBinary, nullable=True)
    organizers = db.Column(db.Text, nullable=True)
    conveners = db.Column(db.Text, nullable=True)
    feedback = db.Column(db.LargeBinary, nullable=True)
    participantslist = db.Column(db.LargeBinary, nullable=True)
    certificates = db.Column(db.LargeBinary, nullable=True)
    sanctionedamount = db.Column(db.Numeric(10, 2), nullable=True)
    facultyreceivingamount = db.Column(db.Numeric(10, 2), nullable=True)
    expenditurereport = db.Column(db.LargeBinary, nullable=True)
    speakersdetails = db.Column(db.Text, nullable=True)
    identifier = db.Column(db.Integer, nullable=False, autoincrement=True)
    master_id = db.Column(db.Integer, db.ForeignKey('master_event.master_id'), nullable=True)

    def to_dict(self):
        """Convert the object to a dictionary for easy serialization."""
        return {
            'seminar_id': self.seminar_id,
            'seminartitle': self.seminartitle,
            'mode': self.mode,
            'brochure': self.brochure if self.brochure else None,
            'dates': self.dates,
            'days': self.days,
            'gpsmedia': self.gpsmedia if self.gpsmedia else None,
            'report': self.report if self.report else None,
            'organizers': self.organizers,
            'conveners': self.conveners,
            'feedback': self.feedback if self.feedback else None,
            'participantslist': self.participantslist if self.participantslist else None,
            'certificates': self.certificates if self.certificates else None,
            'sanctionedamount': float(self.sanctionedamount) if self.sanctionedamount else None,
            'facultyreceivingamount': float(self.facultyreceivingamount) if self.facultyreceivingamount else None,
            'expenditurereport': self.expenditurereport if self.expenditurereport else None,
            'speakersdetails': self.speakersdetails,
            'identifier': self.identifier,
            'master_id': self.master_id
        }

class ClubActivity(db.Model):
    __tablename__ = 'clubactivity'

    clubactivity_id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    clubname = db.Column(db.String(255), nullable=True)
    activitytype = db.Column(db.String(100), nullable=True)
    title = db.Column(db.String(255), nullable=True)
    activitydate = db.Column(db.Date, nullable=True)
    numdays = db.Column(db.Integer, nullable=True)
    gpsmedia = db.Column(db.LargeBinary, nullable=True)
    budget = db.Column(db.Numeric(10, 2), nullable=True)
    report = db.Column(db.LargeBinary, nullable=True)
    organizers = db.Column(db.Text, nullable=True)
    conveners = db.Column(db.Text, nullable=True)
    feedback = db.Column(db.LargeBinary, nullable=True)
    participantslist = db.Column(db.LargeBinary, nullable=True)
    certificates = db.Column(db.LargeBinary, nullable=True)
    speakersdetails = db.Column(db.Text, nullable=True)
    master_id = db.Column(db.Integer, db.ForeignKey('master_event.master_id'), nullable=True)

    def to_dict(self):
        """Convert the object to a dictionary for easy serialization."""
        return {
            'clubactivity_id': self.clubactivity_id,
            'clubname': self.clubname,
            'activitytype': self.activitytype,
            'title': self.title,
            'activitydate': self.activitydate.isoformat() if self.activitydate else None,
            'numdays': self.numdays,
            'gpsmedia': self.gpsmedia if self.gpsmedia else None,
            'budget': float(self.budget) if self.budget else None,
            'report': self.report if self.report else None,
            'organizers': self.organizers,
            'conveners': self.conveners,
            'feedback': self.feedback,
            'participantslist': self.participantslist if self.participantslist else None,
            'certificates': self.certificates if self.certificates else None,
            'speakersdetails': self.speakersdetails,
            'master_id': self.master_id
        }

class IndustrialVisit(db.Model):
    __tablename__ = 'industrial_visit'

    visit_id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    companyname = db.Column(db.String(255), nullable=True)
    industrytype = db.Column(db.String(100), nullable=True)
    visittitle = db.Column(db.String(255), nullable=True)
    visitdate = db.Column(db.Date, nullable=True)
    numdays = db.Column(db.Integer, nullable=True)
    gpsmedia = db.Column(db.LargeBinary, nullable=True)
    budget = db.Column(db.Numeric(10, 2), nullable=True)
    report = db.Column(db.LargeBinary, nullable=True)
    organizers = db.Column(db.Text, nullable=True)
    conveners = db.Column(db.Text, nullable=True)
    feedback = db.Column(db.LargeBinary, nullable=True)
    participantslist = db.Column(db.LargeBinary, nullable=True)
    certificates = db.Column(db.LargeBinary, nullable=True)
    speakersdetails = db.Column(db.Text, nullable=True)
    master_id = db.Column(db.Integer, db.ForeignKey('master_event.master_id'), nullable=True)

    def to_dict(self):
        """Convert the object to a dictionary for easy serialization."""
        return {
            'visit_id': self.visit_id,
            'companyname': self.companyname,
            'industrytype': self.industrytype,
            'visittitle': self.visittitle,
            'visitdate': self.visitdate.isoformat() if self.visitdate else None,
            'numdays': self.numdays,
            'gpsmedia': self.gpsmedia if self.gpsmedia else None,
            'budget': float(self.budget) if self.budget else None,
            'report': self.report if self.report else None,
            'organizers': self.organizers,
            'conveners': self.conveners,
            'feedback': self.feedback,
            'participantslist': self.participantslist if self.participantslist else None,
            'certificates': self.certificates if self.certificates else None,
            'speakersdetails': self.speakersdetails,
            'master_id': self.master_id
        }

class FacultyAchievement(db.Model):
    __tablename__ = 'faculty_achievements'

    achievement_id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    facultyname = db.Column(db.String(255), nullable=True)
    designation = db.Column(db.String(100), nullable=True)
    achievementdate = db.Column(db.Date, nullable=True)
    recognition = db.Column(db.String(255), nullable=True)
    eventname = db.Column(db.String(255), nullable=True)
    awardname = db.Column(db.String(255), nullable=True)
    awardingorganization = db.Column(db.String(255), nullable=True)
    gpsphoto = db.Column(db.LargeBinary, nullable=True)
    report = db.Column(db.LargeBinary, nullable=True)
    proof = db.Column(db.LargeBinary, nullable=True)
    certificateproof = db.Column(db.LargeBinary, nullable=True)
    master_id = db.Column(db.Integer, db.ForeignKey('master_event.master_id'), nullable=True)

    def to_dict(self):
        """Convert the object to a dictionary for easy serialization."""
        return {
            'achievement_id': self.achievement_id,
            'facultyname': self.facultyname,
            'designation': self.designation,
            'achievementdate': self.achievementdate.isoformat() if self.achievementdate else None,
            'recognition': self.recognition,
            'eventname': self.eventname,
            'awardname': self.awardname,
            'awardingorganization': self.awardingorganization,
            'gpsphoto': self.gpsphoto if self.gpsphoto else None,
            'report': self.report if self.report else None,
            'proof': self.proof if self.proof else None,
            'certificateproof': self.certificateproof if self.certificateproof else None,
            'master_id': self.master_id
        }

class StudentAchievement(db.Model):
    __tablename__ = 'student_achievements'

    achievement_id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    studentnames = db.Column(db.Text, nullable=True)
    usns = db.Column(db.Text, nullable=True)
    yearofstudy = db.Column(db.String(50), nullable=True)
    eventtype = db.Column(db.String(100), nullable=True)
    eventtitle = db.Column(db.String(255), nullable=True)
    achievementdate = db.Column(db.Date, nullable=True)
    companyorganization = db.Column(db.String(255), nullable=True)
    recognition = db.Column(db.String(255), nullable=True)
    certificateproof = db.Column(db.LargeBinary, nullable=True)
    gpsphoto = db.Column(db.LargeBinary, nullable=True)
    report = db.Column(db.LargeBinary, nullable=True)
    master_id = db.Column(db.Integer, db.ForeignKey('master_event.master_id'), nullable=True)

    def to_dict(self):
        """Convert the object to a dictionary for easy serialization."""
        return {
            'achievement_id': self.achievement_id,
            'studentnames': self.studentnames,
            'usns': self.usns,
            'yearofstudy': self.yearofstudy,
            'eventtype': self.eventtype,
            'eventtitle': self.eventtitle,
            'achievementdate': self.achievementdate.isoformat() if self.achievementdate else None,
            'companyorganization': self.companyorganization,
            'recognition': self.recognition,
            'certificateproof': self.certificateproof if self.certificateproof else None,
            'gpsphoto': self.gpsphoto if self.gpsphoto else None,
            'report': self.report if self.report else None,
            'master_id': self.master_id
        }

class ProfessionalSociety(db.Model):
    __tablename__ = 'professional_societies'

    society_id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    societyname = db.Column(db.String(255), nullable=True)
    eventtype = db.Column(db.String(100), nullable=True)
    activitytype = db.Column(db.String(100), nullable=True)
    activitydate = db.Column(db.Date, nullable=True)
    numberofdays = db.Column(db.Integer, nullable=True)
    gpsphotosvideos = db.Column(db.LargeBinary, nullable=True)
    budgetsanctioned = db.Column(db.Numeric(10, 2), nullable=True)
    eventreport = db.Column(db.LargeBinary, nullable=True)
    organizers = db.Column(db.Text, nullable=True)
    conveners = db.Column(db.Text, nullable=True)
    feedback = db.Column(db.LargeBinary, nullable=True)
    participantslist = db.Column(db.LargeBinary, nullable=True)
    certificates = db.Column(db.LargeBinary, nullable=True)
    speakerdetails = db.Column(db.Text, nullable=True)
    master_id = db.Column(db.Integer, db.ForeignKey('master_event.master_id'), nullable=True)

    def to_dict(self):
        """Convert the object to a dictionary for easy serialization."""
        return {
            'society_id': self.society_id,
            'societyname': self.societyname,
            'eventtype': self.eventtype,
            'activitytype': self.activitytype,
            'activitydate': self.activitydate.isoformat() if self.activitydate else None,
            'numberofdays': self.numberofdays,
            'gpsphotosvideos': self.gpsphotosvideos if self.gpsphotosvideos else None,
            'budgetsanctioned': str(self.budgetsanctioned) if self.budgetsanctioned else None,
            'eventreport': self.eventreport if self.eventreport else None,
            'organizers': self.organizers,
            'conveners': self.conveners,
            'feedback': self.feedback,
            'participantslist': self.participantslist if self.participantslist else None,
            'certificates': self.certificates if self.certificates else None,
            'speakerdetails': self.speakerdetails,
            'master_id': self.master_id
        }


class MasterEvent(db.Model):
    __tablename__ = 'master_event'
    master_id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    event_name = db.Column(db.String, nullable=False)
    event_type = db.Column(db.String, nullable=False)
    approval = db.Column(db.Boolean, default=None, nullable=True)

    def to_dict(self):
        return {column.name: getattr(self, column.name) for column in self.__table__.columns}