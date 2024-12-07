import streamlit as st
from modules.nav import SideBarLinks

SideBarLinks()

def main():
    st.title("Employer Dashboard")
    st.write(f"Welcome, {st.session_state.get('first_name', 'Employer')}!")
    
    # Provide a single button to redirect to 28_Job_Postings.py
    st.write("Manage all your job postings from the central dashboard below.")
    
    if st.button("Go to Job Postings Dashboard", type="primary"):
        st.switch_page("28_Job_Postings")  

if __name__ == "__main__":
    main()

