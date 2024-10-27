# app/__init__.py
# This file is for intializing the server
from flask import Flask
from app.models import db  # Import db from models now
from app.routes.event_routes import bp as event_bp

def create_app():
    app = Flask(__name__)
    app.config.from_object('config.Config')
    
    # Initialize extensions
    db.init_app(app)
    
    # Register blueprints
    app.register_blueprint(event_bp)
    
    # Create database tables
    with app.app_context():
        db.create_all()
    
    return app
