import streamlit as st
import requests

BASE_API_URL = "http://api:4000/aa"

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
    st.title("Manage Job Postings")
    st.subheader("Update a Job Posting")
    job_id = st.number_input("Enter Job ID to Update:", min_value=1, step=1)
    field = st.selectbox("Field to Update:", ["Title", "Description", "Location", "Skills", "Salary", "Deadline"])
    value = st.text_input(f"Enter New Value for {field}:", "")
    if st.button("Update Job"):
        if not all([job_id, field, value]):
            st.error("Please fill in all fields.")
        else:
            if update_job_posting(job_id, field, value):
                st.success(f"Job posting {job_id} updated successfully!")
            else:
                st.error(f"Failed to update job posting {job_id}.")

    st.subheader("Delete a Job Posting")
    delete_id = st.number_input("Enter Job ID to Delete:", min_value=1, step=1)
    if st.button("Delete Job Posting"):
        if not delete_id:
            st.error("Please enter a Job ID.")
        else:
            if delete_job_posting(delete_id):
                st.success(f"Job posting {delete_id} deleted successfully!")
            else:
                st.error(f"Failed to delete job posting {delete_id}.")

if __name__ == "__main__":
    main()
