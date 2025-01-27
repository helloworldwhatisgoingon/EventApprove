import base64
import traceback
from flask import Blueprint, request, jsonify
from ..models import Conference, MasterEvent, Event, Journal, BookChapter, Workshop, Patent, Fdp, Seminar, ClubActivity, IndustrialVisit, FacultyAchievement, StudentAchievement, ProfessionalSociety, Users
from .. import db
from datetime import datetime
from werkzeug.security import check_password_hash
from werkzeug.security import generate_password_hash

bp = Blueprint("centralized", __name__, url_prefix="/centralized")

# Create a global event
@bp.route('', methods=['POST'])
def create_event():
    # Handle multipart form data
    data = request.form
    event_type = data.get('event_type')

    # Handle file data for BYTEA storage
    document = None
    if 'document' in request.files:
        file = request.files['document']
        if file:
            document = file.read()  # This reads the file as bytes for BYTEA storage

    try:
        event_model = get_event_model(event_type)
    except ValueError as e:
        return jsonify({'error': str(e)}), 400

    # Create entry in master_event
    master_event = MasterEvent(
        event_name=data['event_name'],
        event_type=event_type,
        user_id=data['user_id']
    )
    db.session.add(master_event)
    db.session.flush()

    # Prepare data for event model
    event_data = {key: value for key, value in data.items() 
                 if key in event_model.__table__.columns.keys()}

    # Add document bytes if file was uploaded
    if document:
        event_data['document'] = document

    # Encode specific fields as Base64
    fields_to_encode = [
        "brochure",
        "gpsmedia",
        "report",
        "feedback",
        "participantslist",
        "certificates",
        "expenditurereport",
        "gpsphoto",
        "proof",
        "certificateproof",
        'gpsphotosvideos',
        'eventreport'
    ]
    for field in fields_to_encode:
        if field in request.files:
            file = request.files[field]
            if file:
                event_data[field] = base64.b64encode(file.read()).decode('utf-8')
        elif field in event_data and event_data[field] is not None:
            event_data[field] = base64.b64encode(event_data[field].encode()).decode('utf-8')

    # Create entry in event_type-specific table
    event = event_model(
        master_id=master_event.master_id,
        **event_data
    )
    db.session.add(event)
    db.session.commit()

    return jsonify({
        'message': 'Event created successfully!', 
        'master_id': master_event.master_id
    })

@bp.route('', methods=['GET'])
def get_events():
    event_type = request.args.get('event_type')

    try:
        event_model = get_event_model(event_type)
    except ValueError as e:
        return jsonify({'error': str(e)}), 400

    # Use left join with users table to handle null user_ids
    query = (
        db.session.query(
            event_model,  # All fields from the event-specific table
            MasterEvent.approval,
            MasterEvent.user_id,  # Add user_id
            Users.username,      # Add username
            Users.role          # Add role
        )
        .join(MasterEvent, MasterEvent.master_id == event_model.master_id)
        .outerjoin(Users, MasterEvent.user_id == Users.user_id)  # Left join with users table
    )
    results = query.all()

    document_fields = [
        "brochure",
        "gpsmedia",
        "report",
        "feedback",
        "participantslist",
        "certificates",
        "expenditurereport",
        "document",
        "gpsphoto",
        "proof",
        "certificateproof",
        "gpsphotosvideos",
        "eventreport",
    ]

    data = []
    for event, approval, user_id, username, role in results:
        event_data = event.to_dict()

        # Convert all document fields to base64 if they exist and are not None
        for field in document_fields:
            if field in event_data and event_data[field] is not None:
                event_data[field] = base64.b64encode(event_data[field]).decode('utf-8')

        # Update approval and user data, allowing for null values
        event_data.update({
            'approval': approval,
            'user_id': user_id,
            'username': username if username else None,
            'role': role if role else None
        })

        data.append(event_data)

    return jsonify(data)

@bp.route('/<int:master_id>', methods=['GET'])
def get_event_by_master_id(master_id):
    try:
        # Get the event type from MasterEvent using the master_id
        master_event = MasterEvent.query.filter_by(master_id=master_id).first()

        if not master_event:
            return jsonify({'error': 'MasterEvent not found'}), 404

        # Get the event model dynamically based on the event_type from the MasterEvent
        event_model = get_event_model(master_event.event_type)

        # Perform the LEFT JOIN to get additional fields from the event_model
        query = (
            db.session.query(
                MasterEvent,       # Select all fields from MasterEvent
                event_model        # Select all fields from the event model
            )
            .outerjoin(event_model, MasterEvent.master_id == event_model.master_id)  # LEFT JOIN
            .filter(MasterEvent.master_id == master_id)  # Filter by master_id
        )

        # Execute the query
        result = query.first()

        if not result:
            return jsonify({'error': 'Event not found for the given master_id'}), 404

        # Unpack result and prepare the response
        master_event, event = result

        # Create a dictionary to store the result
        event_data = {
            'master_id': master_event.master_id,
            'event_name': master_event.event_name,
            'event_type': master_event.event_type,
            'approval': master_event.approval,
        }

        if event:
            # Convert the event model to a dictionary if possible
            event_dict = event.to_dict() if hasattr(event, 'to_dict') else {}

            # Perform Base64 encoding for specific fields if they exist
            document_fields = [
                "brochure",
                "gpsmedia",
                "report",
                "feedback",
                "participantslist",
                "certificates",
                "expenditurereport",
                "document",
                "gpsphoto",
                "proof",
                "certificateproof",
                'gpsphotosvideos',
                'eventreport'
            ]
            for field in document_fields:
                if field in event_dict and event_dict[field] is not None:
                    event_dict[field] = base64.b64encode(event_dict[field]).decode('utf-8')

            # Update the event_data with event-specific details
            event_data.update(event_dict)

        return jsonify(event_data)

    except Exception as e:
        return jsonify({'error': str(e)}), 500

# Get all the events from master table
@bp.route('/all', methods=['GET'])
def get_all_master_events():
    try:
        # Query to fetch all records from the MasterEvent table
        master_events = MasterEvent.query.all()

        # Convert each record to a dictionary using the to_dict method
        data = [master_event.to_dict() for master_event in master_events]

        return jsonify(data), 200

    except Exception as e:
        return jsonify({'error': str(e)}), 500

@bp.route('/allFiltered', methods=['GET'])
def get_all_master_events_for_user():
    user_id_param = request.args.get('user_id')  # Get user_id from URL parameters

    try:
        # Query to fetch all records from the MasterEvent table
        query = MasterEvent.query

        # Filter by user_id if provided
        if user_id_param:
            # Ensure the user_id is cast to an integer for comparison
            user_id_param = int(user_id_param)  # Convert the string to integer
            query = query.filter(MasterEvent.user_id == user_id_param)

        master_events = query.all()

        # Convert each record to a dictionary using the to_dict method
        data = [master_event.to_dict() for master_event in master_events]

        return jsonify(data), 200

    except Exception as e:
        return jsonify({'error': str(e)}), 500


@bp.route('', methods=['PUT'])
def update_event_approval():
    try:
        # Parse the JSON payload
        data = request.get_json()
        master_id = data.get('master_id')
        approval = data.get('approval')

        if master_id is None or approval is None:
            return jsonify({'error': 'master_id and approval are required'}), 400

        # Query the MasterEvent table for the given master_id
        master_event = MasterEvent.query.filter_by(master_id=master_id).first()

        if not master_event:
            return jsonify({'error': 'MasterEvent not found'}), 404

        # Update the approval value
        master_event.approval = approval

        # Commit the changes to the database
        db.session.commit()

        return jsonify({'message': 'Approval updated successfully', 'master_id': master_id, 'approval': approval}), 200

    except Exception as e:
        return jsonify({'error': str(e)}), 500

@bp.route('/<int:master_id>', methods=['DELETE'])
def delete_event(master_id):
    try:
        # Query the MasterEvent table for the given master_id
        master_event = MasterEvent.query.filter_by(master_id=master_id).first()

        if not master_event:
            return jsonify({'error': 'MasterEvent not found'}), 404

        # Delete the record from the database
        db.session.delete(master_event)
        db.session.commit()

        return jsonify({'message': f'MasterEvent with ID {master_id} deleted successfully'}), 200

    except Exception as e:
        return jsonify({'error': str(e)}), 500

@bp.route('/login', methods=['POST'])
def login():
    try:
        # Get login data from the request
        data = request.json
        username = data.get('username')
        password = data.get('password')
        role = data.get('role')

        # Validate required fields
        if not all([username, password, role]):
            return jsonify({'error': 'Missing required fields'}), 400

        # Query the database for the user
        user = Users.query.filter_by(username=username, role=role).first()

        # Check if user exists
        if not user:
            return jsonify({'error': 'Invalid credentials or role'}), 404

        # Verify the password
        if not check_password_hash(user.password, password):
            return jsonify({'error': 'Incorrect password'}), 401

        # Return success response with all user details
        return jsonify({
            'message': 'Login successful',
            'user': user.to_dict()  # Converts the user object to a dictionary
        }), 200

    except Exception as e:
        return jsonify({'error': str(e)}), 500

    
@bp.route('/register', methods=['POST'])
def register():
    try:
        # Parse the request JSON
        data = request.json
        username = data.get('username')
        password = data.get('password')
        role = data.get('role')

        # Validate required fields
        if not all([username, password, role]):
            return jsonify({'error': 'Missing required fields'}), 400

        # Validate role
        if role not in ['HOD', 'Faculty']:
            return jsonify({'error': f'Invalid role: {role}. Must be "HOD" or "Faculty".'}), 400

        # Check if the username already exists
        if Users.query.filter_by(username=username).first():
            return jsonify({'error': 'Username already exists'}), 409

        # Hash the password
        hashed_password = generate_password_hash(password)

        # Create a new user
        new_user = Users(username=username, password=hashed_password, role=role)
        db.session.add(new_user)
        db.session.commit()

        return jsonify({'message': 'User registered successfully', 'user_id': new_user.user_id}), 201

    except Exception as e:
        return jsonify({'error': str(e)}), 500
        
def get_event_model(event_type):
    """Helper function to return the corresponding model based on event type."""
    match event_type:
        case 'conference':
            return Conference
        case 'Event':
            return Event
        case 'journals':
            return Journal
        case 'bookchapter':
            return BookChapter
        case 'workshop':
            return Workshop
        case 'patents':
            return Patent
        case 'fdp':
            return Fdp
        case 'seminar':
            return Seminar
        case 'clubactivity':
            return ClubActivity
        case 'industrial_visit':
            return IndustrialVisit
        case 'faculty_achievements':
            return FacultyAchievement
        case 'student_achievements':
            return StudentAchievement
        case 'professional_societies':
            return ProfessionalSociety
        case _:
            raise ValueError(f"Unknown event type: {event_type}")
