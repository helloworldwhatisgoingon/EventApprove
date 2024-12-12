# config.py
import os

class Config:
    SQLALCHEMY_DATABASE_URI = 'postgresql+pg8000://postgres:root18@localhost/events_organised'  # Use pg8000 as the driver
    SQLALCHEMY_TRACK_MODIFICATIONS = False
