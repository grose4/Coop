from flask import Flask 
from flask import Blueprint
from flask import request
from flask import current_app
from flask import jsonify
from flask import make_response
from backend.db_connection import db
import logging

api3 = Blueprint('api3', __name__)

@api3.route('/job-postings', methods=['GET'])
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
@api3.route('/job-postings/<int:job_id>', methods=['GET'])
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

@api3.route('/job-postings', methods=['POST'])
def create_job_posting():
<<<<<<< HEAD
    try:
        # Log the incoming payload for debugging
        job_data = request.json
        current_app.logger.info(f"Received payload: {job_data}")

        # Extract fields from the payload
        Text = job_data.get('Text')
        SalaryRange = job_data.get('SalaryRange')
        Title = job_data.get('Title')
        GPA_Range = job_data.get('GPA_Range')
        Location = job_data.get('Location')
        Deadline = job_data.get('Deadline')
        Experience_Level = job_data.get('Experience_Level')

        # Validate all required fields
        required_fields = ['Text', 'SalaryRange', 'Title', 'GPA_Range', 'Location', 'Deadline', 'Experience_Level']
        for field in required_fields:
            if not job_data.get(field):
                current_app.logger.error(f"Missing key in request payload: '{field}'")
                return jsonify({"error": f"Missing required field: '{field}'"}), 400

        # SQL query to insert into the database
        query = '''
        INSERT INTO Job_Postings (Text, SalaryRange, Title, GPA_Range, Location, Deadline, Experience_Level)
        VALUES (%s, %s, %s, %s, %s, %s, %s)
        '''
        current_app.logger.info('POST /job-postings route')

        # Execute the query
        cursor = db.get_db().cursor()
        cursor.execute(query, (Text, SalaryRange, Title, GPA_Range, Location, Deadline, Experience_Level))
        db.get_db().commit()

        # Return success response
        response = make_response("Job posting successfully created!")
        response.status_code = 201
        return response

    except Exception as e:
        # Log unexpected errors
        current_app.logger.error(f"Error creating job posting: {e}", exc_info=True)
        return jsonify({"error": "Internal server error", "details": str(e)}), 500


=======
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
>>>>>>> ec2680e06f856d8d500e85ee5e696e741cd6bd97

# Update an existing job posting
@api3.route('/job-postings/<int:job_id>', methods=['PUT'])
def update_job_posting(job_id):
    job_data = request.json
    title = job_data['title']
    text = job_data['text']
    experience_level = job_data['experience_level']
    gpa_range = job_data['gpa_range']
    deadline = job_data['deadline']
    salary_range = job_data['salary_range']

    query = '''
    UPDATE Job_Postings
    SET Title = %s, Text = %s, SalaryRange = %s, Title = %s, GPA_Range = %s, Location = %s, Deadline = %s, Experience_Level = %s
    WHERE JobPostingID = %s
    '''
    current_app.logger.info(f'PUT /job-postings/<int:job_id> route')
    cursor = db.get_db().cursor()
    cursor.execute(query, (title, text, experience_level, deadline, salary_range))
    db.get_db().commit()
    
    response = make_response("Job posting successfully updated!")
    response.status_code = 200
    return response

# Delete a job posting
@api3.route('/job-postings/<int:job_id>', methods=['DELETE'])
def delete_job_posting(job_id):
    query = 'DELETE FROM Job_Postings WHERE JobPostingID = %s'
    current_app.logger.info(f'DELETE /job-postings/<int:job_id> route')
    cursor = db.get_db().cursor()
    cursor.execute(query, (job_id,))
    db.get_db().commit()

    response = make_response("Job posting successfully deleted!")
    response.status_code = 200
    return response
