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

    def to_dict(self):
        return {
            'eventID': self.eventID,
            'eventTitle': self.eventTitle,
            'eventType': self.eventType,
            'startDate': self.startDate.isoformat(),
            'endDate': self.endDate.isoformat(),
            'location': self.location,
            'approval': self.approval,
            'eventPDF': bool(self.eventPDF)  # Indicates if a PDF is stored
        }
