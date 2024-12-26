# # run.py
# # This file is to run the server on port 5001 and host network
# # pip install -r requirements.txt (command to install all the required libraries)
# # python run.py

# from app import create_app
# from flask import request, abort

# # Define the list of allowed IP addresses
# ALLOWED_IPS = {
#     "192.168.1.1", # Add faculty IPs
#     "192.168.1.2",
#     "203.0.113.0",
#     "203.0.113.1",
#     "192.168.0.112", # Add the host system IP here using IPConfig
#     "127.0.0.1", # Host System localhost access
# }

# app = create_app()


# @app.before_request
# def restrict_ip():
#     # Check if the client's IP address is in the allowed list
#     if request.remote_addr not in ALLOWED_IPS:
#         abort(403)  # Forbidden


# if __name__ == "__main__":
#     app.run(host="0.0.0.0", port=5001, debug=True)

# Universal access code

# run.py
# This file is to run the server on port 5000 and host network
# pip install -r requirements.txt (command to install all the required libraries)
# python run.py
from app import create_app

app = create_app()

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5001, debug=True)

