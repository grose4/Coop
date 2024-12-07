from flask import Flask 
from flask import Blueprint
from flask import request
from flask import current_app
from flask import jsonify
from flask import make_response
from backend.db_connection import db
import logging

api4 = Blueprint('api4', __name__)

@api4.route('/job-postings', methods=['GET'])
def get_all_job_postings():
    """
    Fetch all job postings from the database without filters.
    """
    query = '''
    SELECT JobPostingID, Text, SalaryRange, Title, GPA_Range, Location, Deadline, Experience_Level
    FROM Job_Postings
    '''
    cursor = db.get_db().cursor()
    cursor.execute(query)
    postings = cursor.fetchall()
    response = make_response(jsonify(postings))
    response.status_code = 200
    return response



# Retrieve specific job posting by ID
@api4.route('/job-postings/<int:job_id>', methods=['GET'])
def get_job_posting(job_id):
    query = f'''
    SELECT JobPostingID, Text, SalaryRange, Title, GPA_Range, Deadline, Experience_Level
    FROM Job_Postings
    WHERE JobPostingID = %s
    '''
    current_app.logger.info('GET /job-postings/<int:job_id> route')
    cursor = db.get_db().cursor()
    cursor.execute(query, (job_id,))
    
    the_data = cursor.fetchall()
    response = make_response(jsonify(the_data))
    response.status_code = 200
    return response

# Create a new job posting
@api3.route('/job-postings', methods=['POST'])
def create_job_posting():
    job_data = request.json
    title = job_data['title']
    text = job_data['text']
    experience_level = job_data['experience_level']
    gpa_range = job_data['gpa_range']
    deadline = job_data['deadline']
    salary_range = job_data['salary_range']

    query = '''
    INSERT INTO Job_Postings (Text, SalaryRange, Title, GPA_Range, Deadline, Experience_Level)
    VALUES (%s, %s, %s, %s, %s, %s)
    '''
    current_app.logger.info('POST /job-postings route')
    cursor = db.get_db().cursor()
    cursor.execute(query, (text, salary_range, title, gpa_range, deadline, experience_level))
    db.get_db().commit()
    
    response = make_response("Job posting successfully created!")
    response.status_code = 201
    return response

# Update an existing job posting
@api4.route('/job-postings/<int:job_id>', methods=['PUT'])
def update_job_posting(job_id):
    """
    Update a specific field in a job posting.
    """
    try:
        job_data = request.json
        field = job_data.get('field')
        value = job_data.get('value')

        # Validate the field to ensure it's a valid column
        valid_fields = [
            "Text", "SalaryRange", "Title", 
            "GPA_Range", "Location", "Deadline", "Experience_Level"
        ]
        if field not in valid_fields:
            return jsonify({"error": f"Invalid field: {field}"}), 400

        # Build the SQL query dynamically
        query = f"UPDATE Job_Postings SET {field} = %s WHERE JobPostingID = %s"
        current_app.logger.info(f"Executing query: {query} with values: ({value}, {job_id})")

        # Execute the query
        cursor = db.get_db().cursor()
        cursor.execute(query, (value, job_id))
        db.get_db().commit()

        return jsonify({"message": f"Job posting {job_id} updated successfully!"}), 200

    except Exception as e:
        current_app.logger.error(f"Error updating job posting: {e}", exc_info=True)
        return jsonify({"error": "Internal server error", "details": str(e)}), 500


# Delete a job posting
@api4.route('/job-postings/<int:job_id>', methods=['DELETE'])
def delete_job_posting(job_id):
    query = 'DELETE FROM Job_Postings WHERE JobPostingID = %s'
    current_app.logger.info(f'DELETE /job-postings/<int:job_id> route')
    cursor = db.get_db().cursor()
    cursor.execute(query, (job_id,))
    db.get_db().commit()

    response = make_response("Job posting successfully deleted!")
    response.status_code = 200
    return response
