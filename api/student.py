from flask import Blueprint
from flask import request
from flask import jsonify
from flask import make_response
from flask import current_app
from backend.db_connection import db
from backend.ml_models.model01 import predict 

students = Blueprint('students', __name__) 

# Get all students that have Python listed as a skill
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

# Get all students and employers that are transparent about their pay/pay offered
@students.route('/students', methods=['GET'])
def get_students():

    cursor = db.get_db().cursor()
    cursor.execute('''SELECT  students.userID, employers.uderID
                   FROM students
                   JOIN faculty ON students.userID = faculty.userID
                   JOIN employer ON faculty.userID = employer.userID
                   WHERE students.PayTransparency = ‘Yes’ AND employer.payoffered = ‘Yes’ 


    ''')  

    theData = cursor.fetchall()
    
    the_response = make_response(jsonify(theData))
    the_response.status_code = 200 
    return the_response 
