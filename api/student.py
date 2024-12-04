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
                   JOIN Faculty ON Student.StuID = Faculty.userID
                   JOIN Employer ON Faculty.userID = Employer.userID
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
    cursor.execute('''SELECT  Student.StuID, Employer.userID
                   FROM Student
                   JOIN Faculty ON Student.StuID = Faculty.userID
                   JOIN employer ON Faculty.userID = Employer.userID
                   WHERE Student.PayTransparency = ‘Yes’ AND Employer.payoffered = ‘Yes’ 


    ''')  

    theData = cursor.fetchall()
    
    the_response = make_response(jsonify(theData))
    the_response.status_code = 200 
    return the_response 


# Deleting a student 
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

#Updating a Student's Skills
@students.route('/students', methods=['PUT'])
def get_students():
    current_app.logger.info('PUT /students route') 
    cust_info = request.json
    cust_skills = cust_info['Skills']
    cust_userid = cust_info['StuID'] 

    query = 'UPDATE Student SET Skills = %s WHERE StuID = %s'
    data = (cust_skills, cust_userid) 
    cursor = db.get_db().cursor() 
    r = cursor.execute(query, data) 
    db.get_db().commit() 
    
    return 'student skills updated!'   

#Updating a Student's Skills
@students.route('/students', methods=['POST'])
def get_students():
    current_app.logger.info('POST /students route') 
    cust_info = request.json
    cust_YEAR = cust_info['Year']
    cust_Coops = cust_info['NumPreviousCoOps'] 
    cust_Pay = cust_info['PayTransparency'] 
    cust_companies = cust_info['Companies']
    cust_skills = cust_info['Skills']
    cust_id = cust_info['StuID'] 

    query = '''INSERT into Student 
               VALUES (%s, %s, %s, %s, %s, %s)''' 
    data = (cust_YEAR, cust_Coops, cust_Pay, cust_companies, cust_skills, cust_id) 
    cursor = db.get_db().cursor() 
    r = cursor.execute(query, data) 
    db.get_db().commit() 
    
    return 'student skills updated!'   