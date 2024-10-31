# app/__init__.py
# This file is for intializing the server
from flask import Flask
from app.models import db
from app.routes.event_routes import bp as event_bp
from app.swagger import api  # Import the centralized Api instance from swagger.py

def create_app():
    app = Flask(__name__)
    app.config.from_object('config.Config')
    
    # Initialize extensions
    db.init_app(app)
    
    # Register blueprints
    app.register_blueprint(event_bp)
    
    # Initialize API documentation
    api.init_app(app)  # Register the centralized Api instance with Flask app
    
    # Create database tables
    with app.app_context():
        db.create_all()
    
    return app
