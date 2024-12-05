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
        response = requests.get("http://localhost:4000/aa/users/view/" + str(UserID))
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
    
        UserID = int(st.number_input("UserID", min_value=0, step=1))
    
        # Add the submit button (which every form needs)
        submit_button = st.form_submit_button("Search for User")
        
        # Validate all fields are filled when form is submitted
        if submit_button:
            if not UserID:
                st.error("Please enter a UserID")
            else:
                # Fetch user data from the API
                user_data = fetch_user_data(UserID)

                if user_data is not None and not user_data.empty:
                    st.success("Successfully fetched data from the API.")
                    st.dataframe(user_data)
                else:
                    st.warning("No user data available.")

main()
