import streamlit as st
import requests
import pandas as pd

BASE_API_URL = "http://api:4000/aa"

def fetch_all_job_postings():
    """
    Fetch all job postings from the API.
    Returns a Pandas DataFrame if successful, otherwise None.
    """
    try:
        response = requests.get(f"{BASE_API_URL}/job-postings")
        response.raise_for_status()
        postings = response.json()
        return pd.DataFrame(postings, columns=["JobID", "Title", "Description", "Location", "Skills", "Deadline", "Salary"])
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
    st.subheader("All Job Postings")
    job_data = fetch_all_job_postings()
    if job_data is not None and not job_data.empty:
        st.dataframe(job_data)
    else:
        st.warning("No job postings available.")

    st.subheader("Search Job Posting by ID")
    job_id = st.number_input("Enter Job ID:", min_value=1, step=1)
    if st.button("Search"):
        job_posting = fetch_job_posting_by_id(job_id)
        if job_posting:
            st.json(job_posting)
        else:
            st.warning(f"No job posting found with ID {job_id}.")

if __name__ == "__main__":
    main()
