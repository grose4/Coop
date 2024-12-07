from flask import Flask 
from flask import Blueprint
from flask import request
from flask import jsonify
from flask import make_response
from backend.db_connection import db
import logging

# Create a new Blueprint object
api3 = Blueprint('api', __name__) 

import sys

@api3.route('/student/<int:stu_id>', methods=['PUT'])
def update_stu(stu_id):
    student_info = request.json
    field = student_info.get('field')
    value = student_info.get('value')


    query = f"UPDATE Users SET {field} = %s WHERE UserID = %s"
    data = (value, stu_id)

    try:
        cursor = db.get_db().cursor()
        cursor.execute(query, data)
        db.get_db().commit()
        return {"message": "User updated successfully"}, 200
    except Exception as e:
        return {"error": str(e)}, 500


# Delete a user 
@api3.route('/student/delete/<stu_id>', methods=['DELETE'])
def delete_user(stu_id):
    current_app.logger.info(f'Deleting user with ID: {stu_id}')

    query = 'DELETE FROM Student WHERE StuID = %s'
    cursor = db.get_db().cursor()
    cursor.execute(query, (stu_id,))
    
    db.get_db().commit()

    response = make_response("User successfully deleted!")
    response.status_code = 200
    
    return response 

@api3.route('/student/create', methods=['POST'])
def add_new_student():
    
    the_data = request.json
    current_app.logger.info(the_data)

    # extract the variable
    year = the_data['Year']
    prevcoops = the_data['NumPreviousCoOps']
    pay = the_data['PayTransparency']
    comps = the_data['Companies']
    skills = the_data['bio'] 
    
    query = '''
        INSERT INTO Users (year, prevcoops, pay, comps, skills)
        VALUES (%s, %s, %s, %s, %s) 
        '''

    current_app.logger.info(query)

    # execute and commit the insert statement 
    cursor = db.get_db().cursor()
    cursor.execute(query, (year, prevcoops, pay, comps, skills))
    db.get_db().commit()
    
    response = make_response("Successfully created student customizations!")
    response.status_code = 200
    return response 

#search for an older student by year 
@api3.route('/student/by-year', methods=['GET'])
def get_users_by_industry():
    
    year = request.json['industry']

    query = f'''
    SELECT s.UserID, u.Name, u.Bio, i.Name AS IndustryName, i.NUCollege
    FROM Users u
	JOIN Student s ON u.UserID = s.StuID
    WHERE s.Year LIKE '{year}';
    '''

    current_app.logger.info('GET /student/by-year route')
    cursor = db.get_db().cursor()
    cursor.execute(query)
    
    theData = cursor.fetchall()

    the_response = make_response(jsonify(theData))
    the_response.status_code = 200
    current_app.logger.info(the_response)

    return the_response 
