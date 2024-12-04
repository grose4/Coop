from flask import Blueprint
from flask import request
from flask import jsonify
from flask import make_response
from flask import current_app
from backend.db_connection import db
from backend.ml_models.model01 import predict 

students = Blueprint('students', __name__) 

# Get all customers from the system
@students.route('/students', methods=['GET'])
def get_students():

    cursor = db.get_db().cursor()
    cursor.execute('''SELECT students.userID
                   FROM students 
                   JOIN faculty ON students.userID = faculty.userID
                   JOIN employers ON faculty.userID = employers.userID
                   WHERE students.skills = ‘Python’ 

    ''') 

    theData = cursor.fetchall()
    
    the_response = make_response(jsonify(theData))
    the_response.status_code = 200 
    return the_response 

