import logging
logger = logging.getLogger(__name__)

import streamlit as st
from modules.nav import SideBarLinks
import requests
import pandas as pd

st.set_page_config(layout = 'wide')

# Show appropriate sidebar links for the role of the currently logged in user
SideBarLinks()

def fetch_user_data():
    """
    Fetch user data from the Flask API.
    Returns a Pandas DataFrame if successful, otherwise None.
    """
    try:
        response = requests.get("http://api:4000/a/users")
        response.raise_for_status() 
        users = response.json() 
        user_data = pd.DataFrame(users, columns=["UserID", "RegisteredAt", "Occupation", "Location,", "Name", "Age", "Bio", "ReferredBy", "Online", "Admin"])
        return user_data
    except requests.exceptions.RequestException as e:
        st.error(f"Failed to fetch  data from the API: {e}")
        return None


def main():
    """
    Main function to render the Streamlit app.
    """
    st.title('Users')

    # Fetch user data from the API
    user_data = fetch_user_data()

    if user_data is not None and not user_data.empty:
        st.success("Successfully fetched data from the API.")
        st.dataframe(user_data)
    else:
        st.warning("No user data available.")

main()
