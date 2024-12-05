from flask import Flask 
from flask import Blueprint
from flask import request
from flask import jsonify
from flask import make_response
from backend.db_connection import db

# Create a new Blueprint object
api = Blueprint('api', __name__)

# USERS ENDPOINTS

# Get all users
@api.route('/users', methods=['GET'])
def get_users():
    cursor = db.get_db().cursor()
    cursor.execute('SELECT UserID, Name, Bio FROM Users')
    users = cursor.fetchall()
    response = make_response(jsonify(users))
    response.status_code = 200
    return response

# Update user info 
@api.route('/users', methods=['PUT'])
def update_user():
    user_info = request.json
    user_id = user_info['id']
    username = user_info['username']
    email = user_info['email']

    query = 'UPDATE users SET username = %s, email = %s WHERE id = %s'
    data = (username, email, user_id)
    cursor = db.get_db().cursor()
    cursor.execute(query, data)
    db.get_db().commit()
    return 'user updated!'

# Delete a user 
@api.route('/users', methods=['DELETE'])
def delete_user():
    user_id = request.args.get('id')
    query = 'DELETE FROM users WHERE id = %s'
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
