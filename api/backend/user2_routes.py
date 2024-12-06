from flask import Flask 
from flask import Blueprint
from flask import request
from flask import jsonify
from flask import make_response
from backend.db_connection import db
import logging

# create blueprint object
users = Blueprint('api2', __name__)

# Get users from specific industries:
<<<<<<< HEAD
@users.route('/users/<industry>', methods=['GET'])
def get_users_by_industry(industry):
=======
@api2.route('/users/by-industry', methods=['GET'])
def get_users_by_industry():
>>>>>>> c1364949e97ee85a7b5c69279f8340a1a35a441a
    
    industry = request.json['industry']

    query = f'''
    SELECT u.UserID, u.Name, u.Bio, i.Name AS IndustryName, i.NUCollege
    FROM Users u
	JOIN User_Industry ui ON u.UserID = ui.UserID
	JOIN Industry i ON i.IndustryID = ui.IndustryID
    WHERE i.Name LIKE '{industry}';
    '''

    current_app.logger.info('GET /users/by-industry route')
    cursor = db.get_db().cursor()
    cursor.execute(query)
    
    theData = cursor.fetchall()

    the_response = make_response(jsonify(theData))
    the_response.status_code = 200
    current_app.logger.info(the_response)

    return the_response

# update user info
<<<<<<< HEAD
@users.route('/users/<userID>', methods=['PUT'])
=======
@api2.route('/users/update/<userID>', methods=['PUT'])
>>>>>>> c1364949e97ee85a7b5c69279f8340a1a35a441a
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
@users.route('/users/by-skills', methods=['GET'])
def get_users_by_skills():
    
    user_info = request.json
    soft_skills = str(user_info['soft_skills'])
    tech_skills = str(user_info['tech_skills'])

<<<<<<< HEAD
    query = '''
    SELECT u.Name, u.Bio, u.Occupation, c.CompanyName, e.SoftSkills, e.TechnicalSkills
    FROM Users u
	JOIN User_Type ut ON u.UserID = ut.UserID
	JOIN Employers e ON ut.EmpID = e.EmpID
	JOIN Companies c ON c.CompanyID = e.EmpID
    WHERE e.SoftSkills = %s AND e.TechnicalSkills = %s
=======
    query = f'''
    SELECT u.UserID, u.Name, u.Bio, u.Occupation, e.SoftSkills, e.TechnicalSkills
    FROM Employer e
	JOIN User_Type ut ON e.EmpID = ut.UserID
	JOIN Users u ON ut.UserID = u.UserID
    WHERE e.SoftSkills LIKE '{soft_skills}' AND e.TechnicalSkills LIKE '{tech_skills}' AND u.UserID IS NOT NULL;
>>>>>>> c1364949e97ee85a7b5c69279f8340a1a35a441a
    '''

    current_app.logger.info('GET /users/by-skills route')
    cursor = db.get_db().cursor()
    cursor.execute(query)
    
    theData = cursor.fetchall()
    
    the_response = make_response(jsonify(theData))
    the_response.status_code = 200
    return the_response

# create a new user
<<<<<<< HEAD
@users.route('/users', methods=['POST'])
def add_new_product():
=======
@api2.route('/users/create', methods=['POST'])
def add_new_user():
>>>>>>> c1364949e97ee85a7b5c69279f8340a1a35a441a
    
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
@notifications.route('/notifications', methods=['POST'])
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
<<<<<<< HEAD
@users.route('/users/<userID>', methods = ['DELETE'])
=======
@api2.route('/users/delete/<userID>', methods = ['DELETE'])
>>>>>>> c1364949e97ee85a7b5c69279f8340a1a35a441a
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
<<<<<<< HEAD
=======


@api2.route('/users/view/<int:UserID>', methods=['GET'])
def get_single_user(UserID):
    
    query = f'''
    SELECT u.UserID, u.Name, u.Bio, u.Location, u.Occupation, u.age, i.Name AS Industry, i.NUCollege, u.Online, u.ReferredBy
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
>>>>>>> c1364949e97ee85a7b5c69279f8340a1a35a441a
