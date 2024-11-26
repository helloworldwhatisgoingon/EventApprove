# Event Approval Flask Server Setup

This project has a Flask server for managing event approvals, using a PostgreSQL database and Swagger for API documentation.

## Getting Started

### 1. Configure Database Connection

In the `config.py` file, set up the PostgreSQL database connection string as follows:

    SQLALCHEMY_DATABASE_URI = 'postgresql://<username>:<password>@<host>/<database>'

Replace:
- `<username>` with your PostgreSQL username.
- `<password>` with your PostgreSQL password.
- `<host>` with the hostname, typically `localhost` for local development.
- `<database>` with the name of your database.

For example:

    SQLALCHEMY_DATABASE_URI = 'postgresql://postgres:root18@localhost/events_organised'

### 2. Install Dependencies

To install the required packages, run:

    pip install -r requirements.txt

### 3. Running the Server

To start the server, use the following command:

    python run.py

### 4. Accessing API Documentation

Once the server is running, you can access the API documentation at:

    http://127.0.0.1:5000

## Additional Information
- Ensure that PostgreSQL is running on your machine and that the credentials in `config.py` match your setup.
- This project uses SQLAlchemy for ORM operations and flask_restx for generating Swagger-based API documentation.

# Database Setup

## Overview
This repository contains the `.sql` file needed to set up the database for the project.

## Prerequisites
- Ensure you have PostgreSQL installed and configured.
- Connect to the appropriate database else just create a new database where you want to execute this schema.

## Installation and Execution
1. Open your PostgreSQL command line interface or any SQL client connected to the desired database else the pg admin4 and open a new query tool under your database
2. Open the .sql file which contains all the queries and just execute the script.

##Changes to be made - 
Make sure to change the username and password before executing the queries.
