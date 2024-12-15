# app/routes/conference_routes.py
import base64
import traceback
from flask import Blueprint, request, jsonify
from ..models import Conference
from .. import db
from datetime import datetime

bp = Blueprint("conference", __name__, url_prefix="/conference")


@bp.route("", methods=["POST"])
def create_conference():
    try:
        # Print/log incoming data for debugging
        print("Form data received:", request.form.to_dict())
        print("Files received:", request.files.to_dict())

        # Parse the incoming form data
        data = request.form

        # Handle the document file
        document_file = request.files.get("document")
        document_content = document_file.read() if document_file else None

        # Create the Conference object
        conference = Conference(
            papertitle=data["papertitle"],
            abstract=data.get("abstract"),
            conferencename=data.get("conferencename"),
            publicationlevel=data.get("publicationlevel"),
            publicationdate=datetime.strptime(data["publicationdate"], "%Y-%m-%d").date()
            if "publicationdate" in data
            else None,
            publisher=data.get("publisher"),
            doiisbn=data.get("doiisbn"),
            document=document_content,
            prooflink=data.get("prooflink"),
        )

        # Add the conference to the database
        db.session.add(conference)
        db.session.commit()

        return jsonify({"message": "Conference created", "conference": conference.to_dict()}), 201

    except Exception as e:
        # Print/log the error and the incoming data
        print("Error occurred while processing the request:")
        print(traceback.format_exc())  # Logs the full stack trace
        print("Form data received:", request.form.to_dict())
        print("Files received:", request.files.to_dict())

        # Return an error response
        return jsonify({"error": str(e), "message": "Failed to create conference"}), 400


@bp.route("/<conference_id>", methods=["PUT"])
def update_conference(conference_id):
    data = request.json
    conference = Conference.query.get(conference_id)
    if not conference:
        return jsonify({"error": "Conference not found"}), 404

    conference.papertitle = data.get("papertitle", conference.papertitle)
    conference.abstract = data.get("abstract", conference.abstract)
    conference.conferencename = data.get("conferencename", conference.conferencename)
    conference.publicationlevel = data.get("publicationlevel", conference.publicationlevel)
    conference.publicationdate = (
        datetime.strptime(data["publicationdate"], "%Y-%m-%d").date()
        if "publicationdate" in data
        else conference.publicationdate
    )
    conference.publisher = data.get("publisher", conference.publisher)
    conference.doiisbn = data.get("doiisbn", conference.doiisbn)
    conference.prooflink = data.get("prooflink", conference.prooflink)

    db.session.commit()
    return jsonify({"message": "Conference updated", "conference": conference.to_dict()}), 200


@bp.route("/approval/<conference_id>", methods=["PUT"])
def update_approval(conference_id):
    data = request.json
    conference = Conference.query.get(conference_id)
    if not conference:
        return jsonify({"error": "Conference not found"}), 404

    conference.approval = data["approval"]
    db.session.commit()
    return (
        jsonify({"message": "Approval status updated", "approval": conference.approval}),
        200,
    )


@bp.route("", methods=["GET"])
def get_all_conferences():
    try:
        conferences = Conference.query.all()
        conferences_list = []

        for conference in conferences:
            conference_data = conference.to_dict()
            # Encode the file as base64
            if conference.document:
                conference_data["document"] = base64.b64encode(conference.document).decode("utf-8")
            else:
                conference_data["document"] = None

            conferences_list.append(conference_data)

        return jsonify({"conferences": conferences_list}), 200

    except Exception as e:
        print("Error fetching conferences:", str(e))
        return jsonify({"error": str(e), "message": "Failed to fetch conferences"}), 500


@bp.route("/by-date", methods=["GET"])
def get_conferences_by_date():
    try:
        # Retrieve the 'publicationdate' query parameter
        publication_date = request.args.get("publicationdate")
        if not publication_date:
            return jsonify({"error": "publicationdate query parameter is required"}), 400

        # Parse the publicationdate into a datetime object for filtering
        try:
            publication_date = datetime.strptime(publication_date, "%Y-%m-%d")
        except ValueError:
            return jsonify({"error": "Invalid publicationdate format. Use YYYY-MM-DD."}), 400

        # Query conferences with a matching or greater publicationdate
        conferences = Conference.query.filter(Conference.publicationdate >= publication_date).all()
        conferences_list = []

        for conference in conferences:
            conference_data = conference.to_dict()
            # Encode the file as base64
            if conference.document:
                conference_data["document"] = base64.b64encode(conference.document).decode("utf-8")
            else:
                conference_data["document"] = None

            conferences_list.append(conference_data)

        return jsonify({"conferences": conferences_list}), 200

    except Exception as e:
        print("Error fetching conferences by publicationdate:", str(e))
        return jsonify({"error": str(e), "message": "Failed to fetch conferences"}), 500


@bp.route("/<conference_id>", methods=["DELETE"])
def delete_conference(conference_id):
    conference = Conference.query.get(conference_id)
    if not conference:
        return jsonify({"error": "Conference not found"}), 404

    db.session.delete(conference)
    db.session.commit()
    return jsonify({"message": "Conference deleted"}), 200
