import streamlit as st
import requests
import pandas as pd
from modules.nav import SideBarLinks

SideBarLinks()

BASE_API_URL = "http://api:4000/jp"

def fetch_all_job_postings(location="%", skills="%", deadline="%"):
    try:
        filters = {
            "location": location,
            "skills": skills,
            "deadline": deadline,
        }
        response = requests.get(
            f"{BASE_API_URL}/job-postings",
            json=filters
        )
        response.raise_for_status()
        postings = response.json()
        return pd.DataFrame(
            postings,
            columns=["JobID", "Title", "Description", "Location", "Skills", "Deadline", "Salary"],
        )
    except requests.exceptions.RequestException as e:
        st.error(f"Failed to fetch job postings: {e}")
        return None


def fetch_job_posting_by_id(job_id):
    """
    Fetch a specific job posting by ID from the API.
    """
    try:
        response = requests.get(f"{BASE_API_URL}/job-postings/{job_id}")
        response.raise_for_status()
        return response.json()
    except requests.exceptions.RequestException as e:
        st.error(f"Failed to fetch job posting: {e}")
        return None

def main():
    st.title("View Job Postings")
    st.subheader("Filter Job Postings")

    # Filters
    location = st.text_input("Location (Leave blank for all):", value="%")
    skills = st.text_input("Skills (Leave blank for all):", value="%")
    deadline = st.date_input("Deadline (Leave blank for all):")

    # Fetch and display job postings
    st.subheader("All Job Postings")
    if st.button("Apply Filters"):
        job_data = fetch_all_job_postings(
            location=location if location else "%",
            skills=skills if skills else "%",
            deadline=str(deadline) if deadline else "%",
        )
        if job_data is not None and not job_data.empty:
            st.dataframe(job_data)
        else:
            st.warning("No job postings available.")

main()
