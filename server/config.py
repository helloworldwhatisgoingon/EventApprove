# config.py
import os

class Config:
    SQLALCHEMY_DATABASE_URI = 'postgresql://postgres:root18@localhost/events_organised' 
    SQLALCHEMY_TRACK_MODIFICATIONS = False
