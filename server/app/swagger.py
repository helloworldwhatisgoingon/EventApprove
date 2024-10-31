# app/swagger.py
from flask_restx import Api, Namespace, Resource, fields
from flask import request, jsonify
from datetime import datetime
from app.models import Event, db

api = Api(
    title="My Flask Server API",
    version="1.0",
    description="Centralized API documentation for Flask server",
    mask=None
)

# Define the event namespace
event_ns = Namespace("events", description="Operations related to events")

# Define the Event model for request and response
event_model = event_ns.model(
    "Event",
    {
        "eventID": fields.Integer(description="Event ID", readonly=True),
        "eventTitle": fields.String(
            required=True,
            description="Title of the event",
            example="Tech Conference 2024",
        ),
        "eventType": fields.String(
            required=True, description="Type of the event", example="Conference"
        ),
        "startDate": fields.String(
            required=True,
            description="Start date of the event (YYYY-MM-DD)",
            example="2024-11-15",
        ),
        "endDate": fields.String(
            required=True,
            description="End date of the event (YYYY-MM-DD)",
            example="2024-11-17",
        ),
        "location": fields.String(
            required=True,
            description="Location of the event",
            example="New York Convention Center",
        ),
        "approval": fields.Boolean(
            description="Approval status of the event", default=False, example=False
        ),
    },
)


# Define each endpoint within the event namespace
@event_ns.route("")
class EventListResource(Resource):
    @event_ns.marshal_list_with(event_model)
    def get(self):
        """Get all events"""
        events = Event.query.all()
        return [event.to_dict() for event in events], 200

    @event_ns.expect(event_model)
    @event_ns.marshal_with(event_model, code=201)
    def post(self):
        """Create a new event"""
        data = request.json
        event = Event(
            eventTitle=data["eventTitle"],
            eventType=data["eventType"],
            startDate=data["startDate"],
            endDate=data["endDate"],
            location=data["location"],
            approval=data.get("approval", False),
        )
        db.session.add(event)
        db.session.commit()
        return event.to_dict(), 201


@event_ns.route("/<int:eventID>")
@event_ns.param("eventID", "The event identifier")
class EventResource(Resource):
    @event_ns.expect(event_model)
    @event_ns.marshal_with(event_model)
    def put(self, eventID):
        """Update an event by ID"""
        data = request.json
        event = Event.query.get(eventID)
        if not event:
            return {"error": "Event not found"}, 404

        event.eventTitle = data.get("eventTitle", event.eventTitle)
        event.eventType = data.get("eventType", event.eventType)
        event.startDate = (
            datetime.strptime(data["startDate"], "%Y-%m-%d").date()
            if "startDate" in data
            else event.startDate
        )
        event.endDate = (
            datetime.strptime(data["endDate"], "%Y-%m-%d").date()
            if "endDate" in data
            else event.endDate
        )
        event.location = data.get("location", event.location)
        event.approval = data.get("approval", event.approval)

        db.session.commit()
        return event.to_dict(), 200

    def delete(self, eventID):
        """Delete an event by ID"""
        event = Event.query.get(eventID)
        if not event:
            return {"error": "Event not found"}, 404

        db.session.delete(event)
        db.session.commit()
        return {"message": "Event deleted"}, 200


@event_ns.route("/<int:eventID>/approval")
@event_ns.param("eventID", "The event identifier")
class EventApprovalResource(Resource):
    @event_ns.doc(params={"approval": "Approval status of the event"})
    def put(self, eventID):
        """Update approval status of an event by ID"""
        data = request.json
        event = Event.query.get(eventID)
        if not event:
            return {"error": "Event not found"}, 404

        event.approval = data["approval"]
        db.session.commit()
        return {"message": "Approval status updated", "approval": event.approval}, 200


# Add the namespace to the main API instance
api.add_namespace(event_ns, path="/event")
