import streamlit as st
from modules.nav import SideBarLinks

SideBarLinks()

def main():
    st.title("Employer Dashboard")
    st.write(f"Welcome, {st.session_state.get('first_name', 'Employer')}!")
    st.write("Manage your job postings using the options below:")

    if st.button("View Job Postings"):
        st.switch_page("51_View_Job_Post")
    if st.button("Create Job Posting"):
        st.switch_page("52_Create_Job_Post")
    if st.button("Manage Job Postings"):
        st.switch_page("53_Manage_Job_Post")

if __name__ == "__main__":
    main()


