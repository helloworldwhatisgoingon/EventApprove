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

    conference_id = db.Column(db.Integer, primary_key=True, autoincrement=True)  # Serial Primary Key
    papertitle = db.Column(db.String(255), nullable=False)  # Title of the paper (not null)
    abstract = db.Column(db.Text, nullable=True)  # Abstract text
    conferencename = db.Column(db.String(255), nullable=True)  # Conference name
    publicationlevel = db.Column(db.String(100), nullable=True)  # Publication level
    publicationdate = db.Column(db.Date, nullable=True)  # Date of publication
    publisher = db.Column(db.String(255), nullable=True)  # Publisher name
    doiisbn = db.Column(db.String(100), nullable=True)  # DOI or ISBN
    document = db.Column(db.LargeBinary, nullable=True, default=None)  # Document in binary format
    prooflink = db.Column(db.String(255), nullable=True)  # Proof link (URL)
    approval = db.Column(db.Boolean, default=None)  # Approval status (boolean, nullable)

    def to_dict(self):
        """Convert the object to a dictionary for easy serialization."""
        return {
            'conference_id': self.conference_id,
            'papertitle': self.papertitle,
            'abstract': self.abstract,
            'conferencename': self.conferencename,
            'publicationlevel': self.publicationlevel,
            'publicationdate': self.publicationdate.isoformat() if self.publicationdate else None,
            'publisher': self.publisher,
            'doiisbn': self.doiisbn,
            'document': bool(self.document),  # Indicates if a document is stored
            'prooflink': self.prooflink,
            'approval': self.approval
        } 