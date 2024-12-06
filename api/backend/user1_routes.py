from flask import Flask 
from flask import Blueprint
from flask import request
from flask import jsonify
from flask import make_response
from backend.db_connection import db
import logging

# Create a new Blueprint object
api = Blueprint('api', __name__)

# USERS ENDPOINTS

import sys

@api.route('/users', methods=['GET'])
def get_users():
    cursor = db.get_db().cursor()
    cursor.execute('SELECT * FROM Users')
    users = cursor.fetchall()
    print(users, flush=True)  # Flush the output to ensure it appears in logs
    response = make_response(jsonify(users))
    response.status_code = 200
    return response



@api.route('/users/<int:user_id>', methods=['PUT'])
def update_user(user_id):
    user_info = request.json
    field = user_info.get('field')
    value = user_info.get('value')


    query = f"UPDATE Users SET {field} = %s WHERE UserID = %s"
    data = (value, user_id)

    try:
        cursor = db.get_db().cursor()
        cursor.execute(query, data)
        db.get_db().commit()
        return {"message": "User updated successfully"}, 200
    except Exception as e:
        return {"error": str(e)}, 500


# Delete a user 
@api.route('/users', methods=['DELETE'])
def delete_user():
    user_id = request.args.get('id')
    query = 'DELETE FROM Users WHERE UserID = %s'
    cursor = db.get_db().cursor()
    cursor.execute(query, (user_id,))
    db.get_db().commit()
    return 'User deleted successfully!'


# SUPPORT-TICKETS ENDPOINTS

@api.route('/SupportTickets', methods=['GET'])
def get_support_tickets():
        cursor = db.get_db().cursor()
        cursor.execute('SELECT TikNum, UserID, StartedAt, Category, RespondedAt, Active, Text, Urgency FROM SupportTickets')
        tickets = cursor.fetchall()
        return jsonify(tickets), 200



@api.route('/SupportTickets/<int:TikNum>', methods=['DELETE'])
def delete_support_ticket(TikNum):
    query = 'DELETE FROM SupportTickets WHERE TikNum = %s'
    cursor = db.get_db().cursor()
    cursor.execute(query, (TikNum,))
    db.get_db().commit()
    return {"message": "Support ticket deleted successfully!"}, 200

# Get interaction data 
@api.route('/interactions', methods=['GET'])
def get_interactions():
    cursor = db.get_db().cursor()
    cursor.execute('SELECT * FROM Interactions')
    interactions = cursor.fetchall()
    response = make_response(jsonify(interactions))
    response.status_code = 200
    return response

@api.route('/notifications', methods=['POST'])
def send_notification():
    try:
        notification_data = request.json
        user_id = notification_data.get('user_id')  
        message = notification_data.get('message')

        if not message:
            return {"error": "Notification message is required."}, 400

        query = '''
            INSERT INTO Notifications (CreatedBy, Text, Active)
            VALUES (%s, %s, TRUE)
        '''
        data = (user_id, message)

        cursor = db.get_db().cursor()
        cursor.execute(query, data)
        db.get_db().commit()

        return {"message": "Notification sent successfully!"}, 200
    except Exception as e:
        current_app.logger.error(f"Error sending notification: {e}")
        return {"error": str(e)}, 500

