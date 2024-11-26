# config.py
import os

class Config:
    SQLALCHEMY_DATABASE_URI = 'postgresql://postgres:qwerty@localhost:3001/Events_Organised'
    SQLALCHEMY_TRACK_MODIFICATIONS = False
