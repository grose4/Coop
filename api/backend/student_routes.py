from flask import Flask 
from flask import Blueprint
from flask import request
from flask import jsonify
from flask import make_response
from flask import current_app
from backend.db_connection import db
import logging

# Create a new Blueprint object
api3 = Blueprint('api_3', __name__) 

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
    try:
        # Parse the incoming JSON data
        the_data = request.json
        current_app.logger.info(the_data)

        # Extract variables
        year = the_data['Year']
        prevcoops = the_data['NumPreviousCoOps']
        pay = the_data['PayTransparency']
        comps = the_data['Companies']
        skills = the_data['bio']

        # Use correct column names in the INSERT query
        query = '''
            INSERT INTO Student (Year, NumPreviousCoOps, PayTransparency, Companies, Skills)
            VALUES (%s, %s, %s, %s, %s)
        '''

        # Log the query for debugging
        current_app.logger.info(f"Executing query: {query} with data: {year}, {prevcoops}, {pay}, {comps}, {skills}")

        # Execute the query
        cursor = db.get_db().cursor()
        cursor.execute(query, (year, prevcoops, pay, comps, skills))
        db.get_db().commit()

        response = make_response("Successfully created student customizations!")
        response.status_code = 200
        return response

    except Exception as e:
        current_app.logger.error(f"Error creating student: {e}", exc_info=True)
        return jsonify({"error": "Internal server error", "details": str(e)}), 500



@api3.route('/student/by-paytransparency', methods=['GET'])
def get_students_by_paytransparency():
    
    student_info = request.json
    pay = str(student_info['paytransparency'])

    query = f'''
    SELECT u.UserID, u.Name, u.Bio, u.Occupation
    FROM Student s
	JOIN Users u ON s.StuID = u.UserID
    WHERE s.PayTransparency LIKE '{pay}' AND u.UserID IS NOT NULL;
    '''

    current_app.logger.info('GET /users/by-paytransparency route')
    cursor = db.get_db().cursor()
    cursor.execute(query)
    
    theData = cursor.fetchall() 
    
    the_response = make_response(jsonify(theData))
    the_response.status_code = 200
    return the_response


@api3.route('/student/by-companies', methods=['GET'])
def get_students_by_companies():
    
    student_info = request.json
    companies = str(student_info['companies'])

    query = f'''
    SELECT u.UserID, u.Name, u.Bio, u.Occupation
    FROM Student s
	JOIN Users u ON s.StuID = u.UserID
    WHERE s.Companies LIKE '{companies}' AND u.UserID IS NOT NULL;
    '''

    current_app.logger.info('GET /users/by-companies route')
    cursor = db.get_db().cursor()
    cursor.execute(query)
    
    theData = cursor.fetchall() 
    
    the_response = make_response(jsonify(theData))
    the_response.status_code = 200
    return the_response
