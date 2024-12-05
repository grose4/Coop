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
def update_user(user_id, field, value):
    try:
        # Treat empty strings as NULL
        payload = {"field": field, "value": None if value == "" else value}
        
        # Send the PUT request
        response = requests.put(f"{BASE_API_URL}/users/{user_id}", json=payload)
        response.raise_for_status()  # Raise an error if the status is not 200
        return True
    except requests.exceptions.RequestException as e:
        st.error(f"Error updating user: {e}")
        return False





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

# Get all support tickets
@api.route('/support-tickets', methods=['GET'])
def get_support_tickets():
    cursor = db.get_db().cursor()
    cursor.execute('SELECT id, user_id, issue_description, status FROM SupportTickets')
    tickets = cursor.fetchall()
    response = make_response(jsonify(tickets))
    response.status_code = 200
    return response

# Delete a support ticket 
@api.route('/support-tickets', methods=['DELETE'])
def delete_support_ticket():
    ticket_id = request.args.get('id')
    query = 'DELETE FROM SupportTickets WHERE id = %s'
    cursor = db.get_db().cursor()
    cursor.execute(query, (ticket_id,))
    db.get_db().commit()
    return 'Support ticket deleted successfully!'

# Get interaction data 
@api.route('/interactions', methods=['GET'])
def get_interactions():
    cursor = db.get_db().cursor()
    cursor.execute('SELECT id, user_id, interaction_type, timestamp FROM Interactions')
    interactions = cursor.fetchall()
    response = make_response(jsonify(interactions))
    response.status_code = 200
    return response

@api.route('/notifications', methods=['POST'])
def send_notification():
    notification_data = request.json
    
    user_id = notification_data['user_id']
    title = notification_data['title']
    message = notification_data['message']

    query = '''
        INSERT INTO notifications (user_id, title, message, created_at)
        VALUES (%s, %s, %s, NOW())
    '''
    data = (user_id, title, message)

    cursor = db.get_db().cursor()
    cursor.execute(query, data)
    db.get_db().commit()

    return 'Notification Sent'
