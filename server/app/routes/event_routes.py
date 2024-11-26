# app/routes/event_routes.py
import traceback
from flask import Blueprint, request, jsonify
from ..models import Event
from .. import db
from datetime import datetime
from sqlalchemy import text

bp = Blueprint('event', __name__, url_prefix='/event')

@bp.route('', methods=['POST'])
def create_event():
    try:
        # Print/log incoming data for debugging
        print("Form data received:", request.form.to_dict())
        print("Files received:", request.files.to_dict())

        # Parse the incoming form data
        data = request.form

        # Handle the PDF file
        pdf_file = request.files.get('eventPDF')
        pdf_content = pdf_file.read() if pdf_file else None

        # Create the Event object
        event = Event(
            eventTitle=data['eventTitle'],
            eventType=data['eventType'],
            startDate=datetime.strptime(data['startDate'], '%Y-%m-%d').date(),
            endDate=datetime.strptime(data['endDate'], '%Y-%m-%d').date(),
            location=data['location'],
            approval=data.get('approval', 'false').lower() == 'true',
            eventPDF=pdf_content
        )

        # Add the event to the database
        db.session.add(event)
        db.session.commit()

        return jsonify({"message": "Event created", "event": event.to_dict()}), 201

    except Exception as e:
        # Print/log the error and the incoming data
        print("Error occurred while processing the request:")
        print(traceback.format_exc())  # Logs the full stack trace
        print("Form data received:", request.form.to_dict())
        print("Files received:", request.files.to_dict())

        # Return an error response
        return jsonify({"error": str(e), "message": "Failed to create event"}), 400

@bp.route('/<eventID>', methods=['PUT'])
def update_event(eventID):
    data = request.json
    event = Event.query.get(eventID)
    if not event:
        return jsonify({"error": "Event not found"}), 404
    
    event.eventTitle = data.get('eventTitle', event.eventTitle)
    event.eventType = data.get('eventType', event.eventType)
    event.startDate = datetime.strptime(data['startDate'], '%Y-%m-%d').date() if 'startDate' in data else event.startDate
    event.endDate = datetime.strptime(data['endDate'], '%Y-%m-%d').date() if 'endDate' in data else event.endDate
    event.location = data.get('location', event.location)
    event.approval = data.get('approval', event.approval)
    
    db.session.commit()
    return jsonify({"message": "Event updated", "event": event.to_dict()}), 200

@bp.route('/<eventID>/approval', methods=['PUT'])
def update_approval(eventID):
    data = request.json
    event = Event.query.get(eventID)
    if not event:
        return jsonify({"error": "Event not found"}), 404
    
    event.approval = data['approval']
    db.session.commit()
    return jsonify({"message": "Approval status updated", "approval": event.approval}), 200

@bp.route('', methods=['GET'])
def get_all_events():
    # Using ORM to get all events
    events = Event.query.all()
    return jsonify([event.to_dict() for event in events]), 200

    # # Using raw SQL (for easier understanding)
    # query = text('SELECT * FROM "Event"')
    # result = db.session.execute(query)  # Execute the raw SQL query

    # events = []
    # for row in result:
    #     event = {
    #         'eventID': row.eventID,
    #         'eventTitle': row.eventTitle,
    #         'eventType': row.eventType,
    #         'startDate': row.startDate.isoformat(),
    #         'endDate': row.endDate.isoformat(),
    #         'location': row.location,
    #         'approval': row.approval
    #     }
    #     events.append(event)

    # return jsonify(events), 200

@bp.route('/<eventID>', methods=['DELETE'])
def delete_event(eventID):
    event = Event.query.get(eventID)
    if not event:
        return jsonify({"error": "Event not found"}), 404
    
    db.session.delete(event)
    db.session.commit()
    return jsonify({"message": "Event deleted"}), 200
