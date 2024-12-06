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
        user_data = pd.DataFrame(users, columns=["UserID", "Occupation", "Location,", "Name", "Age", "Bio"])
        return user_data
    except requests.exceptions.RequestException as e:
        st.error(f"Failed to fetch  data from the API: {e}")
        return None

def main():
    """
    Main function to render the Streamlit app.
    """
    st.title('Users')

    with st.form("search_user_form"):
    
        UserID = int(st.number_input("UserID", step=1))
        industry = st.text_area('Industry')
        soft_skills = st.text_area('Soft Skills')
        tech_skills = st.text_area('Technical Skills')
    
        # Add the submit button (which every form needs)
        submit_button = st.form_submit_button("Search for User")
        
        # Validate all fields are filled when form is submitted
        if submit_button:
            if not UserID:
                st.error("Please enter a UserID")

                if not industry:
                    st.error("Please enter an Industry")
                    
                    if not soft_skills or not tech_skills:
                        st.error("Please enter skills")

                    else:
                        user_data = fetch_user_data_skills(soft_skills, tech_skills)

                else:
                    user_data = fetch_user_data_industry(industry)
            else:
                # Fetch user data from the API
                user_data = fetch_user_data(UserID)

        if UserID or industry or (tech_skills and soft_skills):
            if user_data is not None and not user_data.empty:
                st.success("Successfully fetched data from the API.")
                st.dataframe(user_data)
            else:
                st.warning("No user data available.")

main()
