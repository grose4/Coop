import streamlit as st
from modules.nav import SideBarLinks

# Initialize the sidebar for employer-specific navigation
SideBarLinks()

def main():
    # Page title and welcome message
    st.title("Employer Dashboard")
    st.write(f"Welcome, {st.session_state['first_name']}!")

    # Main content
    st.write("Use the options below to manage job postings and view candidates:")

    # Buttons or links to employer functionalities
    if st.button("Post a Job"):
        st.switch_page("28_Job_Postings")  # Replace with the correct page name if needed

    if st.button("View Candidates"):
        st.switch_page("29_View_Candidates")  # Replace with the correct page name

    if st.button("Manage Profile"):
        st.switch_page("30_Manage_Profile")  # Replace with the correct page name

if __name__ == "__main__":
    main()
