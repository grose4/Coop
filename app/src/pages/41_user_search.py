import logging
logger = logging.getLogger(__name__)

import streamlit as st
from modules.nav import SideBarLinks
import requests
import pandas as pd

st.set_page_config(layout = 'wide')

# Show appropriate sidebar links for the role of the currently logged in user
SideBarLinks()

def fetch_user_data(UserID):
    """
    Fetch user data from the Flask API.
    Returns a Pandas DataFrame if successful, otherwise None.
    """
    try:
        response = requests.get("http://api:4000/aa/users/view/" + str(UserID))
        response.raise_for_status() 
        users = response.json() 
        user_data = pd.DataFrame(users, columns=["UserID", 'Name', "Occupation", "Location,", "Age", "Bio", 'Industry', 'NUCollege'])
        return user_data
    except requests.exceptions.RequestException as e:
        st.error(f"Failed to fetch  data from the API: {e}")
        return None

def fetch_user_data_industry(industry):
    """
    Fetch user data from the Flask API.
    Returns a Pandas DataFrame if successful, otherwise None.
    """
    try:
        response = requests.get("http://api:4000/aa/users/by-industry", json={'industry':industry})
        response.raise_for_status() 
        users = response.json() 
        user_data = pd.DataFrame(users, columns=["UserID", "Name", "Bio", "IndustryName", "NUCollege"])
        return user_data
    except requests.exceptions.RequestException as e:
        st.error(f"Failed to fetch  data from the API: {e}") 
        return None

def fetch_user_data_skills(soft_skills, tech_skills):
    """
    Fetch user data from the Flask API.
    Returns a Pandas DataFrame if successful, otherwise None.
    """
    try:
        skills_data = {'soft_skills' : soft_skills, 'tech_skills' : tech_skills}
        response = requests.get("http://api:4000/aa/users/by-skills", json=skills_data)
        response.raise_for_status() 
        users = response.json() 
        user_data = pd.DataFrame(users, columns=["UserID", "Name", "Bio", "Occupation", "CompanyName", 'SoftSkills', 'TechnicalSkills'])
        return user_data
    except requests.exceptions.RequestException as e:
        st.error(f"Failed to fetch  data from the API: {e}")
        return None
    
    
def fetch_user_data_companies(companies):
    """
    Fetch user data from the Flask API.
    Returns a Pandas DataFrame if successful, otherwise None.
    """
    try:
        companies_data = {'companies' : companies}
        response = requests.get("http://api:4000/aaa/student/by-companies", json=companies_data)
        response.raise_for_status() 
        users = response.json() 
        user_data = pd.DataFrame(users, columns=["UserID", "Name", "Bio", "Occupation"])
        return user_data
    except requests.exceptions.RequestException as e:
        st.error(f"Failed to fetch  data from the API: {e}")
        return None 
    
def fetch_user_data_pay(paytransparency):
    """
    Fetch user data from the Flask API.
    Returns a Pandas DataFrame if successful, otherwise None.
    """
    try:
        pay_data = {'paytransparency' : paytransparency}
        response = requests.get("http://api:4000/aaa/students/by-paytransparency", json=pay_data)
        response.raise_for_status() 
        users = response.json() 
        user_data = pd.DataFrame(users, columns=["UserID", "Name", "Bio", "Occupation"])
        return user_data
    except requests.exceptions.RequestException as e:
        st.error(f"Failed to fetch  data from the API: {e}")
        return None 

def main():
    """
    Main function to render the Streamlit app.
    """
    st.title('Users')

    st.write('Search by users')
    with st.form("search_user_form"):
    
        UserID = int(st.number_input("UserID", step=1))
    
        # create submit button
        submit_button = st.form_submit_button("Search for User")
        
        # check all fields are filled when form is submitted
        if submit_button:
            if not UserID:
                st.error("Please enter a UserID")
            else:
                # Fetch user data from the API
                user_data = fetch_user_data(UserID)
            
                # show user data
                if user_data is not None and not user_data.empty:
                    st.success("Successfully fetched data from the API.")
                    st.dataframe(user_data)
                else:
                    st.warning("No user data available.")

    st.write('Search by Industry')
    with st.form('search_user_industry_form'):
        industry = st.text_area('Industry')

        # create the submit button
        submit_button = st.form_submit_button("Search for User")

        if submit_button:
            if not industry:
                st.error("Please enter an Industry")
            else:
                st.write(f"searching for users in industry: '{industry}'")
                user_data = fetch_user_data_industry(industry)
                # show user data
                if user_data is not None and not user_data.empty:
                    st.success("Successfully fetched data from the API.")
                    st.dataframe(user_data)
                else:
                    st.warning("No user data available.")
    
    st.write('Search by Skills (Employers)')
    with st.form('search_user_skills_form'):

        soft_skills = st.text_area('Soft Skills')
        tech_skills = st.text_area('Technical Skills')

        # Add the submit button (which every form needs)
        submit_button = st.form_submit_button("Search for User")

        if submit_button:
            if not soft_skills or not tech_skills:
                st.error("Please enter skills")

            else:
                user_data = fetch_user_data_skills(soft_skills, tech_skills)
                # show user data
                if user_data is not None and not user_data.empty:
                    st.success("Successfully fetched data from the API.")
                    st.dataframe(user_data)
                else:
                    st.warning("No user data available.")
    
    # persona 1 routes
    st.write('If you want to find a student to talk to with companies: Search by Student Companies')
    with st.form('search_user_companies_form'):
        company = st.text_input('Enter Company to Search for Students:')

        submit_button = st.form_submit_button("Search for Users")

        if submit_button:
            if not company:
                st.error("Please enter a Company")
            else:
                st.write(f"Searching for users with company: '{company}'")
                user_data = fetch_user_data_companies(company)
                
                if user_data is not None and not user_data.empty:
                    st.success("Successfully fetched data from the API.")
                    st.dataframe(user_data)
                else:
                    st.warning("No user data available for the specified year.") 


    st.write('If you want to find a student to talk to about pay on co-op: Search by Student Pay Transparency')
    with st.form('search_user_transparency_form'):
        pay = st.text_input('Enter Value to Search for Students:')

        submit_button = st.form_submit_button("Search for Users")

        if submit_button:
            if not pay:
                st.error("Please enter a Value")
            else:
                st.write(f"Searching for users with pay: '{pay}'")
                user_data = fetch_user_data_companies(pay)
                
                if user_data is not None and not user_data.empty:
                    st.success("Successfully fetched data from the API.")
                    st.dataframe(user_data)
                else:
                    st.warning("No user data available for the specified year.") 

    # general view profile form
    with st.form('view_user_search_form'):
        
        submit_button = st.form_submit_button("View User Profile")
        if submit_button:
            try:
                response = requests.get("http://api:4000/aa/users/view/" + str(UserID))
                response.raise_for_status() 
            except requests.exceptions.RequestException as e:
                st.error(f"Failed to fetch user data from the API: {e}")

main() 
