########################################################
# Sample customers blueprint of endpoints
# Remove this file if you are not using it in your project
########################################################
from flask import Blueprint
from flask import request
from flask import jsonify
from flask import make_response
from flask import current_app
from backend.db_connection import db
from backend.ml_models.model01 import predict

# Create a new Blueprint object
api = Blueprint('api', __name__)

# ------------------------------------------------------------
# USERS ENDPOINTS
# ------------------------------------------------------------

# Get all users
@api.route('/users', methods=['GET'])
def get_users():
    cursor = db.get_db().cursor()
    cursor.execute('SELECT id, username, email FROM users')
    users = cursor.fetchall()
    response = make_response(jsonify(users))
    response.status_code = 200
    return response