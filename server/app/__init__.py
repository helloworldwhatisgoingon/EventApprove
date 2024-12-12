# app/__init__.py
# This file is for initializing the server
from flask import Flask
from app.models import db
from app.routes.event_routes import bp as event_bp
from app.swagger import api  # Import the centralized Api instance from swagger.py

def create_app():
    app = Flask(__name__)
    app.config.from_object('config.Config')  # Load configuration from the config class
    
    # Initialize extensions
    db.init_app(app)
    
    # Register blueprints (routes)
    app.register_blueprint(event_bp)
    
    # Initialize API documentation
    api.init_app(app)  # Register the centralized Api instance with Flask app
    
    # Create database tables if they do not exist
    with app.app_context():
        try:
            db.create_all()  # This creates the tables defined in models if they do not exist
            print("Database tables created successfully.")
        except Exception as e:
            print(f"Error creating database tables: {e}")
    
    return app
