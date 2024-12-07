from flask import Flask 
from flask import Blueprint
from flask import request
from flask import current_app
from flask import jsonify
from flask import make_response
from backend.db_connection import db
import logging

job_postings_bp = Blueprint('job_postings', __name__)

# Retrieve all job postings with filters
@job_postings_bp.route('/job-postings', methods=['GET'])
def get_all_job_postings():
    filters = request.json
    location = filters.get('location', '%')
    skills = filters.get('skills', '%')
    deadline = filters.get('deadline', '%')

    query = f'''
    SELECT JobID, Title, Description, Location, Skills, Deadline, Salary
    FROM Job_Postings
    WHERE Location LIKE %s AND Skills LIKE %s AND Deadline <= %s
    '''
    current_app.logger.info('GET /job-postings route')
    cursor = db.get_db().cursor()
    cursor.execute(query, (location, skills, deadline))
    
    the_data = cursor.fetchall()
    response = make_response(jsonify(the_data))
    response.status_code = 200
    return response

# Retrieve specific job posting by ID
@job_postings_bp.route('/job-postings/<int:job_id>', methods=['GET'])
def get_job_posting(job_id):
    query = f'''
    SELECT JobID, Title, Description, Location, Skills, Deadline, Salary
    FROM Job_Postings
    WHERE JobID = %s
    '''
    current_app.logger.info('GET /job-postings/<int:job_id> route')
    cursor = db.get_db().cursor()
    cursor.execute(query, (job_id,))
    
    the_data = cursor.fetchall()
    response = make_response(jsonify(the_data))
    response.status_code = 200
    return response

# Create a new job posting
@job_postings_bp.route('/job-postings', methods=['POST'])
def create_job_posting():
    job_data = request.json
    title = job_data['title']
    description = job_data['description']
    location = job_data['location']
    skills = job_data['skills']
    deadline = job_data['deadline']
    salary = job_data['salary']

    query = '''
    INSERT INTO Job_Postings (Title, Description, Location, Skills, Deadline, Salary)
    VALUES (%s, %s, %s, %s, %s, %s)
    '''
    current_app.logger.info('POST /job-postings route')
    cursor = db.get_db().cursor()
    cursor.execute(query, (title, description, location, skills, deadline, salary))
    db.get_db().commit()
    
    response = make_response("Job posting successfully created!")
    response.status_code = 201
    return response

# Update an existing job posting
@job_postings_bp.route('/job-postings/<int:job_id>', methods=['PUT'])
def update_job_posting(job_id):
    job_data = request.json
    title = job_data.get('title')
    description = job_data.get('description')
    location = job_data.get('location')
    skills = job_data.get('skills')
    deadline = job_data.get('deadline')
    salary = job_data.get('salary')

    query = '''
    UPDATE Job_Postings
    SET Title = %s, Description = %s, Location = %s, Skills = %s, Deadline = %s, Salary = %s
    WHERE JobID = %s
    '''
    current_app.logger.info(f'PUT /job-postings/<int:job_id> route')
    cursor = db.get_db().cursor()
    cursor.execute(query, (title, description, location, skills, deadline, salary, job_id))
    db.get_db().commit()
    
    response = make_response("Job posting successfully updated!")
    response.status_code = 200
    return response

# Delete a job posting
@job_postings_bp.route('/job-postings/<int:job_id>', methods=['DELETE'])
def delete_job_posting(job_id):
    query = 'DELETE FROM Job_Postings WHERE JobID = %s'
    current_app.logger.info(f'DELETE /job-postings/<int:job_id> route')
    cursor = db.get_db().cursor()
    cursor.execute(query, (job_id,))
    db.get_db().commit()

    response = make_response("Job posting successfully deleted!")
    response.status_code = 200
    return response
