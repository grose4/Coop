import streamlit as st
import requests
from modules.nav import SideBarLinks

SideBarLinks()

BASE_JP_API_URL = "http://api:4000/jp"

def post_job_to_api(job_data):
    try:
        response = requests.post(f"{BASE_JP_API_URL}/job-postings", json=job_data)
        response.raise_for_status()
        return True
    except requests.exceptions.RequestException as e:
        st.error(f"Failed to post the job: {e}")
        return False

def main():
    st.title("Create a New Job Posting")
    with st.form("job_post_form"):
        # Job Posting Fields
        title = st.text_input("Job Title", "")
        text = st.text_area("Job Description", "")
        salary_range = st.text_input("Salary Range (e.g., '50000-70000')", "")
        gpa_range = st.text_input("GPA Range (e.g., '3.5-4.0')", "")
        location = st.text_input("Location", "")
        deadline = st.date_input("Application Deadline")
        experience_level = st.text_input("Experience Level (e.g., 'Entry', 'Mid', 'Senior')", "")

        # Submit Button
        submit_button = st.form_submit_button("Post Job")
        if submit_button:
            # Validate Required Fields
            if not all([title, text, salary_range, gpa_range, location, deadline, experience_level]):
                st.error("Please fill out all required fields.")
            else:
                # Construct Payload
                job_data = {
                    "Text": text,
                    "SalaryRange": salary_range,
                    "Title": title,
                    "GPA_Range": gpa_range,
                    "Location": location,
                    "Deadline": deadline.strftime("%Y-%m-%d"),
                    "Experience_Level": experience_level
                }
                # Post to API
                if post_job_to_api(job_data):
                    st.success("Job posted successfully!")
                else:
                    st.error("Failed to post the job.")

main()
