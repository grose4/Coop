from flask import Blueprint
from flask import request
from flask import jsonify
from flask import make_response
from flask import current_app
from backend.db_connection import db
import logging

# create blueprint object
api2 = Blueprint('api2', __name__)

# Get users from specific industries:
@api2.route('/users/by-industry', methods=['GET'])
def get_users_by_industry():
    
    industry = request.args.get('industry')

    query = f'''
    SELECT u.UserID, u.Name, u.Bio, i.Name AS IndustryName, i.NUCollege
    FROM Users u
	JOIN User_Industry ui ON u.UserID = ui.UserID
	JOIN Industry i ON i.IndustryID = ui.IndustryID
    WHERE i.Name LIKE '{industry}';
    '''

    current_app.logger.info('GET /users/<Industry> route')
    cursor = db.get_db().cursor()
    cursor.execute(query)
    
    theData = cursor.fetchall()

    the_response = make_response(jsonify(theData))
    the_response.status_code = 200
    current_app.logger.info(the_response)

    return the_response

# update user info
@api2.route('/users/update/<userID>', methods=['PUT'])
def update_user(userID):
    # log and make cursor
    current_app.logger.info('PUT /users/<userID> route')
    cursor = db.get_db().cursor()

    # set variables for each user attribute
    user_info = request.json
    name = user_info['name']
    occupation = user_info['occupation']
    location = user_info['location']
    age = user_info['age']
    bio = user_info['bio']

    # execute query
    query = 'UPDATE users SET name = %s, occupation = %s, location = %s, age = %s, bio = %s WHERE id = %s'
    data = (name, occupation, location, age, bio, userID)
    r = cursor.execute(query, data)
    db.get_db().commit()
    return 'customer updated!'

# search users by their skills
@api2.route('/users/by-skills', methods=['GET'])
def get_users_by_skills():
    
    soft_skills = request.args.get('soft_skills')
    tech_skills = request.args.get('tech_skills')

    query = '''
    SELECT u.Name, u.Bio, u.Occupation, c.CompanyName, e.SoftSkills, e.TechnicalSkills
    FROM Users u
	JOIN User_Type ut ON u.UserID = ut.UserID
	JOIN Employer e ON ut.EmpID = e.EmpID
	JOIN Company c ON c.CompanyID = e.EmpID
    WHERE e.SoftSkills = %s AND e.TechnicalSkills = %s
    '''

    current_app.logger.info('GET /users/by-skills route')
    cursor = db.get_db().cursor()
    cursor.execute(query, (soft_skills, tech_skills))
    
    theData = cursor.fetchall()
    
    the_response = make_response(jsonify(theData))
    the_response.status_code = 200
    return the_response

# create a new user
@api2.route('/users/create', methods=['POST'])
def add_new_user():
    
    the_data = request.json
    current_app.logger.info(the_data)

    # extract the variable
    occupation = the_data['occupation']
    location = the_data['location']
    name = the_data['name']
    age = the_data['age']
    bio = the_data['bio']
    reffered_by = the_data['reffered_by']
    
    query = '''
        INSERT INTO Users (occupation, location, name, age, bio, ReferredBy)
        VALUES (%s, %s, %s, %s, %s, %s)
        '''

    current_app.logger.info(query)

    # execute and commit the insert statement 
    cursor = db.get_db().cursor()
    cursor.execute(query, (occupation, location, name, age, bio, reffered_by))
    db.get_db().commit()
    
    response = make_response("Successfully created user!")
    response.status_code = 200
    return response


# create a notification
@api2.route('/notifications', methods=['POST'])
def create_notification():
    
    the_data = request.json
    current_app.logger.info(the_data)

    # extract the variable
    notification = the_data['notification']
    
    query = '''
        INSERT INTO Notifications (Text)
        VALUES ( %s )
        '''

    current_app.logger.info(query)

    # execute and commit the insert statement 
    cursor = db.get_db().cursor()
    cursor.execute(query, (notification,))
    db.get_db().commit()
    
    response = make_response("Successfully created notification!")
    response.status_code = 200
    return response

# delete a user
@api2.route('/users/delete/<userID>', methods = ['DELETE'])
def delete_user(userID):

    # log the deletion
    current_app.logger.info(f'Deleting user with ID: {userID}')
    
    # Create a cursor and execute the DELETE query
    query = 'DELETE FROM Users WHERE userID = %s'
    cursor = db.get_db().cursor()
    cursor.execute(query, (userID,))
    
    # Commit the transaction
    db.get_db().commit()

    response = make_response("User successfully deleted!")
    response.status_code = 200
    
    return response


@api2.route('/users/view/<int:UserID>', methods=['GET'])
def get_single_user(UserID):
    
    query = f'''
    SELECT u.UserID, u.Name, u.Bio, u.Location, u.Occupation, u.Location, i.Name AS Industry, i.NUCollege
    FROM Users u
	JOIN User_Industry ui ON u.UserID = ui.UserID
	JOIN Industry i ON i.IndustryID = ui.IndustryID
    WHERE u.UserID = {UserID}
    '''

    current_app.logger.info('GET /users/view/<int:UserID> route')
    cursor = db.get_db().cursor()
    cursor.execute(query)

    theData = cursor.fetchall()
    current_app.logger.info('request results:', theData)
    
    the_response = make_response(jsonify(theData))
    the_response.status_code = 200
    return the_response
