import logging
import streamlit as st
import pandas as pd
import requests

logger = logging.getLogger(__name__)

API_URL = "http://api:4000/users"

def main():
    st.title("User Management Dashboard")

    st.header("User Data Table")
    st.write("Below is the list of all users fetched from the REST API.")

    try:
        response = requests.get(API_URL)
        response.raise_for_status()  
        users = response.json() 

        user_data = pd.DataFrame(users, columns=["id", "username", "email"])
        st.write("Successfully fetched data from the API.")
        
        if not user_data.empty:
            st.dataframe(user_data)
        else:
            st.write("No user data available.")
    except requests.exceptions.RequestException as e:
        st.error(f"Failed to fetch user data from the API: {e}")
        logger.error(f"API request failed: {e}")

main()
