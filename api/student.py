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
    cursor.execute('''SELECT Student.StuID
                   FROM Student 
                   JOIN faculty ON Student.StuID = faculty.userID
                   JOIN employers ON faculty.userID = employers.userID
                   WHERE Student.Skills = ‘Python’ 

    ''') 

    theData = cursor.fetchall()
    
    the_response = make_response(jsonify(theData))
    the_response.status_code = 200 
    return the_response 

# Get all students and employers that are transparent about their pay/pay offered
@students.route('/students', methods=['GET'])
def get_students():

    cursor = db.get_db().cursor()
    cursor.execute('''SELECT  Student.StuID, employer.userID
                   FROM Student
                   JOIN faculty ON Student.StuID = faculty.userID
                   JOIN employer ON faculty.userID = employer.userID
                   WHERE Students.PayTransparency = ‘Yes’ AND employer.payoffered = ‘Yes’ 


    ''')  

    theData = cursor.fetchall()
    
    the_response = make_response(jsonify(theData))
    the_response.status_code = 200 
    return the_response 


# Deleting a user 
@students.route('/students', methods=['DELETE'])
def get_students():
    current_app.logger.info('DELETE /students route') 
    cust_info = request.json
    cust_userid = cust_info['StuID'] 

    query = 'DELETE FROM Student WHERE StuID = %s'
    data = (cust_userid) 
    cursor = db.get_db().cursor() 
    r = cursor.execute(query, data) 
    db.get_db().commit() 
    

    return 'student deleted!'  