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
    
class MasterEvent(db.Model):
    __tablename__ = 'master_event'
    master_id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    event_name = db.Column(db.String, nullable=False)
    event_type = db.Column(db.String, nullable=False)
    approval = db.Column(db.Boolean, default=None, nullable=True)

    def to_dict(self):
        return {column.name: getattr(self, column.name) for column in self.__table__.columns}