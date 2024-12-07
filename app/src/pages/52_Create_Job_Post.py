import streamlit as st
import requests

BASE_API_URL = "http://api:4000/aa"

def post_job_to_api(job_data):
    try:
        response = requests.post(f"{BASE_API_URL}/job-postings", json=job_data)
        response.raise_for_status()
        return True
    except requests.exceptions.RequestException as e:
        st.error(f"Failed to post the job: {e}")
        return False

def main():
    st.title("Create a New Job Posting")
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

if __name__ == "__main__":
    main()
