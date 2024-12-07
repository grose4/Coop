import streamlit as st
import requests
import pandas as pd

BASE_API_URL = "http://api:4000/aa"

def fetch_all_job_postings():
    try:
        response = requests.get(f"{BASE_API_URL}/job-postings")
        response.raise_for_status()
        postings = response.json()
        return pd.DataFrame(postings, columns=["JobID", "Title", "Description", "Location", "Skills", "Deadline", "Salary"])
    except requests.exceptions.RequestException as e:
        st.error(f"Failed to fetch job postings: {e}")
        return None

def fetch_job_posting_by_id(job_id):
    try:
        response = requests.get(f"{BASE_API_URL}/job-postings/{job_id}")
        response.raise_for_status()
        return response.json()
    except requests.exceptions.RequestException as e:
        st.error(f"Failed to fetch job posting: {e}")
        return None

def post_job_to_api(job_data):
    try:
        response = requests.post(f"{BASE_API_URL}/job-postings", json=job_data)
        response.raise_for_status()
        return True
    except requests.exceptions.RequestException as e:
        st.error(f"Failed to post the job: {e}")
        return False

def update_job_posting(job_id, field, value):
    try:
        payload = {field: value}
        response = requests.put(f"{BASE_API_URL}/job-postings/{job_id}", json=payload)
        response.raise_for_status()
        return True
    except requests.exceptions.RequestException as e:
        st.error(f"Failed to update job posting: {e}")
        return False

def delete_job_posting(job_id):
    try:
        response = requests.delete(f"{BASE_API_URL}/job-postings/{job_id}")
        response.raise_for_status()
        return True
    except requests.exceptions.RequestException as e:
        st.error(f"Failed to delete job posting: {e}")
        return False

def main():
    st.title("Job Postings")
    st.sidebar.title("Job Posting Actions")
    options = ["View All Job Postings", "View Job Posting by ID", "Post a New Job", "Update Job Posting", "Delete Job Posting"]
    choice = st.sidebar.radio("Choose an Action:", options)

    if choice == "View All Job Postings":
        st.header("View All Job Postings")
        job_data = fetch_all_job_postings()
        if job_data is not None and not job_data.empty:
            st.dataframe(job_data)
        else:
            st.warning("No job postings available.")

    elif choice == "View Job Posting by ID":
        st.header("View Job Posting by ID")
        job_id = st.number_input("Enter Job ID:", min_value=1, step=1)
        if st.button("Search"):
            job_posting = fetch_job_posting_by_id(job_id)
            if job_posting:
                st.json(job_posting)
            else:
                st.warning(f"No job posting found with ID {job_id}.")

    elif choice == "Post a New Job":
        st.header("Post a New Job")
        with st.form("job_post_form"):
            title = st.text_input("Job Title", "")
            description = st.text_area("Job Description", "")
            location = st.text_input("Location", "")
            skills = st.text_input("Skills (comma-separated)", "")
            salary = st.number_input("Salary (USD)", min_value=0, step=1000)
            deadline = st.date_input("Application Deadline")
            employer_id = st.text_input("Employer ID", "")

            submit_button = st.form_submit_button("Post Job")
            if submit_button:
                if not all([title, description, location, skills, employer_id]):
                    st.error("Please fill out all required fields.")
                else:
                    job_data = {
                        "title": title,
                        "description": description,
                        "location": location,
                        "skills": skills,
                        "salary": salary,
                        "deadline": deadline.strftime("%Y-%m-%d"),
                        "employer_id": employer_id
                    }
                    if post_job_to_api(job_data):
                        st.success("Job posted successfully!")
                    else:
                        st.error("Failed to post the job.")

    elif choice == "Update Job Posting":
        st.header("Update Job Posting")
        job_id = st.number_input("Enter Job ID:", min_value=1, step=1)
        field = st.selectbox("Field to Update:", ["Title", "Description", "Location", "Skills", "Salary", "Deadline"])
        value = st.text_input(f"Enter New Value for {field}:", "")
        if st.button("Update Job"):
            if not all([job_id, field, value]):
                st.error("Please fill out all fields.")
            else:
                if update_job_posting(job_id, field, value):
                    st.success(f"Job posting {job_id} updated successfully!")
                else:
                    st.error(f"Failed to update job posting {job_id}.")

    elif choice == "Delete Job Posting":
        st.header("Delete Job Posting")
        job_id = st.number_input("Enter Job ID to Delete:", min_value=1, step=1)
        if st.button("Delete Job"):
            if not job_id:
                st.error("Please enter a Job ID.")
            else:
                if delete_job_posting(job_id):
                    st.success(f"Job posting {job_id} deleted successfully!")
                else:
                    st.error(f"Failed to delete job posting {job_id}.")

if __name__ == "__main__":
    main()
