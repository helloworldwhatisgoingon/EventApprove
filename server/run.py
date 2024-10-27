# run.py
# This file is to run the server on port 5000 and host network
# pip install -r requirements.txt (command to install all the required libraries)
# python run.py
from app import create_app

app = create_app()

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)
